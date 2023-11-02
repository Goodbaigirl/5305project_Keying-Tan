function [StartPoint,EndPoint]=vad(k,fs)

%vad double threshold endpoint detection


% Amplitude normalized to [-1,1]
k=double(k);
k=k./max(abs(k));

%------------------------------
%        Calculate short-time zero-crossing rate
%------------------------------
FrameLen=256;
FrameInc=80;
FrameTemp1=enframe(k(1:end-1),FrameLen,FrameInc);
FrameTemp2=enframe(k(2:end),FrameLen,FrameInc);
signs=(FrameTemp1.*FrameTemp2)<0;
diffs=abs(FrameTemp1-FrameTemp2)>0.01;
zcr=sum(signs.*diffs,2);

%------------------------------
%         Calculate short-term energy
%------------------------------
amp=sum(abs(enframe(filter([1 -0.9375], 1, k), FrameLen, FrameInc)), 2);
ampInd=1:length(amp);

%------------------------------
%         Set threshold
%------------------------------
ZcrLow=max([round(mean(zcr)*0.1),3]);                   %Zero crossing rate low threshold
ZcrHigh=max([round(max(zcr)*0.1),5]);                   %Zero crossing rate high threshold
AmpLow=min([min(amp)*10,mean(amp)*0.2,max(amp)*0.1]);   %Low energy threshold
AmpHigh=max([min(amp)*10,mean(amp)*0.2,max(amp)*0.1]);  %High energy threshold
%------------------------------
%         Endpoint detection
%------------------------------
MaxSilence=8;   %Maximum voice gap time
MinAudio=16;    %Minimum voice time
Status=0;       %Status: 0 silent segment, 1 transition segment, 2 speech segment, 3 end segment
HoldTime=0;     %Voice duration
SilenceTime=0;  %Voice gap time
for n=1:length(zcr)
    switch Status
        case{0,1}
            if amp(n)>AmpHigh | zcr(n)>ZcrHigh
                StartPoint=n-HoldTime;
                Status=2;
                HoldTime=HoldTime+1;
                SilenceTime=0;
            elseif amp(n)>AmpLow | zcr(n)>ZcrLow
                Status=1;
                HoldTime=HoldTime+1;
            else
                Status=0;
                HoldTime=0;
            end
        case 2,
            if amp(n)>AmpLow | zcr(n)>ZcrLow
                HoldTime=HoldTime+1;
            else
               SilenceTime=SilenceTime+1;
               if SilenceTime<MaxSilence
                   HoldTime=HoldTime+1;
               elseif (HoldTime-SilenceTime)<MinAudio
                   Status=0;
                   HoldTime=0;
                   SilenceTime=0;
               else
                   Status=3;
               end
            end
        case 3,
            break;
    end
    if Status==3
        break;
    end
end
HoldTime=HoldTime-SilenceTime;
EndPoint=StartPoint+HoldTime;
