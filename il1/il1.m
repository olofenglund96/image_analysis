%% Graylevels
f = @(x, y) x'*(1-y);
x = linspace(0, 1, 5)
y = 1:-1/4:0;

M = f(x, y);

imgf = floor(M*15)
imgr = round(M*15)

imagesc([uint8(imgf) uint8(imgr)])

%% Orthonormal base
e1 = [1 0 0 0]
e2 = [0 1 0 0]
e3 = [0 0 1 0]
e4 = [0 0 0 1]

% e1
norm(e1, 2) % 1, making sure we're using the L2 norm
dot(e1, e2) % 0
dot(e1, e3) % 0
dot(e1, e4) % 0

% e2
norm(e2, 2) % 1
dot(e2, e3) % 0
dot(e2, e4) % 0

% e3
norm(e3, 2) % 1
dot(e3, e4) % 0

%% Scalar and norm
u = [2 -3; 5 -1]
v = (1/2)*[1 1; -1 -1]
w = (1/2)*[1 -1; 1 -1]

% norms
unorm = norm(u, 'fro') % 6.2450
vnorm = norm(v, 'fro') % 1
wnorm = norm(w, 'fro') % 1

uv = sum(sum(u .* v)) % -2.5000
uw = sum(sum(u .* w)) %  5.5000
vw = sum(sum(v .* w)) %  0

%% Projection
uv * v + uw * w

%% Compression
s1 = (1/3)*[0 1 0; 1 1 1; 1 0 1; 1 1 1]
s2 = (1/3)*[1 1 1; 1 0 1; -1 -1 -1; 0 -1 0]
s3 = (1/2)*[1 0 -1; 1 0 -1; 0 0 0; 0 0 0]
s4 = (1/2)*[0 0 0; 0 0 0; 1 0 -1; 1 0 -1]

norm(s1, 'fro') % 1
norm(s2, 'fro') % 1
norm(s3, 'fro') % 1
norm(s4, 'fro') % 1

s12 = sum(sum(s1 .* s2)) % 0
s13 = sum(sum(s1 .* s3)) % 0
s14 = sum(sum(s1 .* s4)) % 0

s23 = sum(sum(s2 .* s3)) % 0
s24 = sum(sum(s2 .* s4)) % 0

s34 = sum(sum(s3 .* s4)) % 0

%% Projection
img = [-2 6 3; 13 7 5; 7 1 8; -3 4 4]

fs1 = sum(sum(s1 .* img)) % 17
fs2 = sum(sum(s2 .* img)) % 1.6667
fs3 = sum(sum(s3 .* img)) % 1.5000
fs4 = sum(sum(s4 .* img)) % -4

fa = fs1*s1 + fs2*s2 + fs3*s3 + fs4*s4

norm(img-fa, 'fro')
norm(img, 'fro')
%% Projtest
img = stacks{1}(:,:,1);
basis = bases{1};
[up, r] = face_projection(img, basis);
subplot(2,1,1)
imshow(uint8(img),'InitialMagnification','fit')
title('Original image')
subplot(2,1,2)
imshow(uint8(up),'InitialMagnification','fit')
title('Projected image')

%% Face projections
stack = stacks{2};
basis = bases{3};
rs = [];
for i = 1:size(stack, 3)
    img = stack(:,:,i);
    [up, r] = face_projection(img, basis);
    rs(i) = r;
end
mean(rs)

%% Sample images
img = stacks{2}(:,:,randi([1, 400], 1));
imshow(uint8(img),'InitialMagnification','fit')

%% Sample bases
img = bases{1}(:,:,2);
colormap('gray')
imagesc(img)
for a = 1:3
    for b = 1:4
        basis = bases{a}(:,:,b);
        colormap('gray')
        imagesc(basis)
        set(gca,'XColor', 'none','YColor','none')
        saveas(gcf, ['base' num2str(a) '_e' num2str(b)], 'png')
        close
    end
end
