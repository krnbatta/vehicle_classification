function result = testim (net,image)
p = im2vec(image);

y = sim(net,p);

[C,I]=max(y);

result=I;


