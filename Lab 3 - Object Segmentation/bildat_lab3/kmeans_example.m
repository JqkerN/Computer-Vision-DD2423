clc
close all
K = 50;                             % number of clusters used
L = 10;                             % number of iterations
seed = 14; %randi(100,1);            % seed used for random initialization
scale_factor = 1.0;                 % image downscale factor
image_sigma = 1.0;                  % image preblurring scale

% Load images
%I = imread('orange.jpg');
I = imread('orange.jpg');

% Rescaling and filtering 
I = imresize(I, scale_factor);
Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);

% Centers from gaussian around the mean
split = 8;
[ segm, centers ] = kmeans_segm(I, K, L, seed,split);
Inew = mean_segments(Iback, segm);
I_b = overlay_bounds(Iback, segm);

% Centers random
[ segm2, centers2 ] = kmeans_segm(I, K, L, seed);
Inew2 = mean_segments(Iback, segm2);
I_b2 = overlay_bounds(Iback, segm2);

% Plots
figure(1)
subplot(1,3,1)
imshow(Iback)
title('Original image')
subplot(1,3,2)
imshow(Inew)
title('Randomization with Gaussian around split means')
subplot(1,3,3)
imshow(Inew2)
title('Completely random')


%imwrite(Inew,'result/kmeans1.png')
%imwrite(I_b,'result/kmeans2.png')