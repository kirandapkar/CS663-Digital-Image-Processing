%% Reading inputs

k1 = [0, 1, 0; 1, -4, 1; 0, 1, 0];
k2 = [-1, -1, -1; -1, 8, -1; -1, -1, -1];

x = 3;
y = 3;
N = 201;

%% FFT 

% FFT of kernel-1
fft_img1 = fftshift(fft2(k1, N, N));
abs_img1 = log(abs(fft_img1) + 1);

% FFT of kernel-2
fft_img2 = fftshift(fft2(k2, N, N));
abs_img2 = log(abs(fft_img2) + 1);

%% Observation
% In k1 the FFT is significant in the higher-frequency/corner region and
% not spherically symmetric. This kernel is used in rectilinear coordinates
% as the distance between all the neighbors is not equal.

% In k2 the FFT is significant everywhere except the central region and
% spherically symmetric. This kernel can be used when we can assume that
% all the neighbors are at equal distance.

%% Displaying output

fig = figure('Position',[0,0,5000,5000]);

subplot(1,2,1);
imshow(abs_img1,[0,5]);
colormap(jet);
colorbar;
title('Kernel-1 FFT');

subplot(1,2,2)
imshow(abs_img2,[0,5]);
colormap(jet)
colorbar;
title('Kernel-2 FFT')
sgtitle('Output')