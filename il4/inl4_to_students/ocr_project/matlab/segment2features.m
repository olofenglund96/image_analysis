function [x] = segment2features(B)
    [I, J] = find(B == 1);
    img = B(min(I):max(I), min(J):max(J));
    scfac = 17/size(img, 1);
    
    img = imresize(img, scfac);
    img = wiener2(img,[2 2]);
    x = [sum(img(1,:)); sum(img(2,:)); sum(img(round(end/2),:)); sum(img(end-1,:)); sum(img(end,:))]; % horizontal pixel count
    x = [x; sum(img(:,1));  sum(img(:,2)); sum(img(:,round(end/2))); sum(img(:,end-1)); sum(img(:,end))]; % vertical pixel count
    x = [x; sum(img, 'all')];
    x = [x; length(I); length(J)];
end

