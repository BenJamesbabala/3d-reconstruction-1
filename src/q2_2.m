% load('../data/some_corresp.mat');

im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');

M = max(size(im1,1), size(im1,2));

% pts1 and pts2 can be selected manually using cpselect(im1,im2);
perm = randperm(size(pts1,1), 7);

% creates 3 possible Fs based on polynomial roots
F = sevenpoint(pts1(perm,:), pts2(perm,:), M);

% check manually using displayEpipolarF.m
% F = F{1};

save('q2_2.mat', 'F', 'M', 'pts1' ,'pts2');
