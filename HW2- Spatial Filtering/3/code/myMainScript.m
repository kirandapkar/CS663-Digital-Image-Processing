%%%%%%%%%%%%
tic;
% barabara
input = load('../data/barbara.mat');
input = input.imageOrig;
input = double(input);

G = fspecial('gaussian', [9,9], 0.5);
input = imfilter(input,G,'same');
cropped_img = input(1:2:end,1:2:end);
[m ,n] = size(cropped_img);
sd = 0.05*(max(max(cropped_img))-min(min(cropped_img)));
noise_img = cropped_img + sd*randn(m,n);

%%%%
patch_size = 9;
window_size = 25;
h = 1.5;

output_img = myPatchBasedFiltering(noise_img,patch_size,window_size,h);
rmsd = sqrt(sum(sum(output_img-noise_img).^2))/(m*n);
fprintf("optimised standard deviation barbara:- %f\n",h);%,rmsd);
fprintf("rmsd barbara:- %f",rmsd);
%imshow


% 0.9*h
output_img_1 = myPatchBasedFiltering(noise_img,patch_size,window_size,h*0.9);
rmsd = sqrt(sum(sum(output_img_1-noise_img).^2))/(m*n);
fprintf("optimised standard deviation 0.9*h barbara:- %f\n",h*0.9);%,rmsd);
fprintf("rmsd barbara:- %f",rmsd);
%imshow

% 1.1*h
output_img_2 = myPatchBasedFiltering(noise_img,patch_size,window_size,h*1.1);
rmsd = sqrt(sum(sum(output_img_2-noise_img).^2))/(m*n);
fprintf("optimised standard deviation 1.1*h barbara:- %f\n",h*1.1);%,rmsd);
fprintf("rmsd barbara:- %f",rmsd);
%imshow
figure('position', [0, 0, 25000,25000]);
subplot(1,3,1), imagesc(input);
title('Original image');
daspect ([1 1 1]);
colormap(gray(200));
colorbar;

subplot(1,3,2), imagesc(noise_img);
title('noise image');
daspect ([1 1 1]);
colormap(gray(200));
colorbar;

subplot(1,3,3),imagesc(output_img);
title('output image');
daspect ([1 1 1]);
colormap(gray(200));
colorbar;
%
%
%%%%%%%%%%%%%%%%%%
%image 2

input_grass = imread("../data/grass.png");
input_grass = im2double(input_grass);

G1 = fspecial('gaussian', [9,9], 0.66);
input_grass = imfilter(input_grass,G1,'same');
cropped_img_grass = input_grass(1:2:end,1:2:end);
[m ,n] = size(cropped_img_grass);
sd = 0.05*(max(max(cropped_img_grass))-min(min(cropped_img_grass)));
noise_img = cropped_img_grass + sd*randn(m,n);

%%%%
patch_size = 9;
window_size = 25;
h = 0.01;

output_img = myPatchBasedFiltering(noise_img,patch_size,window_size,h);
rmsd = sqrt(sum(sum(output_img-noise_img).^2))/(m*n);
fprintf("optimised standard deviation grass:- %f\n",h);%,rmsd);
fprintf("rmsd :- %f",rmsd);
%imshow

% mask = fspecial('gaussian', patch_size, 0.5);

% 0.9*h
output_img_1 = myPatchBasedFiltering(noise_img,patch_size,window_size,h*0.9);
rmsd = sqrt(sum(sum(output_img_1-noise_img).^2))/(m*n);
fprintf("optimised standard deviation 0.9*h grass:- %f\n",h*0.9);%,rmsd);
fprintf("rmsd :- %f",rmsd);
%imshow

% 1.1*h
output_img_2 = myPatchBasedFiltering(noise_img,patch_size,window_size,h*1.1);
rmsd = sqrt(sum(sum(output_img_2-noise_img).^2))/(m*n);
fprintf("optimised standard deviation 1.1*h grass:- %f\n",h*1.1);%,rmsd);
fprintf("rmsd :- %f",rmsd);
%imshow

figure('position', [0, 0, 25000, 25000]);
subplot(2,3,1), imagesc(input_grass);
title('Original image');
daspect ([1 1 1]);
colormap(gray(200));
colorbar;

subplot(2,3,2), imagesc(noise_img);
title('noise image');
daspect ([1 1 1]);
colormap(gray(200));
colorbar;

subplot(2,3,3),imagesc(output_img);
title('output image');
daspect ([1 1 1]);
colormap(gray(200));
colorbar;

%%%%%%%%%%%%%%%%
% 3rd image

input_honey = imread("../data/honeyCombReal.png");
input_honey = im2double(input_honey);

G2 = fspecial('gaussian', [9,9], 1);
input_honey = imfilter(input_honey,G2,'same');
cropped_img_honey = input_honey(1:2:end,1:2:end);
[m ,n] = size(cropped_img_honey);
sd = 0.05*(max(max(cropped_img_honey))-min(min(cropped_img_honey)));
noise_img = cropped_img_honey + sd*randn(m,n);

%%%%
patch_size = 9;
window_size = 25;
h = 0.015;

output_img = myPatchBasedFiltering(noise_img,patch_size,window_size,h);
rmsd = sqrt(sum(sum(output_img-noise_img).^2))/(m*n);
fprintf("optimised standard deviation honey:- %f\n",h);%,rmsd);
fprintf("rmsd :- %f",rmsd);
%imshow

% mask = fspecial('gaussian', patch_size, 1.5);

% 0.9*h
output_img_1 = myPatchBasedFiltering(noise_img,patch_size,window_size,h*0.9);
rmsd = sqrt(sum(sum(output_img_1-noise_img).^2))/(m*n);
fprintf("optimised standard deviation 0.9*h honey:- %f\n",h*0.9);%,rmsd);
fprintf("rmsd :- %f",rmsd);
%imshow

% 1.1*h
output_img_2 = myPatchBasedFiltering(noise_img,patch_size,window_size,h*1.1);
rmsd = sqrt(sum(sum(output_img_2-noise_img).^2))/(m*n);
fprintf("optimised standard deviation 1.1*h honey :- %f\n",h*1.1);%,rmsd);
fprintf("rmsd :- %f",rmsd);
%imshow
figure('position', [0, 0, 25000, 25000]);
subplot(3,3,1), imagesc(input_honey);
title('Original image');
daspect ([1 1 1]);
colormap(gray(200));
colorbar;

subplot(3,3,2), imagesc(noise_img);
title('noise image');
daspect ([1 1 1]);
colormap(gray(200));
colorbar;

subplot(3,3,3),imagesc(output_img);
title('output image');
daspect ([1 1 1]);
colormap(gray(200));
colorbar;

%%%
% imshow for masks

figure('position', [0, 0, 25000, 25000]);
subplot(4,3,1), imagesc(G);
title('barbara');
daspect ([1 1 1]);
colormap(gray(200));
colorbar;

subplot(4,3,2), imagesc(G1);
title('grass');
daspect ([1 1 1]);
colormap(gray(200));
colorbar;

subplot(4,3,3),imagesc(G2);
title('Honey');
daspect ([1 1 1]);
colormap(gray(200));
colorbar;
% figure(1),imagesc(output_img)
% figure(2),imagesc(output_img_1)
% figure(3),imagesc(output_img_2)
% figure(4),imagesc(noise_img)
% figure(5),imagesc(input)
% figure(6),imagesc(G)
% % subplot(1,3,1), imagesc(input);
% % daspect ([1 1 1]);
% % colormap(gray(200));
% % colorbar;
% % subplot(1,3,2), imagesc(noise_img);
% % daspect ([1 1 1]);
% % colormap(gray(200));
% % colorbar;
% % subplot(1,3,3),
% % imagesc(img);
% % daspect ([1 1 1]);
% % colormap(gray(200));
% % colorbar;
% numberColours = 200;
%     colorScale = [[0:1/(numberColours-1):1]',[0:1/(numberColours-1):1]',[0:1/(numberColours-1):1]'];
%
toc;