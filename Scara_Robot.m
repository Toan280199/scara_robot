function varargout = Scara_Robot(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Scara_Robot_OpeningFcn, ...
                   'gui_OutputFcn',  @Scara_Robot_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Scara_Robot is made visible.
function Scara_Robot_OpeningFcn(hObject, eventdata, handles, varargin)                

set(handles.pn_FW,'Visible','on');
set(handles.pn_IV,'Visible','off');
set(handles.pn_PN,'Visible','off');

set(handles.pnPid,'Visible','on');
set(handles.pnqva,'Visible','on');
set(handles.pnJoint,'Visible','on');
set(handles.pnTool,'Visible','on');

global myScara;
global plot_pos;
global myTimer;

myScara = SCARA(handles,0.45,0.4,0.46,180,180,0.42);
plot_pos = [];
myTimer = timer('Name','MyTimer',                     ...
                      'Period',0.01,                 ... 
                      'StartDelay',1,                 ... 
                      'TasksToExecute',inf,           ... 
                      'ExecutionMode','fixedSpacing', ...
                      'TimerFcn',{@timerCallback,handles}); 

handles.output = hObject;
guidata(hObject, handles); 

%output (x, y, z, yaw)
set(handles.vl__FW_x,'String',num2str(myScara.pos(4,1)));
set(handles.vl__FW_y,'String',num2str(myScara.pos(4,2)));
set(handles.vl__FW_z,'String',num2str(myScara.pos(4,3)));
set(handles.vl__FW_yaw,'String',num2str(myScara.orien(4,3)*180/pi));
UpdateRobot(myScara,handles,22,22); 
SetupTrajectoryPlot(handles)

load_system('PIDController');
open_system('PIDController'); 
set_param('PIDController','StopTime','inf');
set_param('PIDController','SimulationMode','normal');
disp('Robot setup finished')

set_param('PIDController/motor1/Integrator','InitialCondition',num2str(0));
set_param('PIDController/motor2/Integrator','InitialCondition',num2str(1.57));
set_param('PIDController/motor3/Integrator','InitialCondition',num2str(0));
set_param('PIDController/motor4/Integrator','InitialCondition',num2str(-1.57));

function varargout = Scara_Robot_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

% --- Executes on button press in cb_view_ws.
function cb_view_ws_Callback(hObject, eventdata, handles)
global myScara
if get(hObject, 'Value')
    PlotWorkspace(myScara,handles);
else
    UpdateRobot(myScara,handles,22,22);  
end

% --- Executes on button press in cb_show_coor.
function cb_show_coor_Callback(hObject, eventdata, handles)

global myScara
if get(hObject, 'Value')
    axes(handles.robot_plot);
    % plot coordinate
    A0_1 = Link_matrix(myScara.a(1),myScara.alpha(1)*pi/180,myScara.d(1),myScara.theta(1)*pi/180) ;
    A1_2 = Link_matrix(myScara.a(2),myScara.alpha(2)*pi/180,myScara.d(2),myScara.theta(2)*pi/180) ;
    A2_3 = Link_matrix(myScara.a(3),myScara.alpha(3)*pi/180,myScara.d(3),myScara.theta(3)*pi/180) ;
    A3_4 = Link_matrix(myScara.a(4),myScara.alpha(4)*pi/180,myScara.d(4),myScara.theta(4)*pi/180) ;
    A0_0=[1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
    A0_2=A0_1*A1_2;
    A0_3=A0_1*A1_2*A2_3;
    A0_4=A0_1*A1_2*A2_3*A3_4;   % Te

    plot_coordinate(0,0,0+myScara.d(1)*5/4,A0_0,'0');
    plot_coordinate(myScara.pos(1,1),myScara.pos(1,2),myScara.pos(1,3)+myScara.d(1)*4/4,A0_1,'1');
    plot_coordinate(myScara.pos(2,1),myScara.pos(2,2),myScara.pos(2,3)+myScara.d(1)*4/4,A0_2,'2');
    plot_coordinate(myScara.pos(3,1),myScara.pos(3,2),myScara.pos(3,3)+myScara.d(1)*4/4,A0_3,'3');
    plot_coordinate(myScara.pos(4,1),myScara.pos(4,2),myScara.pos(4,3)+myScara.d(1)*2/4,A0_4,'4');
else
    UpdateRobot(myScara,handles,22,22); 
end

function vl_a1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function vl_a2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function vl_d1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in btn_Forward.
function btn_Forward_Callback(hObject, eventdata, handles)

set(handles.pn_FW,'Visible','On');
set(handles.pn_IV,'Visible','Off');
set(handles.pn_PN,'Visible','Off');
set(hObject,'BackgroundColor','white');
set(handles.btn_Inverse,'BackgroundColor',[0.74 0.74 0.74]);
set(handles.btn_Planning,'BackgroundColor',[0.74 0.74 0.74]);

% --- Executes on button press in btn_Inverse.
function btn_Inverse_Callback(hObject, eventdata, handles)

set(handles.pn_FW,'Visible','On');
set(handles.pn_IV,'Visible','On');
set(handles.pn_PN,'Visible','Off');
set(hObject,'BackgroundColor','white');
set(handles.btn_Forward,'BackgroundColor',[0.74 0.74 0.74]);
set(handles.btn_Planning,'BackgroundColor',[0.74 0.74 0.74]);

% --- Executes on button press in btn_Planning.
function btn_Planning_Callback(hObject, eventdata, handles)

set(hObject,'BackgroundColor','white');
set(handles.btn_Inverse,'BackgroundColor',[0.74 0.74 0.74]);
set(handles.btn_Forward,'BackgroundColor',[0.74 0.74 0.74]);

set(handles.pn_FW,'Visible','On');
set(handles.pn_IV,'Visible','On');
set(handles.pn_PN,'Visible','On');

% --- Executes on slider movement.
function sld__FW_t1_Callback(hObject, eventdata, handles)

theta1 = get(handles.sld__FW_t1,'value');
set(handles.vl__FW_t1,'string',num2str(theta1));

% --- Executes during object creation, after setting all properties.
function sld__FW_t1_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.74 .74 .74]);
end

% --- Executes on slider movement.
function sld__FW_t2_Callback(hObject, eventdata, handles)

theta(2) = get(handles.sld__FW_t2,'value');
set(handles.vl__FW_t2,'string',num2str(theta(2)));

% --- Executes during object creation, after setting all properties.
function sld__FW_t2_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.74 .74 .74]);
end

% --- Executes on slider movement.
function sld__FW_d3_Callback(hObject, eventdata, handles)

d3 = get(handles.sld__FW_d3,'value');
set(handles.vl__FW_d3,'string',num2str(d3));

% --- Executes during object creation, after setting all properties.
function sld__FW_d3_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.74 .74 .74]);
end

% --- Executes on slider movement.
function sld__FW_t4_Callback(hObject, eventdata, handles)

theta4 = get(handles.sld__FW_t4,'value');
set(handles.vl__FW_t4,'string',num2str(theta4));

% --- Executes during object creation, after setting all properties.
function sld__FW_t4_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.74 .74 .74]);
end

function vl__FW_t1_Callback(hObject, eventdata, handles)

theta1 = str2double(get(handles.vl__FW_t1,'String'));
set(handles.sld__FW_t1, 'value', theta1);

% --- Executes during object creation, after setting all properties.
function vl__FW_t1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function vl__FW_t2_Callback(hObject, eventdata, handles)

theta(2) = str2double(get(handles.vl__FW_t2,'String'));
set(handles.sld__FW_t2, 'value', theta(2));

% --- Executes during object creation, after setting all properties.
function vl__FW_t2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function vl__FW_d3_Callback(hObject, eventdata, handles)

d(3) = str2double(get(handles.vl__FW_d3,'String'));
set(handles.sld__FW_d3, 'value', d(3));

% --- Executes during object creation, after setting all properties.
function vl__FW_d3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function vl__FW_t4_Callback(hObject, eventdata, handles)

theta4 = str2double(get(handles.vl__FW_t4,'String'));
set(handles.sld__FW_t4, 'value', theta4);

% --- Executes during object creation, after setting all properties.
function vl__FW_t4_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function vl__FW_x_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function vl__FW_y_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function vl__FW_y_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function vl__FW_z_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function vl__FW_z_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function vl__FW_yaw_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function vl__FW_yaw_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in btn_FW_set.
function btn_FW_set_Callback(hObject, eventdata, handles)

global myScara;
global myTimer;
SetupTrajectoryPlot(handles)    % clear all data
t = linspace(0,4,401);

if (strcmp(get(handles.pn_IV,'visible'),'off'))
    %% Forward Kinematic
    theta1 = str2double(get(handles.vl__FW_t1,'String'))*pi/180;
    theta2 = str2double(get(handles.vl__FW_t2,'String'))*pi/180;
    d3 = str2double(get(handles.vl__FW_d3,'String'));
    theta4 = str2double(get(handles.vl__FW_t4,'String'))*pi/180;
    
    if abs(theta1) <= myScara.theta1_max*pi/180 && abs(theta2) <= myScara.theta2_max*pi/180 && abs(d3) <= myScara.d3_max && d3 <= 0
        set(handles.vl__FW_x,'String',num2str(theta1*180/pi));
        set(handles.vl__FW_y,'String',num2str(theta2*180/pi));
        set(handles.vl__FW_z,'String',num2str(d3));
        set(handles.vl__FW_yaw,'String',num2str(theta4*180/pi));

            %% ve set_point
        plot(handles.ax_t1,t,theta1*ones(401,1)*180/pi,'r','LineWidth',1.5);
        plot(handles.ax_t2,t,theta2*ones(401,1)*180/pi,'r','LineWidth',1.5);
        plot(handles.ax_d3,t,d3*ones(401,1),'r','LineWidth',1.5);
        plot(handles.ax_t4t,t,theta4*ones(401,1)*180/pi,'r','LineWidth',1.5);

        start_simu(myScara,t,theta1*ones(401,1),theta2*ones(401,1),d3*ones(401,1),theta4*ones(401,1));
        start(myTimer);
    else
        h=questdlg('Workspace Singularity','Warning','OK','OK');
    end
else
    x = str2double(get(handles.vl__IV_x,'String'));
    y = str2double(get(handles.vl__IV_y,'String'));
    z = str2double(get(handles.vl__IV_z,'String'));
    yaw = str2double(get(handles.vl__IV_yaw,'String'));
    tmpScara = myScara;
    [tmpScara,sucess] = tmpScara.InverseKinematic(x,y,z,yaw/180*pi,tmpScara);
    if tmpScara.KinematicSingularity(tmpScara) == 1
        h=questdlg('Kinematic Singularity','Warning','OK','OK');
        return
    end

    if sucess
        set(handles.vl__IV_t1,'String',tmpScara.theta(1));
        set(handles.vl__IV_t2,'String',tmpScara.theta(2));
        set(handles.vl__IV_d3,'String',tmpScara.d(3));
        set(handles.vl__IV_t4,'String',tmpScara.theta(4));
        
        theta1 = tmpScara.theta(1)*pi/180;
        theta2 = tmpScara.theta(2)*pi/180;
        d3 = tmpScara.d(3)*pi/180;
        theta4 = tmpScara.theta(4)*pi/180;
        
        %% ve set_point
        plot(handles.ax_t1,t,theta1*ones(401,1)*180/pi,'r','LineWidth',1.5);
        plot(handles.ax_t2,t,theta2*ones(401,1)*180/pi,'r','LineWidth',1.5);
        plot(handles.ax_d3,t,d3*ones(401,1),'r','LineWidth',1.5);
        plot(handles.ax_t4t,t,theta4*ones(401,1)*180/pi,'r','LineWidth',1.5);
        
        start_simu(myScara,t,theta1*ones(401,1),theta2*ones(401,1),d3*ones(401,1),theta4*ones(401,1));
        start(myTimer);
    else
        h=questdlg('Workspace Singularity','Warning','OK','OK');
    end
end
UpdateRobot(myScara,handles,22,22);

% --- Executes on button press in btn_FW_reset.
function btn_FW_reset_Callback(hObject, eventdata, handles)
global myScara;
ResetRobot(handles);
myScara.theta(1) = 0;
myScara.theta(2) = 90;
myScara.d(3) = 0;
myScara.theta(4) = -90;

[myScara.pos,myScara.orien] = myScara.ForwardKinematic(myScara)
UpdateRobot(myScara,handles,22,22); 

% --- Executes on slider movement.
function sld_IV_x_Callback(hObject, eventdata, handles)

x = get(handles.sld_IV_x,'value');
set(handles.vl__IV_x,'string',num2str(x));

% --- Executes during object creation, after setting all properties.
function sld_IV_x_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.74 .74 .74]);
end

% --- Executes on slider movement.
function sld_IV_y_Callback(hObject, eventdata, handles)

y = get(handles.sld_IV_y,'value');
set(handles.vl__IV_y,'string',num2str(y));

% --- Executes during object creation, after setting all properties.
function sld_IV_y_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.74 .74 .74]);
end

% --- Executes on slider movement.
function sld_IV_z_Callback(hObject, eventdata, handles)
z = get(handles.sld_IV_z,'value');
set(handles.vl__IV_z,'string',num2str(z));

% --- Executes during object creation, after setting all properties.
function sld_IV_z_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.74 .74 .74]);
end

% --- Executes on slider movement.
function sld_IV_yaw_Callback(hObject, eventdata, handles)
yaw = get(handles.sld_IV_yaw,'value');
set(handles.vl__IV_yaw,'string',num2str(yaw));

% --- Executes during object creation, after setting all properties.
function sld_IV_yaw_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.74 .74 .74]);
end

function vl__IV_x_Callback(hObject, eventdata, handles)
x = str2double(get(hObject,'String'));
set(handles.sld_IV_x, 'value', x);

% --- Executes during object creation, after setting all properties.
function vl__IV_x_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function vl__IV_y_Callback(hObject, eventdata, handles)
y = str2double(get(hObject,'String'));
set(handles.sld_IV_y, 'value', y);

% --- Executes during object creation, after setting all properties.
function vl__IV_y_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function vl__IV_z_Callback(hObject, eventdata, handles)
z = str2double(get(hObject,'String'));
set(handles.sld_IV_z, 'value', z);

% --- Executes during object creation, after setting all properties.
function vl__IV_z_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function vl__IV_yaw_Callback(hObject, eventdata, handles)
yaw = str2double(get(hObject,'String'));
set(handles.sld_IV_yaw, 'value', yaw);

% --- Executes during object creation, after setting all properties.
function vl__IV_yaw_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function vl__IV_t1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function vl__IV_t2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function vl__IV_d3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function vl__IV_t4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in rb_MSL850.
function rb_MSL850_Callback(hObject, eventdata, handles)

global myScara;
myScara = SCARA(handles,0.45,0.4,0.46,180,180,0.42);
UpdateRobot(myScara,handles,22,22);  

% --- Executes on button press in rb_MSL1000.
function rb_MSL1000_Callback(hObject, eventdata, handles)

global myScara;
myScara = SCARA(handles,0.6,0.4,0.46,180,180,0.42)
UpdateRobot(myScara,handles,22,22);  

% --- Executes on button press in rb_MSL650.
function rb_MSL650_Callback(hObject, eventdata, handles)

global myScara;
myScara = SCARA(handles,0.4,0.25,0.46,180,180,0.42)
UpdateRobot(myScara,handles,22,22);  

% --- Executes on button press in rb_THL300.
function rb_THL300_Callback(hObject, eventdata, handles)

global myScara;
myScara = SCARA(handles,0.55,0.45,0.194,125,145,0.3)
UpdateRobot(myScara,handles,22,22);   

% --- Executes on button press in rb_THL400.
function rb_THL400_Callback(hObject, eventdata, handles)

global myScara;
myScara = SCARA(handles,0.35,0.45,0.15,125,145,0.16)
UpdateRobot(myScara,handles,22,22);  

% --- Executes on button press in rb_THL600.
function rb_THL600_Callback(hObject, eventdata, handles)

global myScara;
myScara = SCARA(handles,0.3,0.3,0.179,125,145,0.15)
UpdateRobot(myScara,handles,22,22);  

% --- Executes during object creation, after setting all properties.
function x_pre_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function y_pre_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function z_pre_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function yaw_pre_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function xd_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function yd_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function zd_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function yawd_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_gotoPoint.
function btn_gotoPoint_Callback(hObject, eventdata, handles)

SetupTrajectoryPlot(handles)    % clear all data
global myScara
global myTimer
global set_t1 set_t2 set_d3 set_t4
global t
set_t1 = [];
set_t2 = [];
set_d3 = [];
set_t4 = [];

x0 = myScara.pos(4,1);
y0 = myScara.pos(4,2);
z0 = myScara.pos(4,3);
yaw0 = myScara.orien(4,3)*180/pi;

xd = str2double(get(handles.xd,'String'));
yd = str2double(get(handles.yd,'String'));
zd = str2double(get(handles.zd,'String'));
yawd = str2double(get(handles.yawd,'String'));

v_max = str2double(get(handles.vl_vmax,'String'));
a_max = str2double(get(handles.vl_amax,'String'));

joint_space = [myScara.theta(1) myScara.theta(2) myScara.d(3) myScara.theta(4)];

if(handles.btn_Straight.Value) % Straight path
    s_max = norm([xd-x0 yd-y0 zd-z0]);
    if(handles.btn_tra_vel.Value)   % van toc hinh thang
        [q,v,a,t,v_max] = Trajectory_3_seqment(s_max,v_max,a_max);
    else
        [q,v,a,t,v_max] = Trajectory_5_seqment(s_max,v_max,a_max); % S-curve
    end
        
    set(handles.vl_vmax,'String',num2str(v_max));
    theta = atan2(zd-z0,sqrt((yd-y0)^2+(xd-x0)^2));
    phi = atan2(yd-y0,xd-x0);

    x = x0 + q*cos(theta)*cos(phi);
    y = y0 + q*cos(theta)*sin(phi);
    z = z0 + q*sin(theta);
    yaw = yaw0 + q/s_max*(yawd-yaw0);

    % keep robot value
    tmpScara = myScara; % tuong trung cho set point cua bo dieu khien

    for i=1:1:length(q)
         pre_t1 = tmpScara.theta(1);
         pre_t2 = tmpScara.theta(2);
         pre_d3 = tmpScara.d(3);
         pre_t4 = tmpScara.theta(4);
         [tmpScara,sucess] = tmpScara.InverseKinematic(x(i),y(i),z(i),yaw(i)/180*pi,tmpScara);

        if sucess
            [tmpScara.pos,tmpScara.orien] = tmpScara.ForwardKinematic(tmpScara);
            set_t1 = [set_t1;tmpScara.theta(1)*pi/180];
            set_t2 = [set_t2;tmpScara.theta(2)*pi/180];
            set_d3 = [set_d3;tmpScara.d(3)];
            set_t4 = [set_t4;tmpScara.theta(4)*pi/180];
            if i > 1
                joint_space = [joint_space; tmpScara.theta(1) tmpScara.theta(2) tmpScara.d(3) tmpScara.theta(4)];
            end
        else
            return
        end
    end
    draw_path_linear(handles,q,v,a,t,theta,phi,joint_space,x0,y0,z0,'r');
    
else % circle
    if(handles.btn_tra_vel.Value)
        [q,v,a,t,P] = CircularPlanning([x0;y0;z0],[xd;yd;zd],v_max,a_max,0);    % van toc hinh thang
    else
        [q,v,a,t,P] = CircularPlanning([x0;y0;z0],[xd;yd;zd],v_max,a_max,1);    % van toc S-curve
    end
    x = P(1,:);
    y = P(2,:);
    z = P(3,:);
    yaw = yaw0 + q/max(q)*(yawd-yaw0);
                
    % keep robot value
    tmpScara = myScara; % tuong trung cho set point cua bo dieu khien
    pre_t1 = tmpScara.theta(1);
    pre_t2 = tmpScara.theta(2);
    pre_d3 = tmpScara.d(3);
    pre_t4 = tmpScara.theta(4);

    for i=1:1:length(q)
        [tmpScara,sucess] = tmpScara.InverseKinematic(x(i),y(i),z(i),yaw(i)/180*pi,tmpScara);
        if sucess
            [tmpScara.pos,tmpScara.orien] = tmpScara.ForwardKinematic(tmpScara);
            set_t1 = [set_t1;tmpScara.theta(1)*pi/180];
            set_t2 = [set_t2;tmpScara.theta(2)*pi/180];
            set_d3 = [set_d3;tmpScara.d(3)];
            set_t4 = [set_t4;tmpScara.theta(4)*pi/180];
            if i>1
                joint_space = [joint_space; tmpScara.theta(1) tmpScara.theta(2) tmpScara.d(3) tmpScara.theta(4)];
            end
        else
            return
        end
    end
    draw_path_circle(handles,q,v,a,t,joint_space,P,'r');
end

%% run simulink
start_simu(myScara,t,set_t1,set_t2,set_d3,set_t4);
start(myTimer);

% --- Executes during object creation, after setting all properties.
function vl_amax_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function vl_vmax_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function ax_v_CreateFcn(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function ax_q_CreateFcn(hObject, eventdata, handles)

function timerCallback(hObject,event,handles)

global myScara myTimer plot_pos
persistent index
persistent tout theta1out theta2out d3out theta4out dt dt2
persistent xout yout zout yawout
if isempty(index)
    index = 1;
end

if (index == 1)
    tout = evalin('base','tout')';
    theta1out = evalin('base','theta1out')';
    theta2out = evalin('base','theta2out')';
    d3out = evalin('base','d3out')';
    theta4out = evalin('base','theta4out')';
    yawout = theta1out + theta2out + theta4out;
    
    % lay mau
    tout = tout(1:5:end);
    theta1out = theta1out(1:5:end);
    theta2out = theta2out(1:5:end);
    d3out = d3out(1:5:end);
    theta4out = theta4out(1:5:end);
    yawout = yawout(1:5:end);
    dt = tout(end) - tout(end-1);
    dt2 = dt^2;
end

myScara.theta(1) = ToTrigonometricCircle(theta1out(index));
myScara.theta(2) = ToTrigonometricCircle(theta2out(index));
myScara.d(3) = d3out(index);
myScara.theta(4) = ToTrigonometricCircle(theta4out(index));
[myScara.pos,myScara.orien] = myScara.ForwardKinematic(myScara);
plot_pos = [plot_pos;myScara.pos(4,1) myScara.pos(4,2) myScara.pos(4,3)];
UpdateRobot(myScara,handles,22,22);
xout(index) = myScara.pos(4,1);
yout(index) = myScara.pos(4,2);
zout(index) = myScara.pos(4,3);
yawout(index) = myScara.orien(4,3)*180/pi;

if index > 3
    %% PID 

    plot(handles.ax_t1,tout(1:index),theta1out(1:index),'b','LineWidth',1.5);
    plot(handles.ax_t2,tout(1:index),theta2out(1:index),'b','LineWidth',1.5);
    plot(handles.ax_d3,tout(1:index),d3out(1:index),'b','LineWidth',1.5);
    plot(handles.ax_t4t,tout(1:index),theta4out(1:index),'b','LineWidth',1.5);  

    plot(handles.ax_x,tout(1:index),xout(1:index),'b','LineWidth',1.5);
    plot(handles.ax_y,tout(1:index),yout(1:index),'b','LineWidth',1.5);  
    plot(handles.ax_z,tout(1:index),zout(1:index),'b','LineWidth',1.5);
    plot(handles.ax_yaw,tout(1:index),yawout(1:index),'b','LineWidth',1.5);

    %% Tool space
    plot(handles.ax_xd,tout(1:index),xout(1:index),'b','LineWidth',1.5);
    plot(handles.ax_yd,tout(1:index),yout(1:index),'b','LineWidth',1.5);  
    plot(handles.ax_zd,tout(1:index),zout(1:index),'b','LineWidth',1.5);

    plot(handles.ax_x_dot,tout(1:index),[0 diff(xout(1:index))]/dt,'b','LineWidth',1.5);
    plot(handles.ax_y_dot,tout(1:index),[0 diff(yout(1:index))]/dt,'b','LineWidth',1.5);
    plot(handles.ax_z_dot,tout(1:index),[0 diff(zout(1:index))]/dt,'b','LineWidth',1.5);

    plot(handles.ax_x_2dot,tout(1:index),[0 0 diff(xout(1:index),2)]/dt2,'b','LineWidth',1.5);
    plot(handles.ax_y_2dot,tout(1:index),[0 0 diff(yout(1:index),2)]/dt2,'b','LineWidth',1.5);
    plot(handles.ax_z_2dot,tout(1:index),[0 0 diff(zout(1:index),2)]/dt2,'b','LineWidth',1.5);

    %% Joint space
    plot(handles.ax_t1d,tout(1:index),theta1out(1:index),'b','LineWidth',1.5);
    plot(handles.ax_t2d,tout(1:index),theta2out(1:index),'b','LineWidth',1.5);
    plot(handles.ax_d3d,tout(1:index),d3out(1:index),'b','LineWidth',1.5);
    plot(handles.ax_t4d,tout(1:index),theta4out(1:index),'b','LineWidth',1.5);

    plot(handles.ax_t1_dot,tout(1:index),[0 diff(theta1out(1:index))]/dt,'b','LineWidth',1.5);
    plot(handles.ax_t2_dot,tout(1:index),[0 diff(theta2out(1:index))]/dt,'b','LineWidth',1.5);
    plot(handles.ax_d3_dot,tout(1:index),[0 diff(d3out(1:index))]/dt,'b','LineWidth',1.5);
    plot(handles.ax_t4_dot,tout(1:index),[0 diff(theta4out(1:index))]/dt,'b','LineWidth',1.5);

    plot(handles.ax_t1_2dot,tout(1:index),[0 0 diff(theta1out(1:index),2)]/dt^2,'b','LineWidth',1.5);
    plot(handles.ax_t2_2dot,tout(1:index),[0 0 diff(theta2out(1:index),2)]/dt^2,'b','LineWidth',1.5);
    plot(handles.ax_d3_2dot,tout(1:index),[0 0 diff(d3out(1:index),2)]/dt^2,'b','LineWidth',1.5);
    plot(handles.ax_t4_2dot,tout(1:index),[0 0 diff(theta4out(1:index),2)]/dt^2,'b','LineWidth',1.5); 
end

index = index + 1;
if index > length(tout)
    index = 1;
    xout = [0];
    yout = [0];
    zout = [0];
    yawout = [0];
    stop(myTimer);
end

% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)

global myTimer
stop(myTimer);
set_param('PIDController','SimulationCommand','stop');
disp('Model stopped')

% --- Executes on button press in btnqva.
function btnqva_Callback(hObject, eventdata, handles)

set(handles.btnqva,'BackgroundColor',[0 1 1]);
set(handles.btnTool,'BackgroundColor',[0 1 0]);
set(handles.btnJoint,'BackgroundColor',[0 1 0]);
set(handles.btnPid,'BackgroundColor',[0 1 0]);

set(handles.pnPid,'Visible','on');
set(handles.pnJoint,'Visible','on');
set(handles.pnTool,'Visible','on');
set(handles.pnqva,'Visible','on');


% --- Executes on button press in btnJoint.
function btnJoint_Callback(hObject, eventdata, handles)

set(handles.btnqva,'BackgroundColor',[0 1 0]);
set(handles.btnTool,'BackgroundColor',[0 1 0]);
set(handles.btnJoint,'BackgroundColor',[0 1 1]);
set(handles.btnPid,'BackgroundColor',[0 1 0]);

set(handles.pnPid,'Visible','on');
set(handles.pnJoint,'Visible','on');
set(handles.pnTool,'Visible','off');
set(handles.pnqva,'Visible','off');

% --- Executes on button press in btnTool.
function btnTool_Callback(hObject, eventdata, handles)

set(handles.pnPid,'Visible','on');
set(handles.pnJoint,'Visible','on');
set(handles.pnTool,'Visible','on');
set(handles.pnqva,'Visible','off');

set(handles.btnqva,'BackgroundColor',[0 1 0]);
set(handles.btnTool,'BackgroundColor',[0 1 1]);
set(handles.btnJoint,'BackgroundColor',[0 1 0]);
set(handles.btnPid,'BackgroundColor',[0 1 0]);

% --- Executes on button press in btnPid.
function btnPid_Callback(hObject, eventdata, handles)

set(handles.pnPid,'Visible','on');
set(handles.pnJoint,'Visible','off');
set(handles.pnTool,'Visible','off');
set(handles.pnqva,'Visible','off');

set(handles.btnqva,'BackgroundColor',[0 1 0]);
set(handles.btnTool,'BackgroundColor',[0 1 0]);
set(handles.btnJoint,'BackgroundColor',[0 1 0]);
set(handles.btnPid,'BackgroundColor',[0 1 1]);
