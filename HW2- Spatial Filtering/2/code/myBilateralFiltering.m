% Author - Aakash
% Question 2)

%% myBilateralFiltering
function [output,spatialimg,noisyimg,RMSD] = myBilateralFiltering(img,mu_n,sigma_n,window_size,sigma_s,sigma_i)
   
    [d1,d2,d3] = size(img);
    
    %% Adding Noise
    
    noise = mu_n + (sigma_n)*randn(d1);

    noisyimg = img + noise;
    
    %% Bilateral Filtering

    output = zeros(size(noisyimg));

    % Domain filter 

    [x, y] = meshgrid(-window_size:window_size,-window_size:window_size);

    spatial_filter=exp(-(x.^2+y.^2)/(2*sigma_s^2))/(sqrt(2*pi*(sigma_s^2)));

    spatialimg = mat2gray(spatial_filter);

    % Intensity filter

    for i=1:d1
        for j=1:d2

            I = noisyimg(i,j);

            %Adjusting the window size
            xmin = max(i-window_size,1);
            xmax = min(i+window_size,d1);
            ymin = max(j-window_size,1);
            ymax = min(j+window_size,d2);

            I_window = noisyimg(xmin:xmax,ymin:ymax);

            intensity_filter = exp(-double(I_window - I).^2/(2*sigma_i^2))/(sqrt(2*pi*(sigma_i^2)));

            BilateralFilter = intensity_filter.*spatial_filter((xmin:xmax)-i+window_size+1,(ymin:ymax)-j+window_size+1);

            norm = sum(sum(BilateralFilter));

            output(i,j) = sum(sum(BilateralFilter.*double(I_window)))/norm;
        end
    end
    
    %% RMS difference

    difference = output - img;
    RMSD = sum(sum(sqrt((difference.^2)/(d1*d2))));
    
    noisyimg = im2uint8(noisyimg);
    output = im2uint8(output);
    
end


