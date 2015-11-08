function [ x2, y2 ] = epipolarCorrespondence( im1, im2, F, x1, y1 )
% epipolarCorrespondence:
%       im1 - Image 1
%       im2 - Image 2
%       F - Fundamental Matrix between im1 and im2
%       x1 - x coord in image 1
%       y1 - y coord in image 1

% Q2.6 - Todo:
%           Implement a method to compute (x2,y2) given (x1,y1)
%           Use F to only scan along the epipolar line
%           Experiment with different window sizes or weighting schemes
%           Save F, pts1, and pts2 used to generate view to q2_6.mat
%
%           Explain your methods and optimization in your writeup
    im1 = rgb2gray(im1);
    im2 = rgb2gray(im2);

    psize = 16;
    x2 = zeros(size(x1));
    y2 = zeros(size(y1));
    
    for j = 1 : size(x1,1)
    
        srcPatch = impatch(im1, [x1(j), y1(j)], psize);

    %     find epipolar line
        eLine = epipolarLine(F, [x1(j) ,y1(j)]);
        points = lineToBorderPoints(eLine, size(im2));

        d = pdist2(points(1:2), points(3:4));

        minErr = intmax;
        xrange = linspace(points(1),points(3),d);
        for i = 1 : length(xrange)
            x = xrange(i);
            y = - (eLine(1)*x + eLine(3)) / eLine(2);
            d = pdist2([x1(j) y1(j)], [x y]);
            if d > 64
                continue;
            end

            patch = impatch(im2, [x,y], psize);

            % match patch with srcPatch
            err = abs(srcPatch - patch);
            err = sum(err(:));
            if err < minErr
                minErr = err;
                x2(j) = x;
                y2(j) = y;
            end
        end
    
    end

end
