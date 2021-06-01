%% MyMainScript

tic;
%% original image
sz= 300;
up = 70;
low = 50;
pos = 50;
img_I = zeros(sz,sz);
img_I(pos:pos+up-1,pos:pos+low-1) = 255;

pos1 = 120;
pos2 = 20;
img_J = zeros(sz,sz);
img_J(pos1:pos1+up-1,pos2:pos2+low-1) = 255;


FT_J = fftshift(fft2(img_J));
FT_I = fftshift(fft2(img_I));

spect = (FT_I.*conj(FT_J))./(1e-5 + abs(FT_I).*abs(FT_J));
FT_spect = real(fft2(spect));
log_FT_spect = log(abs(FT_spect));

%% noised image
noised_img_I = img_I + 20*randn(sz);
noised_img_J = img_J + 20*randn(sz);

noised_FT_J = fftshift(fft2(noised_img_J));
noised_FT_I = fftshift(fft2(noised_img_I));

noised_spect = (noised_FT_I.*conj(noised_FT_J))./(1e-5 + abs(noised_FT_I).*abs(noised_FT_J));
noised_FT_spect = real(fft2(noised_spect));
noised_log_FT_spect = log(abs(noised_FT_spect));

%% display all images
showmypair(img_I,img_J);
title("Images of I and J");

showmypair(noised_img_I,noised_img_J);
title("Noised Images of I and J");

showmyfig(FT_spect,1);
title("FT of spectrum");

showmyfig(noised_FT_spect,1);
title("FT of noised spectrum");

showmyfig(log_FT_spect,0);
title("log of FT of spectrum");

showmyfig(noised_log_FT_spect,0);
title("log of FT of noised spectrum");

toc;