function varargout = lab033_GUI(varargin)
% LAB033_GUI MATLAB code for lab033_GUI.fig
%      LAB033_GUI, by itself, creates a new LAB033_GUI or raises the existing
%      singleton*.
%
%      H = LAB033_GUI returns the handle to a new LAB033_GUI or the handle to
%      the existing singleton*.
%
%      LAB033_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LAB033_GUI.M with the given input arguments.
%
%      LAB033_GUI('Property','Value',...) creates a new LAB033_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before lab033_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lab033_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help lab033_GUI

% Last Modified by GUIDE v2.5 10-May-2018 01:07:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lab033_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @lab033_GUI_OutputFcn, ...
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


% --- Executes just before lab033_GUI is made visible.
function lab033_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lab033_GUI (see VARARGIN)

% Choose default command line output for lab033_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes lab033_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = lab033_GUI_OutputFcn(hObject, eventdata, handles) 
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



function przedzialx_1_Callback(hObject, eventdata, handles)
% hObject    handle to przedzialx_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of przedzialx_1 as text
%        str2double(get(hObject,'String')) returns contents of przedzialx_1 as a double


% --- Executes during object creation, after setting all properties.
function przedzialx_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to przedzialx_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function przedzialx_2_Callback(hObject, eventdata, handles)
% hObject    handle to przedzialx_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of przedzialx_2 as text
%        str2double(get(hObject,'String')) returns contents of przedzialx_2 as a double


% --- Executes during object creation, after setting all properties.
function przedzialx_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to przedzialx_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function przedzialy_1_Callback(hObject, eventdata, handles)
% hObject    handle to przedzialy_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of przedzialy_1 as text
%        str2double(get(hObject,'String')) returns contents of przedzialy_1 as a double


% --- Executes during object creation, after setting all properties.
function przedzialy_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to przedzialy_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function przedzialy_2_Callback(hObject, eventdata, handles)
% hObject    handle to przedzialy_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of przedzialy_2 as text
%        str2double(get(hObject,'String')) returns contents of przedzialy_2 as a double


% --- Executes during object creation, after setting all properties.
function przedzialy_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to przedzialy_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in oblicz.
function oblicz_Callback(hObject, eventdata, handles)
tic
wybor = get(handles.popupmenu1,'Value');
switch wybor
   case 1
       f1=@(x,y) (x.^2)+(y.^2);
   case 2
       f1=@(x,y) (100*(y-(x.^2)).^2)+(1-x).^2;
   case 3
       f1=@(x,y) -(cos(x).*cos(y).*exp(-(  ((x-pi).^2) + (y-pi).^2)));
end

[x,y]=meshgrid([str2num(get(handles.przedzialx_1,'String')):0.1:str2num(get(handles.przedzialx_2,'String'))],[str2num(get(handles.przedzialy_1,'String')):0.1:str2num(get(handles.przedzialy_2,'String'))]);

x0 = str2num(get(handles.pkt_pocz_x,'String'));
y0 = str2num(get(handles.pkt_pocz_y,'String'));
k = str2num(get(handles.krok,'String'));
dokl = str2num(get(handles.dokl,'String'));
lambda = k;
dx(1)=x0;
dy(1)=y0;


axes(handles.axes1)
mesh(x,y,f1(x,y))

axes(handles.axes2)
[c,h]=contour(x,y,f1(x,y))
clabel(c,h)

hold on;

iteracje=1;
h=0.000001;



    z1 = (f1(x0+h, y0) - f1(x0-h, y0)) / (2*h);
    z2 = (f1(x0, y0+h) - f1(x0, y0-h)) / (2*h);

    grad = [z1, z2];  
    alfa = lambda / norm(grad);
    x0 = x0 - alfa*grad(1);
    y0 = y0 - alfa*grad(2);
    
    iteracje = iteracje + 1;
    dx(iteracje) = x0;
    dy(iteracje) = y0;



while(norm(grad)>dokl)
    z1 = (f1(x0+h, y0) - f1(x0-h, y0)) / (2*h);
    z2 = (f1(x0, y0+h) - f1(x0, y0-h)) / (2*h);

    grad = [z1, z2];  
    alfa = lambda / norm(grad);
    x0 = x0 - alfa*grad(1);
    y0 = y0 - alfa*grad(2);
    
    iteracje = iteracje + 1;
    dx(iteracje) = x0;
    dy(iteracje) = y0;
    
    if (iteracje > 2)
      if(abs(dx(iteracje)- dx(iteracje-2))<dokl)
        if(abs(dy(iteracje)- dy(iteracje-2))<dokl)
            lambda = lambda/2;
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



%x0
set(handles.minx,'String',x0);
%y0
set(handles.miny,'String',y0);
%f1(x0,y0)
set(handles.fmin,'String',f1(x0,y0));
%iteracje-1
set(handles.iteracje,'String',iteracje-1);

toc
hold off;


function pkt_pocz_x_Callback(hObject, eventdata, handles)
% hObject    handle to pkt_pocz_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pkt_pocz_x as text
%        str2double(get(hObject,'String')) returns contents of pkt_pocz_x as a double


% --- Executes during object creation, after setting all properties.
function pkt_pocz_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pkt_pocz_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pkt_pocz_y_Callback(hObject, eventdata, handles)
% hObject    handle to pkt_pocz_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pkt_pocz_y as text
%        str2double(get(hObject,'String')) returns contents of pkt_pocz_y as a double


% --- Executes during object creation, after setting all properties.
function pkt_pocz_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pkt_pocz_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function krok_Callback(hObject, eventdata, handles)
% hObject    handle to krok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of krok as text
%        str2double(get(hObject,'String')) returns contents of krok as a double


% --- Executes during object creation, after setting all properties.
function krok_CreateFcn(hObject, eventdata, handles)
% hObject    handle to krok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dokl_Callback(hObject, eventdata, handles)
% hObject    handle to dokl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dokl as text
%        str2double(get(hObject,'String')) returns contents of dokl as a double


% --- Executes during object creation, after setting all properties.
function dokl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dokl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
