load femfel.mat;
% subtract images, amplifying the second image a bit
ffdiffs1 = femfel1 - 1.5*femfel2;
% blur and floor to remove subtle differences
five_diffs = floor(imgaussfilt(ffdiffs1, 5)/2);
% threshold image in all color channels
fi = find(five_diffs > 23);
% set only these pixels to 255
five_diffs(:,:,:) = 0;
five_diffs(fi) = 255;
% sum all channels and binarize
five_diffs = sum(five_diffs, 3);
bw = imbinarize(five_diffs);
% use bwlabel to find different areas
areas = bwlabel(bw);
% the following code tries to combine areas close to eachother
areacount = max(areas, [], 'all');
distt = 100;
nareas = zeros(size(areas)); % variable to save new areas

for i = 1:areacount
    % find midpoint of first area
    [I, J] = find(areas == i);
    midp1 = [(min(I) + round((max(I) - min(I))/2)) (min(J) + round((max(J) - min(J))/2))];

    for j = i:areacount
        % find midpoint of second area
        [I, J] = find(areas == j);
        midp2 = [(min(I) + round((max(I) - min(I))/2)) (min(J) + round((max(J) - min(J))/2))];

        % are they close?
        if pdist([midp1;midp2], 'euclidean') < distt
            % yes, set the second area label to the same as the first
            nareas(I, J) = i;
            % and set the values to 0 in the old area matrix
            areas(I, J) = 0;
        end
    end
end

areas = nareas;

% the following code computes bounding boxes around the areas
% and plots them in subplots
bboxes = {};
for i = 1:max(areas, [], 'all')
    [I, J] = find(areas == i);
    bboxes{i} = [min(J) min(I) max(J)-min(J) max(I)-min(I)];
end

subplot(1,2,1)
imshow(femfel1)
hold on;
padding = 70;
for i = 1:length(bboxes)
    box = bboxes{i}
    if length(box) > 0
        paddedbox = [box(1)-padding/2 box(2)-padding/2 box(3)+padding box(4)+padding];
        rectangle('Position', paddedbox, 'EdgeColor', 'r', 'LineWidth',3);
    end
end

subplot(1,2,2)
imshow(femfel2)
hold on;
padding = 70;
for i = 1:length(bboxes)
    box = bboxes{i}
    if length(box) > 0
        paddedbox = [box(1)-padding/2 box(2)-padding/2 box(3)+padding box(4)+padding];
        rectangle('Position', paddedbox, 'EdgeColor', 'r', 'LineWidth',3);
    end
end