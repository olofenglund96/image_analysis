function classification_data = class_train(X, Y)
% IMPLEMENT TRAINING OF YOUR CHOSEN MACHINE LEARNING MODEL HERE
    all_gs = {};
    saved_Y = Y;
    K = @(x1, x2) x1'*x2;
    for letter = 1:26
        letter_indices = find(saved_Y == letter);
        Y = -1*ones(1, length(Y));
        Y(letter_indices) = 1;
        
        N = size(X,2);
        f = ones(N, 1);
        
        H = zeros(N,N);

        for i = 1:N
            for j = 1:N
                H(i,j) = Y(i)*Y(j)*K(X(:,i),X(:,j));
            end
        end

        A = [];
        b = [];
        Aeq = Y;
        beq = 0;
        lb = zeros(N,1);
        ub = 5*ones(N,1);
        options = optimset('Display', 'off');
        alpha = quadprog(H,-f,A,b,Aeq,beq,lb,ub, zeros(N,1), options);

        [max_alph, max_index] = max(alpha);
        
        b = 0;
        for i = 1:N
            b = b + alpha(i)*Y(i)*(K(X(:,i),X(:,max_index)));
        end

        b = b-Y(max_index);

        all_gs{letter} = @(v) sum(alpha.*Y'.*K(X,v)) - b;
    end
    classification_data = all_gs;
end

