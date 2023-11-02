function cc=mfcc(k)
%------------------------------
% cc=mfcc(k)Calculate the MFCC coefficient of speech k
%------------------------------
% M is the number of filters, N is the number of voice sampling points in one frame
M=24; N=256;
% Normalized mel filter bank coefficients
bank=melbankm(M,N,8000);

bank=full(bank);
bank=bank/max(bank(:));
% DCT coefficient,12*24
for i=1:12
  j=0:23;
  dctcoef(i,:)=cos((2*j+1)*i*pi/(2*24));
end
% Normalized Cepstral Lifting Window
w=1+6*sin(pi*[1:12]./12);
w=w/max(w);
% Pre-emphasis
AggrK=double(k);
AggrK=filter([1,-0.9375],1,AggrK);
% Framing
FrameK=enframe(AggrK,N,80);
% Add window
for i=1:size(FrameK,1)
    FrameK(i,:)=(FrameK(i,:))'.*hamming(N);
end
FrameK=FrameK';
% Calculate power spectrum
S=(abs(fft(FrameK))).^2;

% Pass the power spectrum through the filter bank
P=bank*S(1:129,:);
% Take the logarithm and do the discrete cosine transform
D=dctcoef*log(P);
% Cepstrum lift window
for i=1:size(D,2)
    m(i,:)=(D(:,i).*w')';
end
% Differential coefficient
dtm=zeros(size(m));
for i=3:size(m,1)-2
  dtm(i,:)=-2*m(i-2,:)-m(i-1,:)+m(i+1,:)+2*m(i+2,:);
end
dtm=dtm/3;
%Combine mfcc parameters and first-order difference mfcc parameters
cc=[m,dtm];
%Remove the first and last two frames because the first-order difference parameters of these two frames are 0
cc=cc(3:size(m,1)-2,:);