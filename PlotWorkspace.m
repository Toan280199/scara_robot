function PlotWorkspace(handles,robot)

axes(handles.robot_plot);
theta1_m = robot.theta1_max*pi/180;
theta2_m = robot.theta2_max*pi/180;
d = robot.d;
d3_max = robot.d3_max;
theta1 = linspace(-theta1_m,theta1_m,181);
theta2 = linspace(-theta2_m,theta2_m,181);

fill3([(robot.a(1)+robot.a(2))*cos(theta1) 0],[(robot.a(1)+robot.a(2))*sin(theta1) 0],(robot.d(1)-d3_max)*ones(1,182),'r','FaceAlpha',0.15);
fill3([(robot.a(1)+robot.a(2))*cos(theta1) 0],[(robot.a(1)+robot.a(2))*sin(theta1) 0],robot.d(1)*ones(1,182),'r','FaceAlpha',0.15);

fill3([robot.a(1)*cos(theta1_m)+robot.a(2)*cos(theta1_m+theta2) robot.a(1)*cos(theta1_m)],[robot.a(1)*sin(theta1_m)+robot.a(2)*sin(theta1_m+theta2) robot.a(1)*sin(theta1_m)],(robot.d(1)-d3_max)*ones(1,182),'r','FaceAlpha',0.15);
fill3([robot.a(1)*cos(theta1_m)+robot.a(2)*cos(theta1_m+theta2) robot.a(1)*cos(theta1_m)],[robot.a(1)*sin(theta1_m)+robot.a(2)*sin(theta1_m+theta2) robot.a(1)*sin(theta1_m)],robot.d(1)*ones(1,182),'r','FaceAlpha',0.15);

fill3([robot.a(1)*cos(-theta1_m)+robot.a(2)*cos(-theta1_m+theta2) robot.a(1)*cos(-theta1_m)],[robot.a(1)*sin(-theta1_m)+robot.a(2)*sin(-theta1_m+theta2) robot.a(1)*sin(-theta1_m)],(robot.d(1)-d3_max)*ones(1,182),'r','FaceAlpha',0.15);
fill3([robot.a(1)*cos(-theta1_m)+robot.a(2)*cos(-theta1_m+theta2) robot.a(1)*cos(-theta1_m)],[robot.a(1)*sin(-theta1_m)+robot.a(2)*sin(-theta1_m+theta2) robot.a(1)*sin(-theta1_m)],robot.d(1)*ones(1,182),'r','FaceAlpha',0.15);

for i = 1:181
    plot3([(robot.a(1)+robot.a(2))*cos(theta1(i)) (robot.a(1)+robot.a(2))*cos(theta1(i))],[(robot.a(1)+robot.a(2))*sin(theta1(i)) (robot.a(1)+robot.a(2))*sin(theta1(i))],[robot.d(1)-d3_max robot.d(1)],'r');
    plot3([robot.a(1)*cos(theta1_m)+robot.a(2)*cos(theta1_m+theta2(i)) robot.a(1)*cos(theta1_m)+robot.a(2)*cos(theta1_m+theta2(i))],[robot.a(1)*sin(theta1_m)+robot.a(2)*sin(theta1_m+theta2(i)) robot.a(1)*sin(theta1_m)+robot.a(2)*sin(theta1_m+theta2(i))],[robot.d(1)-d3_max robot.d(1)],'r');
    plot3([robot.a(1)*cos(-theta1_m)+robot.a(2)*cos(-theta1_m+theta2(i)) robot.a(1)*cos(-theta1_m)+robot.a(2)*cos(-theta1_m+theta2(i))],[robot.a(1)*sin(-theta1_m)+robot.a(2)*sin(-theta1_m+theta2(i)) robot.a(1)*sin(-theta1_m)+robot.a(2)*sin(-theta1_m+theta2(i))],[robot.d(1)-d3_max robot.d(1)]);
end

if (robot.a(1)-robot.a(2))>0
    fill3((robot.a(1)-robot.a(2))*cos(-pi:0.1:pi),(robot.a(1)-robot.a(2))*sin(-pi:0.1:pi),(robot.d(1)-d3_max)*ones(1,63),'g','FaceAlpha',0.155);
    fill3((robot.a(1)-robot.a(2))*cos(-pi:0.1:pi),(robot.a(1)-robot.a(2))*sin(-pi:0.1:pi),(robot.d(1))*ones(1,63),'g','FaceAlpha',0.155);
end