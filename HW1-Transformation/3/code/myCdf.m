function [c] = myCdf(A,a)
    k=0; [no_r,no_c]=size(A);
    % 2 'for' loops to access each element of matrix A
    for ii=1:no_r
        for jj=1:no_c           
            if A(ii,jj)<=a                            
                k=k+1; 
            end
        end
    end
    % after end of the loops k represents number of pixels having intensity
    % less than the given intensity 'a' $$ \\ $$
    % CDF(a)=(no. of pixels having intensity <=a)/(total no. of pixels)
    c=k/(no_r*no_c); 
end