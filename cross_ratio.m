% Given collinear points A B C D (in order), 
% computes their cross-ratio (AC*BD)/(BC*AD)
% (which is invariant to perspective projections!)
%
% http://en.wikipedia.org/wiki/Cross-ratio
%
% X is 4x2 matrix, where each of 4 rows is image coordinates
% returns xr

% Test
% X = [0,0;1,2;2,4;3,6];
% th = 30*pi/180;
% R = [cos(th),-sin(th);sin(th),cos(th)];
% Y = [.5,.5,.5,.5;2,2,2,2]' .* X*R + 3.0; % skew, rotation, translation
% assert( cross_ratio(X) - cross_ratio(Y) < 1e-8 ); % test invariance

function xr = cross_ratio(X)
    % TODO: check collinearity
    assert( size(X,1)==4 );

    num = dot( X(1,:)-X(3,:), X(2,:)-X(4,:)); 
    denom = dot( X(2,:)-X(3,:), X(1,:)-X(4,:)); 
    
    xr = num ./ denom;
end