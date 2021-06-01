%% MyMainScript

tic;
%% Your code here
%%%%%%% read image %%%%%%%%%%%%%%
img = load('../data/image_low_frequency_noise.mat');
img = double(img.Z);
figure;
imagesc(img);
daspect([1 1 1]);
title('Original Image');
axis tight;
colormap('gray');


%%%%%%%%% Fourier Transform %%%%%%%%
Y = fftshift(fft2(img));
figure;
imagesc(log(abs(Y)+1));
title('Log Fourier transform of the Original image');
daspect([1 1 1]);
axis on;
colormap('jet');
impixelinfo;



G = Y;
k=3;
notch_range = -k:k;
G(119 + notch_range, 124 + notch_range) = 0;
G(139 + notch_range, 134 + notch_range) = 0;
%IFT
G_res = ifft2(ifftshift(G));

figure;
imagesc(log(abs(G)+1));
title('Log Fourier transform of the image after Notch');
daspect([1 1 1]);
axis on;
colormap('jet');

figure;
imagesc(G_res);
title('Restored Image');
daspect([1 1 1]);
axis on;
colormap('gray');
toc;
