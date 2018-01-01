function IMVECTOR = im2vec (img)
if(ndims(img)~=2)
    img=rgb2gray(img);
end
img = adapthisteq(img); 
[energy,amplitude]=createGabor(img,5,8);
feature=horzcat(energy,amplitude);
feature=normalise(feature);
IMVECTOR=transpose(feature);

