function ForwardKinematic(handles)

theta1 = get(handles.t1vl,'value');
theta2 = get(handles.t2vl,'value');
d3 = get(handles.d3vl,'value');
theta4 = get(handles.t4vl,'value');

%% Update POSE
% Get parameters
global a1 a2 d1;

a     = [a1    ; a2     ;  0  ; 0     ];
alpha = [0     ; 0     ;  0  ;  pi     ];
d     = [d1     ; 0      ;  d3 ; 0    ];
theta = [theta1; theta2 ;  0  ; theta4];

%% FK Matrix
A0_1 = Link_matrix(a(1),alpha(1),d(1),theta(1)) ;
A1_2 = Link_matrix(a(2),alpha(2),d(2),theta(2)) ;
A2_3 = Link_matrix(a(3),alpha(3),d(3),theta(3)) ;
A3_4 = Link_matrix(a(4),alpha(4),d(4),theta(4)) ;

A0_2=A0_1*A1_2;
A0_3=A0_1*A1_2*A2_3;
A0_4=A0_1*A1_2*A2_3*A3_4;   % Te

p0 = [0;0;0];
[p1, o1] = cal_pose(A0_1,p0);
[p2, o2] = cal_pose(A0_2,p0);
[p3, o3] = cal_pose(A0_3,p0);
[p4, o4] = cal_pose(A0_4,p0);
set(handles.xvl,'String',num2str(round(1000*p4(1))/1000));
set(handles.yvl,'String',num2str(round(1000*p4(2))/1000));
set(handles.zvl,'String',num2str(round(1000*p4(3))/1000));
set(handles.rollvl,'String',round(o3(1)*180/pi,3));
set(handles.pitchvl,'String',round(o4(2)*180/pi,3));
set(handles.yawvl,'String',round(o4(3)*180/pi,3));

%% Plot
UpdateRobot(p0,p1,p2,p3,p4,handles);