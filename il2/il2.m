img = imread('saker.png');
imgg = rgb2gray(img);
%%
f1 = [0 -1; 1 0];
imgc = imgaussfilt(imgg,3);
imgc = conv2(imgc, f1, 'same');
imshow(imgc);

%% interpolation
v = [1 4 6 8 7 5 3];
x = linspace(0, length(v)-1, length(v))
plot(x, v, 'o-')
axis([0 max(x) 0 max(v)])

%% 3 mean
c1 = [0.4003 0.3988 0.3998 0.3997 0.4010 0.3995 0.3991]
c2 = [0.2554 0.3139 0.2627 0.3802 0.3287 0.3160 0.2924]
c3 = [0.5632 0.7687 0.0524 0.7586 0.4243 0.5005 0.6769]
classes = []
classes(1,:) = c1(1:4)
classes(2,:) = c2(1:4)
classes(3,:) = c3(1:4)

data = []
data(1,:) = c1(5:end)
data(2,:) = c2(5:end)
data(3,:) = c3(5:end)

mins = [];

for a = 1:3
    for b = 1:3
        p = data(a,b)
        [V, cols] = min(abs(classes - p))
        [V2, colIndex] = min(V)
        mins(a,b) = cols(colIndex)
    end
end

%% gauss
gauss1 = [0.4 0.01]
gauss2 = [0.3 0.05]
gauss3 = [0.5 0.2]
g1 = normpdf(classes(1,1), 0.4, 0.01)
g2 = normpdf(classes(3,1), 0.5, 0.2)