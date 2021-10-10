function varargout = starter(varargin)
% STARTER MATLAB code for starter.fig
%      STARTER, by itself, creates a new STARTER or raises the existing
%      singleton*.
%
%      H = STARTER returns the handle to a new STARTER or the handle to
%      the existing singleton*.
%
%      STARTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STARTER.M with the given input arguments.
%
%      STARTER('Property','Value',...) creates a new STARTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before starter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to starter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help starter

% Last Modified by GUIDE v2.5 10-Oct-2021 23:14:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @starter_OpeningFcn, ...
                   'gui_OutputFcn',  @starter_OutputFcn, ...
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


% --- Executes just before starter is made visible.
function starter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to starter (see VARARGIN)

% Choose default command line output for starter
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes starter wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = starter_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ForwardBtn.
function ForwardBtn_Callback(hObject, eventdata, handles)
% hObject    handle to ForwardBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closereq();
main;

% --- Executes on button press in Inverse_Btn.
function Inverse_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to Inverse_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Pathplanning_Btn.
function Pathplanning_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to Pathplanning_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Demo_Btn.
function Demo_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to Demo_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
