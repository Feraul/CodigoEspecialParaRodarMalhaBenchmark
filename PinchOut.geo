cl__1 = 1;
Point(1) = {0, 0, 0, 1};
Point(2) = {1, 0, 0, 1};
Point(3) = {1, 1, 0, 1};
Point(4) = {0, 1, 0, 1};
Point(5) = {0, 0.7, 0, 1};
Point(6) = {0, 0.25, 0, 1};
Point(7) = {0.83, 0.55, 0, 1};
Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 4};
Line(4) = {4, 5};
Line(5) = {5, 6};
Line(6) = {6, 1};
Line(7) = {6, 7};
Line(8) = {7, 5};
Line Loop(10) = {6, 1, 2, 3, 4, -8, -7};
Plane Surface(10) = {10};
Line Loop(12) = {8, 5, 7};
Plane Surface(12) = {12};
Physical Point(13) = {1, 4, 5, 6};
Physical Point(14) = {2, 3};
Physical Point(15) = {7};
Physical Line(16) = {4, 5, 6};
Physical Line(17) = {2};
Physical Line(18) = {1, 3};
Physical Line(19) = {7, 8};
Physical Surface(20) = {10};
Physical Surface(21) = {12};
