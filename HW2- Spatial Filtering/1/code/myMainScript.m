%% Question 1
tic;
% Image reading
im_1=load("/MATLAB Drive/1/data/lionCrop.mat").imageOrig;
im_2=load("/MATLAB Drive/1/data/superMoonCrop.mat").imageOrig;

% Applying the Unsharp filter
Fim_1=myUnsharpMasking(im_1,2,3); % standard deviation=2, Scale factor=3
Fim_2=myUnsharpMasking(im_2,4,3); % standard deviation=4, Scale factor=3

%Plotting both images
figure,subplot(1,2,1),imshow(im_1)
title('Original Image')
colorbar
subplot(1,2,2),imshow(Fim_1)
title('Sharpened Image; S.D.=2,Scale=3')
colorbar

figure,subplot(1,2,1),imshow(im_2)
title('Original Image')
colorbar
subplot(1,2,2),imshow(Fim_2)
title('Sharpened Image; S.D.=4,Scale=3')
colorbar
toc;
