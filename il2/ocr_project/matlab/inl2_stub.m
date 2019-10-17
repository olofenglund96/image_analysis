datadir = '../datasets/short1';

a = dir(datadir);

file = 'im9';

fnamebild = [datadir filesep file '.jpg'];
fnamefacit = [datadir filesep file '.txt'];

bild = imread(fnamebild);
fid = fopen(fnamefacit);
facit = fgetl(fid);
fclose(fid);
imagesc(bild)
S = im2segment(bild);
B = S{3};
x = segment2features(B)
