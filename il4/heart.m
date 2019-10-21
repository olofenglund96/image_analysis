% calculate means and standard deviations
bmean = mean(background_values);
cmean = mean(chamber_values);
bstd = std(background_values);
cstd = std(chamber_values);

% create gaussian functions for background and chamber
nback = @(x) 1/(2*pi*bstd^2)*exp(-(x-bmean).^2/(2*bstd^2));
nchamb = @(x) 1/(2*pi*cstd^2)*exp(-(x-cmean).^2/(2*cstd^2));

lambda = 6;

M = size(im,1);
N = size(im,2);
n = N*M;

% create a map of the image
Neighbours = edges4connected(M,N);
i = Neighbours(:,1);
j = Neighbours(:,2);
A = sparse(i,j,lambda,n,n);

% create the energy function
T = [-log(nchamb(im(:))) -log(nback(im(:)))];
T = sparse(T);

% minimize the energy function using max flow algorithm
[E Theta] = maxflow(A,T);

% construct overlay and visualise segmentation
Theta = reshape(Theta,M,N);
Theta = double(Theta);
I = imfuse(im, Theta);
figure()
imshow(im, 'InitialMagnification','fit')
figure()
imshow(I, 'InitialMagnification','fit')
