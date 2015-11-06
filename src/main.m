load('../data/some_corresp.mat');
load('../data/intrinsics.mat');

im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');

M = max(size(im1,1), size(im1,2));

F = eightpoint(pts1, pts2, M);

%  select point
% cpselect(im1,im2);

sF = sevenpoint(p1, p2, M);
sF_ok = sF{1};  % found using displayEpipolarF manually

E = essentialMatrix(F, K1, K2);

