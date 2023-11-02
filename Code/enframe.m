function f=enframe(x,win,inc)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Framing and windowing

nx=length(x);                     %Get the length of the input signal
nwin=length(win);                 %Get the length of the window function
%If the window length is 1, set the frame length to win; 
%otherwise, the frame length is the length of the window vector
if (nwin == 1)
   len = win;
else
   len = nwin;
end
%If the inc argument is not provided, it is set to the length of the frame
if (nargin < 3)                   
   inc = len;
end                               
nf = fix((nx-len+inc)/inc);       %Count the number of frames
f=zeros(nf,len);                  %Initialize frame matrix
indf= inc*(0:(nf-1)).';           %Calculate the starting index of each frame
inds = (1:len);                   %Calculate the sample point to index within each frame 
f(:) = x(indf(:,ones(1,len))+inds(ones(nf,1),:));    
%If a window vector is provided, apply the window to each frame
if (nwin > 1)
    w = win(:)';                  
    f = f .* w(ones(nf,1),:);     
end                               
                                  

