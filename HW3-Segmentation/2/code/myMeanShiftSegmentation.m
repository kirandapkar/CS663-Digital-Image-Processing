
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% call function here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input_img =img;
function [output_img] = myMeanShiftSegmentation(input_img,hi,hs,iter)
    [m, n, c] = size(input_img);
    output_img = double(zeros(m,n,c));
    img_pixel_vec = zeros(m*n,2);
    
    for i=1:m
        for j=1:n
            img_pixel_vec(i+(j-1)*m,:)=[i/hs,j/hs];
        end
    end
    
    num_neighbour = (randi([200,500],1));
    img_vec = horzcat(reshape(input_img,m*n,c)./hi,img_pixel_vec);
    
    for it=1:iter
        [I,D]=knnsearch(img_vec,img_vec,'k',num_neighbour);
        img_vec_update = img_vec;
        for i=1:m
            for j=1:n
                wt = exp(-(D(i+(j-1)*m,:).^2)/2)';
                index_1 = i+(j-1)*m;
                s = sum(wt);
                dif = ((img_vec(I(index_1,:),:)'*wt)./s-img_vec(index_1,:)');
                img_vec_update(index_1,:) = img_vec(index_1,:)+ dif'.*1;
            end
        end
        img_vec = img_vec_update;
    end
    
    for i=1:m
        for j=1:n
            output_img(i,j,:)=img_vec(i+(j-1)*m,1:c).*hi;
        end
    end
end