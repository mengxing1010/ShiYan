function ncutCost = costOfNormalisedCut( W, D, V, threshold)
% Calculate the cost/score of a normalized cut using the algorithm
% described in Shi's paper


    % Section 2.1
    % Let x be an N = |V| dimensional indicator vector, xi = 1 if node i 
    % is in A and -1, otherwise.
    x = double((V > threshold));   % 1 for membership of A, 0 for membership of B
    x( x == 0 ) = -1;           % 1 and -1
    
    % Let d(i) = sum_j (W_ij) be the total connection from node i to all 
    % other nodes.
    d = diag(D);
    
    % Ncut(A,B) = sum_(x_i<0, x_j>0) (-W * x_i * x_j)
    %             ------------------------------------
    %                     sum_(x_i<0) d(i)
    %
    % Let k =   sum_(x_i>0) d(i)
    %           -----------------
    %              sum_i d(i)
    %
    k = sum( d( x>0 )) / sum(d);
    
    % Letting b =  k
    %             ---
    %             1-k
    b = k / (1-k);
    
    % Setting y = (1+x) - b(1-x)
    y = (1 + x) - b * (1 - x );

    % We have
    % min_x Ncut(x) = min_y yT(D - W)y
    %                 --------------------
    %                          yTDy
    
    ncutCost = ( y' * ( D - W ) * y ) / ( y' * D * y );
end