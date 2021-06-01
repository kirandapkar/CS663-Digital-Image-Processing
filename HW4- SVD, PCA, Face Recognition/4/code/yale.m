%% Your code here
function [ ] = yale(yale_path)
% yale_path  = "../data/CroppedYale";

    directoryPath = yale_path;
    arr = [1, 2, 3, 5, 10, 15, 20, 30, 50, 60, 65, 75, 100, 200, 300, 500, 1000];
    len_arr = length(arr); 

    w = 192;
    h = 168;

    numF = 38;
    numTrain_img = 40;
    numTest_img = 24;

    num_faces = [1:13,15:39];
    %%%% using svd
    %%training set X
    X = zeros([w*h numF*numTrain_img]);
    % IDs = kron(num_faces, ones([1 numTest_img]));
    for i = 1:numF
        if(i<10)
            p = directoryPath+"/yaleB0"+num2str(i)+"/";
            Files = dir( p );
            Names = { Files.name };
            for j = 1:numTrain_img 
                file = strcat(p, Names{j+2});
                img = imread(file);
                X(:,(numTrain_img)*i-numTrain_img+j) = img(:);
            end
        elseif(i==14)
            continue;
        else
            p = directoryPath+"/yaleB"+num2str(i)+"/";
            Files = dir( p );
            Names = { Files.name };
            for j = 1:numTrain_img 
                file = strcat(p, Names{j+2});
                img = imread(file);
                X(:,(numTrain_img)*i-numTrain_img+j) = img(:);

            end
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
        if(i1<10)
            p = directoryPath+"/yaleB0"+num2str(i1)+"/";
            Files = dir( p );
            Names = { Files.name };
            for j = 1:numTest_img 
                file = strcat(p, Names{j+numTrain_img});
                img = imread(file);
                X_test(:,(numTest_img)*i1-numTest_img+j) = img(:);
            end
        elseif(i1==14)
            continue;
        else
            p = directoryPath+"/yaleB"+num2str(i1)+"/";
            Files = dir( p );
            Names = { Files.name };
            for j = 1+numTrain_img:size(Names,2)-2
                file = strcat(p, Names{j+2});
                img = imread(file);
                X_test(:,(numTest_img)*i1-numTest_img+j) = img(:);

            end
        end       
    end
    for p=1:len_arr
        V_hat = U(:,1:arr(p));
        alpha = V_hat'*X;
        alpha_size = size(alpha,2);

        z = X_test-repmat(mean, [1, size(X_test,2)]);
        b = V_hat'*z;

        num = 0;
        for i=1:size(b,2)
            dist = sum((alpha - repmat(b(:,i),[1,alpha_size])).^2, 1);
            img_col = find(dist == min(dist));
            if( floor((i-1)/24) >= floor((img_col-1)/40) )
                num = num + 1;
            end
        end
        rate_plot_svd(p) = num/size(X_test,2);
    end
    figure, plot(arr, 100.0*rate_plot_svd);
    xlabel('k');
    ylabel('Rec rate in %');
    title('with 3 eigenvectors');
    toc;
    disp(rate_plot_svd*100)
    tic;

    rate_plot_svd = zeros(len_arr);

    for p=1:len_arr
        V_hat = V(:,4:arr(p));
        alpha = V_hat'*X;
        alpha_size = size(alpha,2);

        z = X_test-repmat(mean, [1, size(X_test,2)]);
        b = V_hat'*z;

        num = 0;
        for i=1:size(b,2)
            dist = sum((alpha - repmat(b(:,i),[1,alpha_size])).^2, 1);
            img_col = find(dist == min(dist));
            if( floor((i-1)/24) <= floor((img_col-1)/40) )
                num = num + 1;
            end
        end
        rate_plot_svd(p) = num/size(X_test,2);
    end
    figure, plot(arr, 100.0*rate_plot_svd);
    xlabel('k');
    ylabel('Rec rate in %');
    title('without top 3 eigenvalues');
    toc;
end
