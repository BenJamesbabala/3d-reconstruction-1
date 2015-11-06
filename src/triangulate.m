function [ P, error ] = triangulate( M1, p1, M2, p2 )
% triangulate:
%       M1 - 3x4 Camera Matrix 1
%       p1 - Nx2 set of points
%       M2 - 3x4 Camera Matrix 2
%       p2 - Nx2 set of points

% Q2.4 - Todo:
%       Implement a triangulation algorithm to compute the 3d locations
%       See Szeliski Chapter 7 for ideas
%
    n = size(p1, 1);

    p1 = [p1 ones(n, 1)];
    p2 = [p2 ones(n, 1)];
    
    P = zeros(n,4);
    error = zeros(n,1);
    for i = 1 : n
        v1 = p1(i,:);
        v2 = p2(i,:);
        A = [M1(3,:) * v1(1) - M1(1,:); ...
            M1(3,:) * v1(2) - M1(2,:); ...
            M2(3,:) * v2(1) - M2(1,:); ...
            M2(3,:) * v2(2) - M2(2,:)];
        
        [~,~,V] = svd(A);
        p3d = V(:, end);
        p3d = p3d / p3d(end);
        P(i,:) = p3d';
        
        error(i) = pdist2(v1, reproject(p3d,M1)') + pdist2(v2, reproject(p3d,M2)');
    end
    
    error = mean(error);

end

function p2d = reproject(p3d, M)
    p2d = M * p3d;
    p2d = p2d / p2d(end);
end

