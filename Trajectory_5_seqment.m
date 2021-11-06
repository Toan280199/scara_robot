function [s,v,a] = Trajectory_5_seqment(s_max,v_max,a_max)

tc = v_max/a_max;
t_m = (s_max-2*a_max*tc^2)/(a_max*tc);
if t_m <= 0.0001
    disp('Nhap lai');
    return
end
tf = 4*tc + t_m;
%% Dieu kien
% s_max > 2*a_max*tc^2 = 2*v_max^2/a_max
% v_max < sqrt(0.5*s_max*a_max)

Jerk = a_max/tc;
t = linspace(0,tf,5001);
for i = 1:5001
    if t(i) <= tc
        a(i) = Jerk*t(i);
        v(i) = 1/2*Jerk*t(i)^2;
        s(i) = 1/6*Jerk*t(i)^3;
        a1 = a(end);
        v1 = v(end);
        s1 = s(end);
    elseif t(i) <= 2*tc
        a(i) = a1 + Jerk*-(t(i)-tc);
        v(i) = v1 - 1/2*Jerk*(t(i)-tc)^2 + a1*(t(i)-tc);
        s(i) = s1 - 1/6*Jerk*(t(i)-tc)^3 + 1/2*a1*(t(i)-tc)^2 + v1*(t(i)-tc);
        a2 = a(end);
        v2 = v(end);
        s2 = s(end);
    elseif t(i) <= 2*tc + t_m
        a(i) = 0;
        v(i) = v2;
        s(i) = s2 + v2*(t(i)-2*tc);
        a3 = a(end);
        v3 = v(end);
        s3 = s(end);
    elseif t(i) <= 3*tc + t_m
        a(i) = -Jerk*(t(i) - 2*tc - t_m);
        v(i) = v3 - 1/2*Jerk*(t(i) - 2*tc - t_m)^2 + a3*(t(i) - 2*tc - t_m);
        s(i) = s3 - 1/6*Jerk*(t(i) - 2*tc - t_m)^3 + 1/2*a3*(t(i) - 2*tc - t_m)^2 + v3*(t(i) - 2*tc - t_m);
        a4 = a(end);
        v4 = v(end);
        s4 = s(end);
    else
        a(i) = a4 + Jerk*(t(i) - 3*tc - t_m);
        v(i) = v4 + 1/2*Jerk*(t(i) - 3*tc - t_m)^2 + a4*(t(i) - 3*tc - t_m);
        s(i) = s4 + 1/6*Jerk*(t(i) - 3*tc - t_m)^3 + 1/2*a4*(t(i) - 3*tc - t_m)^2 + v4*(t(i) - 3*tc - t_m);
    end
end
v2
subplot(3,1,1)
hold on
grid on
title('q')
plot(t,s,'LineWidth',1.5);
subplot(3,1,2)
hold on
grid on
title('v')
plot(t,v,'LineWidth',1.5);
subplot(3,1,3)
hold on
grid on
title('a')
plot(t,a,'LineWidth',1.5);
xlabel('Time (s)')