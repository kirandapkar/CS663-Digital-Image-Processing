%%%%%%
% myMainScript part start
% input = load('barbara.mat');
% input = input.imageOrig;
% input = double(input);
% 
% G = fspecial('gaussian', [9,9], 0.66);
% input = imfilter(input,G,'same');
% cropped_img = input(1:2:end,1:2:end);
% [m ,n] = size(cropped_img);
% sd = 0.05*(max(max(cropped_img))-min(min(cropped_img)));
% noise_img = cropped_img + sd*randn(m,n);
% 
% %%%%
% patch_size = 9;
% window_size = 25;
% h = 1.5;        % std_dev
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% call functiom here in myMainSCript
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function img = myPatchBasedFiltering(noise_img,patch_size,window_size,h)
%aspect ratio 1:1
img = noise_img;
sz = size(img,1);
patch = (patch_size-1)/2;
window = (window_size-1)/2;
%calculate isotropy of patch
isotropy_patch = fspecial('gaussian',[patch_size,patch_size],1.5);
x =patch+1;
%patch around pixel p
for i= x:sz-patch
    for j = x:sz-patch
        window_max = max([patch+1,patch+1],[i-window,j-window]);
        window_min = min([sz-patch,sz-patch],[i+window,j+window]);
        % crop patch
        img_patch_p = noise_img(i-patch:i+patch,j-patch:j+patch);
        patch_wt = zeros([window_size^2,1]);
        patch_center = zeros([window_size^2,1]);
        c=1;
        %patch around pixel q
        for i1= window_max(1):window_min(1)
            for j1=window_max(2):window_min(2)
                img_patch_q = noise_img(i1-patch:i1+patch,j1-patch:j1+patch);
                patch_wt(c) = exp(-1*(sum(sum((isotropy_patch.*(img_patch_p-img_patch_q)).^2))/(h^2)));
                patch_center(c) = noise_img(i1,j1);
                c=c+1;                
            end
        end
        patch_wt=patch_wt/sum(patch_wt);
        img(i,j)= sum(patch_wt.*patch_center);
        
    end
end
% subplot(1,3,1), imagesc(input);
% daspect ([1 1 1]);
% colormap(gray(200));
% colorbar;
% subplot(1,3,2), imagesc(noise_img);
% daspect ([1 1 1]);
% colormap(gray(200));
% colorbar;
% subplot(1,3,3),
% imagesc(img);
% daspect ([1 1 1]);
% colormap(gray(200));
% colorbar;
% % varargin = img;
% % numberColours = 200;
% %     colorScale = [[0:1/(numberColours-1):1]',[0:1/(numberColours-1):1]',[0:1/(numberColours-1):1]'];
% %     figure('NumberTitle','off', 'position', [50, 50, 1200, 400]);
% % 
% %     num = nargin/2;
% %     for k = 1:num
% %         subplot(1,num,k);
% %         imagesc(varargin{2*k-1});
% %         title(varargin{2*k}, 'Fontsize', 12, 'Fontname', 'Cambria');
% %         % truesize;
% %         colormap(colorScale);
% %         daspect([1,1,1]);
% %         axis tight;
% %         colorbar;