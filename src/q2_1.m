load('../data/some_corresp.mat');

im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');

M = max(size(im1,1), size(im1,2));

F = eightpoint(pts1, pts2, M);

save('q2_1.mat', 'F', 'M', 'pts1' ,'pts2');
