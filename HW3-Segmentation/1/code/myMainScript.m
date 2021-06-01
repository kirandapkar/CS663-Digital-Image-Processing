%% Reading Img

img_struct = load('boat','imageOrig');

img = im2double(mat2gray(img_struct.imageOrig));

% Parameters

% Smoothening Input Image
window1 = 5;    % 1st Gaussian parameter
sigma1 = 1;     % 1nd Gaussian parameter

% Smoothening Structure Tensor
window2 = 5;    % 2nd Gaussian parameter
sigma2 = 0.8;     % 2nd Gaussian parameter

% Corner-ness Parameter
k = 0.06;       
threshold = 0.3;

[C,L1,L2,img_x,img_y] = myHarrisCornerDetector(img, k, window1, sigma1, window2, sigma2);

% Resizing the image to 500x500
img = img(5:504,5:504);

%% Display

fig2 = figure('Position',[0,0,5000,5000]);

subplot(1,2,1),imshow(img_x);
title('X Gradient');
colorbar;

subplot(1,2,2),imshow(img_y);
title('Y Gradient');
colorbar;

fig3 = figure('Position',[0,0,5000,5000]);

subplot(1,2,1),imshow(L1);
title('Eigenvalue 1');
colorbar;
colormap(jet);

subplot(1,2,2),imshow(L2);
title('Eigenvalue 2');
colorbar;
colormap(parula);

fig4 = figure('Position',[0,0,5000,5000]);

subplot(1,2,1),imshow(50*C-threshold);
title('Corner-ness Measure');
colorbar;

subplot(1,2,2),imshow((img/5)+50*C.*(50*C >= threshold));
title('Output Image');
colorbar;
colormap(parula);