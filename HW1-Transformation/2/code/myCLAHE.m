
%TEM 120 , 0.5
%chestXray 100,0.5
%canyon 50 0.1
function img_new = myCLAHE(img,ws,alpha)
    img = imread(img);
    
    [h,w,ch] = size(img);
    img_size= size(img);
    img_new = zeros(img_size);
    % if an(2)==0
    %     h=0;
    % else
    %     h=an(2);
    % end
    for c=1:ch
        parfor i=1:h
            for j=1:w
                %effectively crop the window to
                %restrict it within the image boundaries
                window = img(max(1,i-ws):min(h,i+ws),max(1,j-ws):min(w,j+ws));
                hist = imhist(window,256);
                updated_hist=hist-max(hist-alpha*sum(hist),0)+sum(max(hist-alpha*sum(hist),0))/256;
                
                cum_hist = cumsum(updated_hist)/sum(updated_hist);
                img_new(i,j,c)=cum_hist(img(i,j,c)+1);
                
            end
        end
        
    end
end

