function [ F ] = sevenpoint( pts1, pts2, M )
% sevenpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.2 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save recovered F (either 1 or 3 in cell), M, pts1, pts2 to q2_2.mat

%     Write recovered F and display the output of displayEpipolarF in your writeup

    n = size(pts1, 1);
    if n ~= 7
        error('It is expected to process only with 7 correspondance points');
    end

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
    
%     svd(A) gives V - last 2 eigen vectors are f1 and f2. same as null
%     space of A
    f = null(A);
    
    F1 = reshape(f(:,1), [3,3]);
    F2 = reshape(f(:,2), [3,3]);
    
%     det( (1-lamda)*F1 + lamda*F2 ) = 0. solve the polynomial eqn
    l = sym('l');
    lambda = real(vpa(solve(det((1-l)*F1 + l*F2))));
    
    % For each value of lambda compute an F
    F = cell(length(lambda), 1);
    for i = 1 : length(lambda)
        % Compute F
        Fi = (1-lambda(i))*F1 + lambda(i)*F2;

        % Unscale F
        F{i} = T' * Fi * T;
    end
    
end

