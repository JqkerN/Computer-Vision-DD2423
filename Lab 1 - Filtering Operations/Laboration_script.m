%% CV Laboriation Exersize 

%% Question 1: 
% Repeat this exercise with the coordinates p and q set to (5, 9), (9, 5), (17, 9), (17, 121),
% (5, 1) and (125, 1) respectively. What do you observe?
close all
clear all
clc
disp('Running script...')

sz = 128; % number of pixels

u = 5;    % discrete coordinate (x)
v = 9;    % discrete coordinate (y)
figure(1)
fftwave(u, v, sz)

figure(2)
u = 9;    % discrete coordinate (x)
v = 5;    % discrete coordinate (y)
fftwave(u, v, sz)

figure(3)
u = 17;    % discrete coordinate (x)
v = 9;    % discrete coordinate (y)
fftwave(u, v, sz)

figure(4)
u = 17;    % discrete coordinate (x)
v = 121;    % discrete coordinate (y)
fftwave(u, v, sz)

figure(5)
u = 5;    % discrete coordinate (x)
v = 1;    % discrete coordinate (y)
fftwave(u, v, sz)

figure(6)
u = 125;    % discrete coordinate (x)
v = 1;    % discrete coordinate (y)
fftwave(u, v, sz)

%% Question 5:
% What happens when we pass the point in the center and either p or q exceeds half the image size? 
% Explain and illustrate graphically with Matlab!

figure(7) 
u = 1;
v = 63;
fftwave(u,v,128)

figure(8) 
u = 1;
v = 65;
fftwave(u,v,128)

%% Question 7:
% Why are these Fourier spectra concentrated to the borders of the images? Can you
% give a mathematical interpretation? Hint: think of the frequencies in the source image and consider
% the resulting image as a Fourier transform applied to a 2D function. It might be easier to analyze each
% dimension separately!


% Define some rectangular shaped 128 × 128 pixel test images by
F = [ zeros(56, 128); ones(16, 128); zeros(56, 128)];
G = F';
H = F + 2 * G;

% and display them with showgrey. Then compute the discrete Fourier transform of the images by
%writing
Fhat = fft2(F);
Ghat = fft2(G);
Hhat = fft2(H);

% and show their Fourier spectra with
figure(71)
showgrey(log(1 + abs(Fhat)));
figure(72)
showgrey(log(1 + abs(Ghat)));
figure(73)
showgrey(log(1 + abs(Hhat)));

% Also try to run the following
figure(74)
showgrey(log(1 + abs(fftshift(Hhat))));
figure(75)
showgrey(F)
figure(76)
showgrey(G)
figure(77)
showgrey(H)
figure(78)
showgrey(log(1 + abs(fftshift(Fhat))));


%% 1.5 Multiplication
% With F and G as previously defined
F = [ zeros(56, 128); ones(16, 128); zeros(56, 128)];
G = F';
% Try the following commands
figure(100)
showgrey(F .* G);
figure(101)
showfs(fft2(F .* G));
figure(104)
showgrey(fftshift(abs(fft2(F .* G))));
% and explain the results. (The notation F .* G in Matlab refers to point-wise multiplication of corresponding matrix elements.)

%% Question 10: 
% Are there any other ways to compute the last image? Remember what multiplication in Fourier domain equals to in the spatial domain! 
% Perform these alternative computations in practice.
% Fhat = fft(F);
% Ghat = fft(G);
Fhat = 1/128*fft2(F);
Ghat = 1/128*fft2(G);
figure(102)
showfs(Fhat*Ghat)


Cv = conv2(Fhat,Ghat);
Cv = Cv(1:128, 1:128);
figure(105)
showfs(Cv)

%% Question 11:
F = [zeros(60, 128); ones(8, 128); zeros(60, 128)] .* ...
[zeros(128, 48) ones(128, 32) zeros(128, 48)];

figure(110)
showgrey(F)
figure(111)
showfs(fft2(F))


%% Question 12:
% 1.7 Rotation
% Activate a new figure with figure, but keep the Fourier spectrum of F in the first figure. Rotate F by
% for example alpha = 30? and show the results with
alpha = 45;
G = rot(F, alpha);
figure(120)
subplot(1,3,1)
showgrey(G)
axis on
% Then calculate the discrete Fourier transform of the rotated image with
Ghat = fft2(G);
subplot(1,3,2)
showfs(Ghat)
% and display the results with showfs. Do you recognize it? Finally, rotate the spectrum back by the
% same angle with
% Lab 1: Filtering operations 7
Hhat = rot(fftshift(Ghat), -alpha );
% and show the results by writing
subplot(1,3,3)
showgrey(log(1 + abs(Hhat)))
% Assemble the original images and their Fourier spectra into the same figure with the subplot
% command. Vary the angle with different values of alpha, for example alpha = 30?
% , 45?
% , 60?
% , 90? and
% illustrate with at least one case.

%% Question 13:

phone = phonecalc128;
few = few128;
nallo = nallo128;

a = 10^-10;

pow_phone = pow2image(phone, a);
pow_few = pow2image(few, a);
pow_nallo = pow2image(nallo, a);

rand_phone = randphaseimage(phone);
rand_few = randphaseimage(few);
rand_nallo = randphaseimage(nallo);

figure(131)
subplot(1,3,1)
showgrey(phone)
subplot(1,3,2)
showgrey(pow_phone)
subplot(1,3,3)
showgrey(rand_phone)

figure(132)
subplot(1,3,1)
showgrey(few)
subplot(1,3,2)
showgrey(pow_few)
subplot(1,3,3)
showgrey(rand_few)

figure(133)
subplot(1,3,1)
showgrey(nallo)
subplot(1,3,2)
showgrey(pow_nallo)
subplot(1,3,3)
showgrey(rand_nallo)

%% Question 14:
pic = deltafcn(128,128);
tvec = [0.1,0.3,1,10,100];
var = [];
varg = [];

figure(140)
for i = 1:length(tvec)
    [psf, G] = gaussfft(pic,tvec(i));
    var = [var variance(psf)];
    varg = [varg variance(G)];
    subplot(2,3,i)
    showgrey(psf)
    title(['t = ', num2str(tvec(i)), ', Variance = ', num2str(max(max(variance(G))))])
end
print = 0;
if print == 1
    disp('Question 14:')
    disp('Variance of psf:')
    disp(var)
    disp('Variance of G:')
    disp(varg)
end

%% Question 16:

male = male128;
office = office128;
hand = hand128; 
tvec = [1,4,16,32,64,256];

figure(160)
for i = 1:length(tvec)
    psf = gaussfft(male,tvec(i));
    subplot(2,3,i)
    showgrey(psf)    
end

figure(161)
for i = 1:length(tvec)
    psf = gaussfft(office,tvec(i));
    subplot(2,3,i)
    showgrey(psf)    
end

figure(162)
for i = 1:length(tvec)
    psf = gaussfft(hand,tvec(i));
    subplot(2,3,i)
    showgrey(psf)    
end

%% Question 17/18:
office = office256;
gaus = gaussnoise(office, 16);
sap = sapnoise(office, 0.1, 255);

%Gaussian filter:
t_gaus = 1.5;
t_sap = 6;
gaus_gaus = gaussfft(gaus,t_gaus);
sap_gaus = gaussfft(sap,t_sap);

% Median filter
h_gaus = 5;
w_gaus = 5;
h_sap = 3;
w_sap = 3;
gausmed = medfilt(gaus,w_gaus,h_gaus);
sapmed = medfilt(sap,w_sap,h_sap);

% Ideal filter: 
fc_gaus = 0.3;
fc_sap = 0.18;
gaus_id = ideal(gaus,fc_gaus);
sap_id = ideal(sap,fc_sap);

figure(170)
subplot(2,2,1)
showgrey(gaus)
title('Gaussian noise')
subplot(2,2,2)
showgrey(gaus_gaus)
title('Gaussian filter, t = 1.5')
subplot(2,2,3)
showgrey(gausmed)
title('Median filter, width = 5 height = 5')
subplot(2,2,4)
showgrey(gaus_id)
title('Ideal low-pass filter, cut-off = 0.3')

figure(171)
subplot(2,2,1)
showgrey(sap)
title('Salt and pepper noise')
subplot(2,2,2)
showgrey(sap_gaus)
title('Gaussian filter, t = 6')
subplot(2,2,3)
showgrey(sapmed) 
title('Median filter, width = 3 height = 3')
subplot(2,2,4)
showgrey(sap_id)
title('Ideal low-pass filter, cut-off = 0.18 ')

%% Question 19/20:

img = phonecalc256;
smoothimg = img;
smoothid = img; 
N=5;
t = 1.5; 
fc = 0.27;

sap_id = ideal(sap,fc);

figure(190)
for i=1:N
if i>1
% generate subsampled versions
img = rawsubsample(img);
smoothimg = gaussfft(smoothimg, t);
smoothimg = rawsubsample(smoothimg);
smoothid = ideal(smoothid,fc);
smoothid = rawsubsample(smoothid);
end
if i == 1
    subplot(3, N, i)
    showgrey(img)
    title('Original subsampled')
    subplot(3, N, i+N)
    showgrey(smoothimg)
    title('Gaussian filter, t = 1.5')
    subplot(3,N,i+2*N)
    showgrey(smoothid)
    title('Ideal low-pass filter, cut-off = 0.27')
else
subplot(3, N, i)
showgrey(img)
subplot(3, N, i+N)
showgrey(smoothimg)
subplot(3,N,i+2*N)
showgrey(smoothid)
end
end


%% END
disp('Script finnished!')
