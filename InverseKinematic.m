function [theta1,theta2,d3,theta4,ok] = InverseKinematic(x,y,z,yaw,a1,a2,d1)

%% Ham tinh dong hoc nguoc c?a robot
% Input: x y z yaw a1 a2
% Output: theta1 theta2 d3 theta4

c2 = (x^2 + y^2 - a1^2 - a2^2)/(2*a1*a2);
if abs(c2)<=1
    s2 = sqrt(1-c2^2);
    theta2 = atan2(s2,c2);
    t1 = [a1+a2*c2 -a2*s2;a2*s2 a1+a2*c2]^(-1)*[x;y];
    c1 = t1(1);
    s1 = t1(2);
    theta1 = atan(s1/c1);
    d3 = z - d1;
    theta4 = yaw - ( theta1 + theta2 );
    
    if(theta4>pi)
        theta4 = theta4-2*pi;
    end
    
    if(theta4<-pi)
        theta4 = theta4+2*pi;
    end
    
    ok = 1;
else
    ok = 0;
    warndlg('Out of workspace','Warning');
    return
end