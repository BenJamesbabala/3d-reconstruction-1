# 3D-Reconstruction
"3D reconstruction using epipolar geometry"

Given two different images of the same scene from two different view points, the 3D structure of the object is constructed using epipolar geometry which uses Fundamental matrix, Essential matrix and Triangulation methods. The project is a work on an existing [dataset](http://vision.middlebury.edu/mview/data/)  "Temple of the Dioskouroi". The step by step walkthrough of the process is given in my page.

##### Code structure
/data    - contains two images, intinsic matrices of the camera used, and some correspondence points<br>
/src     - matlab code<br>
/results - screenshots of the output

/src/eightpoint.m <br>
Eight point algorithm implementation.

/src/sevenpoint.m<br>
Seven point algorithm implementation.

src/essentialMatrix.m<br>
Converts Fundamental matrix into the Essential matrix using two camera intrinsic matrices.

src/camera2.m<br>
Creates four possible extrinsic matrices of camera-2 using the Essential matrix.

src/triangulate.m<br>
Triangulates and creates 3D points using two camera matrices and correspondence points.

src/findM2.m<br>
Chooses the right camera matrix that estimates 3D points with all positive z-index.

src/epipolarCorrespondence.m<br>
Compute (x2,y2) given (x1,y1) using Fundamental matrix to only scan along the epipolar line.




Please feel free to contact me to know more about the project and code.
