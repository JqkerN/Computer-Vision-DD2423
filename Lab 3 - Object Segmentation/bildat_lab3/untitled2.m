I = imread('tiger1.jpg');
imshow(I)
set(gcf,'Units')
k = waitforbuttonpress;
rect_pos = rbbox;
annotation('rectangle',rect_pos,'Color','red') 
