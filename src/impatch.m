function [ patches ] = impatch( im, points, psize )
% Create patches of image around given coordinate points

    n = size(points,1);
    w = size(im,2);
    h = size(im,1);
    rgb = size(im,3);
    
    range = int16(-floor((psize-1)/2) : floor(psize/2));
    
    patches = uint8(zeros(psize, psize, rgb, n));
    for i = 1 : n
        x = int16(points(i,1));
        y = int16(points(i,2));
        
        xrange = range + x;
        yrange = range + y;
        
%         even if the point is around corners, this logic moves it to the
%         start/end of the image
        if min(xrange) < 1
            xrange = xrange + (1-min(xrange));
        elseif max(xrange) > w
            xrange = xrange - (max(xrange)-w);
        end
        
        if min(yrange) < 1
            yrange = yrange + (1-min(yrange));
        elseif max(yrange) > h
            yrange = yrange - (max(yrange)-h);
        end
        
        patches(:,:,:,i) = im(yrange, xrange, :);
    end

end

