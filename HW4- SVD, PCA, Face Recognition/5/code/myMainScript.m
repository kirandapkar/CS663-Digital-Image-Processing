%% Reading inputs

% Reading the X matrix and mean(X) generated from Question 4
x_struct = load('X','X');
X = x_struct.X;

x_mean = load('mean','mean');
mean = x_mean.mean;

% Calucating the eigenvalues and eigenvectors of Xt*X
[W,D] = eig(X.'*X);

% Normalized Eigenvalues and eigenvectors of C
V = X * W;
V = normalize(V,'norm');
Ds = rot90(D,2);
Vs = fliplr(V);

%% Displaying the 25 largest Eigenfaces
fig1 = figure('Position',[0,0,5000,5000]);
for i = 1:25

    temp = Vs(:,i);
    temp = mat2gray(reshape(temp,112,92));

    subplot(5,5,i);
    imshow(temp);
end
sgtitle("25 Largest Eigenfaces");


%% Reconstruction of ORL/s1/1.pgm

arr = [2, 10, 20, 50, 75, 100, 125, 150, 175];

img = imread("1.pgm");
x = double(img(:)) - mean;

fig2 = figure('Position',[0,0,5000,5000]);
for i = 1:9
    
    k = arr(i);
    Vr = Vs(:,1:k);
    
    a = Vr.' * x;
    temp = 0;

    for j = 1:k
        temp = temp + Vr(:,j)*a(j);
    end
    
    temp = temp + mean;
    temp = mat2gray(reshape(temp,112,92));
    
    subplot(3,3,i);
    imshow(temp);
end

sgtitle("ORL/s1/1.pgm Reconstruction");