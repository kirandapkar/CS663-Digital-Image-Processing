%% MyMainScript

tic;
%% Your code here
ORL_path  = "../data/ORL";

directoryPath = ORL_path;
arr = [1, 2, 3, 5, 10, 15, 20, 30, 50, 75, 100, 150, 170];
len_arr = length(arr); 

w = 112;
h = 92;

numF = 32;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
numTrain_img = 6;
numTest_img = 4;
                                                                                                                                                                                                                                                                                                                                                                                    
num_faces = 1:numF;
%%%% using svd
%%training set X
X = zeros([w*h numF*numTrain_img]);
IDs = kron(num_faces, ones([1 numTest_img]));
for i = 1:numF
    for j = 1:numTrain_img
        p = directoryPath+"/s"+num2str(i)+"/"+num2str(j)+".pgm";
        img = imread(p);
        X(:,(numTrain_img)*i-numTrain_img+j) = img(:);
        
    end
end  

mean = transpose(sum(transpose(X)))/(numF*numTrain_img);
X = X - repmat(mean, [1, size(X,2)]);
%U will be the eigenvector matrix of X'X [V S U]
[V S U] = svd(X, 'econ');
U = X*U;
for k=1:size(U,2)
    U(:,k) = U(:,k)/norm(U(:,k));
end
[temp, perm] = sort(diag(S), 'descend'); %descending will
                                           % give highest value eigen in 1st column
S = S(perm, perm);
U = U(:, perm);
rate_plot_svd = zeros(len_arr);
X_test = zeros([w*h numF*numTest_img]);
for i1 = 1:numF
    for j1 = 1:numTest_img
        p = directoryPath+"/s"+num2str(i1)+"/"+num2str(j1+6)+".pgm";
        img = imread(p);
        X_test(:,(numTest_img)*i1-numTest_img+j1) = double(img(:))-mean;
    end
end


for i = 1:len_arr
    k = arr(i);
    Vr = U(:,1:k); %first k
    c = transpose(Vr)*X;
    X_test = zeros([w*h numF*numTest_img]);
    for i1 = 1:numF
        for j1 = 1:numTest_img
            p = directoryPath+"/s"+num2str(i1)+"/"+num2str(j1+6)+".pgm";
            img = imread(p);
            X_test(:,(numTest_img)*i1-numTest_img+j1) = double(img(:))-mean;
        end
    end
    test_c = transpose(Vr)*X_test;
    ID_predict = transpose((floor((dsearchn(transpose(c), transpose(test_c))-1)/numTrain_img))+1);
    %cal error
    ID_correct = 1;
    for i2 = 1:numF*numTest_img
        if(IDs(i2)==ID_predict(i2))
            ID_correct = ID_correct + 1;
        end
    end
    
    rate_plot_svd(i) = 100*ID_correct/(numF*numTest_img);
end
%disp(rate_plot_svd);
figure;
plot(arr,rate_plot_svd);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%kronecker delta of all faces in testing 
IDs = kron(num_faces, ones([1 numTest_img]));
%%training set X
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
[W,D] = eig(X'*X);
%normalize
V = X*W;
normalized = sqrt(sum(V.^2));
V = V ./ kron(normalized, ones([w*h 1]));
D = flipud(D);
Vs = fliplr(V);
rec_rates = zeros(len_arr);

%1st K eigen vecs

for i = 1:len_arr
    k = arr(i);
    Vr = Vs(:,1:k); %first k
    c = transpose(Vr)*X;
    X_test = zeros([w*h numF*numTest_img]);
    for i1 = 1:numF
        for j1 = 1:numTest_img
            p = directoryPath+"/s"+num2str(i1)+"/"+num2str(j1+6)+".pgm";
            img = imread(p);
            X_test(:,(numTest_img)*i1-numTest_img+j1) = double(img(:))-mean;
        end
    end
    test_c = transpose(Vr)*X_test;
    ID_predict = transpose((floor((dsearchn(transpose(c), transpose(test_c))-1)/numTrain_img))+1);
    %cal error
    ID_correct = 0;
    for i2 = 1:numF*numTest_img
        if(IDs(i2)==ID_predict(i2))
            ID_correct = ID_correct + 1;
        end
    end
    
    rec_rates(i) = 100*ID_correct/(numF*numTest_img);
end

figure;
plot(arr,rec_rates);


%%
yale('../data/CroppedYale');

toc;


%%
%%
