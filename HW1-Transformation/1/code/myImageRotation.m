% Author - Aakash
% Question 1)f)

%% Coordinate Rotation function
% Rotation of pixel grid function

function rotimg = myImageRotation(img,deg)   

    [m,n] = size(img);
    
    for t=1:m
        for s=1:n
            i = (t-m/2)*cos(deg) + -(s-n/2)*sin(deg) + m/2;
            j = (t-m/2)*sin(deg) + (s-n/2)*cos(deg) + n/2;
            if floor(i)>=0 && floor(j)>=0 && ceil(i)<=m+1 && ceil(j)<=n+1
                rotimg(t,s) = bilinear(img,j,i);
            end
        end
    end
    
end

%% Bilinear Interpolation function
% Bilinear Interpolation Function

function intensity = bilinear(img,x,y)
    
    [m,n] = size(img);
    
    x1 = floor(x);
    x2 = x1 + 1;
    y1 = floor(y);
    y2 = y1 + 1;
    
    if(x1==0 && y1>=0 && y2<=m)
        x  = 1;
        x1 = 1;
    end
    if(x2==n+1 && y1>=0 && y2<=m)
        x  = n;
        x2 = n;
    end
    if(y1==0 && x1>=0 && x2<=n)
        y  = 1;
        y1 = 1;
    end
    if(y2==m+1 && x1>=0 && x2<=n)
        y  = m;
        y2 = m;
    end
    
    A1 = (x2-x)*(y2-y);
    A2 = (x-x1)*(y2-y);
    A3 = (x-x1)*(y-y1);
    A4 = (x2-x)*(y-y1);
    A = A1 + A2 + A3 + A4;
    
    intensity = img(y1,x1).*(A1/A) + img(y2,x1).*(A4/A) + img(y2,x2).*(A3/A) + img(y1,x2).*(A2/A);
    
end