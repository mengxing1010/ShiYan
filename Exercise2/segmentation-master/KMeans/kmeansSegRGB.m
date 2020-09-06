function [I,meanImage] = kmeansSegRGB(imrgb, k)
% Perform kmeans segmentation of an RGB image
%
% imrgb is an RGB image, it's assumed that if values greater that 1.0 are
% found in it then each colour plane is in the range 0-255, otherwise it's
% assumed to be sRGB
%
% k is the number of clusters to find.
%
% The output is a cell array of k images (RGB) representing the segments

% Confirm that args are present
error(nargchk(2, 2, nargin));       % Allow 2 inputs
error(nargoutchk(2, 2, nargout));       % Allow 2 outputs

% Extract dimensions
[height, width, ~] = size(imrgb);

% First force imrgb to double values
imrgb = double(imrgb);

% Turn it into 3 column vectors
sz = height * width;
rgbVecs = reshape(imrgb, sz, 3 );

% Run kmeans against the rgb vecs
[idx, c] = kmeans_d(rgbVecs, k );

% Assign cell array for output images
I = cell(k,1);

% Assign storage for the fake coloured image
meanVecs= zeros(sz, 3);

% For each cluster
for i=1:k
    
    % Lookup the pixels for this cluster
    pixIndices = find(idx==i);
        
    % Separate them into an image segment as vectors
    segVecs = zeros(size(rgbVecs));
    
    % Assign pixel values from original to segment
    segVecs(pixIndices,:) = rgbVecs(pixIndices,:);
    
    % Convert these back into an image
    I{i}= uint8(round(reshape(segVecs, size(imrgb) )));
    
    % Now take care of the mean coloured image by
    % assigning original L plus mean ab values
    meanVecs(pixIndices,1) = c(i,1);
    meanVecs(pixIndices,2) = c(i,2);
    meanVecs(pixIndices,3) = c(i,3);
end
meanImage = reshape( meanVecs, size(imrgb));
end