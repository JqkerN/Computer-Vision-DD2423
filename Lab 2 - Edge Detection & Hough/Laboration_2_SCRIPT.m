%% LAB 2: Edge detection and Hough transform
% Ilian Corneliussen and Andrej wilczek
clear all
close all
clf
clc
disp('Script running...')
%% Question 1:
tools = few256;

deltax = [-1 0 1;-2 0 2; -1 0 1];
deltay = [-1 -2 -1; 0 0 0; 1 2 1];

dxtools = conv2(tools, deltax, 'valid');
dytools = conv2(tools, deltay, 'valid');



figure(1)
subplot(1,3,1)
showgrey(tools)
title('Original')
subplot(1,3,2)
showgrey(dxtools)
title('dxtools')
subplot(1,3,3)
showgrey(dytools)
title('dytools')
% orginal_size = size(tools)
% deltax_size = size(dxtools)
% deltay_size = size(dytools)

%% Question 2: 
dxtoolsconv = dxtools;
dytoolsconv = dytools;


gradmagntools = sqrt(dxtoolsconv .^2 + dytoolsconv .^2);
figure(20)
showgrey(gradmagntools)
figure(21)
histogram(gradmagntools)


threshold = 100;
figure(22)
subplot(1,3,1)
showgrey(tools)
title('Original')
subplot(1,3,2)
showgrey(gradmagntools)
title('Magnitude plot')
subplot(1,3,3)
showgrey((gradmagntools - threshold) > 0)
title(['Threshold = ', num2str(threshold)])


% part godthem
godthem = godthem256;
pixels = Lv(godthem);
threshold = 100;

figure(24)
subplot(1,3,1)
showgrey(godthem)
title('Original')

subplot(1,3,2)
showgrey((pixels - threshold) > 0)
title(['Threshold = ', num2str(threshold)])

subplot(1,3,3)
[psf, Ghat] = gaussfft(godthem, 1);
pixels = Lv(psf);
threshold = 100;
showgrey((pixels - threshold) > 0)
title(['Smothed and with threshold = ', num2str(threshold)])


%% Question 4:
figure(40)
scales = [0.0001, 1, 4, 16, 64];
house = godthem256;
subplot(2,3,1)
showgrey(house);
title('Original')
for i = 1:5
    scale = scales(i);
    subplot(2,3,i+1)
    contour(Lvvtilde(discgaussfft(house, scale), 'same'), [0,0])
    axis('image')
    axis('ij')
%      showgrey(Lvvtilde(discgaussfft(house, scale), 'same') <0 )
    title(['Contour with the scaling = ', num2str(scale)])
end

figure(41)
tools = few256;
subplot(2,3,1)
showgrey(tools)
title('Original')
for i = 1:5
    scale = scales(i);
    subplot(2,3,i+1)
    showgrey(Lvvvtilde(discgaussfft(tools, scale), 'same') < 0)
    title(['Contour with the scaling = ', num2str(scale)])
end



% %% test
% pixels = Lvvtilde(godthem);
% figure(40)
% %showgrey(pixels)
% 
% [x,y] = meshgrid(-5:5, -5:5);
% inpic = x;
% shape = 'same';
% 
% temp = [-1/2, 0, 1/2];
% dx = zeros(5,5);
% dx(3, 2:4) = temp;
% dy = dx';
% 
% temp = [1, -2, 1];
% dxx = zeros(5,5);
% dxx(3, 2:4) = temp;
% dyy = dxx';
% 
% 
% dxxx = conv2(dx, dxx, shape);
% dxxy = conv2(dxx,dy,shape);
% 
% subplot(2,2,1)
% showgrey(x)
% subplot(2,2,3)
% showgrey(filter2(dxxx, x.^3, 'valid'))
% subplot(2,2,2)
% showgrey(filter2(dxx, x.^3, 'valid'))
% subplot(2,2,4)
% showgrey(filter2(dxxy, x.^2.*y, 'valid'))

%% Question 6: 
% Sigmoid explaination. 

syms x
sigmoid =@(x) 1./(1+exp(-x));
dx =@(x) exp(-x)./(exp(-x) + 1).^2;
dxx =@(x) (2*exp(-2*x))./(exp(-x) + 1).^3 - exp(-x)./(exp(-x) + 1).^2;
dxxx =@(x) exp(-x)./(exp(-x) + 1).^2 - (6*exp(-2*x))./(exp(-x) + 1).^3 + (6*exp(-3*x))./(exp(-x) + 1).^4;

x = linspace(-10,10,100000);
figure(1000)
subplot(2,2,1)
plot(sigmoid(x))
title('sigmoid')

subplot(2,2,2)
plot(dx(x))
title('First derivative')

subplot(2,2,3)
plot(dxx(x))
title('Second derivative')

subplot(2,2,4)
plot(dxxx(x))
title('Third derivative')

% subplot(2,3,5)
% plot(sigmoid(x)*0.2)
% hold on
% plot(dx(x))
% plot(dxx(x))
% plot(dxxx(x))



%% Extraction of edge segment
figure(70)
house = few256;
subplot(2,3,1)
showgrey(house);
title('Original')

% VARIABLES: 
threshold = 40;
shape = 'same';
scales = [0.0001, 1, 4, 16, 64];

for i = 1:5
    scale = scales(i);
    edgecurves = extractedge(house, scale, shape, threshold);
    subplot(2,3,i+1)
    overlaycurves(house, edgecurves)
    title(['Scaling factor = ', num2str(scale)])
end

%% HOUGH
% Parmaters:
pic = phonecalc256;
gradmagnthreshold = 40;
scale = 4;
L = length(pic);
Diag = sqrt((L - 1)^2 + (L - 1)^2);
nrho = (2*ceil(Diag/1)) + 1;
ntheta = 180*5;
nlines = 50;
verbose = 0;

[linepar, acc] = houghedgeline(pic, scale, gradmagnthreshold, ...
                                        nrho, ntheta, nlines, verbose);

%%
disp('Finnished!')