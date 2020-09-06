function images = normalizedCut( image, sigmaI, sigmaD, radius, maxCost )
% Perform normalized cut on image based on paper 
% Recursively cuts image into two segments until
% the score of a segment exceeds maxNCut when it terminates
% segments is a cell array of vectors containing the pixel indices of
% each segment

    % Validate Parameters

    % Extract image parameters
    [height, width, colourDepth] = size(image);
    
    % Reshape the input image into column vectors by colour plane
    % for later reconstruction
    imageAsVectors = reshape( image, height * width, colourDepth );
    
    % Construct the graph representing the image
    [W, D] = constructGraphForImage( image, sigmaI, sigmaD, radius );

    % Top level segment contains all nodes
    numNodes = height * width;
    mainCluster = (1:numNodes);

    % Perform segmentation. Clusters is a cell array of
    % vectors of pixel indices belonging to each cluster
    clusters = partition( mainCluster, W, D, maxCost );

    % Preallocate cell array for images
    numClusters = length( clusters );
    images{numClusters}=0;
    
    % Create cell array of images, one per cluster
    for i=1:numClusters
        % Allocate image
        image = zeros( width * height, colourDepth );
        
        % Set only those pixels whose indices belong to this cluster
        image( clusters{i}, :) = imageAsVectors( clusters{i}, : );

        % Reshape segment into image dimensions
        images{i} = reshape(image, height, width, colourDepth);
    end
end