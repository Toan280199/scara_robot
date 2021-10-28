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

global a alpha d theta;
global pos orien;
global theta1_max theta2_max d3_max;

theta1_max = 180;
theta2_max = 180;
d3_max = 0.42;
a     = [0.45;    0.40;     0.00;      0.00];
alpha = [0.00;    0.00;     0.00;      180];
d     = [0.46;    0.00;     0.00;      0.00];
theta = [0.00;     90;     0.00;      0.00];
[pos,orien] = ForwardKinematic(a, alpha*pi/180, d, theta*pi/180)
set(handles.tb_dh,'Data',[a alpha d theta]);   %put dh parameter to DH table
set(handles.tb_pos_orien,'Data',[pos orien*180/pi]);   %put dh parameter to DH table
%output (x, y, z, yaw)
set(handles.vl__FW_x,'String',num2str(pos(4,1)));
set(handles.vl__FW_y,'String',num2str(pos(4,2)));
set(handles.vl__FW_z,'String',num2str(pos(4,3)));
set(handles.vl__FW_yaw,'String',num2str(orien(4,3)*180/pi));
UpdateRobot(pos,orien,handles,11,11);

% --- Outputs from this function are returned to the command line.
function varargout = Scara_Robot_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

% --- Executes on button press in cb_view_ws.
function cb_view_ws_Callback(hObject, eventdata, handles)

global a pos orien theta1_max theta2_max d3_max d;
if get(hObject, 'Value')
    axes(handles.robot_plot);
    theta1_m = theta1_max*pi/180;
    theta2_m = theta2_max*pi/180;
    theta1 = linspace(-theta1_m,theta1_m,181);
    fill([(a(1)+a(2))*cos(theta1) 0],[(a(1)+a(2))*sin(theta1) 0],'r');
    theta2 = linspace(-theta2_m,theta2_m,181);
    fill([a(1)*cos(theta1_m)+a(2)*cos(theta1_m+theta2) a(1)*cos(theta1_m)],[a(1)*sin(theta1_m)+a(2)*sin(theta1_m+theta2) a(1)*sin(theta1_m)],'r');
    fill([a(1)*cos(-theta1_m)+a(2)*cos(-theta1_m+theta2) a(1)*cos(-theta1_m)],[a(1)*sin(-theta1_m)+a(2)*sin(-theta1_m+theta2) a(1)*sin(-theta1_m)],'r');
else
    UpdateRobot(pos,orien,handles,11,11);
end

% --- Executes on button press in cb_show_coor.
function cb_show_coor_Callback(hObject, eventdata, handles)

global pos orien
if get(hObject, 'Value')
    axes(handles.robot_plot);
    % plot coordinate
    plot_coordinate(0,0,0.5,-1,-1,1,0);
    plot_coordinate(pos(1,1),pos(1,2),pos(1,3)+0.5,1,1,1,1);
    plot_coordinate(pos(2,1),pos(2,2),pos(2,3)+0.5,1,1,1,2);
    plot_coordinate(pos(3,1),pos(3,2),pos(3,3)+0.5,1,1,1,3);
    plot_coordinate(pos(4,1),pos(4,2),pos(4,3)+0.5,-1,1,-1,4);
else
    UpdateRobot(pos,orien,handles,11,11);
end

function vl_a1_Callback(hObject, eventdata, handles)

a(1) = str2double(get(handles.vl_a1,'String'));

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

function vl_a2_Callback(hObject, eventdata, handles)

a(2) = str2double(get(handles.vl_a2,'String'));

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

function vl_d1_Callback(hObject, eventdata, handles)

d(1) = str2double(get(handles.vl_d1,'String'));

% --- Executes during object creation, after setting all properties.
function vl_d1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vl_d1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in btn_Forward.
function btn_Forward_Callback(hObject, eventdata, handles)

set(handles.pn_FW,'Visible','On');
set(handles.pn_IV,'Visible','Off');
set(hObject,'BackgroundColor','white');
set(handles.btn_Inverse,'BackgroundColor',[0.94 0.94 0.94]);
set(handles.btn_Planning,'BackgroundColor',[0.94 0.94 0.94]);

% --- Executes on button press in btn_Inverse.
function btn_Inverse_Callback(hObject, eventdata, handles)

set(handles.pn_FW,'Visible','Off');
set(handles.pn_IV,'Visible','On');
set(hObject,'BackgroundColor','white');
set(handles.btn_Forward,'BackgroundColor',[0.94 0.94 0.94]);
set(handles.btn_Planning,'BackgroundColor',[0.94 0.94 0.94]);

% --- Executes on button press in btn_Planning.
function btn_Planning_Callback(hObject, eventdata, handles)

set(hObject,'BackgroundColor','white');
set(handles.btn_Inverse,'BackgroundColor',[0.94 0.94 0.94]);
set(handles.btn_Forward,'BackgroundColor',[0.94 0.94 0.94]);

% --- Executes on slider movement.
function sld__FW_t1_Callback(hObject, eventdata, handles)

theta1 = get(handles.sld__FW_t1,'value');
set(handles.vl__FW_t1,'string',num2str(theta1));

% --- Executes during object creation, after setting all properties.
function sld__FW_t1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sld__FW_t1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
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

theta(4) = get(handles.sld__FW_t4,'value');
set(handles.vl__FW_t4,'string',num2str(theta(4)));

% --- Executes during object creation, after setting all properties.
function sld__FW_t4_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function vl_t1_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function vl_t1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function vl__FW_t1_Callback(hObject, eventdata, handles)

theta1 = str2double(get(handles.vl__FW_t1,'String'));
set(handles.sld__FW_t1, 'value', theta1);

% --- Executes during object creation, after setting all properties.
function vl__FW_t1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function vl_t2_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function vl_t2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function vl_t4_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function vl_t4_CreateFcn(hObject, eventdata, handles)

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

global a alpha d theta pos orien;
theta(1) = str2double(get(handles.vl__FW_t1,'String'));
theta(2) = str2double(get(handles.vl__FW_t2,'String'));
d(3) = str2double(get(handles.vl__FW_d3,'String'));
theta(4) = str2double(get(handles.vl__FW_t4,'String'));
[pos,orien] = ForwardKinematic(a, alpha*pi/180, d, theta*pi/180)
set(handles.tb_dh,'Data',[a alpha d theta]);   %put dh parameter to DH table
set(handles.tb_pos_orien,'Data',[pos orien*180/pi]);   %put dh parameter to DH table
%output (x, y, z, yaw)
set(handles.vl__FW_x,'String',num2str(pos(4,1)));
set(handles.vl__FW_y,'String',num2str(pos(4,2)));
set(handles.vl__FW_z,'String',num2str(pos(4,3)));
set(handles.vl__FW_yaw,'String',num2str(orien(4,3)*180/pi));
UpdateRobot(pos,orien,handles,11,11);

% --- Executes on button press in btn_FW_reset.
function btn_FW_reset_Callback(hObject, eventdata, handles)

global a alpha d theta pos orien;
set(handles.sld__FW_t1, 'value', 0);
set(handles.sld__FW_t2, 'value', 90);
set(handles.sld__FW_d3, 'value', 0);
set(handles.sld__FW_t4, 'value', 0);
set(handles.vl__FW_t1,'string','0');
set(handles.vl__FW_t2,'string','90');
set(handles.vl__FW_d3,'string','0');
set(handles.vl__FW_t4,'string','0');

theta(1) = 0;
theta(2) = 90;
d(3) = 0;
theta(4) = 0;
[pos,orien] = ForwardKinematic(a, alpha*pi/180, d, theta*pi/180)
set(handles.tb_dh,'Data',[a alpha d theta]);   %put dh parameter to DH table
set(handles.tb_pos_orien,'Data',[pos orien*180/pi]);   %put dh parameter to DH table
%output (x, y, z, yaw)
set(handles.vl__FW_x,'String',num2str(pos(4,1)));
set(handles.vl__FW_y,'String',num2str(pos(4,2)));
set(handles.vl__FW_z,'String',num2str(pos(4,3)));
set(handles.vl__FW_yaw,'String',num2str(orien(4,3)*180/pi));
UpdateRobot(pos,orien,handles,11,11);
% --- Executes on button press in cb_record.
function cb_record_Callback(hObject, eventdata, handles)

% while get(hObject, 'Value')
%     i = 1;
%     if (get(hObject, 'Value'))
%         F(i)=getframe(handles.robot_plot);
%         pause(0.1);
%         i = i + 1;
%     end
%     video = VideoWriter('TestMovie_sbg.avi','Uncompressed AVI');
%     length(F)
%     video.FrameRate = 8;
%     open(video)
%     writeVideo(video,F);
%     close(video)
end

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

global a alpha d theta pos orien
x = str2double(get(handles.vl__IV_x,'String'));
y = str2double(get(handles.vl__IV_y,'String'));
z = str2double(get(handles.vl__IV_z,'String'));
yaw = str2double(get(handles.vl__IV_yaw,'String'));
[theta(1),theta(2),d(3),theta(4),sucess] = InverseKinematic(x,y,z,yaw/180*pi,a(1),a(2),d(1));
if sucess
    theta(1) = theta(1)*180/pi;
    theta(2) = theta(2)*180/pi;
    theta(4) = theta(4)*180/pi;

    [pos,orien] = ForwardKinematic(a, alpha*pi/180, d, theta*pi/180)
    set(handles.vl__IV_t1,'String',theta(1));
    set(handles.vl__IV_t2,'String',theta(2));
    set(handles.vl__IV_d3,'String',d(3));
    set(handles.vl__IV_t4,'String',theta(4));
    UpdateRobot(pos,orien,handles,11,11);
    set(handles.tb_dh,'Data',[a alpha d theta]);   %put dh parameter to DH table
    set(handles.tb_pos_orien,'Data',[pos orien*180/pi]);   %put dh parameter to DH table
end

% --- Executes on button press in btn_IV_reset.
function btn_IV_reset_Callback(hObject, eventdata, handles)

global a alpha d theta pos orien
    set(handles.vl__IV_x,'String','0.45');
    set(handles.vl__IV_y,'String','0.40');
    set(handles.vl__IV_z,'String','0.46');
    set(handles.vl__IV_yaw,'String','90');
    
    theta(1) = 0;
    theta(2) = 90;
    d(3) = 0;
    theta(4) = 0;

    [pos,orien] = ForwardKinematic(a, alpha*pi/180, d, theta*pi/180)
    UpdateRobot(pos,orien,handles,11,11);
    set(handles.tb_dh,'Data',[a alpha d theta]);   %put dh parameter to DH table
    set(handles.tb_pos_orien,'Data',[pos orien*180/pi]);   %put dh parameter to DH table


% --- Executes on button press in rb_MSL850.
function rb_MSL850_Callback(hObject, eventdata, handles)

global a alpha d theta
global theta1_max theta2_max d3_max;
theta1_max = 180;
theta2_max = 180;
d3_max = 0.42;

a(1) = 0.45;
a(2) = 0.40;
d(1) = 0.46;
set(handles.vl_a1,'String',a(1)) 
set(handles.vl_a2,'String',a(2)) 
set(handles.vl_d1,'String',d(1)) 
[pos,orien] = ForwardKinematic(a, alpha*pi/180, d, theta*pi/180)
UpdateRobot(pos,orien,handles,11,11);

% --- Executes on button press in rb_MSL1000.
function rb_MSL1000_Callback(hObject, eventdata, handles)

global a alpha d theta
global theta1_max theta2_max d3_max;
theta1_max = 180;
theta2_max = 180;
d3_max = 0.42;

a(1) = 0.6;
a(2) = 0.4;
d(1) = 0.46;
set(handles.vl_a1,'String',a(1)) 
set(handles.vl_a2,'String',a(2)) 
set(handles.vl_d1,'String',d(1)) 
[pos,orien] = ForwardKinematic(a, alpha*pi/180, d, theta*pi/180)
UpdateRobot(pos,orien,handles,11,11);

% --- Executes on button press in rb_MSL650.
function rb_MSL650_Callback(hObject, eventdata, handles)

global a alpha d theta
global theta1_max theta2_max d3_max;
theta1_max = 180;
theta2_max = 180;
d3_max = 0.42;

a(1) = 0.4;
a(2) = 0.25;
d(1) = 0.46;
set(handles.vl_a1,'String',a(1)) 
set(handles.vl_a2,'String',a(2)) 
set(handles.vl_d1,'String',d(1)) 
[pos,orien] = ForwardKinematic(a, alpha*pi/180, d, theta*pi/180)
UpdateRobot(pos,orien,handles,11,11);

% --- Executes on button press in rb_THL300.
function rb_THL300_Callback(hObject, eventdata, handles)

global a alpha d theta
global theta1_max theta2_max d3_max;
theta1_max = 125;
theta2_max = 145;
d3_max = 0.3;
a(1) = 0.55;
a(2) = 0.45;
d(1) = 0.194;
set(handles.vl_a1,'String',a(1)) 
set(handles.vl_a2,'String',a(2)) 
set(handles.vl_d1,'String',d(1)) 
[pos,orien] = ForwardKinematic(a, alpha*pi/180, d, theta*pi/180)
UpdateRobot(pos,orien,handles,11,11);

% --- Executes on button press in rb_THL400.
function rb_THL400_Callback(hObject, eventdata, handles)

global a alpha d theta
global theta1_max theta2_max d3_max;
a(1) = 0.35;
a(2) = 0.45;
d(1) = 0.15;
theta1_max = 125;
theta2_max = 145;
d3_max = 0.16;
set(handles.vl_a1,'String',a(1)) 
set(handles.vl_a2,'String',a(2)) 
set(handles.vl_d1,'String',d(1)) 
[pos,orien] = ForwardKinematic(a, alpha*pi/180, d, theta*pi/180)
UpdateRobot(pos,orien,handles,11,11);

% --- Executes on button press in rb_THL600.
function rb_THL600_Callback(hObject, eventdata, handles)

global a alpha d theta
global theta1_max theta2_max d3_max;
theta1_max = 125;
theta2_max = 145;
d3_max = 0.15;

a(1) = 0.3;
a(2) = 0.3;
d(1) = 0.179;
set(handles.vl_a1,'String',a(1)) 
set(handles.vl_a2,'String',a(2)) 
set(handles.vl_d1,'String',d(1)) 
[pos,orien] = ForwardKinematic(a, alpha*pi/180, d, theta*pi/180)
UpdateRobot(pos,orien,handles,11,11);
