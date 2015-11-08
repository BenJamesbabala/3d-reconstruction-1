function [ xs, xe, ys ,ye ] = epipolarLin( F, point, imgSize )

    point(3) = 1;
    sy = imgSize(1);
    sx = imgSize(2);

    l = F * point';

    s = sqrt(l(1)^2+l(2)^2);
    
    if s==0
        error('Zero line vector in displayEpipolar');
    end

    l = l/s;

    if l(1) ~= 0
        ye = sy;
        ys = 1;
        xe = -(l(2) * ye + l(3))/l(1);
        xs = -(l(2) * ys + l(3))/l(1);
    else
        xe = sx;
        xs = 1;
        ye = -(l(1) * xe + l(3))/l(2);
        ys = -(l(1) * xs + l(3))/l(2);
    end
end

