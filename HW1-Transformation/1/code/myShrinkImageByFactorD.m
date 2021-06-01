% Author - Aakash
% Question 1)a)

%% Subsampling function
function subimg = myShrinkImageByFactorD(img,d)
    subimg = img(1:d:end,1:d:end);
end