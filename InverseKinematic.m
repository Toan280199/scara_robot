function InverseKinametic(handles)

x = get(handles.x_sld,'value');
y = get(handles.y_sld,'value');
z = get(handles.z_sld,'value');
yaw = get(handles.yaw_sld,'value');

%% Update POSE
% Get parameters
global a1 a2 d1;
a1     = 0.45;
a2     = 0.4;
d1     = 0.46;

%%x = a1c1 + a2c12;
%%y = a1s1 + a2s12;
%%z = d1+d3;

c2 = (x^2 + y^2 - a1^2 - a2^2)/(2*a1*a2);
if abs(c2)<=1
    s2 = sqrt(1-c2^2);
    r = sqrt(x^2 + y^2);
    theta2 = atan2(s2,c2);
    theta1 = -acos((a1^2+r^2-a2^2)/(2*a1*r))+acos(x/r);
    d3 = z - d1;

    set(handles.t1_txt,'String',num2str(round(1000*180/pi*theta1)/1000));
    set(handles.t2_txt,'String',num2str(round(1000*180/pi*theta2)/1000));
    set(handles.d3_txt,'String',num2str(round(1000*d3)/1000));
%     roll = 0;
%     pitch = pi;
    theta4 = theta1+theta2 - yaw;
    set(handles.t4_txt,'String',num2str(round(theta4*180/pi)));
else
    warndlg('Out of workspace','Warning');
end

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

%% Plot
UpdateRobot(p0,p1,p2,p3,p4,handles);