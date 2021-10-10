function UpdateRobot(p0,p1,p2,p3,p4,handles)
[Az,El] = view;
global plot_data d1 a1 a2;
cla reset
hold on
grid on

% define links
line1=[[p0(1) p1(1)];[p0(2) p1(2)];[p0(3) p1(3)]];
line2=[[p1(1) p2(1)];[p1(2) p2(2)];[p1(3) p2(3)]];
line3=[[p2(1) p3(1)];[p2(2) p3(2)];[p2(3) p3(3)]];
line4=[[p3(1) p4(1)];[p3(2) p4(2)];[p3(3) p4(3)]];

xlabel(handles.axes1,'x');
ylabel(handles.axes1,'y');
zlabel(handles.axes1,'z');
xlim(handles.axes1,[-1 1]);
ylim(handles.axes1,[-1 1]);
zlim(handles.axes1,[-0.2 0.6]);

%draw ground
t = (1/16:1/8:1)'*2*pi;
x = cos(t);
y = sin(t);
z = [0 0 0 0 0 0 0 0]';
fill3(handles.axes1,x,y,z,'g','FaceAlpha',0.25);
rotate3d on
view(45,45)

% Ve base
VeHop(0,0,0,0.24,0.24,0.02,[0.9290 0.6940 0.1250])
VeHinhTru(0,0,0.02,0.12,0.343,[0.9290 0.6940 0.1250])
% 
% %link 1
VeHinhTru(line1(1,1),line1(2,1),0.363,0.1,8.5/1000,[0.9290 0.6940 0.1250]);
VeHinhTru(line1(1,2),line1(2,2),0.363,0.1,8.5/1000,[0.9290 0.6940 0.1250]);
VeHinhTru(line1(1,2),line1(2,2),0.3715,0.1,0.08,[0.9290 0.6940 0.1250]);
VeHinhTru(line1(1,1),line1(2,1),0.3715,0.1,0.08,[0.9290 0.6940 0.1250]);

[pp1,pp2]=F_Common_Tangent([line1(1,1) line1(2,1)],[line1(1,2) line1(2,2)],0.1,0.1,1,-1);
[pp4,pp3]=F_Common_Tangent([line1(1,1) line1(2,1)],[line1(1,2) line1(2,2)],0.1,0.1,1,1);

fill3([pp1(1) pp2(1) pp3(1) pp4(1)],[pp1(2) pp2(2) pp3(2) pp4(2)],[0.3715 0.3715 0.3715 0.3715],[0.9290 0.6940 0.1250])
fill3([pp1(1) pp2(1) pp3(1) pp4(1)],[pp1(2) pp2(2) pp3(2) pp4(2)],[0.4515 0.4515 0.4515 0.4515],[0.9290 0.6940 0.1250])
fill3([pp1(1) pp4(1) pp4(1) pp1(1)],[pp1(2) pp4(2) pp4(2) pp1(2)],[0.3715 0.3715 0.4515 0.4515],[0.9290 0.6940 0.1250])
fill3([pp3(1) pp4(1) pp4(1) pp3(1)],[pp3(2) pp4(2) pp4(2) pp3(2)],[0.3715 0.3715 0.4515 0.4515],[0.9290 0.6940 0.1250])
fill3([pp2(1) pp3(1) pp3(1) pp2(1)],[pp2(2) pp3(2) pp3(2) pp2(2)],[0.3715 0.3715 0.4515 0.4515],[0.9290 0.6940 0.1250])
fill3([pp1(1) pp2(1) pp2(1) pp1(1)],[pp1(2) pp2(2) pp2(2) pp1(2)],[0.3715 0.3715 0.4515 0.4515],[0.9290 0.6940 0.1250])

% 
%link2
VeHinhTru(line1(1,1),line1(2,1),0.4515,0.07,8.5/1000,[0.9290 0.6940 0.1250]);
VeHinhTru(line1(1,2),line1(2,2),0.4515,0.11,8.5/1000,[0.9290 0.6940 0.1250]);
VeHinhTru(line2(1,1),line2(2,1),0.4515,0.08,0.386+8.5/1000,[0.9290 0.6940 0.1250])
VeHinhTru(line2(1,2),line2(2,2),d1,0.08,0.1,[0.9290 0.6940 0.1250])

[pp1,pp2]=F_Common_Tangent([line2(1,1) line2(2,1)],[line2(1,2) line2(2,2)],0.08,0.08,1,-1);
[pp4,pp3]=F_Common_Tangent([line2(1,1) line2(2,1)],[line2(1,2) line2(2,2)],0.08,0.08,1,1);

fill3([pp1(1) pp2(1) pp3(1) pp4(1)],[pp1(2) pp2(2) pp3(2) pp4(2)],[d1 d1 d1 d1],[0.9290 0.6940 0.1250])
fill3([pp1(1) pp2(1) pp3(1) pp4(1)],[pp1(2) pp2(2) pp3(2) pp4(2)],[d1+0.1 d1+0.1 d1+0.1 d1+0.1],[0.9290 0.6940 0.1250])
fill3([pp1(1) pp4(1) pp4(1) pp1(1)],[pp1(2) pp4(2) pp4(2) pp1(2)],[d1 d1 d1+0.1 d1+0.1],[0.9290 0.6940 0.1250])
fill3([pp3(1) pp4(1) pp4(1) pp3(1)],[pp3(2) pp4(2) pp4(2) pp3(2)],[d1 d1 d1+0.1 d1+0.1],[0.9290 0.6940 0.1250])
fill3([pp2(1) pp3(1) pp3(1) pp2(1)],[pp2(2) pp3(2) pp3(2) pp2(2)],[d1 d1 d1+0.1 d1+0.1],[0.9290 0.6940 0.1250])
fill3([pp1(1) pp2(1) pp2(1) pp1(1)],[pp1(2) pp2(2) pp2(2) pp1(2)],[d1 d1 d1+0.1 d1+0.1],[0.9290 0.6940 0.1250])

pp5 = (pp1+pp2)/2;
pp6 = (pp3+pp4)/2;

fill3([pp1(1) pp5(1) pp5(1) pp1(1)],[pp1(2) pp5(2) pp5(2) pp1(2)],[d1+0.1 d1+0.1 d1+0.386 d1+0.386],[0.9290 0.6940 0.1250])
fill3([pp4(1) pp6(1) pp6(1) pp4(1)],[pp4(2) pp6(2) pp6(2) pp4(2)],[d1+0.1 d1+0.1 d1+0.386 d1+0.386],[0.9290 0.6940 0.1250])
fill3([pp1(1) pp5(1) pp6(1) pp4(1)],[pp1(2) pp5(2) pp6(2) pp4(2)],[d1+0.386 d1+0.386 d1+0.386 d1+0.386],[0.9290 0.6940 0.1250])
fill3([pp5(1) pp2(1) pp5(1)],[pp5(2) pp2(2) pp5(2)],[d1+0.1 d1+0.1 d1+0.386],[0.9290 0.6940 0.1250]);
fill3([pp6(1) pp3(1) pp6(1)],[pp6(2) pp3(2) pp6(2)],[d1+0.1 d1+0.1 d1+0.386],[0.9290 0.6940 0.1250]);
fill3([pp5(1) pp2(1) pp3(1) pp6(1)],[pp5(2) pp2(2) pp3(2) pp6(2)],[d1+0.386 d1+0.1 d1+0.1 d1+0.386],[0.9290 0.6940 0.1250])


% %link3
VeHinhTru(p2(1),p2(2),d1-0.02,0.05,0.02,[0.4660 0.6740 0.1880])
VeHinhTru(p2(1),p2(2),d1-0.035,0.02,0.015,[0.4660 0.6740 0.1880])
VeHinhTru(p3(1),p3(2),p3(3),0.02,0.6,[0 0 0]);
VeHinhTru(p3(1),p3(2),p3(3)+0.6,0.03,0.03,[0 0 0]);

plot_data = [plot_data;p4'];
plot3(plot_data(:,1),plot_data(:,2),plot_data(:,3),'Color','r','MarkerSize',25)

%picker arm
picker(p4(1),p4(2),p4(3),-str2num(get(handles.yawvl,'String'))*pi/180,0.15,0.05);
% plot coordinate
plot_coordinate(p0(1),p0(2),p0(3)+0.5,-1,-1,1,0);
plot_coordinate(p1(1),p1(2),p1(3)+0.5,1,1,1,1);
plot_coordinate(p2(1),p2(2),p2(3)+0.5,1,1,1,2);
plot_coordinate(p3(1),p3(2),p3(3)+0.5,1,1,1,3);
% plot_coordinate(p4(1),p4(2),p4(3)+0.5,-1,1,-1,4);

rotate3d on
view(Az,El)