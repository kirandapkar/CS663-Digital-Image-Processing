function[] = showmyfig(img,t)
    
figure;
    if t==1
        imagesc(img, [min(min(img)), max(max(img))]);
        colormap(gray);
        colorbar;
    end
    if t==0
        imagesc(img);
        colormap(gray);
        colorbar;
    end
end