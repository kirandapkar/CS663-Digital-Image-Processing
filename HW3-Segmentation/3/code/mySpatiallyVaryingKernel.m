function [output_img,radius_img,blr_kern_img] = mySpatiallyVaryingKernel(inp_img,mask_img,hs,alpha)
[m,n,c]=size(inp_img);
radius_img=zeros(m,n);
output_img=inp_img;
blr_kern_img=zeros(2*alpha+1,2*alpha+1,5);

for i=1:m
    for j=1:n
        if mask_img(i,j)==0  % if condition, so that transformation happens only on background pixels
            
        % This section is to get the radius of the disc kernel for a pixel (i,j)
        r=alpha;
        for iii=max(1,i-alpha):min(m,i+alpha)
            for jjj=max(1,j-alpha):min(n,j+alpha)
                if mask_img(iii,jjj)==1  % r=alpha, till you get a pixel in the disc kernel which lies in foreground region
                    r=min(r,sqrt((i-iii)^2+(j-jjj)^2)); 
                end
            end
        end
        radius_img(i,j)=r;
        
        % creating the disc kernel  
        wt=zeros(2*alpha+1,2*alpha+1);
        for ii=1:2*alpha+1
            for jj=1:2*alpha+1
                if sqrt((ii-alpha-1)^2+(jj-alpha-1)^2)<=r && max(1,i-alpha)-i+alpha+1<=ii && ii<=min(m,i+alpha)-i+alpha+1 && max(1,j-alpha)-j+alpha+1<=jj && jj<=min(n,j+alpha)-j+alpha+1 
                    % above if condition is to make sure that the weights
                    % for the region outside boundary and pixels in foreground region, remains zero 
                    wt(ii,jj)=exp((-(ii-alpha-1)^2-(jj-alpha-1)^2)/(hs^2));
                end
            end
        end
        
        % This section is to store the blurring kernels for different radii
        if r==alpha||r==0.8*alpha||r==0.6*alpha||r==0.4*alpha||r==0.2*alpha
            blr_kern_img(:,:,r/(0.2*alpha))=wt;
        end
        
        % Creating the corresponding intensity kernel for a pixel (i,j)
        ints=zeros(2*alpha+1,2*alpha+1,c);
        ints(max(1,i-alpha)-i+alpha+1:min(m,i+alpha)-i+alpha+1,max(1,j-alpha)-j+alpha+1:min(n,j+alpha)-j+alpha+1,:)=inp_img(max(1,i-alpha):min(m,i+alpha),max(1,j-alpha):min(n,j+alpha),:);
        
        % output blurred image
        output_img(i,j,:)=sum(sum((wt.*ints)))/sum(sum(wt));
        end
    end
end
end
