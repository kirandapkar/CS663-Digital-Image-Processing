function [output] = myUnsharpMasking(F,sigma,scale)
  si=round(3*sigma);
  % code for zero padding for boundary pixels
  A=zeros(size(F)+(2*si),'single');         
  A(si+1:si+size(F,1),si+1:si+size(F,2))=F; % A is the zero padded matrix
  
  % code for the 2-D gaussian mask (M) of size '6*sigma+1'
  x=-si:si; m=exp(-(x.^2)/(2*sigma^2));
  M=m'*m;
  
  B=zeros(2*si+1,'single'); 
  C=zeros(size(F),'single');
  for l=1:size(F,1)
      for m=1:size(F,2)
          % construction of matrix of neighbourhood pixels of pixel(l,m) 
          % on which Gaussian mask will be applied         
          B=A(l:l+2*si,m:m+2*si);
          
          % applying Gaussian filter on neighbourhood of pixel (l,m)
          Mb=(M.*B);
          C(l,m)= sum(Mb,'all')/sum(M,'all');
      end
  end
  % from above code we get C=Gaussian filtered image=G*F
  
  ScUns=scale*(F-C); % Scaled Unsharp mask= scale*(DoG)=scale*(-LoG)
  output=F+ScUns;    
end