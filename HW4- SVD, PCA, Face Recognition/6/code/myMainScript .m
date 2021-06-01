%% Question 6
%If we test for the subjects which were not the part of training set then
%the distance between the eigen-coefficient vector of gallery images and probe image will be large
%% Alternate testing method
% We took Eigen-coefficient vector of the 6 gallery images of each subject in training phase, 
% and calculated the distances between those vectors and took the the
% average of it. Now while testing the probe image we had calculated the
% distance between the eigencoefficient vectors of the probe and one of the
% gallery images and then if that distance is less than the avearge of the
% distance (which we calculated earlier for each subject) then that probe
% image is considered to have its identity in the training database.
%% Training Phase 
ORL_path  = "../data/ORL";

directoryPath = ORL_path;

w = 112;
h = 92;

numF = 32;
numTrain_img = 6;
numTest_img = 4;

num_faces = 1:numF;

% kronecker delta of all faces in testing 

X = zeros([w*h numF*numTrain_img]);

for i = 1:numF
    for j = 1:numTrain_img
        p = directoryPath+"/s"+num2str(i)+"/"+num2str(j)+".pgm";
        img = imread(p);
        X(:,(numTrain_img)*i-numTrain_img+j) = img(:);
        
    end
end  

mean = transpose(sum(transpose(X)))/(numF*numTrain_img);
X = X - kron(mean, ones([1 numF*numTrain_img]));
X32_test=X; % these training images will be tested for false negative case
[U,~,~] = svd(X);

%normalize
normalized = sqrt(sum(U.^2));
U = U ./ kron(normalized, ones([w*h 1]));

Vk = U(:,1:20);
c = transpose(Vk)*X;

%% Testing phase
fls_pos=0; fls_neg=0;

% Reading the test images for rest 8 subjects
X8_test = zeros([w*h 8*numTest_img]);
for i1 = 33:40
    for j1 = 1:numTest_img
        p = directoryPath+"/s"+num2str(i1)+"/"+num2str(j1+6)+".pgm";
        img = imread(p);
        X8_test(:,(i1-32)*numTest_img-numTest_img+j1)= double(img(:))-mean;
    end
end

%Testing for false positive cases on 4 testing images of rest 8 subjects
for t8=1:32
    if imMatching(Vk,c,X8_test(:,t8))==1
        fls_pos=fls_pos+1;
    end
end

% Testing for false negative cases on all the training images
for t32=1:numF*numTest_img
    if imMatching(Vk,c,X32_test(:,t32))==0
        fls_neg=fls_neg+1;
    end
end

fls_pos_rate=fls_pos/32
fls_neg_rate=fls_neg/(32*6)

