function [I,meanImage] = kmeansSegLabSeeds(imrgb, k, seeds)
% Perform kmeans segmentation of an RGB image by converting to L*a*b*
% colour space and using both colour components and normalised image
% coordinates
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
error(nargchk(3, 3, nargin));       % Allow 2 inputs or 3
error(nargoutchk(2, 2, nargout));       % Allow 1 output

% Extract dimensions
[height, width, ~] = size(imrgb);

% First force imrgb to double values
imrgb = double(imrgb);

% Next normalise RGB values if they're greater than 1.0
if max(max(max(imrgb))) > 1
    imrgb = imrgb ./ 255;
end


% Convert into L*a*b* space to get at colour data
srgb2lab = makecform('srgb2lab');
imlab = applycform(imrgb,srgb2lab);

% Turn it into 3 column vectors
sz = height * width;
invecs = reshape(imlab, sz, 3 );

% Use only a and b
vecsab = double(invecs(:,2:3));

% Run kmeans against the ab vecs
[idx, c] = kmeans_d(vecsab, k, seeds );

% Assign cell array for output images
I = cell(k,1);

% Create a transform back from L*a*b* to RGB
lab2srgb = makecform('lab2srgb');

% Assign storage for the fake coloured image
meanVecs= zeros(height * width, 3);

% For each cluster
for i=1:k
    
    % Lookup the pixels for this cluster
    pixIndices = find(idx==i);
        
    % Separate them into an image segment as vectors
    segVecs = zeros(size(invecs));
    
    % Assign pixel values from original to segment
    segVecs(pixIndices,:) = invecs(pixIndices,:);
    
    % Convert these back into an image
    segImage = reshape(segVecs, size(imlab) );
    
    % convert back to RGB colour space
    segImage = applycform(segImage, lab2srgb);
    
    % Store to cell array
    I{i} = uint8(round(segImage*255));
    
    % Now take care of the mean coloured image by
    % assigning original L plus mean ab values
    meanVecs(pixIndices,1) = 25;
    meanVecs(pixIndices,2) = c(i,1);
    meanVecs(pixIndices,3) = c(i,2);
end

% Convert meanImage back to RGB
meanImage = reshape(meanVecs, size(imlab) );
meanImage = applycform(meanImage, lab2srgb);
meanImage = uint8(round(meanImage*255));

end