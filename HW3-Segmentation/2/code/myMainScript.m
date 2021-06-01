%% MyMainScript

tic;
%% Your code here
%%%%%%%%%%
%% image 1
%%%%%%%%%%%%%%%%%%
img = imread("../data/baboonColor.png");
img = imgaussfilt(img(:,:,:),1);

img  = imresize(img,0.5);
% figure(2),imagesc(img);
img = im2double(img);

% parameters %%
hi = 1;
hs = 20;
iter = 20;
output_img = myMeanShiftSegmentation(img,hi,hs,iter);
% figure(1),imagesc(output_img);
%%% plot
figure
subplot(1,2,1),imagesc(img)
title('Original Image')
daspect([1 1 1])
colorbar
subplot(1,2,2),imagesc(output_img)
title('Image after Mean shift')
daspect([1 1 1])
colorbar
%%%%%%%%%%%%%%%%%%%
%% image2
%%%%%%%%%%%%%%%%%%%%
img = imread("../data/flower.jpg");
img = imgaussfilt(img(:,:,:),1);

img  = imresize(img,0.5);
% figure(2),imagesc(img);
img = im2double(img);

% parameters %%
hi =  0.15;
hs = 20;
iter = 25;
output_img = myMeanShiftSegmentation(img,hi,hs,iter);
% figure(1),imagesc(output_img);
%%% plot
figure
subplot(1,2,1),imagesc(img)
title('Original Image')
daspect([1 1 1])
colorbar
subplot(1,2,2),imagesc(output_img)
title('Image after Mean shift')
daspect([1 1 1])
colorbar

%%%%%%%%%
%% image 3
%%%%%%%%%%
img = imread("../data/bird.jpg");
img = imgaussfilt(img(:,:,:),1);

img  = imresize(img,0.5);
% figure(2),imagesc(img);
img = im2double(img);

% parameters %%
hi = 1;
hs = 15;
iter = 20;
output_img = myMeanShiftSegmentation(img,hi,hs,iter);
% figure(1),imagesc(output_img);
%%% plot
figure
subplot(1,2,1),imagesc(img)
title('Original Image')
daspect([1 1 1])
colorbar
subplot(1,2,2),imagesc(output_img)
title('Image after Mean shift')
daspect([1 1 1])
colorbar

toc;
