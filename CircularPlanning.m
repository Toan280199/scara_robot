function  [q_max, p]= CircularPlanning(p_pre,p_desired)
% p: the set of points lying on the arc
% p_pre = [x y z] old position
% p_desired = [x y z] desired position

p_x_old = p_pre(1);
p_y_old = p_pre(2);
p_z_old = p_pre(3);

% desired value
p_x = p_desired(1);
p_y = p_desired(2);
p_z = p_desired(3);
%%
% cal distance
q_max = ((p_x - p_x_old)^2+(p_y - p_y_old)^2+(p_z - p_z_old)^2)^(1/2);
% cal 3d vector parameters
%%
%%
p1 = [p_x_old ; p_y_old ; p_z_old];
p2 = [p_x     ; p_y     ; p_z];
%% 
% Vector phap tuyen
n_vec = p2 - p1;
% Trung diem AB
I = (p1+p2)/2;
% plot3(I(1),I(2),I(3),'gx')
syms x_cir y_cir z_cir
P = dot(n_vec, [x_cir-I(1);y_cir-I(2);z_cir-I(3)]);
if isreal(coeffs(P,x_cir))
     z_cir = I(3);
     y_cir = I(2)-0.5;
     x_cir = eval(solve(P,x_cir));
elseif isreal(coeffs(P,y_cir))
    x_cir = I(1)-0.5;
    z_cir = I(3);
    y_cir = eval(solve(P,y_cir))    ;
elseif isreal(coeffs(P,z_cir))
    x_cir = I(1)-0.5;
    y_cir = I(2)-0.5;
    z_cir = eval(solve(P,z_cir))  ;
elseif (p_x== p_x_old)
    x_cir = I(1)-0.5;
    y_cir = I(2)-0.5;
    z_cir = eval(solve(P,z_cir));
elseif (p_z== p_z_old)
    z_cir = I(3);
    y_cir = I(2)-0.5;
    x_cir = eval(solve(P,x_cir));
elseif (p_y== p_y_old)
    z_cir = I(3);
    y_cir = I(2)-0.5;
    x_cir = eval(solve(P,x_cir));
else
    x_cir = I(1)-0.5;
    y_cir = I(2)-0.5;
    z_cir = eval(solve(P,z_cir))  ;
end
O_cir(1) = x_cir;
O_cir(2) = y_cir;
O_cir(3) = z_cir;

OA = (O_cir' - p1);
OB = (O_cir' - p2);
z_hat = cross(OA,OB)/norm(cross(OA,OB));
%%
gamma_max = acos(dot(OA,OB)/(norm(OA)^2));

% tinh su tuong duong
gamma = linspace(0, gamma_max ,101);
Ox = -(OA*cos(gamma) + cross(z_hat , OA)*sin(gamma));
plot3(O_cir(1)+Ox(1,:),O_cir(2)+Ox(2,:),O_cir(3)+Ox(3,:),'b')
axis equal