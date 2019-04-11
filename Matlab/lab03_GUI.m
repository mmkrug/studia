function varargout = lab03_GUI(varargin)
% lab03_GUI MATLAB code for lab03_GUI.fig
%      lab03_GUI, by itself, creates a new lab03_GUI or raises the existing
%      singleton*.
%
%      H = lab03_GUI returns the handle to a new lab03_GUI or the handle to
%      the existing singleton*.
%
%      lab03_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in lab03_GUI.M with the given input arguments.
%
%      lab03_GUI('Property','Value',...) creates a new lab03_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before lab03_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lab03_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help lab03_GUI

% Last Modified by GUIDE v2.5 19-Apr-2018 00:29:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lab03_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @lab03_GUI_OutputFcn, ...
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


% --- Executes just before lab03_GUI is made visible.
function lab03_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lab03_GUI (see VARARGIN)

% Choose default command line output for lab03_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes lab03_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = lab03_GUI_OutputFcn(hObject, eventdata, handles) 
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
%handles.wybor = get(hObject, 'Value');

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

%##########################################################################
% --- Executes on button press in oblicz.
function oblicz_Callback(hObject, eventdata, handles)

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
dokl = str2num(get(handles.dokl,'String'));;
dx(1)=x0;
dy(1)=y0;

%f1=@(x,y) (x.^2)+(y.^2);
%f1=@(x,y) (100*(y-(x.^2)).^2)+(1-x).^2;
%f1=@(x,y) -(cos(x).*cos(y).*exp(-(  ((x-pi).^2) + (y-pi).^2)));

axes(handles.axes1)
mesh(x,y,f1(x,y))
axes(handles.axes2)
[c,h]=contour(x,y,f1(x,y))
title('Metoda ...')
%axis square
clabel(c,h)
hold on
czybyl=0;
iteracje=1;

while(k>dokl)
    [w,p]=min([f1(x0,y0),f1(x0,y0+k),f1(x0+k,y0),f1(x0,y0-k),f1(x0-k,y0),f1(x0+k,y0+k),f1(x0+k,y0-k),f1(x0-k,y0-k),f1(x0-k,y0+k)]);
    iteracje=iteracje+1;
    switch(p)
        case 1
            k=k/2;
            czybyl=czybyl+1;
            dx(iteracje)=x0;
            dy(iteracje)=y0;
            if(czybyl>6)
               break; 
            end
            continue;
        case 2
            y0=y0+k;
            dx(iteracje)=x0;
            dy(iteracje)=y0;
           czybyl=0;
            continue;
        case 3
            x0=x0+k;
            dx(iteracje)=x0;
            dy(iteracje)=y0;
            czybyl=0;
            continue;
        case 4
            y0=y0-k;
            dx(iteracje)=x0;
            dy(iteracje)=y0;
            czybyl=0;
            continue;
        case 5
            x0=x0-k;
            dx(iteracje)=x0;
            dy(iteracje)=y0;
            czybyl=0;
           continue;   
         case 6
            x0=x0+k;
            y0=y0+k;
            dx(iteracje)=x0;
            dy(iteracje)=y0;
            czybyl=0;
           continue;   
          case 7
            x0=x0+k;
            y0=y0-k;
            dx(iteracje)=x0;
            dy(iteracje)=y0;
            czybyl=0;
           continue; 
        case 8
            x0=x0-k;
            y0=y0-k;
            dx(iteracje)=x0;
            dy(iteracje)=y0;
            czybyl=0;
           continue; 
         case 9
            x0=x0-k;
            y0=y0+k;
            dx(iteracje)=x0;
            dy(iteracje)=y0;
            czybyl=0;
           continue; 
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

%set(handles.iteracje,'String',str2num(get(handles.przedzialx_1,'String')));


%##########################################################################
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
