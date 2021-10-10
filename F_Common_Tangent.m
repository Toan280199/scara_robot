function [p_1,p_2]=F_Common_Tangent(c1,c2,r1,r2,flag,rho)
%get the Internal Common Tangents and External Common Tangents
%
%   Usage Example,
%   c1: %the center of the first cycle
%   c2: %the center of the second cycle
%   r1: %the radius of the first cycle
%   r2: %the radius of the second cycle
%   flag = Determine Internal tangent (flag = -1) or External tangent (flag = 1)
%   rho  = Sign of tangent point

if c1(1)==c2(1) && c1(2)==c2(2)
    p_1 = [i,i];
    p_2 = i;
    return
end

d = norm([c2(1)-c1(1), c2(2)-c1(2)]);
unitTangent = [c2(1)-c1(1), c2(2)-c1(2)] / d;
unitNormal = [c1(2)-c2(2), c2(1)-c1(1)] / d;
if (flag == -1)
    % Internal Common Tangents
    theta=acos((r1+r2)/d);
    if rho==-1
        p_1=c1+unitTangent*r1*cos(theta)+unitNormal*r1*sin(theta);
        p_2=c2-unitTangent*r2*cos(theta)-unitNormal*r2*sin(theta);
    else
        p_1=c1+unitTangent*r1*cos(theta)-unitNormal*r1*sin(theta);
        p_2=c2-unitTangent*r2*cos(theta)+unitNormal*r2*sin(theta);
    end
else
    theta=acos((r1-r2)/d);
    % External Common Tangents
    if rho == -1
        p_1=c1+unitTangent*r1*cos(theta)+unitNormal*r1*sin(theta);
        p_2=c2+unitTangent*r2*cos(theta)+unitNormal*r2*sin(theta);
    else
        p_1=c1+unitTangent*r1*cos(theta)-unitNormal*r1*sin(theta);
        p_2=c2+unitTangent*r2*cos(theta)-unitNormal*r2*sin(theta);   
    end
end