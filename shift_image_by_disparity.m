% TEST
% img = rgb2gray(imread('../lze_patterns/kinect-pattern.png'));
% dispImg = 0.1.*ones(size(img));

function img_shifted = shift_image_by_disparity(img,dispImg)
    
    assert( all(size(img)==size(dispImg)) );

    [F,X,Y] = im2surface(img);
        
    X_prime = X + dispImg; % only shifting along columns, i.e. assumes image is rectified so that epipolar lines are along rows
    
    %img_shifted = interp2(X,Y,im2double(img),X_prime,Y,'linear',0);
    img_shifted = interp2(X,Y,im2double(img),X_prime,Y,'nearest',0);
    
end
