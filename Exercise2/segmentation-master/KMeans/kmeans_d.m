% K-Means clustering function
% k           : in  The number of means to select
% data        : in  An mxn matrix of data, m entries of n components
% seeds       : in  Optional starting centroids. If present must be kxn
%
% indices     : out A vector of length m indices indicating which cluster each input
%             :     value is assigned to
% means       :     The k means
function [indices, means] = kmeans_d( data, k, seeds)
    % do some parameter validation
    % numMeans must be positive
    % data must have at least numMeans elements and be nxm
    % Seeds may optionally be specified  but if it is, we want k elements

    
    [numItems, numComponents] = size(data);
    
    % Convert data to double
    data = double(data);
    
    if ~exist('seeds','var')
        
        % Randomly select starting centroids 
        centroids = zeros(k, numComponents);
    
        % Create random centroids
        componentMins = min(data);
        componentMaxs = max(data);
        ranges = componentMaxs-componentMins;
        for c=1:k
            centroids(c,:) = componentMins + ( rand * ranges);
        end
    else
        centroids = seeds;
    end
    
    % Now assign values to bins based on nearest centroid
    converged=false;
    
    clusters=cell(k,1);
    dists = zeros(numItems, k );
    while ~converged
        
        % Calculate the distance from each centroid
        for c=1:k
            % replicate the centroid numItems times in rows
            centroidRows = repmat(centroids(c,:), numItems, 1 );
            
            % deltas is the diff between point data and centroid
            deltas = data - centroidRows;
            
            % Distance is the L2 norm of these rows
            dists( :,c ) = sqrt( sum(deltas .* deltas, 2 ) );
        end
        
        % The minimum column index of each row is the appropriate cluster
        [val,clusterIdx] = min(dists,[],2);

        
        % pick the k biggest distances and find the corresponding data
        % points for use in empty clusters
        outlierIdx = zeros(k,1);
        for i=1:k
            [~,idx] = max(max(dists,[],2));
            outlierIdx(i) = idx;
            dists(idx,:) = zeros(1,k);
        end
        nextOutlier = 1;
        
        % Allocate indices to clusters
        for i=1:k
            els = find( clusterIdx == i );
            
            % If there are no elements in this cluster, use the biggest
            if size(els,1) == 0
                els = [outlierIdx(nextOutlier)];
                nextOutlier= nextOutlier+1;
            end
            clusters{i} = els;
        end
        
        % Remove any used outliers from their clusters
        i=1;
        while i<nextOutlier
            for c=1:k
                els = clusters{c};
                ix = els(els ~= outlierIdx(i));
                if size(ix,1) > 0
                    els = ix;
                    clusters{c} = els;
                end
            end
            i= i+1;
        end
        
        % Now recalculate the centroids
        ssd = zeros(k,1);
        
        oldCentroids = centroids;
        for i=1:k
            clusterData = data(clusters{i},:);
            % handle only one element
            if size( clusterData,1) == 1
                centroids(i,:) = clusterData;
            else
                centroids(i,:) = mean(clusterData);
            end
        end
        
        % work out how far the mean moved
        delta = oldCentroids - centroids;
        ssd = ssd + sum( delta .* delta, 2 );
        
        % Iterate until convergence
        if ssd == 0 
            converged = true;
        end
    end
    
    % Assign return values
    means = centroids;
    indices = clusterIdx;
end