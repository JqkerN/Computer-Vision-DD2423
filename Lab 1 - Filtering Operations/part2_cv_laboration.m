%% LABORATION SCRIPT: PART 2 of the script.
% AFTER QUESTION 9!!
close all
clf
clear all
clc
% 1.5 Multiplication
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

























