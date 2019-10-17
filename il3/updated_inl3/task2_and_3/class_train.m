function classification_data = class_train(X, Y)
    K = @(x1, x2) x1'*x2; % linear kernel 

    N = size(X,2);
    f = ones(N, 1);

    H = zeros(N,N);
    
    % constructing H
    for i = 1:N
        for j = 1:N
            H(i,j) = Y(i)*Y(j)*K(X(:,i),X(:,j));
        end
    end

    % parameters for quadprog
    A = [];
    b = [];
    Aeq = Y;
    beq = 0;
    lb = zeros(N,1);
    ub = 5*ones(N,1);
    options = optimset('Display', 'off');
    % using quadprog yields the alphas
    alpha = quadprog(H,-f,A,b,Aeq,beq,lb,ub, zeros(N,1), options);
    
    % choose the largest alpha and use that as the support vector
    [max_alph, max_index] = max(alpha);
    
    % compute the bias
    b = 0;
    for i = 1:N
        b = b + alpha(i)*Y(i)*(K(X(:,i),X(:,max_index)));
    end
    b = b-Y(max_index);

    % return a discriminant function
    classification_data = @(v) sum(alpha.*Y'.*K(X,v)) - b;
end

