function draw_path_circle(handles,q,v,a,t,joint_space,P,clr)

dt = t(2) - t(1);
yaw = joint_space(:,1) + joint_space(:,2) + joint_space(:,4);

xd = P(1,:);
yd = P(2,:);
zd = P(3,:);

x_dot = [0 diff(xd)/dt];
y_dot = [0 diff(yd)/dt];
z_dot = [0 diff(zd)/dt];

x_2dot = [0 0 diff(xd,2)/dt^2];
y_2dot = [0 0 diff(yd,2)/dt^2];
z_2dot = [0 0 diff(zd,2)/dt^2];

%% ve qx
plot(handles.ax_x,t,xd,clr,'LineWidth',1.5);
plot(handles.ax_xd,t,xd,clr,'LineWidth',1.5);

%% ve xdot, x2dot
plot(handles.ax_x_dot,t,x_dot,clr,'LineWidth',1.5);
plot(handles.ax_x_2dot,t,x_2dot,clr,'LineWidth',1.5);

%% ve qy
plot(handles.ax_y,t,yd,clr,'LineWidth',1.5);
plot(handles.ax_yd,t,yd,clr,'LineWidth',1.5);

%% ve ydot y2dot
plot(handles.ax_y_dot,t,y_dot,clr,'LineWidth',1.5);
plot(handles.ax_y_2dot,t,y_2dot,clr,'LineWidth',1.5);

%% ve qz
plot(handles.ax_z,t,zd,clr,'LineWidth',1.5);
plot(handles.ax_zd,t,zd,clr,'LineWidth',1.5);

%% ve zdot z2dot
plot(handles.ax_z_dot,t,z_dot,clr,'LineWidth',1.5);
plot(handles.ax_z_2dot,t,z_2dot,clr,'LineWidth',1.5);

%% ve qyaw
plot(handles.ax_yaw,t,yaw,clr,'LineWidth',1.5);

%% Ve q
plot(handles.ax_q,t,q,clr,'LineWidth',1.5);

%% Ve v
plot(handles.ax_v,t,v,clr,'LineWidth',1.5);

%% Ve a
plot(handles.ax_a,t,a,clr,'LineWidth',1.5);

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
