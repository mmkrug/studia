function varargout = gradient_gui(varargin)
% GRADIENT_GUI MATLAB code for gradient_gui.fig
%      GRADIENT_GUI, by itself, creates a new GRADIENT_GUI or raises the existing
%      singleton*.
%
%      H = GRADIENT_GUI returns the handle to a new GRADIENT_GUI or the handle to
%      the existing singleton*.
%
%      GRADIENT_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GRADIENT_GUI.M with the given input arguments.
%
%      GRADIENT_GUI('Property','Value',...) creates a new GRADIENT_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gradient_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gradient_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gradient_gui

% Last Modified by GUIDE v2.5 19-Apr-2018 09:25:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gradient_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gradient_gui_OutputFcn, ...
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


% --- Executes just before gradient_gui is made visible.
function gradient_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gradient_gui (see VARARGIN)

% Choose default command line output for gradient_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gradient_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gradient_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%[x,y]=meshgrid([-5:0.1:5],[-5:0.1:5]);
%[x,y]=meshgrid([-2:0.1:2],[-1:0.1:3]);
%[x,y]=meshgrid([-20:0.1:20],[-20:0.1:20]);

%f1=@(x,y) (x.^2)+(y.^2);
%f1=@(x,y) (100*(y-(x.^2)).^2)+(1-x).^2;
%f1=@(x,y) -(cos(x).*cos(y).*exp(-(  ((x-pi).^2) + (y-pi).^2)));

x_s = str2double(get(handles.x_s,'String'));
x_k = str2double(get(handles.x_k,'String'));

y_s = str2double(get(handles.y_s,'String'));
y_k = str2double(get(handles.y_k,'String'));

a = str2double(get(handles.a,'String'));
b = str2double(get(handles.b,'String'));

L = str2double(get(handles.lambda,'String'));
dokl = str2double(get(handles.dokladnosc,'String'));

elo = get(handles.my_fun,'String');

[x,y]=meshgrid([x_s:0.1:x_k],[y_s:0.1:y_k]);

x0 = a;
y0 = b;

f1=@(x,y)eval(elo);

axes(handles.axes1);
mesh(x,y,f1(x,y))

axes(handles.axes2);
[c,h]=contour(x,y,f1(x,y))
clabel(c,h)
hold on;

iteracje=1;

h = 0.000001;

    dfdx = (f1(x0+h,y0)-f1(x0-h,y0))/(2*h)
    dfdy = (f1(x0,y0+h)-f1(x0,y0-h))/(2*h)
    
    grad = [dfdx,dfdy]
    alfa = L/norm(grad)
    
    x0 = x0 - alfa *grad(1);
    y0 = y0 - alfa * grad(2);
    
    dx(1)=x0;
    dy(1)=y0;
    

while(norm(grad)>dokl)

    dfdx = (f1(x0+h,y0)-f1(x0-h,y0))/(2*h);
    dfdy = (f1(x0,y0+h)-f1(x0,y0-h))/(2*h);
    
    grad = [dfdx,dfdy];
    
    alfa = L/norm(grad);
    
    x0 = x0 - alfa *grad(1);
    y0 = y0 - alfa * grad(2);
    
    iteracje = iteracje + 1;
    
    dx(iteracje) = x0;
    dy(iteracje) = y0;
    
    if (iteracje > 2)
      if(abs(dx(iteracje)- dx(iteracje-2))<dokl)
        if(abs(dy(iteracje)- dy(iteracje-2))<dokl)
            L=L/2
        end
      end
    end
end


plot(dx(1),dy(1),'r*')
text(dx(1),dy(1),'START')
plot(dx(end),dy(end),'r*')
text(dx(end),dy(end),'STOP')

plot(dx(2:end-1),dy(2:end-1),'g.')
plot(dx,dy)

set(handles.x_min,'String',x0);
set(handles.y_min,'String',y0);
set(handles.f_min,'String',f1(x0,y0));
set(handles.iteracja,'String',iteracje-1);

hold off;









function my_fun_Callback(hObject, eventdata, handles)
% hObject    handle to my_fun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of my_fun as text
%        str2double(get(hObject,'String')) returns contents of my_fun as a double


% --- Executes during object creation, after setting all properties.
function my_fun_CreateFcn(hObject, eventdata, handles)
% hObject    handle to my_fun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x_s_Callback(hObject, eventdata, handles)
% hObject    handle to x_s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x_s as text
%        str2double(get(hObject,'String')) returns contents of x_s as a double


% --- Executes during object creation, after setting all properties.
function x_s_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x_k_Callback(hObject, eventdata, handles)
% hObject    handle to x_k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x_k as text
%        str2double(get(hObject,'String')) returns contents of x_k as a double


% --- Executes during object creation, after setting all properties.
function x_k_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y_s_Callback(hObject, eventdata, handles)
% hObject    handle to y_s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y_s as text
%        str2double(get(hObject,'String')) returns contents of y_s as a double


% --- Executes during object creation, after setting all properties.
function y_s_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y_k_Callback(hObject, eventdata, handles)
% hObject    handle to y_k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y_k as text
%        str2double(get(hObject,'String')) returns contents of y_k as a double


% --- Executes during object creation, after setting all properties.
function y_k_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a_Callback(hObject, eventdata, handles)
% hObject    handle to a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a as text
%        str2double(get(hObject,'String')) returns contents of a as a double


% --- Executes during object creation, after setting all properties.
function a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b_Callback(hObject, eventdata, handles)
% hObject    handle to b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b as text
%        str2double(get(hObject,'String')) returns contents of b as a double


% --- Executes during object creation, after setting all properties.
function b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lambda_Callback(hObject, eventdata, handles)
% hObject    handle to lambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lambda as text
%        str2double(get(hObject,'String')) returns contents of lambda as a double


% --- Executes during object creation, after setting all properties.
function lambda_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dokladnosc_Callback(hObject, eventdata, handles)
% hObject    handle to dokladnosc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dokladnosc as text
%        str2double(get(hObject,'String')) returns contents of dokladnosc as a double


% --- Executes during object creation, after setting all properties.
function dokladnosc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dokladnosc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
