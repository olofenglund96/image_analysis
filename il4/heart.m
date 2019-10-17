bmean = mean(background_values);
cmean = mean(chamber_values);
bstd = std(background_values);
cstd = std(chamber_values);

nback = @(x) 1/(2*pi*bstd^2)*exp(-(x-bmean).^2/(2*bstd^2));
nchamb = @(x) 1/(2*pi*cstd^2)*exp(-(x-cmean).^2/(2*cstd^2));

lambda = 1;

M = size(im,1);
N = size(im,2);
n = N*M;

Neighbours = edges4connected(M,N);
i = Neighbours(:,1);
j = Neighbours(:,2);
A = sparse(i,j,lambda,n,n);

T = [-log(nchamb(im(:))) -log(nback(im(:)))];
T = sparse(T);

[E Theta] = maxflow(A,T);
Theta = reshape(Theta,M,N);
Theta = double(Theta);

I = imfuse(im, Theta);

imshow(I, 'InitialMagnification','fit')
