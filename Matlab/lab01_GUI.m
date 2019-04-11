function varargout = lab01_GUI(varargin)
% LAB01_GUI MATLAB code for lab01_GUI.fig
%      LAB01_GUI, by itself, creates a new LAB01_GUI or raises the existing
%      singleton*.
%
%      H = LAB01_GUI returns the handle to a new LAB01_GUI or the handle to
%      the existing singleton*.
%
%      LAB01_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LAB01_GUI.M with the given input arguments.
%
%      LAB01_GUI('Property','Value',...) creates a new LAB01_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before lab01_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lab01_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help lab01_GUI

% Last Modified by GUIDE v2.5 04-Apr-2018 21:52:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lab01_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @lab01_GUI_OutputFcn, ...
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


% --- Executes just before lab01_GUI is made visible.
function lab01_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lab01_GUI (see VARARGIN)

% Choose default command line output for lab01_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes lab01_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = lab01_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.wybor = get(hObject, 'Value');

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function funkcja_Callback(hObject, eventdata, handles)
% hObject    handle to funkcja (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of funkcja as text
%        str2double(get(hObject,'String')) returns contents of funkcja as a double


% --- Executes during object creation, after setting all properties.
function funkcja_CreateFcn(hObject, eventdata, handles)
% hObject    handle to funkcja (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in oblicz.
function oblicz_Callback(hObject, eventdata, handles)
% hObject    handle to oblicz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wybor = get(handles.popupmenu1,'Value');
switch wybor
   case 1
        %f=@(x) (1./3).*x.^2 - (13./7).*x + 11;
        %f=@(x) (1./3).*(x-3).^3 + (x-4).^2;
        f = str2func(get(handles.funkcja,'String'));
        %x1= 1;
        x1 = str2num(get(handles.x1,'String'));
        %x3= 5;
        x3 = str2num(get(handles.x3,'String'));

        krok = 0.001
        iteracje = 1;
        x= x1:krok:x3;
        x2 = (x1+x3)/2
        delta = x2-x1

        xm = x2-0.5*delta*((f(x3)-f(x1))/(f(x1)-2*f(x2)+f(x3)))

        while abs(x2-xm)>krok
            xm = x2-0.5*delta*((f(x3)-f(x1))/(f(x1)-2*f(x2)+f(x3)))
            if f(xm)<f(x2)
                x2 = xm;
            end

            delta = 0.5 * delta;
            x1 = x2 - delta;
            x3 = x2 + delta;    
            iteracje = iteracje + 1;
        end

        axes(handles.axes1)
        plot(x,f(x))
        %xm
        %f(xm)
        %iteracje
        set(handles.iteracje,'String',iteracje);
        set(handles.wynik,'String',xm);

    otherwise
end



function x1_Callback(hObject, eventdata, handles)
% hObject    handle to x1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x1 as text
%        str2double(get(hObject,'String')) returns contents of x1 as a double


% --- Executes during object creation, after setting all properties.
function x1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x3_Callback(hObject, eventdata, handles)
% hObject    handle to x3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x3 as text
%        str2double(get(hObject,'String')) returns contents of x3 as a double


% --- Executes during object creation, after setting all properties.
function x3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
