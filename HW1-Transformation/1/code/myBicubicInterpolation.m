
function new_img = myBicubicInterpolation(img)
    img = imread(img);
    [M,N]=size(img);
    new_M=3*M-2;
    new_N=2*N-1;
    new_img = zeros(new_M,new_N);
    
    for i = 1:3:new_M
        for j= 1:2:new_N
            new_img(i,j) = img((i+2)/3.0 , (j+1)/2.0);
        end
    end
    
    
    for i = 1:3:new_M-3
        for j= 1:2:new_N-2
        new_img(i,j+1) = (new_img(i,j)+ new_img(i,j+2))/2.0;
        new_img(i+1,j) = (2*new_img(i,j)+ new_img(i+3,j))/3.0;
        new_img(i+2,j) = (new_img(i,j)+ 2*new_img(i+3,j))/3.0;
        end
    end
    %right corner
    for j=1:2:new_N-2
        new_img(new_M,j+1) = (new_img(new_M,j)+new_img(new_M,j+2))/2.0;
    end
    
    %bottom 
    for i = 1:3:new_M-3
        new_img(i+1,new_N) = (2*new_img(i,new_N)+new_img(i+3,new_N))/3.0;
        new_img(i+2,new_N) = (new_img(i,new_N)+2*new_img(i+3,new_N))/3.0;
    end
    %adjust remianing
    for i = 1:3:new_M-3
        for j= 1:2:new_N-2
        new_img(i+1,j+1) = (new_img(i+1,j)+new_img(i+1,j+2))/2;
        new_img(i+2,j+1) = (new_img(i+2,j)+new_img(i+2,j+2))/2;
        end
    end
end