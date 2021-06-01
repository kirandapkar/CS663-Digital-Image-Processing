%% MyMainScript

tic;
%% Part a)
% Shrinking images using subsampling. $$ \\ $$
%%
% The subsampling is done by the function myShrinkImageByFactorD which
% selects every $$ d^{th} $$ pixel from the rows and columns.

% Read image Concentric Circles image
img = imread('circles_concentric.png');

% Subsampling
% Subsampling the original images by choosing the dth pixel

d = 2;
subimg1 = myShrinkImageByFactorD(img,d);

d = 3;
subimg2 = myShrinkImageByFactorD(img,d);

% Display
figure1=figure('Position', [0, 0, 10000, 10000]);

% Original Image
subplot(1,3,1), imshow(img);
title('Original');
xlabel('Pixels');
colorbar;
axis on;

% Subsampled Image (d=2)
subplot(1,3,2), imshow(subimg1);
title('Shrunken Image (d=2)');
xlabel('Pixels');
colorbar;
axis on;

% Subsampled Image (d=3)
subplot(1,3,3), imshow(subimg2);
title('Shrunken Image (d=3)');
xlabel('Pixels');
colorbar;
axis on;
sgtitle('Shrinking by Subsampling Results');

%% Conclusion
% The outputs are displayed side by side with the original image for reference
% in which Moire Effects are clearing visible.

%% Part b)
% Image reading and interpolation
A=imread("barbaraSmall.png");
Bi=myBilinearInterpolation(A);

% Display
imshow(A)
title('Original Image')
axis on
colorbar

figure,imshow(mat2gray(Bi))
title('Interpolated Image')
% changed aspect ratio of axes to make the image again a square image
daspect([205 307 307])
axis on
colorbar
%% Part c)
% Reading image and interpolation
A=imread("barbaraSmall.png");
Ni=myNearestNeighbourInterpolation(A);

%Display
imshow(A)
title('Original Image')
axis on
colorbar

figure,imshow(mat2gray(Ni))
title('Interpolated Image')
% changed aspect ratio
daspect([205 307 307])
axis on
colorbar
%% Conclusion
% Even after having the same resolution as Bilinearly interpolated image,
% image is not that much smooth
%% Part d)

%% Part e)

%% Part f)
% Image Rotation using Bilinear Interpolation. $$ \\ $$
%%
% The pixel is grid rotated using the mapping $$ T^{-1}R^{-1}(\theta)TX' = X $$ where
% $$ T^{-1}R^{-1}(\theta)T $$ takes the coordinates of the rotated image to the
% coordinates of the original image and then Bilinear interpolation is used
% at point X to get the corresponding Intensity.
%%
% $$ T $$ takes the coordinates of the pixels from the original coordinate
% system to the center of frame coordinate system and vice-versa for $$ T^{-1} $$.

% Reading the image
img = imread('barbaraSmall.png');

% Rotating the pixel coordinates
deg = 30;
deg = deg2rad(deg);
rotimg = myImageRotation(img,deg);

% Display

% Original Image
figure2=figure('Position', [0, 0, 1000, 1000]);

subplot(1,2,1), imshow(img);
title('Original Image');
colorbar;
axis on;

subplot(1,2,2), imshow(rotimg);
title('Rotated Image');
colorbar;
axis on;
sgtitle('Rotation by Bilinear Interpolation Result');

%% Conclusion
% In the Original Image is rotated by 30 degrees clockwise using bilinear
% interpolation, and it can be noticed that the edges after rotation are
% not smooth and appear to be jagged due to the quantization of
% coordinates.
%%
%%part d)
i1= "../data/barbaraSmall.png";
i2= "../data/circles_concentric.png";


image1 = myBicubicInterpolation(i1);
image2 = myBicubicInterpolation(i2);

figure(1),imshow(image1);
title("barbaraSmall.png bicubic");
figure(2),imshow(image2);
title("circlesConcentric.png bicubic");
figure(3),imshow(i1);
title("barbara original");
figure(4),imshow(i2);
title("circles original");

toc;
