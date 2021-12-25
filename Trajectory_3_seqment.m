function [q,v,a,t,v_max] = Trajectory_3_seqment(q_max,v_max,a_max)
%% condition
if v_max > sqrt(q_max*v_max)
    v_max = sqrt(q_max*v_max);
end

tc = v_max/a_max;
qc = 1/2*a_max*tc^2;
t_m = (q_max-2*qc)/v_max;
tf = 2*tc+t_m;

t = 0:tf/1000:tf;
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
% 
% subplot(3,1,1)
% hold on
% grid on
% title('q')
% plot(t,q,'LineWidth',1.5);
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