% Author - Aakash
% Question 2)d)

%% Histogram function
function [eqlimg,matimg] = myHM(img,imgmask,ref,refmask)
    
    [m,n,p] = size(img);
    
    eqlimg = zeros(m,n,p,'uint8');
    matimg = zeros(m,n,p,'uint8');
    Mmat = zeros(256,1,'uint8');

    for i=1:3

        M = histo(img(:,:,i),imgmask);
        refM = histo(ref(:,:,i),refmask);

        for r=1:size(M)
            diff = abs(M(r) - refM);
            [~,z] = min(diff);
            Mmat(r) = z - 1; 
        end

        for t=1:m
            for s=1:n
                if(imgmask(t,s)==1)
                    eqlimg(t,s,i) = M(double(img(t,s,i))+1);
                    matimg(t,s,i) = Mmat(double(img(t,s,i))+1);
                end
            end
        end
    end
    
end
    
%% Cumulative Function in the Foreground region

function output = histo(img,mask)
    
    [m,n] = size(img);
    freq = zeros(256,1);
    elenum = 0;
    
    for p=1:m
        for q=1:n
           if(mask(p,q)==1)
                freq(img(p,q) + 1) = freq(img(p,q) + 1) + 1;    
                elenum = elenum + 1;
           end
        end
    end
   
    output = 255*(cumsum(freq)/elenum);
 
end