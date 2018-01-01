function [Nimg]=segmentGray(Orig,Mask)
Nimg=Orig;
Nimg=rgb2gray(Nimg);
sz=size(Mask);
r=sz(1,1);
c=sz(1,2);
for i=1:r
    for j=1:c
        if(Mask(i,j)==0)
            Nimg(i,j)=0;
        end
    end
end
