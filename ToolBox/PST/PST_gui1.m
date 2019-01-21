%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           SPECTRUM: A MATLAB Toolbox for Top-down Proteomics     %
%                           Version 1.0.0                          %
%        Copyright (c) Biomedical Informatics Research Laboratory, %
%          Lahore University of Management Sciences Lahore (LUMS), %
%                           Pakistan.                              %
%                (http://biolabs.lums.edu.pk/BIRL)                 %
%                    (safee.ullah@gmail.com)                       %
%                 Last Modified on: 19-January-2019                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function varargout = PST_gui1(varargin)
% PST_GUI1 MATLAB code for PST_gui1.fig
%      PST_GUI1, by itself, creates a new PST_GUI1 or raises the existing
%      singleton*.
%
%      H = PST_GUI1 returns the handle to a new PST_GUI1 or the handle to
%      the existing singleton*.
%
%      PST_GUI1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PST_GUI1.M with the given input arguments.
%
%      PST_GUI1('Property','Value',...) creates a new PST_GUI1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PST_gui1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PST_gui1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PST_gui1

% Last Modified by GUIDE v2.5 01-Jan-2018 14:07:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @PST_gui1_OpeningFcn, ...
    'gui_OutputFcn',  @PST_gui1_OutputFcn, ...
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


% --- Executes just before PST_gui1 is made visible.
function PST_gui1_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PST_gui1 (see VARARGIN)
% Choose default command line output for PST_gui1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PST_gui1 wait for user response (see UIRESUME)
% uiwait(handles.figure_PST);


% --- Outputs from this function are returned to the command line.
function varargout = PST_gui1_OutputFcn(~, ~, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiwait;
% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_next.
function pushbutton_next_Callback(~, ~, handles) %#ok<*DEFNU>
% hObject    handle to pushbutton_next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Max_rang=get(handles.popupmenu_max,'String');
Max_value=get(handles.popupmenu_max,'Value');
Min_rang=get(handles.popupmenu_min,'String');
Min_value=get(handles.popupmenu_min,'Value');
try
    if(str2num(get(handles.edit_hop,'String'))>2||str2num(get(handles.edit_hop,'String'))<0) %#ok<*ST2NM>
        errordlg({'Invalid hop tolerance!';'tolerance must be a positive number and less than or equal to  2 '},'Error!','Modal')
        return
    end
    if(str2num(get(handles.edit_PST,'String'))>4 ||str2num(get(handles.edit_PST,'String'))<0)
        errordlg({'Invalid PST tolerance selected!';'tolerance must be a positive number less than or equal to 4 '},'Error!','Modal');
        return
    end
    if(str2num(Min_rang{Min_value})>str2num(Max_rang{Max_value}))
        errordlg('Error Minimum length can not be greater than Maximium length! ');
        return
    end
    
    setappdata(0,'Mini_TagLength',Min_rang{Min_value});
    setappdata(0,'Max_TagLength',Max_rang{Max_value});
    setappdata(0,'Hop_threshold',get(handles.edit_hop,'String'));
    setappdata(0,'TagError_threshold',get(handles.edit_PST,'String'));
    setappdata(0,'FilterPSTs',get(handles.FilterPSTs,'Value'));
    setappdata(0,'condition',1);
catch
    errordlg('Invaid input parameters!','Error');
    return
end
uiresume;
delete(handles.figure_PST)

% --- Executes on selection change in popupmenu_min.
function popupmenu_min_Callback(~, ~, ~)

% --- Executes during object creation, after setting all properties.
function popupmenu_min_CreateFcn(hObject, ~, ~)
% hObject    handle to popupmenu_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_PST_Callback(~, ~, ~)

% --- Executes during object creation, after setting all properties.
function edit_PST_CreateFcn(hObject, ~, ~)
% hObject    handle to edit_PST (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_min.
function popupmenu_max_Callback(~, ~, ~)

% --- Executes during object creation, after setting all properties.
function popupmenu_max_CreateFcn(hObject, ~, ~)
% hObject    handle to popupmenu_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_hop_Callback(~, ~, ~)

% --- Executes during object creation, after setting all properties.
function edit_hop_CreateFcn(hObject, ~, ~)
% hObject    handle to edit_hop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_cancel.
function pushbutton_cancel_Callback(~, ~, handles)
% hObject    handle to pushbutton_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'condition',2);
close(handles.figure_PST);
%return


% --- Executes on button press in pushbutton_reset.
function pushbutton_reset_Callback(~, ~, handles)
% hObject    handle to pushbutton_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.popupmenu_min,'Enable','on');
set(handles.popupmenu_max,'Enable','on');
set(handles.edit_hop,'Enable','on');
set(handles.popupmenu_units,'Enable','on');
set(handles.edit_PST,'Enable','on');
set(handles.FilterPSTs,'Value',1);
set(handles.popupmenu_max,'Value',6);
set(handles.popupmenu_min,'Value',3);
set(handles.edit_hop,'String','0.1');
set(handles.edit_PST,'String','0.45');



% --- Executes when user attempts to close figure_PST.
function figure_PST_CloseRequestFcn(hObject, ~, ~)
% hObject    handle to figure_PST (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
setappdata(0,'condition',2);
delete(hObject);


% --- Executes during object creation, after setting all properties.
function Title_text_CreateFcn(hObject, ~, ~)
% hObject    handle to Title_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
Title=getappdata(0,'Title');
set(hObject,'String',Title);

% --- Executes on selection change in popupmenu_units.
function popupmenu_units_Callback(~, ~, ~)

% --- Executes during object creation, after setting all properties.
function popupmenu_units_CreateFcn(hObject, ~, ~)
% hObject    handle to popupmenu_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in FilterPSTs.
function FilterPSTs_Callback(hObject, ~, handles)
% hObject    handle to FilterPSTs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of FilterPSTs
status = get(hObject,'Value');
if status == 1
    set(handles.popupmenu_min,'Enable','on');
    set(handles.popupmenu_max,'Enable','on');
    set(handles.edit_hop,'Enable','on');
    set(handles.popupmenu_units,'Enable','on');
    set(handles.edit_PST,'Enable','on');
else
    set(handles.popupmenu_min,'Enable','off');
    set(handles.popupmenu_max,'Enable','off');
    set(handles.edit_hop,'Enable','off');
    set(handles.popupmenu_units,'Enable','off');
    set(handles.edit_PST,'Enable','off');
end
