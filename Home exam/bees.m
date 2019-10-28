img = imread('bees.jpg');
ig = rgb2gray(img);

%imshow([img(:,:,1) img(:,:,2) img(:,:,3)])
figure()
imshow(ig)

%%
ig = rgb2gray(img);
ig = wiener2(ig, [10 10]);
im1 = ig(850:1050, 940:1150) < 100;
im3 = ig(1:200, 4000:end-1) < 100;
im2 = ig(800:1150, 2450:2800) < 100;
im1 = imresize(im1, [256 256]);
im2 = imresize(im2, [256 256]);
im3 = imresize(im3, [256 256]);
f1 = log(fft(im1));
f2 = log(fft(im2));
f3 = log(fft(im3));
f1t = f1 > 1;
f2t = f2 > 1;
f3t = f3 > 1;
mean(f1t, 'all')
mean(f2t, 'all')
mean(f3t, 'all')

figure()
subplot(3,2,1)
imshow(im1)
subplot(3,2,3)
imshow(im2)
subplot(3,2,5)
imshow(im3)
subplot(3,2,2)
imshow(f1t);
subplot(3,2,4)
imshow(f2t);
subplot(3,2,6)
imshow(f3t);
% 
% figure()
% imshow(img)
% hold on;
% rectangle('Position', [900 900 300 300]);
% rectangle('Position', [2450 800 500 500]);

%%
ig = rgb2gray(img);
ig = wiener2(ig, [10 10]) < 100;
elsize = 256;
ffts = zeros(size(ig,1), size(ig,2));
slice = zeros(elsize, elsize);
for i = 1:elsize/2:size(ig,1)-elsize
    for j = 1:elsize/2:size(ig,2)-elsize
        slice = ig(i:i+elsize, j:j+elsize);
        ffts(i:i+elsize/2,j:j+elsize/2) = mean(log(fft(slice)) > 1, 'all');
    end
end

imagesc(ffts)

%%
scalefac = 0.3;
dims = floor([700, 1200, 2400, 2900]*scalefac);
%dimsbee = floor([280, 460, 80, 390]*scalefac);
ims = imresize(img, scalefac);
ig = rgb2gray(ims);
bee = ig(dims(1):dims(2), dims(3):dims(4));
imshow(bee);
bee = imrotate(bee, -33);
figure()
imshow(bee);
bee = bee(dimsbee(1):dimsbee(2), dimsbee(3):dimsbee(4));
figure()
imshow(bee)
bee = imrotate(bee, 90);
beeconv = conv2(ig, bee, 'full');
for i = 1:36
    bee = imrotate(bee, 10);
    beeconv = beeconv + conv2(ig, bee, 'full');
end

beenorm = beeconv/max(max(beeconv));
beef = beenorm > 0.6;
beef = double(beef);
imf = imfuse(ims, beef);
imshow(img)
figure()
imshow(imf)
figure()
imagesc(beef)

%%
se = strel('disk', 10);
imshow(imclose(ig, se))

%%
im2 = ig < 30;
im2 = ~im2;
imagesc(im2);