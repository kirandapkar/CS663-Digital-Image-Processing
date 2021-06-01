%% Centering Refinement of color histogram
% List of Images from Database

% Query images
q = [1,6,121,158,179,];

% "Correct" images
c = [3,7,124,161,180];


for a = 1:5
 % Reading query images
    q_name = "../data/"+int2str(q(a))+".jpg";
    q_img = imread(q_name);
    [q_cent_ref, qhist] = CenRef(q_img);
 % Reading correct images
    c_name = "../data/"+int2str(c(a))+".jpg";
    c_img =  imread(c_name);
    [c_cent_ref, chist] = CenRef(c_img);

    dist = zeros(1,180); 
    hdist = zeros(1,180);
  % this for loop is to calculate difference between color histograms (also refined histogram) of query image and all the images in database  
    for i = 1:180
        name = "../data/"+int2str(i)+".jpg";
        img = imread(name);
        [ref_hist, hist] = CenRef(img);
        dist(i) = (sum(sum(abs(ref_hist - q_cent_ref))));  % Using L1 Norm for refined histogram
        hdist(i) = (sum(sum(abs(hist - qhist)))); % Using L1 Norm for color histogram
    end

    dist(q) = Inf; 
    hdist(q) = Inf;
    
    [h,k] = min(dist);
    [hd,kd] = min(hdist);
    
    dist = sort(dist);
    hdist = sort(hdist);

    dist = abs(dist - sum(sum(abs(c_cent_ref - q_cent_ref))));
    rank = find(~dist); % Rank of "correct" image
    
    hdist = abs(hdist - sum(sum(abs(chist - qhist))));
    hrank = find(~hdist); % Rank of "correct" image
    
    % Plotting the output
    figure();
    subplot(1,3,1);
    imshow(q_name);
    title('Query image');
    
    subplot(1,3,2);
    imshow(strcat(int2str(k),'.jpg'));
    title('Min CCV Image');

    subplot(1,3,3);
    imshow(c_name)
    title(strcat('Correct Image Rank-',int2str(rank)));
    
end



%% Function to get refined histogram

function [cent_ref, hist] = CenRef(img)

    colorbins = 512;
    
    cent_ref = zeros(2,colorbins);
    hist = zeros(1,colorbins);
    
    % Smoothing the image
    gaussian = fspecial('gaussian',[5 5],2);
    img = imfilter(img,gaussian,'same');
    
    [img, bins]= discretizeColors(img,colorbins);
    
    [mm,nn]=size(img);
    k=round(0.5*(sqrt(3*mm*nn))); % k*k is equal to 75% centered pixels 
    bin_elem=0; cen_bin_elem=0;
    
    for i = 0 : bins-1
        bin_val = img==i;   %here we will get the binary image, f(x,y)=1 for img(x,y)=i(th) color                                  
        for ii=1:size(img,1)
        for jj=1:size(img,2)
            if bin_val==1
                bin_elem=bin_elem+1;     
                if abs(ii-(mm/2))<=(k/2) && abs(jj-(nn/2))<=(k/2)
                    cen_bin_elem=cen_bin_elem+1;
                end
            end
            
        end
        end
        cent_ref(:,i+1) = [cen_bin_elem; bin_elem - cen_bin_elem]; % center refined histogram
        hist(:,i+1) = bin_elem;                       % Color histogram
    end
end

%% Discretizing the Image and color

function [discrete_img, bins] = discretizeColors(img, numcolors)

    width = size(img,2);
    height = size(img,1);
    discrete_img = zeros(height,width);

    % Image is 3 channel, thus for each channel we have V unique values
    % Calculating the value of V such that V x V x V = numcolors
    
    numbins = floor(pow2(log2(numcolors)/3));
    numbinssq = numbins*numbins;
    
    % Re-Scaling the pixel intensities to [0,numbins]
    img = floor((img/(256/numbins)));
    
    for i=1:height
        for j=1:width
            discrete_img(i,j) = img(i,j,1)*numbinssq + img(i,j,2)*numbins + img(i,j,3);
        end
    end
    
    bins = power(numbins,3);

end