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

%%
g = @(x) (x+1).*heaviside(x+1) - 2*x.*heaviside(x) + (x-1).*heaviside(x-1);
x = linspace(-2, 2, 3000);

%%
v = [1 4 6 8 7 5 3];
i = linspace(0, length(v)-1, length(v))
hold on;

plot(0.5:1:5.5,Fg(0.5:1:5.5, i, v), 'ro');
Fgp(0.5:1:5.5, i, v);
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

%% rand
eps = [0.05 0.5]
f = @(n, p) p.^n.*(1-p).^(4-n);
f1 = f(1, eps)*1/2
f2 = f(3, eps)*1/4
f3 = f(2, eps)*1/4

fno = f1 + f2 + f3;

f1no = f1./fno
f2no = f2./fno
f3no = f3./fno

%% class 4x4
pcx = @(i, c, p) 0.2^i * 0.8^c * p;
p1x = pcx(6, 10, 0.3)
p2x = pcx(4, 12, 0.2)
p3x = pcx(6, 10, 0.2)
p4x = pcx(8, 8, 0.3)

pcxn = p1x + p2x + p3x + p4x;
p1xn = p1x/pcxn
p2xn = p2x/pcxn
p3xn = p3x/pcxn
p4xn = p4x/pcxn

%% characters
w1 = [0 0 1; 0 1 0; 0 0 1; 0 1 0; 0 0 1]
w2 = [1 0 1; 0 1 0; 0 1 0; 0 1 0; 1 0 1]
w3 = [1 0 1; 0 1 0; 1 0 1; 0 1 0; 1 0 1]

x = [1 1 1; 0 1 1; 1 0 1; 1 1 0; 0 0 1]

diff1 = w1-x
diff2 = w2-x
diff3 = w3-x

% [white black]
types1 = [length(find(w1 == 1)) length(find(w1 == 0))]
types2 = [length(find(w2 == 1)) length(find(w2 == 0))]
types3 = [length(find(w3 == 1)) length(find(w3 == 0))]

% [truly white truly black]
wrong1 = [length(find(diff1 == 1)) length(find(diff1 == -1))]
wrong2 = [length(find(diff2 == 1)) length(find(diff2 == -1))]
wrong3 = [length(find(diff3 == 1)) length(find(diff3 == -1))]

prob = @(wrong, types) 0.35^wrong(1) * 0.65^(types(1)-wrong(1)) * 0.25^wrong(2) * 0.75^(types(2)-wrong(2));
prob1 = 0.25*prob(wrong1, types1)
prob2 = 0.4*prob(wrong2, types2)
prob3 = 0.35*prob(wrong3, types3)

pnorm = prob1 + prob2 + prob3

pn1 = prob1/pnorm
pn2 = prob2/pnorm
pn3 = prob3/pnorm