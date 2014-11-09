img = rgb2gray(imread('../lze_patterns/kinect-pattern.png'));
dispImg = 0.1.*ones(size(img));
dispImg(size(img,1)/3:2/3*size(img,1),size(img,2)/3:2/3*size(img,2)) = 0.15; % square in the middle

img_shifted = shift_image_by_disparity(img,dispImg);

C = find_correspondences_cross_ratio(img>0,img_shifted>0);