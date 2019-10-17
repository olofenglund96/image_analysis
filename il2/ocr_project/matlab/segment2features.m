function [x] = segment2features(B)
    [I, J] = find(B == 1);
    img = B(min(I):max(I), min(J):max(J));
    %set(gca,'XColor', 'none','YColor','none')
    %imagesc(img)
    x = [sum(img(1,:)); sum(img(round(end/2),:)); sum(img(end,:))]; % horizontal white pixel count at specific locations
    x = [x; sum(img(:,1)); sum(img(:,round(end/2))); sum(img(:,end))]; % vertical white pixel count at specific locations
    x = [x; sum(img, 'all')]; % counting all white pixels
end