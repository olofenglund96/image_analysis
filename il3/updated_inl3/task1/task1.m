% Task 1: Fit least squares and total least squares lines to data points.

% Clear up
clc;
close all;
clearvars;

% Begin by loading data points from linjepunkter.mat
load linjepunkter

% Convenient to have x, y as column vectors
x = x';
y = y';
N = length(x); % number of data points

% Plot data
plot(x, y, '*'); hold on;
xlabel('x') 
ylabel('y')
title('LS and LTS fitting of data points') % OBS - CHANGE TITLE!
x_fine = [min(x)-0.05,max(x)+0.05]; % used when plotting the fitted lines

% Fit a line to these data points with least squares
% Here you should write code to obtain the p_ls coefficients (assuming the
% line has the form y = p_ls(1) * x + p_ls(2)).
A = [x ones(1, N)']
p_ls = A\y;
plot(x_fine, p_ls(1) * x_fine + p_ls(2))

% Fit a line to these data points with total least squares.
% Note that the total least squares line has the form 
% ax + by + c = 0, but the plot command requires it to be of the form
% y = kx + m, so make sure to convert appropriately.
M = [sum(x.^2)-1/N*sum(x)*sum(x) sum(x.*y)-1/N*sum(x)*sum(y);
     sum(x.*y)-1/N*sum(x)*sum(y) sum(y.^2)-1/N*sum(y)*sum(y)]
 
[V,D] = eig(M)
a = V(1,:)
b = V(2,:)

c = -1/N*(a*sum(x)+b*sum(y))
p_tls = [-a./b; -c./b]
plot(x_fine, p_tls(1,1) * x_fine + p_tls(2,1), 'k--')
%plot(x_fine, p_tls(1,2) * x_fine + p_tls(2,2), 'k--')

% Legend --> show which line corresponds to what (if you need to
% re-position the legend, you can modify rect below)
h=legend('data points', 'least-squares','total-least-squares');
rect = [0.20, 0.65, 0.25, 0.25];
set(h, 'Position', rect)

% After having plotted both lines, it's time to compute errors for the
% respective lines. Specifically, for each line (the least squares and the
% total least squares line), compute the least square error and the total
% least square error. Note that the error is the sum of the individual
% errors for each data point! In total you should get 4 errors. Report these
% in your report, and comment on the results. OBS: Recall the distance formula
% between a point and a line from linear algebra, useful when computing orthogonal
% errors!

% WRITE CODE BELOW TO COMPUTE THE 4 ERRORS
k = p_ls(1);
l = p_ls(2);
LS_err_LS = sum(abs(y - k*x - l))
LS_err_TLS = sum(abs(y - k*x - l)/sqrt(1 + k^2))

k = p_tls(1,1);
l = p_tls(2,1);
TLS_err_LS = sum(abs(y - k*x - l))
TLS_err_TLS = sum(abs(y - k*x - l)/sqrt(1 + k^2))