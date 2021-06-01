function [matched] = imMatching(V_k,EgnCoeff,probeIm)
 % V_k= (m*n,k), matrix of k eigenvectors of m*n size, (m,n) is the size of
 % image
 % EgnCoeff= (k,32*6), coefficients of gallery images of 32 subjects, 6
 % images each
 % probeIm should be mean subtracted image column vector
 
a_p=V_k'*probeIm;
matched=0;

for subNo=1:32
    [~,D]=knnsearch(EgnCoeff(:,(subNo-1)*6+1:(subNo-1)*6+6)',EgnCoeff(:,(subNo-1)*6+1:(subNo-1)*6+6)','k',6);
    avgDis=sum(sum(D))/30;
    
    for imNo=1:6
        d_p=sqrt((a_p-EgnCoeff(:,(subNo-1)*6+imNo))'*(a_p-EgnCoeff(:,(subNo-1)*6+imNo)));
        if d_p<=(avgDis/1.5) % 1.5 factor is introduced to decrease the threshold, after observation i.e. it had been set manually
            matched=1;
            break
        end
    end
    
    if matched==1
        break
    end
end

end