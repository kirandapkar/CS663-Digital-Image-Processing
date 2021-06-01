%% Question 3)d
B=imread("moon_bwc.png");
B=rgb2gray(B);
Bs=splitHistEql(B);
Bm=myHistEql(B);

imshow(B)
title('Original Image')

figure,imshow(Bm)
title('Normal HE')

figure,imshow(Bs)
title('Split HE')
