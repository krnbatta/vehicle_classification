function g = drawBoundry(Orig,image,text)
CC = bwconncomp(image);
stats = regionprops(CC, 'BoundingBox');
g = Orig;
x=stats.BoundingBox(1);
y=stats.BoundingBox(2);
width=stats.BoundingBox(3);
height=stats.BoundingBox(4);
position=[x  y-25];
boxColor='green';
Labeled=insertText(Orig,position,text,'FontSize', 15, 'BoxColor', boxColor, 'BoxOpacity', 0.5);
imshow(Labeled),hold on;
rectangle('position',[x y width height],'edgecolor','g','LineWidth',2);

