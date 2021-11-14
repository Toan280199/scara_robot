function SetupFigure2(t,q,v,a)

%% figure 2: plot qx, qy, qz, q, v, a
figure(2)
clf
subplot(6,2,1)
hold on
grid on
title('qx');

subplot(6,2,3)
hold on
grid on
title('qy');

subplot(6,2,5)
hold on
grid on
title('qz');
xlabel('Time (s)');

subplot(6,2,7)
hold on
grid on
title('q');

subplot(6,2,9)
hold on
grid on
title('v');

subplot(6,2,11)
hold on
grid on
title('a');
xlabel('Time (s)');

subplot(6,2,7)
plot(t,q,'r','LineWidth',1.5);

subplot(6,2,9)
plot(t,v,'r','LineWidth',1.5);

subplot(6,2,11)
plot(t,a,'r','LineWidth',1.5);

%% plot theta_dot
subplot(6,2,2)
hold on
grid on
title('$\dot{\theta_1}$ (deg/s)', 'Interpreter','latex')

subplot(6,2,4)
hold on
grid on
title('$\dot{\theta_2}$ (deg/s)', 'Interpreter','latex')

subplot(6,2,6)
hold on
grid on
title('$\dot{d_3}$ (m/s)', 'Interpreter','latex')

subplot(6,2,8)
hold on
grid on
title('$\dot{\theta_4}$ (deg/s)', 'Interpreter','latex')
xlabel('Time (s)');