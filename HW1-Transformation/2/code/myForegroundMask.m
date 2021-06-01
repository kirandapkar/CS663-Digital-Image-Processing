% Author - Aakash
% Question 2)a)

%% Binary Mask and Masked Image function
function [bitmask,maskimg] = myForegroundMask(img)

    fac = 0.6;
    thres = max(max(img))*fac;
    
    [m,n] = size(img);
    bitmask = zeros(m,n);
    
    bitmask(img >= thres) = 1;
    
    maskimg = uint8(bitmask).*uint8(img);    
    
end