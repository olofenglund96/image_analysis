function [imgCell] = im2segment(I)

    % Initialization of variables
    imgCell = {};
    cellIndex = 1;
    prevCol = 1;
    col = 1;
    tempI = zeros(size(I));
    inChar = false;
    
    % Normalizing and inverting image
    Itemp = zeros(size(I));
    Itemp(imgaussfilt(I,0.2) < 125) = 1;
    I = Itemp;
    
    % Loop over each column and check if the column contains
    % a part of a character
    while col < size(I, 2)
        % Is there a part of a character here
        % and is it the first column for the character?
        if any(I(:,col)) && ~inChar
            inChar = true;
        end
        
        % Are there no part of a character in the current column
        % and did the previous column contain a character?
        
        if ~any(I(:,col)) && inChar
            if length(find(I(:, prevCol:col) == 1)) < 30
                prevCol = col;
            else
                % Add the character to an empty matrix with 
                % same size as I (the image)
                tempI(:, prevCol:col) = I(:, prevCol:col);
                imgCell{cellIndex} = tempI;
                cellIndex = cellIndex + 1;
                % Empty temp image before adding the next character
                tempI(:,:) = 0;
                inChar = false;
                prevCol = col;
            end
        end
        
        col = col + 1;
    end
end

