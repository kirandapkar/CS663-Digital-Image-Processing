function [D] = myBilinearInterpolation(A)
  [M,N]=size(A); B=eye(M,2*N-1); C=eye(3*M-2,2*N-1);
    for ii=1:M
        for jj=1:2:2*N
            B(ii,jj)=A(ii,(jj+1)/2);
            if jj~=2*N-1
                B(ii,jj+1)=0.5*A(ii,(jj+3)/2) + 0.5*A(ii,(jj+1)/2);
            end
        end
    end
       
    for k=1:2*N-1
        for r=1:3:3*M
            C(r,k)=B((r+2)/3,k);
            if r~=3*M-2
                C(r+1,k)= (2/3)*B((r+2)/3,k) + (1/3)*B((r+5)/3,k);
                C(r+2,k)= (1/3)*B((r+2)/3,k) + (2/3)*B((r+5)/3,k);
            end
        end
    end
  D=round(C);
end