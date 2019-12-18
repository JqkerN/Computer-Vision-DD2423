close all 
clear all
clc
%% LABORATION 3
disp('Scripts starts...')
%% QUESTION 1: 
K = 2;                             % number of clusters used
L = 10;                             % number of iterations
seed = 14; %randi(100,1);            % seed used for random initialization
scale_factor = 1.0;                 % image downscale factor
image_sigma = 1.0;                  % image preblurring scale

% Load images
%I = imread('orange.jpg');
I = imread('tiger1.jpg');

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

%% QUESTION 2:
K = 10;                             % number of clusters used
L = 8;                             % number of iterations
seed = 14; %randi(100,1);            % seed used for random initialization
scale_factor = 1.0;                 % image downscale factor
image_sigma = 1.0;                  % image preblurring scale

% Load images
I = imread('tiger1.jpg');
%I = imread('orange.jpg');

% Rescaling and filtering 
I = imresize(I, scale_factor);
Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);


% Centers from gaussian around the mean
split = 8;
L_max = 20;
figure(20)
pic_idx = 0;
L = 1;
disp('-- getting multiple plots for gaussians --')
for i = 1:9
    pic_idx = pic_idx +1 ;
    % Centers random
    subplot(3,3,pic_idx)
    [ segm2, centers2 ] = kmeans_segm(I, K, L, seed);
    Inew2 = mean_segments(Iback, segm2);
    I_b2 = overlay_bounds(Iback, segm2);
    imshow(Inew2);
    title(['Tiger, L = ', num2str(L)])
    L = i*5;
end
%% 
% Loss function'
disp('-- Initilizing Loss Function --')
K = 10;                             % number of clusters used
L = 8;                             % number of iterations
seed = 14; %randi(100,1);            % seed used for random initialization
scale_factor = 1.0;                 % image downscale factor
image_sigma = 1.0;                  % image preblurring scale

% Load images
I = imread('tiger1.jpg');
%I = imread('orange.jpg');

% Rescaling and filtering 
I = imresize(I, scale_factor);
Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);

[ ~, centers_1000 ] = kmeans_segm(I, K, 1000, seed);
centers = ones(size(centers_1000))*1000;
tol = 1e-3;
error = abs(nansum(nansum(centers_1000 - centers)));
L = 0;
while tol < error
    L = L + 1;
    [ ~, centers] = kmeans_segm(I, K, L, seed);
    error = abs(nansum(nansum(centers_1000 - centers)));
    error_vec(L) = error;   
end
figure(21)
plot(1:L, error_vec,'k')
title('Convergence of L')
xlabel('Iteration - L')
ylabel('Absolute error')

%% SCATTER
H  = size(I,1);
W = size(I,2);
image = reshape(I,H*W,3);
figure(25)
% scatter3(image(:,1),image(:,2),image(:,3))
% hold on
scatter3(centers_1000(:,1),centers_1000(:,2),centers_1000(:,3),'r')
hold off

%% QUESTION 5:
scale_factor = 0.5;       % image downscale factor
spatial_bandwidth = [4.5, 10];  % spatial bandwidth
colour_bandwidth = [1, 12];    % colour bandwidth
num_iterations = 40;      % number of mean-shift iterations
image_sigma = 1.0;        % image preblurring scale

I = imread('tiger1.jpg');
I = imresize(I, scale_factor);
Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);

figure(50)
for i = 1:2; 
    CBW = colour_bandwidth(i);
    SBW = spatial_bandwidth(1);
    segm = mean_shift_segm(I, SBW, CBW, num_iterations);
    Inew = mean_segments(Iback, segm);
    I = overlay_bounds(Iback, segm);
    imwrite(Inew,'result/meanshift1.png')
    imwrite(I,'result/meanshift2.png')
    subplot(2,2,i*2-1); imshow(Inew);
    title(['coulor-BW = ', num2str(CBW),', spartial-BW =', num2str(SBW)])
    subplot(2,2,i*2); imshow(I);
end
figure(51)
for i = 1:2; 
    CBW = colour_bandwidth(2);
    SBW = spatial_bandwidth(i);
    segm = mean_shift_segm(I, SBW, CBW, num_iterations);
    Inew = mean_segments(Iback, segm);
    I = overlay_bounds(Iback, segm);
    imwrite(Inew,'result/meanshift1.png')
    imwrite(I,'result/meanshift2.png')
    subplot(2,2,i*2-1); imshow(Inew);
    title(['color-BW = ', num2str(CBW),', spartial-BW =', num2str(SBW)])
    subplot(2,2,i*2); imshow(I);
end

%% Question 6:

scale_factor = 0.5;       % image downscale factor
spatial_bandwidth = 4.5;  % spatial bandwidth
colour_bandwidth = 12;    % colour bandwidth
num_iterations = 40;      % number of mean-shift iterations
image_sigma = 1.0;        % image preblurring scale

I = imread('tiger1.jpg');
I = imresize(I, scale_factor);
Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);

segm = mean_shift_segm(I, spatial_bandwidth, colour_bandwidth, num_iterations);
Inew = mean_segments(Iback, segm);
I = overlay_bounds(Iback, segm);
imwrite(Inew,'result/meanshift1.png')
imwrite(I,'result/meanshift2.png')

K = 10;                             % number of clusters used
L = 10;                             % number of iterations
seed = 14; %randi(100,1);            % seed used for random initialization
scale_factor = 1.0;                 % image downscale factor
image_sigma = 1.0;                  % image preblurring scale

% Load images
%I = imread('orange.jpg');
I = imread('tiger1.jpg');

% Rescaling and filtering 
I = imresize(I, scale_factor);
Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);


% Centers random
[ segm2, centers2 ] = kmeans_segm(I, K, L, seed);
Inew2 = mean_segments(Iback, segm2);
I_b2 = overlay_bounds(Iback, segm2);


% Plots
figure(60)
subplot(3,1,1)
imshow(Iback)
title('Original image')

subplot(3,1,2)
imshow(Inew2)
title('K-mean')

subplot(3,1,3); imshow(Inew);
title('Mean-shift segmentation')


%% TIGER IN THE FOREST
colour_bandwidth = 8.0; % color bandwidth
radius = 3;              % maximum neighbourhood distance
ncuts_thresh = 0.2*0.19;      % cutting threshold
min_area = 200*1.9;          % minimum area of segment
max_depth = 10;           % maximum splitting depth
scale_factor = 0.4;      % image downscale factor
image_sigma = 2*1;       % image preblurring scale

I = imread('tiger2.jpg');
I = imresize(I, scale_factor);
Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);

segm = norm_cuts_segm(I, colour_bandwidth, radius, ncuts_thresh, min_area, max_depth);
Inew = mean_segments(Iback, segm);
I = overlay_bounds(Iback, segm);
imwrite(Inew,'result/normcuts1.png')
imwrite(I,'result/normcuts2.png')

figure(70)
subplot(1,2,1)
imshow(Inew)

subplot(1,2,2)
imshow(I)


%% APELSIN
colour_bandwidth = 24.0; % color bandwidth
radius = 6;              % maximum neighbourhood distance
ncuts_thresh = 0.2*0.3;      % cutting threshold
min_area = 200*0.3;          % minimum area of segment
max_depth = 5;           % maximum splitting depth
scale_factor = 0.4;      % image downscale factor
image_sigma = 2*1;       % image preblurring scale

I = imread('orange.jpg');
I = imresize(I, scale_factor);
Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);

segm = norm_cuts_segm(I, colour_bandwidth, radius, ncuts_thresh, min_area, max_depth);
Inew = mean_segments(Iback, segm);
I = overlay_bounds(Iback, segm);
imwrite(Inew,'result/normcuts1.png')
imwrite(I,'result/normcuts2.png')

figure(71)
subplot(1,2,1)
imshow(Inew)

subplot(1,2,2)
imshow(I)



disp('... Script Done!')