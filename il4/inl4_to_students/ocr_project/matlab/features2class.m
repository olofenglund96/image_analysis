function y = features2class(x,classification_data)
    best_val = 0;
    y = 1;
    for i = 1:26
        classification = classification_data{i}(x);
        if classification > best_val
            best_val = classification;
            y = i;
        end
    end
end