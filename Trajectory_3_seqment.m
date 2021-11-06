function [q,v,a] = TrajectoryPlanning(q_max,v_max,a_max)
close all
clc
tc = v_max/a_max;
qc = 1/2*a_max*tc^2;
t_m = (q_max-2*qc)/v_max;
if t_m < 0
    disp('Khong the co quy dao hinh thang')
    return
end
tf = 2*tc+t_m;

t = linspace(0,tf,1001);
for i=1:length(t)
    if t(i)<tc
        q(i)=1/2*a_max*t(i)^2;
        v(i) = a_max*t(i);
        a(i) = a_max;
    elseif t(i)<tc+t_m
        q(i) = qc + v_max*(t(i)-tc);
        v(i) = v_max;
        a(i) = 0;
    else
        q(i) = q_max - 1/2*a_max*(tf-t(i))^2;
        v(i) = a_max*(tf-t(i));
        a(i) = -a_max;
    end
end

subplot(3,1,1)
hold on
grid on
title('q')
plot(t,q,'LineWidth',1.5);
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