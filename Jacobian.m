function J = Jacobian(robot)

a = robot.a;
alpha = robot.alpha;
d = robot.d;
theta = robot.theta;

A01 = Link_matrix(a(1),alpha(1),d(1),theta(1));
A12 = Link_matrix(a(2),alpha(2),d(2),theta(2));
A23 = Link_matrix(a(3),alpha(3),d(3),theta(3));
A34 = Link_matrix(a(4),alpha(4),d(4),theta(4));

A02 = A01*A12;
A03 = A02*A23;
A04 = A03*A34;

z0 = [0 0 1]';
p0 = [0 0 0]';

z1 = A01(1:3,3);
z2 = A02(1:3,3);
z3 = A03(1:3,3);
z4 = A04(1:3,3);

p1 = A01(1:3,4);
p2 = A02(1:3,4);
p3 = A03(1:3,4);
p4 = A04(1:3,4);

%% Khop 1 xoay, khop 2 xoay, khop 3 tinh tien, khop 4 xoay

J = [cross(z0,p4-p0) cross(z1,p4-p1) z2 cross(z3,p4-p3);
     z0 z1 0 z3];