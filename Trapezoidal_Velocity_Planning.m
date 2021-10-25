function [t,q] = Trapezoidal_Velocity_Planning(tf,qi,qf)

%% qi: start positon
%% qf: final positon
%% qc_2dot: maximum acceblbration

qm = (qf + qi)/2;
tm = tf/2;
tc = tf/4;

qc_2dot = (qf-qi)/(1/16+1/8)/tf^2;
qc = qi + 1/2*qc_2dot*tc^2;

t = 0:0.001:tf;

for i = 1:length(t)
    if t(i) <= tc
        q(i) = qi + 1/2*qc_2dot*t(i)^2;
    elseif t(i) <= tf - tc
        q(i) = qi + qc_2dot*tc*(t(i)-tc/2);
    else
        q(i) = qf - 1/2*qc_2dot*(tf-t(i))^2;
    end
end

new_qc_2dot = qc_2dot;