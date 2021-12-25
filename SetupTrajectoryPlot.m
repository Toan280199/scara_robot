function SetupTrajectoryPlot(handles)

% axes to plot q, v, a
axes(handles.ax_q)
cla
hold on
grid on
title('q', 'Interpreter','latex')

axes(handles.ax_v)
cla
hold on
grid on
title('v', 'Interpreter','latex')

axes(handles.ax_a)
cla
hold on
grid on
title('a', 'Interpreter','latex')
xlabel('Time (s)');

% axes to plot joint space
axes(handles.ax_t1d)
cla
hold on
grid on
title('${\theta_1}$ (deg)', 'Interpreter','latex')

axes(handles.ax_t2d)
cla
hold on
grid on
title('${\theta_2}$ (deg)', 'Interpreter','latex')

axes(handles.ax_d3d)
cla
hold on
grid on
title('${d_3}$ (m/s)', 'Interpreter','latex')

axes(handles.ax_t4d)
cla
hold on
grid on
title('${\theta_4}$ (deg)', 'Interpreter','latex')
xlabel('Time (s)');

% plot theta1 theta2 d3 theta4 dot

axes(handles.ax_t1_dot)
cla
hold on
grid on
title('$\dot{\theta_1}$ (deg)', 'Interpreter','latex')

axes(handles.ax_t2_dot)
cla
hold on
grid on
title('$\dot{\theta_2}$ (deg)', 'Interpreter','latex')

axes(handles.ax_d3_dot)
cla
hold on
grid on
title('$\dot{d_3}$ (m/s)', 'Interpreter','latex')

axes(handles.ax_t4_dot)
cla
hold on
grid on
title('$\dot{\theta_4}$ (deg)', 'Interpreter','latex')
xlabel('Time (s)');

% 2 dot 

axes(handles.ax_t1_2dot)
cla
hold on
grid on
title('$\stackrel{..}{\theta_1}$ (deg)', 'Interpreter','latex')

axes(handles.ax_t2_2dot)
cla
hold on
grid on
title('$\stackrel{..}{\theta_2}$ (deg)', 'Interpreter','latex')

axes(handles.ax_d3_2dot)
cla
hold on
grid on
title('$\stackrel{..}{d_3}$ (m/s)', 'Interpreter','latex')

axes(handles.ax_t4_2dot)
cla
hold on
grid on
title('$\stackrel{..}{\theta_4}$ (deg)', 'Interpreter','latex')
xlabel('Time (s)');

% axes to plot tool space
axes(handles.ax_xd)
cla
hold on
grid on
title('${x}$ (m)', 'Interpreter','latex')

axes(handles.ax_yd)
cla
hold on
grid on
title('${y}$ (m)', 'Interpreter','latex')

axes(handles.ax_zd)
cla
hold on
grid on
title('${z}$ (m/s)', 'Interpreter','latex')
xlabel('Time (s)');

axes(handles.ax_x_dot)
cla
hold on
grid on
title('$\dot{x}$ (m/s)', 'Interpreter','latex')

axes(handles.ax_y_dot)
cla
hold on
grid on
title('$\dot{y}$ (m/s)', 'Interpreter','latex')

axes(handles.ax_z_dot)
cla
hold on
grid on
title('$\dot{z}$ (m/s)', 'Interpreter','latex')
xlabel('Time (s)');

axes(handles.ax_x_2dot)
cla
hold on
grid on
title('$\stackrel{..}{x}$ (m/s2)', 'Interpreter','latex')

axes(handles.ax_y_2dot)
cla
hold on
grid on
title('$\stackrel{..}{y}$ (m/s2)', 'Interpreter','latex')

axes(handles.ax_z_2dot)
cla
hold on
grid on
title('$\stackrel{..}{z}$ (m/s2)', 'Interpreter','latex')
xlabel('Time (s)');

% plot pid controller response
axes(handles.ax_x)
cla
hold on
grid on
title('x (m)', 'Interpreter','latex')

axes(handles.ax_y)
cla
hold on
grid on
title('y (m)', 'Interpreter','latex')

axes(handles.ax_z)
cla
hold on
grid on
title('z (m)', 'Interpreter','latex')

axes(handles.ax_yaw)
cla
hold on
grid on
title('${\psi}$ (deg)', 'Interpreter','latex')
xlabel('Time (s)');

axes(handles.ax_t1)
cla
hold on
grid on
title('${\theta_1}$ (deg)', 'Interpreter','latex')

axes(handles.ax_t2)
cla
hold on
grid on
title('${\theta_2}$ (deg)', 'Interpreter','latex')

axes(handles.ax_d3)
cla
hold on
grid on
title('${d_3}$ (m/s)', 'Interpreter','latex')

axes(handles.ax_t4t)
cla
hold on
grid on
title('${\theta_4}$ (deg)', 'Interpreter','latex')
xlabel('Time (s)');