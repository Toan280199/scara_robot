function  [q,v,a,t,P] = CircularPlanning(P1,P2,v_max,a_max,mode)
%% Code ve cung tron di qua 2 diem P1, P2 (P3 la diem phu) P2, P3: 3x1 matrix
% mode = 0 => van toc hinh thang
% mode = 1 => S-curve

P3 = (P1+P2)/2+[0.1;0.1;0];
% P3 = [0.85;0;0.1];

%% Unit vector orthogonal to plane of 3 points
v1 = cross(P2-P1,P3-P1);
v1 = v1/norm(v1); 

%% The center, P0, must satisfy these three equations:
% dot(P0-P1,v1) = 0
% dot(P0-(p2+P1)/2,P2-P1) = 0
% dot(P0-(p3+P1)/2,P3-P1) = 0

A = [v1';P2'-P1';P3'-P1'];
B = [dot(P1',v1');dot((P1'+P2')/2,P2'-P1');dot((P1'+P3')/2,P3'-P1')];
P0 = A\B

R = norm(P1-P0);

v2 = P1-P0;
R = norm(v2);
v2 = v2/R;
v3 = cross(v2,v1);
v3 = v3/norm(v3);

s_max = R*acos(dot((P1-P0)/R,(P2-P0)/R));
s_max = real(s_max);
if s_max > 0
    rho = 1;
else
    s_max = -s_max;
    rho = -1;
end

if mode == 0
    [q,v,a,t,~] = Trajectory_3_seqment(s_max,v_max,a_max);
else
    [q,v,a,t,~] = Trajectory_5_seqment(s_max,v_max,a_max);
end

syms tt;
t1 = solve(v2 - v2*cos(tt) - v3*sin(tt),tt);
t1 = double(t1);

P = P0 + R*(v2*cos(t1+rho*q/R) + v3*sin(t1+rho*q/R));
