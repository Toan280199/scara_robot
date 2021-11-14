p0 = [0;0;0];
p1 = [1;-2;3];

theta = atan2(p1(3)-p0(3),sqrt((p1(1)-p0(1))^2+(p1(2)-p0(2))^2));
phi = atan2(p1(2)-p0(2),p1(1)-p0(1));

[q,~,~,t] = Trajectory_5_seqment(norm(p1-p0),0.9,2);

x = p0(1) + q*cos(theta)*cos(phi);
y = p0(2) + q*cos(theta)*sin(phi);
z = p0(3) + q*sin(theta);

figure
plot3(x,y,z);