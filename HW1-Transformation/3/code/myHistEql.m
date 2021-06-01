% function for Standard global HE
function [B] = myHistEql(A)
   B=A;
   % 2 'for' loops to access and change value of each element of input matrix
    for ii=1:size(A,1)
        for jj=1:size(A,2)
            % new intensity, b(i,j)=CDF(a(i,j))
             B(ii,jj)=min(A,[],'all')+ (max(A,[],'all')-min(A,[],'all'))*myCdf(A,A(ii,jj));
        end
    end
end