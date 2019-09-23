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
n1 = @(x) normpdf(x, 0.4, 0.01);
n2 = @(x) normpdf(x, 0.3, 0.05);
n3 = @(x) normpdf(x, 0.5, 0.2);
ctot = [c1;c2;c3];

maxs = [];
vals = [];
for a = 1:3
    for b = 1:length(c1)
        val = ctot(a,b);
        [n1(val) n2(val) n3(val)]
        [V, I] = max([n1(val) n2(val) n3(val)]);
        maxs(a,b) = I;
        vals(a,b) = V;
    end
end

maxs
vals

%% random scene
px = 1;%@(eps) 1/2*1/4*eps + 1/4*(1/4*eps)^3 + 1/4*(1/4*eps)^2;
pxc = @(eps, pc, n) (eps*1/4)^n * pc;

pcx = @(eps, pc, n) pxc(eps, pc, n)*pc/px;

eps1 = 0.5;
p1 = 1/2;
p2 = 1/4;
p3 = 1/4;

a=pcx(eps1, p1, 1)
b=pcx(eps1, p2, 3)
c=pcx(eps1, p3, 2)
