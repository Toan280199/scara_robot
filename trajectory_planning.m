function varargout = trajectory_planning(varargin)
% TRAJECTORY_PLANNING MATLAB code for trajectory_planning.fig
%      TRAJECTORY_PLANNING, by itself, creates a new TRAJECTORY_PLANNING or raises the existing
%      singleton*.
%
%      H = TRAJECTORY_PLANNING returns the handle to a new TRAJECTORY_PLANNING or the handle to
%      the existing singleton*.
%
%      TRAJECTORY_PLANNING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRAJECTORY_PLANNING.M with the given input arguments.
%
%      TRAJECTORY_PLANNING('Property','Value',...) creates a new TRAJECTORY_PLANNING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before trajectory_planning_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to trajectory_planning_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help trajectory_planning

% Last Modified by GUIDE v2.5 15-Oct-2021 03:49:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @trajectory_planning_OpeningFcn, ...
                   'gui_OutputFcn',  @trajectory_planning_OutputFcn, ...
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


% --- Executes just before trajectory_planning is made visible.
function trajectory_planning_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to trajectory_planning (see VARARGIN)

% Choose default command line output for trajectory_planning
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global plot_data;
plot_data = [];

global a1 a2 d1;
a1     = 0.45;
a2     = 0.4;
d1     = 0.46;

global theta1 theta2 d3 theta4
theta1 = 0;
theta2 = pi/2;
d3 = 0;
theta4 = 0;
axes(handles.axes1)
rotate3d on
view(15,11)

% UIWAIT makes trajectory_planning wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = trajectory_planning_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function a1_vl_Callback(hObject, eventdata, handles)
% hObject    handle to a1_vl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a1_vl as text
%        str2double(get(hObject,'String')) returns contents of a1_vl as a double


% --- Executes during object creation, after setting all properties.
function a1_vl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a1_vl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function tf_vl_Callback(hObject, eventdata, handles)
% hObject    handle to tf_vl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tf_vl as text
%        str2double(get(hObject,'String')) returns contents of tf_vl as a double


% --- Executes during object creation, after setting all properties.
function tf_vl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tf_vl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Go.
function Go_Callback(hObject, eventdata, handles)
% hObject    handle to Go (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global a1 a2 d1 theta1 theta2 d3 theta4
a1     = 0.45;
a2     = 0.4;
d1     = 0.46;

px = str2num(get(handles.px_vl,'String'));
py = str2num(get(handles.py_vl,'String'));
pz = str2num(get(handles.pz_vl,'String'));
pyaw = str2num(get(handles.pyaw_vl,'String'));

[ptheta1,ptheta2,pd3,ptheta4] = InverseKinametic(px,py,pz,pyaw,handles)

% theta 1
a_max = str2num(get(handles.a1_vl,'String'))
t_f = str2num(get(handles.tf_vl,'String'));

[new_a,t,theta1_d] = Trapezoidal_Velocity_Planning(a_max,t_f,theta1,ptheta1);
set(handles.a1_vl,'String',num2str(new_a));

axes(handles.theta1_plot);
cla;
plot(t,theta1_d,'r','LineWidth',1.5);
hold on
ylabel('\theta_1 (rad)');

axes(handles.theta1_dot_plot);
theta1_dot_d = diff(theta1_d)/10^-3;
plot(t,[0 theta1_dot_d],'r','LineWidth',1.5);

axes(handles.theta1_2dot_plot);
theta1_2dot_d = diff(theta1_dot_d)/10^-3;
plot(t,[0 0 theta1_2dot_d],'r','LineWidth',1.5);

% theta 2
a_max = str2num(get(handles.a2_vl,'String'));
[new_a,theta2_d] = Trapezoidal_Velocity_Planning(a_max,t_f,theta2,ptheta2);
set(handles.a2_vl,'String',num2str(new_a));

axes(handles.theta2_plot);
cla;
plot(t,theta2_d,'r','LineWidth',1.5);
ylabel('\theta_2 (rad)');

axes(handles.theta2_dot_plot);
theta2_dot_d = diff(theta2_d)/10^-3;
plot(t,[0 theta2_dot_d],'r','LineWidth',1.5);

axes(handles.theta2_2dot_plot);
theta2_2dot_d = diff(theta2_dot_d)/10^-3;
plot(t,[0 0 theta2_2dot_d],'r','LineWidth',1.5);

% d3
a_max = str2num(get(handles.a3_vl,'String'));
[new_a,t,d3_d] = Trapezoidal_Velocity_Planning(a_max,t_f,d3,pd3);
set(handles.a3_vl,'String',num2str(new_a));

axes(handles.d3_plot);
cla;
plot(t,d3_d,'r','LineWidth',1.5);
xlabel('Time (s)')
ylabel('d_3 (rad)');

axes(handles.d3_dot_plot);
d3_dot_d = diff(d3_d)/10^-3;
plot(t,[0 d3_dot_d],'r','LineWidth',1.5);

axes(handles.d3_2dot_plot);
d3_2dot_d = diff(d3_dot_d)/10^-3;
xlabel('Time (s)')
plot(t,[0 0 d3_2dot_d],'r','LineWidth',1.5);

% theta 4

a_max = str2num(get(handles.a4_vl,'String'));
[new_a,t,theta4_d] = Trapezoidal_Velocity_Planning(a_max,t_f,theta4,ptheta4);
set(handles.a4_vl,'String',num2str(new_a));

axes(handles.theta4_plot);
cla;
plot(t,theta4_d,'r','LineWidth',1.5);
ylabel('\theta_4 (rad)');

axes(handles.theta4_dot_plot);
theta4_dot_d = diff(theta4_d)/10^-3;
plot(t,[0 theta4_dot_d],'r','LineWidth',1.5);

axes(handles.theta4_2dot_plot);
theta4_2dot_d = diff(theta4_dot_d)/10^-3;
xlabel('Time (s)')
plot(t,[0 0 theta4_2dot_d],'r','LineWidth',1.5);

%% Cap nhat ket qua
[p4,o4] = ForwardKinematic(theta1_d(end), theta2_d(end), d3_d(end), theta4_d(end), handles)
theta1 = theta1_d(end);
theta2 = theta2_d(end);
d3 = d3_d(end);
theta4 = theta4_d(end);


function px_vl_Callback(hObject, eventdata, handles)
% hObject    handle to px_vl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of px_vl as text
%        str2double(get(hObject,'String')) returns contents of px_vl as a double


% --- Executes during object creation, after setting all properties.
function px_vl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to px_vl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function py_vl_Callback(hObject, eventdata, handles)
% hObject    handle to py_vl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of py_vl as text
%        str2double(get(hObject,'String')) returns contents of py_vl as a double


% --- Executes during object creation, after setting all properties.
function py_vl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to py_vl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pz_vl_Callback(hObject, eventdata, handles)
% hObject    handle to pz_vl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pz_vl as text
%        str2double(get(hObject,'String')) returns contents of pz_vl as a double


% --- Executes during object creation, after setting all properties.
function pz_vl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pz_vl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pyaw_vl_Callback(hObject, eventdata, handles)
% hObject    handle to pyaw_vl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pyaw_vl as text
%        str2double(get(hObject,'String')) returns contents of pyaw_vl as a double


% --- Executes during object creation, after setting all properties.
function pyaw_vl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pyaw_vl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a2_vl_Callback(hObject, eventdata, handles)
% hObject    handle to a2_vl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a2_vl as text
%        str2double(get(hObject,'String')) returns contents of a2_vl as a double


% --- Executes during object creation, after setting all properties.
function a2_vl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a2_vl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a3_vl_Callback(hObject, eventdata, handles)
% hObject    handle to a3_vl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a3_vl as text
%        str2double(get(hObject,'String')) returns contents of a3_vl as a double


% --- Executes during object creation, after setting all properties.
function a3_vl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a3_vl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a4_vl_Callback(hObject, eventdata, handles)
% hObject    handle to a4_vl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a4_vl as text
%        str2double(get(hObject,'String')) returns contents of a4_vl as a double


% --- Executes during object creation, after setting all properties.
function a4_vl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a4_vl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xvl_Callback(hObject, eventdata, handles)
% hObject    handle to xvl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xvl as text
%        str2double(get(hObject,'String')) returns contents of xvl as a double


% --- Executes during object creation, after setting all properties.
function xvl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xvl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yvl_Callback(hObject, eventdata, handles)
% hObject    handle to yvl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yvl as text
%        str2double(get(hObject,'String')) returns contents of yvl as a double


% --- Executes during object creation, after setting all properties.
function yvl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yvl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function zvl_Callback(hObject, eventdata, handles)
% hObject    handle to zvl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of zvl as text
%        str2double(get(hObject,'String')) returns contents of zvl as a double


% --- Executes during object creation, after setting all properties.
function zvl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zvl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yaw_real_Callback(hObject, eventdata, handles)
% hObject    handle to pyaw_vl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pyaw_vl as text
%        str2double(get(hObject,'String')) returns contents of pyaw_vl as a double


% --- Executes during object creation, after setting all properties.
function yaw_real_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pyaw_vl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function t1_txt_Callback(hObject, eventdata, handles)
% hObject    handle to t1_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t1_txt as text
%        str2double(get(hObject,'String')) returns contents of t1_txt as a double


% --- Executes during object creation, after setting all properties.
function t1_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t1_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function t2_txt_Callback(hObject, eventdata, handles)
% hObject    handle to t2_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t2_txt as text
%        str2double(get(hObject,'String')) returns contents of t2_txt as a double


% --- Executes during object creation, after setting all properties.
function t2_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t2_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function d3_txt_Callback(hObject, eventdata, handles)
% hObject    handle to d3_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d3_txt as text
%        str2double(get(hObject,'String')) returns contents of d3_txt as a double


% --- Executes during object creation, after setting all properties.
function d3_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d3_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function t4_txt_Callback(hObject, eventdata, handles)
% hObject    handle to t4_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t4_txt as text
%        str2double(get(hObject,'String')) returns contents of t4_txt as a double


% --- Executes during object creation, after setting all properties.
function t4_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t4_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rollvl_Callback(hObject, eventdata, handles)
% hObject    handle to rollvl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rollvl as text
%        str2double(get(hObject,'String')) returns contents of rollvl as a double


% --- Executes during object creation, after setting all properties.
function rollvl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rollvl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pitchvl_Callback(hObject, eventdata, handles)
% hObject    handle to pitchvl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pitchvl as text
%        str2double(get(hObject,'String')) returns contents of pitchvl as a double


% --- Executes during object creation, after setting all properties.
function pitchvl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pitchvl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
