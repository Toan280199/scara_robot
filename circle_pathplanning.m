p0 = [1;21];
p1 = [3;4];
R = 5;
rho = -1;

%% Tim tam duong tron
midpoint = (p0+p1)/2;
dis = norm(p1-p0);
%% Tim vector phap tuyen
normalVec = [p1(2)-p0(2);p0(1)-p1(1)];
normalVec = normalVec/dis;
p_center = midpoint-sqrt(R^2-dis^2/4)*normalVec*rho;

phi1 = atan2(p0(2)-p_center(2),p0(1)-p_center(1));
phi2 = atan2(p1(2)-p_center(2),p1(1)-p_center(1));

if (phi2-phi1)*rho < 0
    phi2 = phi2 + rho*2*pi;
end

q = linspace(0,R*(phi2-phi1),101);

phi = linspace(phi1,phi2,101);
plot(p_center(1)+R*cos(q/R+phi1),p_center(2)+R*sin(q/R+phi1));
axis equal