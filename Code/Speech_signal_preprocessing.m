clc;clear;close all;
%Read audio
[x,fs]=audioread('201.wav');
%Calculate audio time
t0=1/fs;%unit sampling time
t=0:t0:(length(x)-1)*t0;
figure(1);
plot(t,x);
grid on;
title('Sriginal Speech Signal');
xlabel('Time');
ylabel('Amplitude');
%Voice signal pre-emphasis
x1=double(x);
x2=filter([1 -0.9375],1,x1);
figure(2);
plot(t,x2);
grid on;
title('Pre-emphasized speech signal');
xlabel('Time');
ylabel('Amplitude');
%Windowing and framing after pre-emphasis
N1=256;%window length
x2=enframe(x2,N1);
t1=0:t0:(N1-1)*t0;
figure(3);
subplot(2,2,1)
plot(t1,x2(1,:));
grid on;
xlabel('Time')
ylabel('Amplitude');
title('Speech signal of frame 1');
subplot(2,2,2)
plot(t1,x2(50,:));
grid on;
xlabel('Time')
ylabel('Amplitude');
title('Speech signal of frame 50');
subplot(2,2,3)
plot(t1,x2(80,:));
grid on;
xlabel('Time')
ylabel('Amplitude');
title('Speech signal of frame 80');
subplot(2,2,4)
plot(t1,x2(100,:));
grid on;
xlabel('Time')
ylabel('Amplitude');
title('Speech signal of frame 100');
%Voice signal endpoint detection
% Amplitude normalized to [-1,1]
x2=double(x2);
x2=x2./max(abs(x2));

%------------------------------
%        Calculate short-time zero-crossing rate
%------------------------------
FrameLen=N1;
FrameInc=N1;
FrameTemp1=enframe(x2(1:end-1),FrameLen,FrameInc);
FrameTemp2=enframe(x2(2:end),FrameLen,FrameInc);
signs=(FrameTemp1.*FrameTemp2)<0;
diffs=abs(FrameTemp1-FrameTemp2)>0.01;
zcr=sum(signs.*diffs,2);
%------------------------------
%         Calculate short-term energy
%------------------------------
[m,n]=size(x2);
for i=1:m
    amp(i)=sum(x2(i,:).*x2(i,:));
end
figure(4);
subplot(2,1,1);
plot(zcr);grid on;
title('Short time zero crossing rate');
xlabel('Frame')
subplot(2,1,2);
plot(amp);grid on;
title('Short-term energy');
xlabel('Frame');

%Endpoint detection
len1=[1,2,3,4];
figure(5)
for i=2:4
    m1=len1(i);
    m2=len1(i-1);
    x3=x2(m2:m1,:);
    [m3,n3]=size(x3);
    x4=reshape(x3,[1,m3*n3]);
    [StartPoint,EndPoint]=vad(x4,fs);
    t2=0:t0:(length(x4)-1)*t0;
    subplot(3,1,i-1);
    plot(x4);
    hold on;
    a2=max(x4);
    a3=min(x4);
    plot(StartPoint.*ones(1,10),linspace(a3,a2,10),'LineWidth',1.5)
    axis([-10,550,a3,a2]);
    plot(512.*ones(1,10),linspace(a3,a2,10),'LineWidth',1.5)
end


