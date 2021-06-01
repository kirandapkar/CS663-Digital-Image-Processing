% function for Split HE, i.e. given histogram is split into 2 histogram and
% then each one is independently equalized, splitting have been done at median
% intensity
function [B] = splitHistEql(A)
    a=median(A,"all"); B=A;
    % 2 'for' loops to access each element of given matrix A  
    for ii=1:size(A,1)
        for jj=1:size(A,2)
            if A(ii,jj)<=a
  % if value of matrix element lies in 1st half then the new intensity, b=CDF*scaling factor
                B(ii,jj)=2*a*myCdf(A,A(ii,jj));
            else
  % if value lies in second half then b= median intensity 'a'+ (CDF(x)-(CDF at median intensity i.e. '0.5') )*scaling factor               
                B(ii,jj)=a + 2*(max(A,[],'all')-a)*(myCdf(A,A(ii,jj))-0.5);
            end
        end
    end
end