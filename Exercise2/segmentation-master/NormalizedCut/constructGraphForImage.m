function [W,D] = constructGraphForImage( image, sigmaI, sigmaD, r )
% Builds a graph representing the input image where the nodes are pixels of
% the image and the weights on the edges represent the degree of affinity
% between the pixels as decribed in 
% Inputs
%   image    : An image either greyscale or colour
%   sigmaI   : A scale factor for intensity value affinity
%   sigmaD   : A scale factor for distance affinity
%   r        : The radius within which edges are constructed for pixels. Outside this radius, weights are set to 0
%
% Outputs
%   W        : The symmetric weights matrix representing the graph 
%   D        : The degree of each node 

    % Extract the dimensions of the image
    [height, width, colourDepth] = size(image);
    
    % Scale factors
    if ~sigmaD
        sigmaD = 4.5;
    end
    if ~sigmaI
        sigmaI = 0.5;
    end
    if ~r
        r = 9;
    end
    
    % Now make a matrix of edge weights
    numNodes = width * height;
    Wij = zeros(numNodes, numNodes);
    
    % For each pixel, calculate the weght of the link to all other pixels
    for sourceNode = 1:numNodes-1
        % MUST generate x and y columnwise or else later reshapes break
        % things!
        % Determine source pixel coordinates
        sourceX = ceil(sourceNode / height);
        sourceY = sourceNode - ((sourceX - 1) * height);
        
        % Don't visit every node twice
        for destNode =sourceNode+1:numNodes
            % Determine dest pixel coordinates
            destX = ceil(destNode / height);
            destY = destNode - ((destX -1)* height);
            
            % Spatial constraint is that the pixels must be within
            % radius r
            dx = destX - sourceX;
            dy = destY - sourceY;
            dist = sqrt(dx*dx +dy*dy);
                    
            % If we're in radius, calculate affinity weight
            if dist <= r
                % Brightness component
                if colourDepth == 1
                    F = greyLevelAffinity( sourceX, sourceY, destX, destY, image );
                else
                    F = hsvLevelAffinity( sourceX, sourceY, destX, destY, image );
                end
%                featureAffinity = exp(-(F * F)/(2*sigmaI*sigmaI));
                featureAffinity = exp(-(F * F)/(sigmaI*sigmaI));
%                featureAffinity = exp(-(F * F)/sigmaI);
                        
                % Distance component - normalised
                normalisedDx = dx / width;
                normalisedDy = dy / height;
%                distanceAffinity = exp( -((normalisedDx*normalisedDx + normalisedDy*normalisedDy)/ (2 * sigmaD * sigmaD)) );
%               distanceAffinity = exp( -((dist*dist)/( 2 * sigmaD * sigmaD) ) );
               distanceAffinity = exp( -((dist*dist)/(sigmaD * sigmaD) ) );
%               distanceAffinity = exp( -((dist*dist)/sigmaD  ) );
                        
                weight = distanceAffinity * featureAffinity;
            else
                % Outside radius, weight = 0
                weight = 0;
            end
            
            % Save weight symmetrically
            Wij( sourceNode, destNode) = weight / 2.0;
            Wij( destNode, sourceNode) = weight / 2.0;
        end % destNode
    end % sourceNode

    % Convert Wij to sparse matrix to improve performance later
    W = sparse(Wij);

    % Construct the degree matrix D
    d = sum(W, 2);
    D = spdiags(d, 0, numNodes, numNodes );

end

%% Weighting function for grey level images
function dF = greyLevelAffinity( sourceX, sourceY, destX, destY, image )
    Fi = double(image(sourceY, sourceX));
    Fj = double(image(destY, destX));
    dF = abs(Fi - Fj);
end

%% Weighting function for colour images; assumed to be HSV
function dF = hsvLevelAffinity( sourceX, sourceY, destX, destY, image )
 HSVi = image(sourceY, sourceX, 1:3 );
 HSVj = image(destY, destX, 1:3 );
 
 Fi = [HSVi(1,1,3), HSVi(1,1,2) * HSVi(1,1,3) * sin(HSVi(1,1,1)), HSVi(1,1,2) * HSVi(1,1,3) * cos(HSVi(1,1,1))];
 Fj = [HSVj(1,1,3), HSVj(1,1,2) * HSVj(1,1,3) * sin(HSVj(1,1,1)), HSVj(1,1,2) * HSVj(1,1,3) * cos(HSVi(1,1,1))];
 
 dF = norm( ( Fi - Fj ) , 2 );
end



