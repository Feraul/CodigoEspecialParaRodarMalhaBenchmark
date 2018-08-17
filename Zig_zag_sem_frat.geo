cl1 = 0.05;

Point(1) = {0, 0, 0, cl1};
Point(2) = {0, 1, 0, cl1};
Point(3) = {1, 1, 0, cl1};
Point(4) = {1, 0, 0, cl1};
Point(5) = {0.292, 1, 0, cl1};
Point(6) = {0.711, 1, 0, cl1};
Point(7) = {0.711, 0, 0, cl1};
Point(8) = {0.292, 0, 0, cl1};
Point(9) = {0.292, 0.48, 0, cl1};
Point(10) = {0.711, 0.48, 0, cl1};
Point(11) = {0.292, 0.52, 0, cl1};
Point(12) = {0.711, 0.52, 0, cl1};
Point(13) = {0.15, 0.52, 0, cl1};
Point(14) = {0.85, 0.52, 0, cl1};
Point(15) = {0.15, 0.48, 0, cl1};
Point(16) = {0.85, 0.48, 0, cl1};

Line(1) = {1, 8};
Line(2) = {8, 7};
Line(3) = {7, 4};
Line(4) = {4, 3};
Line(5) = {3, 6};
Line(6) = {6, 5};
Line(7) = {5, 2};
Line(8) = {2, 1};
Line(9) = {8, 9};
Line(10) = {9, 11};
Line(11) = {11, 5};
Line(12) = {6, 12};
Line(13) = {12, 10};
Line(14) = {10, 7};
Line(15) = {15, 9};
Line(16) = {9, 10};
Line(17) = {10, 16};
Line(18) = {16, 14};
Line(19) = {14, 12};
Line(20) = {12, 11};
Line(21) = {11, 13};
Line(22) = {13, 15};

Line Loop(1) = {7, 8, 1, 9, -15, -22, -21, 11};
Plane Surface(1) = {1};

Line Loop(2) = {6, -11, -20, -12};
Plane Surface(2) = {2};

Line Loop(3) = {16, 14, -2, 9};
Plane Surface(3) = {3};

Line Loop(4) = {5, 12, -19, -18, -17, 14, 3, 4};
Plane Surface(4) = {4};

Line Loop(5) = {21, 22, 15, 10};
Plane Surface(5) = {5};

Line Loop(6) = {20, -10, 16, -13};
Plane Surface(6) = {6};

Line Loop(7) = {18, 19, 13, 17};
Plane Surface(7) = {7};

Physical Point(101) = {3, 6, 5, 2, 1, 8, 7, 4};

Physical Line(101) = {1, 2, 3, 4, 5, 6, 7, 8};

Physical Surface(1) = {1};
Physical Surface(2) = {2, 3};
Physical Surface(3) = {4};
Physical Surface(4) = {5};
Physical Surface(5) = {6};
Physical Surface(6) = {7};