function [s,v,a,t,v_max] = Trajectory_5_seqment(s_max,v_max,a_max)


if v_max > sqrt(0.5*s_max*a_max)-0.01;
    v_max = sqrt(0.5*s_max*a_max)
    tc = v_max/a_max;
    tf = 4*tc;
    t_m = 0;
else
    tc = v_max/a_max;
    t_m = (s_max-2*a_max*tc^2)/(a_max*tc);
    tf = 4*tc + t_m;
end

%% Dieu kien
% s_max > 2*a_max*tc^2 = 2*v_max^2/a_max
% v_max < sqrt(0.5*s_max*a_max)

Jerk = a_max/tc;
t = 0:tf/1000:tf
for i = 1:length(t)
    if t(i) <= tc
        a(i) = Jerk*t(i);
        v(i) = 1/2*Jerk*t(i)^2;
        s(i) = 1/6*Jerk*t(i)^3;
        a1 = Jerk*tc;
        v1 = 1/2*Jerk*tc^2;
        s1 = 1/6*Jerk*tc^3;
    elseif t(i) <= 2*tc
        a(i) = a1 + Jerk*-(t(i)-tc);
        v(i) = v1 - 1/2*Jerk*(t(i)-tc)^2 + a1*(t(i)-tc);
        s(i) = s1 - 1/6*Jerk*(t(i)-tc)^3 + 1/2*a1*(t(i)-tc)^2 + v1*(t(i)-tc);
        a2 = 0;
        v2 = v(end);
        s2 = s(end);
        a3 = 0;
        v3 = v2;
        s3 = s_max-s2;
    elseif t(i) <= 2*tc + t_m
        a(i) = 0;
        v(i) = v2;
        s(i) = s2 + v2*(t(i)-2*tc);
    elseif t(i) <= 3*tc + t_m
        a(i) = -Jerk*(t(i) - 2*tc - t_m);
        v(i) = v3 - 1/2*Jerk*(t(i) - 2*tc - t_m)^2 + a3*(t(i) - 2*tc - t_m);
        s(i) = s3 - 1/6*Jerk*(t(i) - 2*tc - t_m)^3 + 1/2*a3*(t(i) - 2*tc - t_m)^2 + v3*(t(i) - 2*tc - t_m);
        a5 = 0;
        v5 = 0;
        s5 = s_max;
    else
        a(i) = Jerk*(t(i) - tf);
        v(i) = 1/2*Jerk*(t(i) - tf)^2;
        s(i) = s5 + 1/6*Jerk*(t(i) - tf)^3;
    end
end

% subplot(3,1,1)
% hold on
% grid on
% title('q')
% plot(t,s,'LineWidth',1.5);
% subplot(3,1,2)
% hold on
% grid on
% title('v')
% plot(t,v,'LineWidth',1.5);
% subplot(3,1,3)
% hold on
% grid on
% title('a')
% plot(t,a,'LineWidth',1.5);
% xlabel('Time (s)')