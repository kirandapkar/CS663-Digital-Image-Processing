%% Harris corner-ness measure

function [C,L2,L1,img_x,img_y] = myHarrisCornerDetector(img, k, window1, sigma1, window2, sigma2)

    % Gaussian smoothening of Image
    gauss_img = gaussian_filter(img,window1,sigma1);

    img_padded = padarray(gauss_img,[1 1],0,'both');
    
    % Calculating the X,Y-Gradients of Image
    [img_x, img_y] = sobel(img_padded);
    
    % Gaussian smoothening of Structure Tensor
    P = gaussian_filter(img_x.^2,window2,sigma2);
    Q = gaussian_filter(img_x.*img_y,window2,sigma2);
    R = gaussian_filter(img_y.^2,window2,sigma2);

    % Root Terms of the eigenvalue eqn 
    T1 = (P+R)/2;
    T2 = (((P-R).^2 + 4*(Q.^2)).^(1/2))/2;
    
    % Eigenvalues
    L1 = T1 + T2;
    L2 = T1 - T2;
    
    % Resizing the eigenvalues to remove the boundary cases
    L1 = L1(7:506, 7:506);
    L2 = L2(7:506, 7:506);
    
    % Determinant and Trace
    D = L1.*L2;
    T = L1 + L2;
    
    % Harris Corner-ness measure
    C = D - k*(T.^2);

end

%% Gradient function

function [img_x,img_y] = sobel(img)

    img_x = zeros(size(img));
    img_y = zeros(size(img));

    sobel_x = [-1 0 1; -2 0 2; -1 0 1];
    sobel_y = sobel_x';
    
    [d1,d2] = size(img);
    
    for i = 2:d1-1
        for j = 2:d2-1

            I_window = img(i-1:i+1,j-1:j+1);

            img_x(i,j) = sum(sum(sobel_x.*double(I_window)));
            img_y(i,j) = sum(sum(sobel_y.*double(I_window)));

        end
    end
    
end

%% Gaussian smoothening

function [output] = gaussian_filter(img,window,sigma)

    % Domain filter 
    
    [d1,d2] = size(img);
    
    [x, y] = meshgrid(-window:window,-window:window);

    spatial_filter = exp(-(x.^2+y.^2)/(2*sigma^2))/(sqrt(2*pi*(sigma^2)));

    output = zeros(size(img));
    
    for i = 1:d1
        for j = 1:d2

            %Adjusting the window size
            xmin = max(i-window,1);
            xmax = min(i+window,d1);
            ymin = max(j-window,1);
            ymax = min(j+window,d2);   

            I_window = img(xmin:xmax,ymin:ymax);

            GaussianFilter = spatial_filter((xmin:xmax)-i+window+1,(ymin:ymax)-j+window+1);

            norm = sum(sum(GaussianFilter));

            output(i,j) = sum(sum(GaussianFilter.*double(I_window)))/norm;
        end
    end
  
end