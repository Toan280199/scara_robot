function varargout = forward(varargin)
% MAIN M-file for forward.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before forward_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to forward_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help forward

% Last Modified by GUIDE v2.5 10-Oct-2021 23:47:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @forward_OpeningFcn, ...
                   'gui_OutputFcn',  @forward_OutputFcn, ...
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

% --- Executes just before forward is made visible.
function forward_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to forward (see VARARGIN)

% Choose default command line output for forward
handles.output = hObject;
handles(axes1)
rotate3d on
view(15,11)

% Update handles structure
guidata(hObject, handles);
ForwardKinematic(0, pi/2, 0, 0, handles)

% UIWAIT makes forward wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = forward_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on slider movement.
function t1vl_Callback(hObject, eventdata, handles)
% hObject    handle to t1vl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
theta1 = get(handles.t1vl,'value');
set(handles.t1dp,'string',num2str(theta1/3.14*180));

theta1 = get(handles.t1vl,'value');
theta2 = get(handles.t2vl,'value');
d3 = get(handles.d3vl,'value');
theta4 = get(handles.t4vl,'value');
ForwardKinematic(theta1, theta2, d3, theta4, handles)

% --- Executes during object creation, after setting all properties.
function t1vl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t1vl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function t2vl_Callback(hObject, eventdata, handles)
% hObject    handle to t2vl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
theta2 = get(handles.t2vl,'value');
set(handles.t2dp,'string',num2str(theta2/3.14*180));
theta1 = get(handles.t1vl,'value');
theta2 = get(handles.t2vl,'value');
d3 = get(handles.d3vl,'value');
theta4 = get(handles.t4vl,'value');
ForwardKinematic(theta1, theta2, d3, theta4, handles)

% --- Executes during object creation, after setting all properties.
function t2vl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t2vl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function d3vl_Callback(hObject, eventdata, handles)
% hObject    handle to d3vl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

d3 = get(handles.d3vl,'value');
set(handles.d3dp,'string',num2str(d3));
theta1 = get(handles.t1vl,'value');
theta2 = get(handles.t2vl,'value');
d3 = get(handles.d3vl,'value');
theta4 = get(handles.t4vl,'value');
ForwardKinematic(theta1, theta2, d3, theta4, handles)

% --- Executes during object creation, after setting all properties.
function d3vl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d3vl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function t4vl_Callback(hObject, eventdata, handles)
% hObject    handle to t4vl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

theta4 = get(handles.t4vl,'value');
set(handles.t4dp,'string',num2str(theta4/3.14*180));
theta1 = get(handles.t1vl,'value');
theta2 = get(handles.t2vl,'value');
d3 = get(handles.d3vl,'value');
theta4 = get(handles.t4vl,'value');
ForwardKinematic(theta1, theta2, d3, theta4, handles)

% --- Executes during object creation, after setting all properties.
function t4vl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t4vl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function t1dp_Callback(hObject, eventdata, handles)
% hObject    handle to t1dp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t1dp as text
%        str2double(get(hObject,'String')) returns contents of t1dp as a double
theta1 = str2double(get(handles.t1dp, 'String'))/180*3.14;
set(handles.t1vl, 'Value', theta1);

% --- Executes during object creation, after setting all properties.
function t1dp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t1dp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function t2dp_Callback(hObject, eventdata, handles)
% hObject    handle to t2dp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t2dp as text
%        str2double(get(hObject,'String')) returns contents of t2dp as a double
theta2 = str2double(get(handles.t2dp, 'String'))/180*3.14;
set(handles.t2vl, 'Value', theta2);

% --- Executes during object creation, after setting all properties.
function t2dp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t2dp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function d3dp_Callback(hObject, eventdata, handles)
% hObject    handle to d3dp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d3dp as text
%        str2double(get(hObject,'String')) returns contents of d3dp as a double
d3 = str2double(get(handles.d3dp, 'String'));
set(handles.d3vl, 'Value', d3);

% --- Executes during object creation, after setting all properties.
function d3dp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d3dp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function t4dp_Callback(hObject, eventdata, handles)
% hObject    handle to t4dp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t4dp as text
%        str2double(get(hObject,'String')) returns contents of t4dp as a double
theta4 = str2double(get(handles.t4dp, 'String'))/180*3.14;
set(handles.t4vl, 'Value', theta4);

% --- Executes during object creation, after setting all properties.
function t4dp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t4dp (see GCBO)
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

function yawvl_Callback(hObject, eventdata, handles)
% hObject    handle to yawvl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yawvl as text
%        str2double(get(hObject,'String')) returns contents of yawvl as a double


% --- Executes during object creation, after setting all properties.
function yawvl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yawvl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in show_xyz.
function show_xyz_Callback(hObject, eventdata, handles)
% hObject    handle to show_xyz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of show_xyz


% --- Executes on button press in clearBtn.
function clearBtn_Callback(hObject, eventdata, handles)
% hObject    handle to clearBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global plot_data
plot_data = [];
ForwardKinematic(0,pi/2,0,0,handles)


% --- Executes on button press in goHome_Btn.
function goHome_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to goHome_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closereq();
starter;

% --- Executes on button press in Exit_Btn.
function Exit_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to Exit_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closereq();
