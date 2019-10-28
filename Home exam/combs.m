imgc = imread('honeycomb.jpg');
imshow(imgc(:,:,3) - (imgc(:,:,1) + imgc(:,:,2))/4)
%imshow((imgc(:,:,1) + imgc(:,:,2))/2)
img = rgb2gray(imgc);
%%
d = floor((221-155)/2);
el = strel('disk', d);
im1 = rgb2gray(imclose(imgc, el));
im2 = im1 - img;
for i = 1:10
    subplot(2,5,i)
    im3 = im2 > i*10;
    imshow(im3)
    title(['tresh: ' num2str(i*10)]) 
end

%%
t = 60;
im3 = im2 > t;
el = strel('disk', 3);
im4 = imopen(im3, el);
imshow(im4);

%%
im = imgc(:,:,3) - (imgc(:,:,1) + imgc(:,:,2))/4;
im = im;
imshow(im);
d = floor((221-155)/2);
el = strel('disk', d);
figure()
im1 = imclose(im, d);
imshow(im1-im);