function [ F ] = eightpoint( pts1, pts2, M )
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save F, M, pts1, pts2 to q2_1.mat

%     Write F and display the output of displayEpipolarF in your writeup

    n = size(pts1, 1);

%  Make homogenous
    pts1 = [pts1 ones(n, 1)];
    pts2 = [pts2 ones(n, 1)];
    
%     scale down co-ordinates
    T = [2/M 0 -1; 0 2/M -1; 0 0 1];
    pts1 = pts1 * T';
    pts2 = pts2 * T';
    
    A = zeros(n, 9);
    
    for i = 1 : 3
        cols = 1+((i-1)*3) : i*3;
    	A(:, cols) = pts1 .* repmat(pts2(:,i), 1, 3);
    end

    [U, D, V] = svd(A);
    
%     force A to be singular by making last singulare value of D to 0,
%   and construct the F matrix again
    D(:,end) = 0;
    
    A = U * D * V';
    [~, ~, V] = svd(A);
    f = V(:,9);
    F = reshape(f, [3,3]);
    
    F = refineF(F, pts1, pts2);
    
    F = T' * F * T;
end
