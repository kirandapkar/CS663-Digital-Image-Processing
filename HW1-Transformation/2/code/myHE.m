%

function [img_new] = myHE(img)
    img = imread(img);
    [h,w,ch] = size(img);
    img_size = size(img);
    img_new = zeros(img_size);
    for i=1:ch
        v = img(:,:,i);
        v=v(:);
        hist = imhist(v,256);
        cum_hist = cumsum(hist)/sum(hist);
        img_new = reshape(cum_hist(v+1),h,w);
    end
    
    figure(1),imshow(img);
    figure(2),imshow(img_new);
    figure(3),imhist(img);
    figure(4),imhist(img_new);
end
