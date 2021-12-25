function UpdateRobot(robot,handles,Az,El)

global plot_pos

set(handles.cb_view_ws,'Value',0);
set(handles.cb_show_coor,'Value',0);
set(handles.tb_dh,'Data',[robot.a robot.alpha robot.d robot.theta]);   %put dh parameter to DH table
set(handles.tb_pos_orien,'Data',[robot.pos robot.orien*180/pi]);   %put dh parameter to DH table

robot_plot = handles.robot_plot;
cla(robot_plot,'reset')
hold(robot_plot,'on')
grid(robot_plot,'on')

if ~isempty(plot_pos)
    plot3(robot_plot,plot_pos(:,1),plot_pos(:,2),plot_pos(:,3),'b','LineWidth',1.5);
end

p0 = [0 0 0];
p1 = robot.pos(1,:);
p2 = robot.pos(2,:);
p3 = robot.pos(3,:);
p4 = robot.pos(4,:);
d = robot.d;
a = robot.a;
orien = robot.orien;

% define links
line1=[[p0(1) p1(1)];[p0(2) p1(2)];[p0(3) p1(3)]];
line2=[[p1(1) p2(1)];[p1(2) p2(2)];[p1(3) p2(3)]];
line3=[[p2(1) p3(1)];[p2(2) p3(2)];[p2(3) p3(3)]];
line4=[[p3(1) p4(1)];[p3(2) p4(2)];[p3(3) p4(3)]];

xlabel(robot_plot,'x');
ylabel(robot_plot,'y');
zlabel(robot_plot,'z');
% xlim(robot,[-1 1]);
% ylim(robot,[-1 1]);
% zlim(robot_plot,[0.0 inf]);

%draw ground
t = (1/16:1/32:1)'*2*pi;
x = (a(1)+a(2))*cos(t);
y = (a(1)+a(2))*sin(t);
z = zeros(length(t),1);
fill3(robot_plot,x,y,z,'g','FaceAlpha',0.25);
view(robot_plot,Az,El)

% Ve base
VeHop(handles,0,0,0,0.24,0.24,0.02,[0.9290 0.6940 0.1250])
VeHinhTru(handles,0,0,0.02,0.12,0.7457*d(1),[0.9290 0.6940 0.1250])
% 
% %link 1
VeHinhTru(handles,line1(1,1),line1(2,1),0.7826*d(1),0.1,0.0185*d(1),[0.9290 0.6940 0.1250]);
VeHinhTru(handles,line1(1,2),line1(2,2),0.7826*d(1),0.1,0.0185*d(1),[0.9290 0.6940 0.1250]);
VeHinhTru(handles,line1(1,2),line1(2,2),0.8076*d(1),0.1,0.08,[0.9290 0.6940 0.1250]);
VeHinhTru(handles,line1(1,1),line1(2,1),0.8076*d(1),0.1,0.08,[0.9290 0.6940 0.1250]);

[pp1,pp2]=F_Common_Tangent([line1(1,1) line1(2,1)],[line1(1,2) line1(2,2)],0.1,0.1,1,-1);
[pp4,pp3]=F_Common_Tangent([line1(1,1) line1(2,1)],[line1(1,2) line1(2,2)],0.1,0.1,1,1);

fill3(robot_plot,[pp1(1) pp2(1) pp3(1) pp4(1)],[pp1(2) pp2(2) pp3(2) pp4(2)],[0.8076*d(1) 0.8076*d(1) 0.8076*d(1) 0.8076*d(1)],[0.9290 0.6940 0.1250])
fill3(robot_plot,[pp1(1) pp2(1) pp3(1) pp4(1)],[pp1(2) pp2(2) pp3(2) pp4(2)],[0.9815*d(1) 0.9815*d(1) 0.9815*d(1) 0.9815*d(1)],[0.9290 0.6940 0.1250])
fill3(robot_plot,[pp1(1) pp4(1) pp4(1) pp1(1)],[pp1(2) pp4(2) pp4(2) pp1(2)],[0.8076*d(1) 0.8076*d(1) 0.9815*d(1) 0.9815*d(1)],[0.9290 0.6940 0.1250])
fill3(robot_plot,[pp3(1) pp4(1) pp4(1) pp3(1)],[pp3(2) pp4(2) pp4(2) pp3(2)],[0.8076*d(1) 0.8076*d(1) 0.9815*d(1) 0.9815*d(1)],[0.9290 0.6940 0.1250])
fill3(robot_plot,[pp2(1) pp3(1) pp3(1) pp2(1)],[pp2(2) pp3(2) pp3(2) pp2(2)],[0.8076*d(1) 0.8076*d(1) 0.9815*d(1) 0.9815*d(1)],[0.9290 0.6940 0.1250])
fill3(robot_plot,[pp1(1) pp2(1) pp2(1) pp1(1)],[pp1(2) pp2(2) pp2(2) pp1(2)],[0.8076*d(1) 0.8076*d(1) 0.9815*d(1) 0.9815*d(1)],[0.9290 0.6940 0.1250])

% 
%link2
VeHinhTru(handles,line1(1,1),line1(2,1),0.9815*d(1),0.07,0.0185*d(1),[0.9290 0.6940 0.1250]);
VeHinhTru(handles,line1(1,2),line1(2,2),0.9815*d(1),0.11,0.0185*d(1),[0.9290 0.6940 0.1250]);
VeHinhTru(handles,line2(1,1),line2(2,1),0.9815*d(1),0.08,0.8391*d(1)+0.0185*d(1),[0.9290 0.6940 0.1250])
VeHinhTru(handles,line2(1,2),line2(2,2),d(1),0.08,0.1,[0.9290 0.6940 0.1250])

[pp1,pp2]=F_Common_Tangent([line2(1,1) line2(2,1)],[line2(1,2) line2(2,2)],0.08,0.08,1,-1);
[pp4,pp3]=F_Common_Tangent([line2(1,1) line2(2,1)],[line2(1,2) line2(2,2)],0.08,0.08,1,1);

fill3(robot_plot,[pp1(1) pp2(1) pp3(1) pp4(1)],[pp1(2) pp2(2) pp3(2) pp4(2)],[d(1) d(1) d(1) d(1)],[0.9290 0.6940 0.1250])
fill3(robot_plot,[pp1(1) pp2(1) pp3(1) pp4(1)],[pp1(2) pp2(2) pp3(2) pp4(2)],[d(1)+0.1 d(1)+0.1 d(1)+0.1 d(1)+0.1],[0.9290 0.6940 0.1250])
fill3(robot_plot,[pp1(1) pp4(1) pp4(1) pp1(1)],[pp1(2) pp4(2) pp4(2) pp1(2)],[d(1) d(1) d(1)+0.1 d(1)+0.1],[0.9290 0.6940 0.1250])
fill3(robot_plot,[pp3(1) pp4(1) pp4(1) pp3(1)],[pp3(2) pp4(2) pp4(2) pp3(2)],[d(1) d(1) d(1)+0.1 d(1)+0.1],[0.9290 0.6940 0.1250])
fill3(robot_plot,[pp2(1) pp3(1) pp3(1) pp2(1)],[pp2(2) pp3(2) pp3(2) pp2(2)],[d(1) d(1) d(1)+0.1 d(1)+0.1],[0.9290 0.6940 0.1250])
fill3(robot_plot,[pp1(1) pp2(1) pp2(1) pp1(1)],[pp1(2) pp2(2) pp2(2) pp1(2)],[d(1) d(1) d(1)+0.1 d(1)+0.1],[0.9290 0.6940 0.1250])

pp5 = (pp1+pp2)/2;
pp6 = (pp3+pp4)/2;

fill3(robot_plot,[pp1(1) pp5(1) pp5(1) pp1(1)],[pp1(2) pp5(2) pp5(2) pp1(2)],[d(1)+0.1 d(1)+0.1 1.8*d(1) 1.8*d(1)],[0.9290 0.6940 0.1250])
fill3(robot_plot,[pp4(1) pp6(1) pp6(1) pp4(1)],[pp4(2) pp6(2) pp6(2) pp4(2)],[d(1)+0.1 d(1)+0.1 1.8*d(1) 1.8*d(1)],[0.9290 0.6940 0.1250])
fill3(robot_plot,[pp1(1) pp5(1) pp6(1) pp4(1)],[pp1(2) pp5(2) pp6(2) pp4(2)],[1.8*d(1) 1.8*d(1) 1.8*d(1) 1.8*d(1)],[0.9290 0.6940 0.1250])
fill3(robot_plot,[pp5(1) pp2(1) pp5(1)],[pp5(2) pp2(2) pp5(2)],[d(1)+0.1 d(1)+0.1 1.8*d(1)],[0.9290 0.6940 0.1250]);
fill3(robot_plot,[pp6(1) pp3(1) pp6(1)],[pp6(2) pp3(2) pp6(2)],[d(1)+0.1 d(1)+0.1 1.8*d(1)],[0.9290 0.6940 0.1250]);
fill3(robot_plot,[pp5(1) pp2(1) pp3(1) pp6(1)],[pp5(2) pp2(2) pp3(2) pp6(2)],[1.8*d(1) d(1)+0.1 d(1)+0.1 1.8*d(1)],[0.9290 0.6940 0.1250])


% %link3
VeHinhTru(handles,p2(1),p2(2),d(1)-0.02,0.05,0.02,[0.4660 0.6740 0.1880])
VeHinhTru(handles,p2(1),p2(2),d(1)-0.035,0.02,0.015,[0.4660 0.6740 0.1880])
VeHinhTru(handles,p3(1),p3(2),p3(3),0.02,1.4*d(1),[0 0 0]);
VeHinhTru(handles,p3(1),p3(2),p3(3)+1.4*d(1),0.03,0.03,[0 0 0]);

%picker arm
for i=0:pi/4:3*pi/4
    picker(handles,p4(1),p4(2),p4(3),orien(4,3)*pi/180+i,0.15,0.05);
end

view(robot_plot,Az,El)
axis(robot_plot,'equal')