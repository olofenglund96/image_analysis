function [] = im2seg(im1, im2, t, g)
imf1 = zeros(size(im1,1), size(im1, 2));
imf1(imgaussfilt(im1, g) < t) = 255;
imf2 = zeros(size(im2,1), size(im2, 2));
imf2(imgaussfilt(im2, g) < t) = 255;
subplot(4,1,1)
imshow(im1, 'InitialMagnification', 'fit')
subplot(4,1,2)
imshow(imf1, 'InitialMagnification', 'fit')
subplot(4,1,3)
imshow(im2, 'InitialMagnification', 'fit')
subplot(4,1,4)
imshow(imf2, 'InitialMagnification', 'fit')
end

