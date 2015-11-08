% Q2.5 - Todo:
%       1. Load point correspondences
%       2. Obtain the correct M2
%       4. Save the correct M2, p1, p2, R and P to q2_5.mat

load('../data/some_corresp.mat');
load('../data/intrinsics.mat');

im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');

M = max(size(im1,1), size(im1,2));

F = eightpoint(pts1, pts2, M);

E = essentialMatrix(F, K1, K2);

M2s = camera2(E);

M1 = [eye(3) [0;0;0]];
M2 = [eye(3) [0;0;0]];
C1 = K1 * M1;

P = zeros(size(pts1,1), 4);
error = 0;
minNegZs = intmax;
for i = 1 : length(M2s)
    M2_tmp = M2s(:,:,i);
    C2 = K2 * M2_tmp;
    
    [newP, newE] = triangulate(C1, pts1, C2, pts2);
    
    % find the M2 for which the z-index is non-negative or has minimum negative
    % points
    negZs = length(find(newP(:,3) < 0));
    if negZs < minNegZs
        minNegZs = negZs;
        P = newP;
        error = newE;
        M2 = M2_tmp;
    end
end

save('q2_5.mat', 'M1', 'M2', 'pts1' ,'pts2', 'P', 'error');

clearvars -except M1 M2 pts1 pts2 P error im1 im2 F E K1 K2
