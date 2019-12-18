clear all
close all
clf 
clc
scale_factor = 0.5;          % image downscale factor
area = [ 80, 110, 570, 300 ];% image region to train foreground with
K = 2;                      % number of mixture components
alpha = 8.0;                 % maximum edge cost
sigma = 10.0;                % edge cost decay factor

% I = imread('tiger2.jpg');
% figure(1000)
% imshow(I)
% set(gcf,'Units')
% k = waitforbuttonpress;
% area = rbbox;
% %annotation('rectangle',rect_pos,'Color','red') 


I = imread('tiger1.jpg');
Original = I;
I = imresize(I, scale_factor);
Iback = I;
area = int16(area*scale_factor);
[ segm, prior ] = graphcut_segm(I, area, K, alpha, sigma);

Inew = mean_segments(Iback, segm);
I = overlay_bounds(Iback, segm);
% imwrite(Inew,'result/graphcut1.png')
% imwrite(I,'result/graphcut2.png')
% imwrite(prior,'result/graphcut3.png')
subplot(2,2,1); imshow(Inew);
subplot(2,2,2); imshow(I);
subplot(2,2,3); imshow(prior);
% rec = [area(1),area(2),area(3)-area(1),area(4)-area(2)];
% subplot(2,2,4); imshow(Original); hold on;
% rectangle('Position',rec, 'Curvature',[0,0],'LineWidth',2,'LineStyle','-','EdgeColor','r')
% 
% 











