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

handles.output = hObject;
guidata(hObject, handles);
set(handles.pn_FW,'Visible','on');
set(handles.pn_IV,'Visible','off');
set(handles.pn_PN,'Visible','off');

global myScara;
global plot_pos;
myScara = SCARA(handles,0.45,0.4,0.46,180,180,0.42);
plot_pos = [];

%output (x, y, z, yaw)
set(handles.vl__FW_x,'String',num2str(myScara.pos(4,1)));
set(handles.vl__FW_y,'String',num2str(myScara.pos(4,2)));
set(handles.vl__FW_z,'String',num2str(myScara.pos(4,3)));
set(handles.vl__FW_yaw,'String',num2str(myScara.orien(4,3)*180/pi));
handles.robot_plot;
UpdateRobot(myScara,handles,22,22); 

% --- Outputs from this function are returned to the command line.
function varargout = Scara_Robot_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

% --- Executes on button press in cb_view_ws.
function cb_view_ws_Callback(hObject, eventdata, handles)
global myScara
if get(hObject, 'Value')
    PlotWorkspace(handles,myScara);
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

% --- Executes during object creation, after setting all properties.
function vl_a1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vl_a1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function vl_a2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vl_a2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
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
set(handles.btn_Inverse,'BackgroundColor',[0.94 0.94 0.94]);
set(handles.btn_Planning,'BackgroundColor',[0.94 0.94 0.94]);

% --- Executes on button press in btn_Inverse.
function btn_Inverse_Callback(hObject, eventdata, handles)

set(handles.pn_FW,'Visible','Off');
set(handles.pn_IV,'Visible','On');
set(handles.pn_PN,'Visible','Off');
set(hObject,'BackgroundColor','white');
set(handles.btn_Forward,'BackgroundColor',[0.94 0.94 0.94]);
set(handles.btn_Planning,'BackgroundColor',[0.94 0.94 0.94]);

% --- Executes on button press in btn_Planning.
function btn_Planning_Callback(hObject, eventdata, handles)

set(hObject,'BackgroundColor','white');
set(handles.btn_Inverse,'BackgroundColor',[0.94 0.94 0.94]);
set(handles.btn_Forward,'BackgroundColor',[0.94 0.94 0.94]);

set(handles.pn_FW,'Visible','Off');
set(handles.pn_IV,'Visible','Off');
set(handles.pn_PN,'Visible','On');

% figure(2)
% set(gcf, 'Position', [0.0799,0.2899,0.3972,0.2184]);

% --- Executes on slider movement.
function sld__FW_t1_Callback(hObject, eventdata, handles)

theta1 = get(handles.sld__FW_t1,'value');
set(handles.vl__FW_t1,'string',num2str(theta1));

% --- Executes during object creation, after setting all properties.
function sld__FW_t1_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function sld__FW_t2_Callback(hObject, eventdata, handles)

theta(2) = get(handles.sld__FW_t2,'value');
set(handles.vl__FW_t2,'string',num2str(theta(2)));

% --- Executes during object creation, after setting all properties.
function sld__FW_t2_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function sld__FW_d3_Callback(hObject, eventdata, handles)

d3 = get(handles.sld__FW_d3,'value');
set(handles.vl__FW_d3,'string',num2str(d3));

% --- Executes during object creation, after setting all properties.
function sld__FW_d3_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function sld__FW_t4_Callback(hObject, eventdata, handles)

theta4 = get(handles.sld__FW_t4,'value');
set(handles.vl__FW_t4,'string',num2str(theta4));

% --- Executes during object creation, after setting all properties.
function sld__FW_t4_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
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

function vl__FW_x_Callback(hObject, eventdata, handles)

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
myScara.theta(1) = str2double(get(handles.vl__FW_t1,'String'));
myScara.theta(2) = str2double(get(handles.vl__FW_t2,'String'));
myScara.d(3) = str2double(get(handles.vl__FW_d3,'String'));
myScara.theta(4) = str2double(get(handles.vl__FW_t4,'String'));
[myScara.pos,myScara.orien] = myScara.ForwardKinematic(myScara);
if myScara.KinematicSingularity(myScara) == 1
    h=questdlg('Kinematic Singularity','Warning','OK','OK');
    return
end
    
%output (x, y, z, yaw)
set(handles.vl__FW_x,'String',num2str(myScara.pos(4,1)));
set(handles.vl__FW_y,'String',num2str(myScara.pos(4,2)));
set(handles.vl__FW_z,'String',num2str(myScara.pos(4,3)));
set(handles.vl__FW_yaw,'String',num2str(myScara.orien(4,3)*180/pi));
UpdateRobot(myScara,handles,22,22); 

% --- Executes on button press in btn_FW_reset.
function btn_FW_reset_Callback(hObject, eventdata, handles)

global myScara;
set(handles.sld__FW_t1, 'value', 0);
set(handles.sld__FW_t2, 'value', 90);
set(handles.sld__FW_d3, 'value', 0);
set(handles.sld__FW_t4, 'value', 0);
set(handles.vl__FW_t1,'string','0');
set(handles.vl__FW_t2,'string','90');
set(handles.vl__FW_d3,'string','0');
set(handles.vl__FW_t4,'string','0');

myScara.theta(1) = 0;
myScara.theta(2) = 90;
myScara.d(3) = 0;
myScara.theta(4) = 0;
[myScara.pos,myScara.orien] = myScara.ForwardKinematic(myScara);
%output (x, y, z, yaw)
set(handles.vl__FW_x,'String',num2str(myScara.pos(4,1)));
set(handles.vl__FW_y,'String',num2str(myScara.pos(4,2)));
set(handles.vl__FW_z,'String',num2str(myScara.pos(4,3)));
set(handles.vl__FW_yaw,'String',num2str(myScara.orien(4,3)*180/pi));
UpdateRobot(myScara,handles,22,22);  
% --- Executes on button press in cb_record.
function cb_record_Callback(hObject, eventdata, handles)

% --- Executes on slider movement.
function sld_IV_x_Callback(hObject, eventdata, handles)

x = get(handles.sld_IV_x,'value');
set(handles.vl__IV_x,'string',num2str(x));

% --- Executes during object creation, after setting all properties.
function sld_IV_x_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function sld_IV_y_Callback(hObject, eventdata, handles)

y = get(handles.sld_IV_y,'value');
set(handles.vl__IV_y,'string',num2str(y));

% --- Executes during object creation, after setting all properties.
function sld_IV_y_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function sld_IV_z_Callback(hObject, eventdata, handles)

z = get(handles.sld_IV_z,'value');
set(handles.vl__IV_z,'string',num2str(z));

% --- Executes during object creation, after setting all properties.
function sld_IV_z_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function sld_IV_yaw_Callback(hObject, eventdata, handles)

yaw = get(handles.sld_IV_yaw,'value');
set(handles.vl__IV_yaw,'string',num2str(yaw));

% --- Executes during object creation, after setting all properties.
function sld_IV_yaw_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
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

function vl__IV_t1_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function vl__IV_t1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function vl__IV_t2_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function vl__IV_t2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function vl__IV_d3_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function vl__IV_d3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vl__IV_d3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function vl__IV_t4_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function vl__IV_t4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in btn_IV_set.
function btn_IV_set_Callback(hObject, eventdata, handles)

global myScara;
x = str2double(get(handles.vl__IV_x,'String'));
y = str2double(get(handles.vl__IV_y,'String'));
z = str2double(get(handles.vl__IV_z,'String'));
yaw = str2double(get(handles.vl__IV_yaw,'String'));
[myScara,sucess] = myScara.InverseKinematic(x,y,z,yaw/180*pi,myScara);
if myScara.KinematicSingularity(myScara) == 1
    h=questdlg('Kinematic Singularity','Warning','OK','OK');
    return
end

if sucess
    [myScara.pos,myScara.orien] = myScara.ForwardKinematic(myScara)
    set(handles.vl__IV_t1,'String',myScara.theta(1));
    set(handles.vl__IV_t2,'String',myScara.theta(2));
    set(handles.vl__IV_d3,'String',myScara.d(3));
    set(handles.vl__IV_t4,'String',myScara.theta(4));
    UpdateRobot(myScara,handles,22,22);
end

% --- Executes on button press in btn_IV_reset.
function btn_IV_reset_Callback(hObject, eventdata, handles)

global myScara;
    set(handles.vl__IV_x,'String','0.45');
    set(handles.vl__IV_y,'String','0.40');
    set(handles.vl__IV_z,'String','0.46');
    set(handles.vl__IV_yaw,'String','90');
    
    myScara.theta(1) = 0;
    myScara.theta(2) = 90;
    myScara.d(3) = 0;
    myScara.theta(4) = 0;

    [myScara.pos,myScara.orien] = myScara.ForwardKinematic(myScara)
    UpdateRobot(myScara,handles,22,22);  

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



function x_pre_Callback(hObject, eventdata, handles)
% hObject    handle to x_pre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x_pre as text
%        str2double(get(hObject,'String')) returns contents of x_pre as a double


% --- Executes during object creation, after setting all properties.
function x_pre_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_pre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y_pre_Callback(hObject, eventdata, handles)
% hObject    handle to y_pre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y_pre as text
%        str2double(get(hObject,'String')) returns contents of y_pre as a double


% --- Executes during object creation, after setting all properties.
function y_pre_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_pre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function z_pre_Callback(hObject, eventdata, handles)
% hObject    handle to z_pre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of z_pre as text
%        str2double(get(hObject,'String')) returns contents of z_pre as a double


% --- Executes during object creation, after setting all properties.
function z_pre_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z_pre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yaw_pre_Callback(hObject, eventdata, handles)
% hObject    handle to yaw_pre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yaw_pre as text
%        str2double(get(hObject,'String')) returns contents of yaw_pre as a double


% --- Executes during object creation, after setting all properties.
function yaw_pre_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yaw_pre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xd_Callback(hObject, eventdata, handles)
% hObject    handle to xd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xd as text
%        str2double(get(hObject,'String')) returns contents of xd as a double


% --- Executes during object creation, after setting all properties.
function xd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yd_Callback(hObject, eventdata, handles)
% hObject    handle to yd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yd as text
%        str2double(get(hObject,'String')) returns contents of yd as a double


% --- Executes during object creation, after setting all properties.
function yd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function zd_Callback(hObject, eventdata, handles)
% hObject    handle to zd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of zd as text
%        str2double(get(hObject,'String')) returns contents of zd as a double


% --- Executes during object creation, after setting all properties.
function zd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yawd_Callback(hObject, eventdata, handles)
% hObject    handle to yawd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yawd as text
%        str2double(get(hObject,'String')) returns contents of yawd as a double


% --- Executes during object creation, after setting all properties.
function yawd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yawd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_gotoPoint.
function btn_gotoPoint_Callback(hObject, eventdata, handles)

global myScara
global plot_pos 
joint_vel = [0 0 0 0];
x0 = myScara.pos(4,1);
y0 = myScara.pos(4,2);
z0 = myScara.pos(4,3);
yaw0 = myScara.orien(4,3);

xd = str2double(get(handles.xd,'String'));
yd = str2double(get(handles.yd,'String'));
zd = str2double(get(handles.zd,'String'));
yawd = str2double(get(handles.yawd,'String'));

v_max = str2double(get(handles.vl_vmax,'String'));
a_max = str2double(get(handles.vl_amax,'String'));
        
if(handles.btn_tra_vel.Value)
    if(handles.btn_Straight.Value)
        s_max = norm([xd-x0 yd-y0 zd-z0]);
        [q,v,a,t,v_max] = Trajectory_3_seqment(s_max,v_max,a_max);
        set(handles.vl_vmax,'String',num2str(v_max));
        
        theta = atan2(zd-z0,sqrt((yd-y0)^2+(xd-x0)^2));
        phi = atan2(yd-y0,xd-x0);

        x = x0 + q*cos(theta)*cos(phi);
        y = y0 + q*cos(theta)*sin(phi);
        z = z0 + q*sin(theta);
        yaw = yaw0 + q/s_max*(yawd-yaw0);
        
        SetupFigure2(t,q,v,a);   %% for trajectory planning
        
        for i=1:1:length(q)
            pre_t1 = myScara.theta(1);
            pre_t2 = myScara.theta(2);
            pre_d3 = myScara.d(3);
            pre_t4 = myScara.theta(4);
            [myScara,sucess] = myScara.InverseKinematic(x(i),y(i),z(i),yaw(i)/180*pi,myScara);
            if myScara.KinematicSingularity(myScara) == 1
                h=questdlg('Kinematic Singularity','Warning','OK','OK');
                return
            end
            if sucess
                [myScara.pos,myScara.orien] = myScara.ForwardKinematic(myScara);
                if i>1
                    joint_vel = [joint_vel; [myScara.theta(1)-pre_t1 myScara.theta(2)-pre_t2 myScara.d(3)-pre_d3 myScara.theta(4)-pre_t4]/(t(i)-t(i-1))];
                end
                
                if mod(i,50) == 0 || i == length(q)
                    plot_pos = [plot_pos;myScara.pos(4,1) myScara.pos(4,2) myScara.pos(4,3)];
                    UpdateRobot(myScara,handles,22,22);
                    figure(2)
                    subplot(6,2,1)
                    plot(t(1:i),x0 + q(1:i)*cos(theta)*cos(phi),'b','LineWidth',1.5);
                    subplot(6,2,3)
                    plot(t(1:i),y0 + q(1:i)*cos(theta)*sin(phi),'b','LineWidth',1.5);
                    subplot(6,2,5)
                    plot(t(1:i),z0 + q(1:i)*sin(theta),'b','LineWidth',1.5);
                    subplot(6,2,7)
                    plot(t(1:i),q(1:i),'b','LineWidth',1.5);
                    subplot(6,2,9)
                    plot(t(1:i),v(1:i),'b','LineWidth',1.5);
                    subplot(6,2,11)
                    plot(t(1:i),a(1:i),'b','LineWidth',1.5);

                    subplot(6,2,2)
                    plot(t(1:i),joint_vel(1:i,1),'b','LineWidth',1.5);

                    subplot(6,2,4)
                    plot(t(1:i),joint_vel(1:i,2),'b','LineWidth',1.5);

                    subplot(6,2,6)
                    plot(t(1:i),joint_vel(1:i,3),'b','LineWidth',1.5);

                    subplot(6,2,8)
                    plot(t(1:i),joint_vel(1:i,4),'b','LineWidth',1.5);

                    pause(0.2)
                end
            end
        end
    end
else
    if(handles.btn_Straight.Value)
        s_max = norm([xd-x0 yd-y0 zd-z0]);
        [q,v,a,t,v_max] = Trajectory_5_seqment(s_max,v_max,a_max);
        set(handles.vl_vmax,'String',num2str(v_max));
        SetupFigure2(t,q,v,a);   %% for trajectory planning

        theta = atan2(zd-z0,sqrt((yd-y0)^2+(xd-x0)^2));
        phi = atan2(yd-y0,xd-x0);

        x = x0 + q*cos(theta)*cos(phi);
        y = y0 + q*cos(theta)*sin(phi);
        z = z0 + q*sin(theta);
        yaw = yaw0 + q/s_max*(yawd-yaw0);;

        for i=1:1:length(q)
            pre_t1 = myScara.theta(1);
            pre_t2 = myScara.theta(2);
            pre_d3 = myScara.d(3);
            pre_t4 = myScara.theta(4);
            [myScara,sucess] = myScara.InverseKinematic(x(i),y(i),z(i),yaw(i)/180*pi,myScara);
            if myScara.KinematicSingularity(myScara) == 1
                h=questdlg('Kinematic Singularity','Warning','OK','OK');
                return
            end
            if sucess
                [myScara.pos,myScara.orien] = myScara.ForwardKinematic(myScara);
                if i>1
                    joint_vel = [joint_vel; [myScara.theta(1)-pre_t1 myScara.theta(2)-pre_t2 myScara.d(3)-pre_d3 myScara.theta(4)-pre_t4]/(t(i)-t(i-1))];
                end
                
                if mod(i,50) == 0 || i == length(q)
                    UpdateRobot(myScara,handles,22,22);
                    plot_pos = [plot_pos;myScara.pos(4,1) myScara.pos(4,2) myScara.pos(4,3)];
                    figure(2)
                    subplot(6,2,1)
                    plot(t(1:i),x0 + q(1:i)*cos(theta)*cos(phi),'b','LineWidth',1.5);
                    subplot(6,2,3)
                    plot(t(1:i),y0 + q(1:i)*cos(theta)*sin(phi),'b','LineWidth',1.5);
                    subplot(6,2,5)
                    plot(t(1:i),z0 + q(1:i)*sin(theta),'b','LineWidth',1.5);
                    subplot(6,2,7)
                    plot(t(1:i),q(1:i),'b','LineWidth',1.5);
                    subplot(6,2,9)
                    plot(t(1:i),v(1:i),'b','LineWidth',1.5);
                    subplot(6,2,11)
                    plot(t(1:i),a(1:i),'b','LineWidth',1.5);

                    subplot(6,2,2)
                    plot(t(1:i),joint_vel(1:i,1),'b','LineWidth',1.5);

                    subplot(6,2,4)
                    plot(t(1:i),joint_vel(1:i,2),'b','LineWidth',1.5);

                    subplot(6,2,6)
                    plot(t(1:i),joint_vel(1:i,3),'b','LineWidth',1.5);

                    subplot(6,2,8)
                    plot(t(1:i),joint_vel(1:i,4),'b','LineWidth',1.5);

                    pause(0.2)
                end
            end
        end
    end
end

function vl_amax_Callback(hObject, eventdata, handles)
% hObject    handle to vl_amax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vl_amax as text
%        str2double(get(hObject,'String')) returns contents of vl_amax as a double


% --- Executes during object creation, after setting all properties.
function vl_amax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vl_amax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function vl_vmax_Callback(hObject, eventdata, handles)
% hObject    handle to vl_vmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vl_vmax as text
%        str2double(get(hObject,'String')) returns contents of vl_vmax as a double


% --- Executes during object creation, after setting all properties.
function vl_vmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vl_vmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
