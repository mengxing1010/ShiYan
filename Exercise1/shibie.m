t = 0:0.1:2*pi;
x = sin(t);
y = cos(t);

figure
patch(x,y,'r')            % make a red circular patch
patch(x+0.8,y,'g')        % make a green circular path
patch(x+0.4,y+0.8,'b')    % make a blue circular path
axis square tight         % set axis to square

alpha(0.3)                % set all patches transparency to 0.3
[X,Y,Z] = peaks(20);
s2 = surf(X,Y,Z);

s2.AlphaData = gradient(Z);    % set vertex transparencies
s2.FaceAlpha = 'flat';
earth = imread('landOcean.jpg');
image(earth)    % display Earth image
axis image
clouds = imread('cloudCombined.jpg');
image(earth)
axis image
hold on

im = image(clouds);
im.AlphaData = max(clouds,[],3);    % set transparency to maximum cloud value
hold off
cla
p1 = patch(x,y,'r');             % make a red circular patch
axis square tight                % set axis to square

p1.FaceVertexAlphaData = 0.2;    % Set constant transparency 
p1.FaceAlpha = 'flat' ;          % Interpolate to find face transparency
p1.FaceVertexAlphaData = x';   % Set vertex transparency to x values
p1.FaceAlpha = 'interp' ;      % Interpolate to find face transparency
[px,py,pz] = sphere(50);                % generate coordinates for a 50 x 50 sphere

cla
sEarth = surface(py, px ,flip(pz));   
sEarth.FaceColor = 'texturemap';        % set color to texture mapping
sEarth.EdgeColor = 'none';              % remove surface edge color
sEarth.CData = earth;                   % set color data 

hold on
sCloud = surface(px*1.02,py*1.02,flip(pz)*1.02); 

sCloud.FaceColor = 'texturemap';        % set color to texture mapping
sCloud.EdgeColor = 'none';              % remove surface edge color
sCloud.CData = clouds;                  % set color data 
 
sCloud.FaceAlpha = 'texturemap';        % set transparency to texture mapping
sCloud.AlphaData = max(clouds,[],3);    % set transparency data 
hold off

view([80 2])                            % specify viewpoint 
daspect([1 1 1])                        % set aspect ratio
axis off tight                          % remove axis and set limits to data range