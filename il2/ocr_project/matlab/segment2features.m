function [x] = segment2features(B)
    [I, J] = find(B == 1);
    img = B(min(I):max(I), min(J):max(J));
    %imagesc(img);
    x = [sum(img(1,:)); sum(img(round(end/2),:)); sum(img(end,:))]; % horizontal pixel count
    x = [x; sum(img(:,1)); sum(img(:,round(end/2))); sum(img(:,end))]; % vertical pixel count
    x = [x; sum(img, 'all')];
end

