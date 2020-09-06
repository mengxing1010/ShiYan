function [I,meanImage] = kmeansSegHSVSpatial(imrgb, k, weight)
% Perform kmeans segmentation of an RGB image by converting to HSV
% colour space and using all three components
%
% imrgb is an RGB image, it's assumed that if values greater that 1.0 are
% found in it then each colour plane is in the range 0-255, otherwise it's
% assumed to be sRGB
%
% k is the number of clusters to find.
%
% weight is an indicator of how much weight to give to the spatial information.
%
% The output is a cell array of k images (RGB) representing the segments

% Confirm that args are present
error(nargchk(2, 3, nargin));       % Allow 2 inputs
error(nargoutchk(2, 2, nargout));       % Allow 1 output

if ~ exist(weight,'var')
    weight = 1;
end

% Extract dimensions
[height, width, colourDepth] = size(imrgb);


% First force imrgb to double values
imrgb = double(imrgb);

% Next normalise RGB values if they're greater than 1.0
if max(max(max(imrgb))) > 1
    imrgb = imrgb ./ 255;
end


% Convert into HSV space to get at colour data
imhsv = rgb2hsv( imrgb );

% Turn it into 3 column vectors
sz = height * width;
invecs = reshape(imhsv, sz, 3 );

% Now construct spatial vectors
yvec = repmat( (1:height)',width,1);
xvec = reshape(repmat( (1:width),height,1),width*height,1);

% Normalise the spatial data to be in the range -100 to +100
% which is in line with the a* and b* ranges
midX = width / 2;
midY = height / 2;
yvec = ((yvec - midY) / midY) * 100 * weight;
xvec = ((xvec - midX) / midX) * 100 * weight;

% Cat these onto the raw colour data
invecs = cat( 2, invecs, xvec, yvec );

% Run kmeans against the ab vecs
[idx, c] = kmeans_d(invecs, k );

% Assign cell array for output images
I = cell(k,1);

% Assign storage for the fake coloured image
meanVecs= zeros(height * width, 3);

% For each cluster
for i=1:k
    
    % Lookup the pixels for this cluster
    pixIndices = find(idx==i);
        
    % Separate them into an image segment as vectors
    segVecs = zeros(sz,3);
    
    % Assign pixel values from original to segment
    segVecs(pixIndices,:) = invecs(pixIndices,1:3);
    
    % Convert these back into an image
    segImage = reshape(segVecs, size(imrgb) );
    
    % convert back to RGB colour space
    segImage = hsv2rgb(segImage);
    
    % Store to cell array
    I{i} = uint8(round(segImage*255));
    
    % Now take care of the mean coloured image by
    % assigning HSV
    meanVecs(pixIndices) = c(i);
end

% Convert meanImage back to RGB
meanImage = reshape(meanVecs, size(imrgb) );
meanImage = hsv2rgb(meanImage);
meanImage = uint8(round(meanImage*255));

end