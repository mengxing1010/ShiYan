function segments = partition( nodes, Wij, D, maxCost )
% Partition the cluster of graph nodes provided into two sub partitions
% using the normalized cut algorithm.
% This functionrecursively calls itself until the cost of the cut made
% exceeds maxNCut
% 
% Inputs
%   nodes       : A vector of indices representing the nodes in this cluster
%   Wij         : Edge weights between the nodes
%   D           : Diagonal matrix representing the degree of the nodes
%   maxCost     : The maximum cut value to tolerate
%
% Outputs
%   segments    : A cell array of vectors of indices where each vector
%                 represents a single segment
%
% Author: Dave Durbin
% References
%


    % Solve the generalised eigen system, selecting the two smallest
    % eigenvalues and corresponding eigenvectors
    [vectors,values] = eigs(D-Wij, D, 2, 'sm');
    
    % Select the larger of the two
    if values(1,1) < values(2,2) 
        v = vectors( :, 2);
    else 
        v = vectors( :, 1);
    end
    
    % Now we have the eigenvector of real values but we need to convert it
    % to integral values by finding the optimal threshold and setting
    % values above the threshold to 1 and below the threshold to -b
    % We use fminsearch to do this
    
    % Starting point is the mean
	threshold = mean( v );
    
    % Use an anonymous function handle to wrap up the extra parameters
    costFunction = @(threshold) costOfNormalisedCut(Wij, D, v, threshold);
    threshold = fminsearch( costFunction, threshold);
    
    % Now partition into two clusters based on the threshold
    cluster1 = find( v > threshold );
    cluster2 = find( v <= threshold );
    
    
    % Score the cut and if it's less than the max, recursively partition
    % the two clusters, otherwise return the input cluster and don't look
    % further
    ncutCost = costOfNormalisedCut(Wij, D, v, threshold);
    if ncutCost <= maxCost
        % Recursively divide cluster 1
        cluster1Nodes = nodes(cluster1);
        cluster1Weights = Wij(cluster1, cluster1);
        d = sum( cluster1Weights, 2 );
        cluster1Degree = spdiags(d, 0, length( cluster1 ), length( cluster1 ) );
        cluster1Segments = partition( cluster1Nodes, cluster1Weights, cluster1Degree, maxCost);

        % Recursively divide cluster 2
        cluster2Nodes = nodes(cluster2);
        cluster2Weights = Wij(cluster2, cluster2);
        d = sum( cluster2Weights, 2 );
        cluster2Degree = spdiags(d, 0, length( cluster2 ), length( cluster2 ) );
        cluster2Segments = partition( cluster2Nodes, cluster2Weights, cluster2Degree, maxCost);

        % Concatenate the two sets of segments
        segments = [cluster1Segments cluster2Segments];
    else
        % Return the niput nodes
        segments{1}   = nodes;
    end
    
end