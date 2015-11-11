% run findM2.m before this script
findM2;

load('../data/templeCoords.mat');

[x2, y2] = epipolarCorrespondence(im1, im2, F, x1, y1);

C1 = K1 * M1;
C2 = K2 * M2;

point3d = triangulate(C1, [x1 y1], C2, [x2 y2]);

scatter3(point3d(:,1), point3d(:,2), point3d(:,3), 200);
