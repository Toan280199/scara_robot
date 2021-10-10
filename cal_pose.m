function [P,O] = cal_pose(A,p0)
%% position
    p_extended  = [p0;1];
    P_temp =  A*p_extended;
    P = P_temp(1:3);
%% Orientation
    O(1)  = atan2(-A(2,3),A(3,3));
    O(2)  = asin(A(1,3));
    O(3)  = atan2(-A(1,2),A(1,1));
end