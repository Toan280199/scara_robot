function varargout = inverse(varargin)
% INVERSE MATLAB code for inverse.fig
%      INVERSE, by itself, creates a new INVERSE or raises the existing
%      singleton*.
%
%      H = INVERSE returns the handle to a new INVERSE or the handle to
%      the existing singleton*.
%
%      INVERSE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INVERSE.M with the given input arguments.
%
%      INVERSE('Property','Value',...) creates a new INVERSE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before inverse_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to inverse_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help inverse

% Last Modified by GUIDE v2.5 14-Oct-2021 00:13:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @inverse_OpeningFcn, ...
                   'gui_OutputFcn',  @inverse_OutputFcn, ...
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


% --- Executes just before inverse is made visible.
function inverse_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to inverse (see VARARGIN)

% Choose default command line output for inverse
handles.output = hObject;
rotate3d on
view(15,11)

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes inverse wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = inverse_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function x_sld_Callback(hObject, eventdata, handles)
% hObject    handle to x_sld (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

x = get(handles.x_sld,'value');
set(handles.x_txt,'string',x);
InverseKinematic(handles);


% --- Executes during object creation, after setting all properties.
function x_sld_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_sld (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
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



function x_txt_Callback(hObject, eventdata, handles)
% hObject    handle to x_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x_txt as text
%        str2double(get(hObject,'String')) returns contents of x_txt as a double


% --- Executes during object creation, after setting all properties.
function x_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function y_txt_Callback(hObject, eventdata, handles)
% hObject    handle to y_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y_txt as text
%        str2double(get(hObject,'String')) returns contents of y_txt as a double


% --- Executes during object creation, after setting all properties.
function y_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function z_txt_Callback(hObject, eventdata, handles)
% hObject    handle to z_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of z_txt as text
%        str2double(get(hObject,'String')) returns contents of z_txt as a double


% --- Executes during object creation, after setting all properties.
function z_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z_txt (see GCBO)
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


% --- Executes on button press in clear_btn.
function clear_btn_Callback(hObject, eventdata, handles)
% hObject    handle to clear_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global plot_data
plot_data = [];
InverseKinametic(handles)

% --- Executes on button press in hme_btn.
function hme_btn_Callback(hObject, eventdata, handles)
% hObject    handle to hme_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closereq();
starter;

% --- Executes on button press in ext_btn.
function ext_btn_Callback(hObject, eventdata, handles)
% hObject    handle to ext_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closereq();

% --- Executes on slider movement.
function y_sld_Callback(hObject, eventdata, handles)
% hObject    handle to y_sld (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

y = get(handles.y_sld,'value');
set(handles.y_txt,'string',y);
InverseKinematic(handles);


% --- Executes during object creation, after setting all properties.
function y_sld_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_sld (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function z_sld_Callback(hObject, eventdata, handles)
% hObject    handle to z_sld (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

z = get(handles.z_sld,'value');
set(handles.z_txt,'string',z);
InverseKinematic(handles);


% --- Executes during object creation, after setting all properties.
function z_sld_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z_sld (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function yaw_sld_Callback(hObject, eventdata, handles)
% hObject    handle to yaw_sld (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
yaw = get(handles.yaw_sld,'value');
set(handles.yawvl,'string',yaw*180/pi);
InverseKinematic(handles);


% --- Executes during object creation, after setting all properties.
function yaw_sld_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yaw_sld (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
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
