function draw_path_linear(handles,q,v,a,t,theta,phi,joint_space,x0,y0,z0,clr)

dt = t(2) - t(1);
yaw = joint_space(:,1) + joint_space(:,2) + joint_space(:,4);

%% ve qx
plot(handles.ax_x,t,x0 + q*cos(theta)*cos(phi),clr,'LineWidth',1.5);
plot(handles.ax_xd,t,x0 + q*cos(theta)*cos(phi),clr,'LineWidth',1.5);

%% ve xdot, x2dot
plot(handles.ax_x_dot,t,v*cos(theta)*cos(phi),clr,'LineWidth',1.5);
plot(handles.ax_x_2dot,t,a*cos(theta)*cos(phi),clr,'LineWidth',1.5);

%% ve qy
plot(handles.ax_y,t,y0 + q*cos(theta)*sin(phi),clr,'LineWidth',1.5);
plot(handles.ax_yd,t,y0 + q*cos(theta)*sin(phi),clr,'LineWidth',1.5);

%% ve qyaw
plot(handles.ax_yaw,t,yaw,clr,'LineWidth',1.5);

%% ve ydot y2dot
plot(handles.ax_y_dot,t,v*cos(theta)*sin(phi),clr,'LineWidth',1.5);
plot(handles.ax_y_2dot,t,a*cos(theta)*sin(phi),clr,'LineWidth',1.5);

%% ve qz
plot(handles.ax_z,t,z0 + q*sin(theta),clr,'LineWidth',1.5);
plot(handles.ax_zd,t,z0 + q*sin(theta),clr,'LineWidth',1.5);

%% ve zdot z2dot
plot(handles.ax_z_dot,t,v*sin(theta),clr,'LineWidth',1.5);
plot(handles.ax_z_2dot,t,a*sin(theta),clr,'LineWidth',1.5);

%% Ve q
axes(handles.ax_q)
plot(t,q,clr,'LineWidth',1.5);

%% Ve v
axes(handles.ax_v)
plot(t,v,clr,'LineWidth',1.5);

%% Ve a
axes(handles.ax_a)
plot(t,a,clr,'LineWidth',1.5);

%% ve theta1, theta1_dot, theta1_2dpt
plot(handles.ax_t1,t,joint_space(:,1),clr,'LineWidth',1.5);
plot(handles.ax_t1d,t,joint_space(:,1),clr,'LineWidth',1.5);
plot(handles.ax_t1_dot,t,[0;diff(joint_space(:,1))/dt],clr,'LineWidth',1.5);
plot(handles.ax_t1_2dot,t,[0;0; diff(joint_space(:,1),2)/dt^2],clr,'LineWidth',1.5);

%% ve theta2, theta2_dot, theta2_2dot
plot(handles.ax_t2,t,joint_space(:,2),clr,'LineWidth',1.5);
plot(handles.ax_t2d,t,joint_space(:,2),clr,'LineWidth',1.5);
plot(handles.ax_t2_dot,t,[0;diff(joint_space(:,2))/dt],clr,'LineWidth',1.5);
plot(handles.ax_t2_2dot,t,[0;0; diff(joint_space(:,2),2)/dt^2],clr,'LineWidth',1.5);

%% ve d3, d3_dot, d3_2dot
plot(handles.ax_d3,t,joint_space(:,3),clr,'LineWidth',1.5);
plot(handles.ax_d3d,t,joint_space(:,3),clr,'LineWidth',1.5);
plot(handles.ax_d3_dot,t,[0;diff(joint_space(:,3))/dt],clr,'LineWidth',1.5);
plot(handles.ax_d3_2dot,t,[0;0; diff(joint_space(:,3),2)/dt^2],clr,'LineWidth',1.5);

%% ve theta4, theta4_dot, theta4_2dot
plot(handles.ax_t4t,t,joint_space(:,4),clr,'LineWidth',1.5);
plot(handles.ax_t4d,t,joint_space(:,4),clr,'LineWidth',1.5);
plot(handles.ax_t4_dot,t,[0;diff(joint_space(:,4))/dt],clr,'LineWidth',1.5);
plot(handles.ax_t4_2dot,t,[0;0; diff(joint_space(:,4),2)/dt^2],clr,'LineWidth',1.5);