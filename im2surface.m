% converts to coordinate system centered in image with x-axis in row
% direction and y-axis in column direction, each normalized to range
% [-0.5,0.5]
%
% return matrices X and Y, same size as img, 
% also returns F, a double matrix same size as img w/ values in range [0,1]
function [F,X,Y] = im2surface(img)
    [nr,nc] = size(img);    
    x = linspace(-0.5,0.5,nc)';
    y1 = linspace(-0.5,0.5,nr)';
    y = flipud(y1);
    [X,Y] = meshgrid(x,y);
    F = im2double(img);
end