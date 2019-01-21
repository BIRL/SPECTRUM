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

function varargout = anb(varargin)
% ANB M-file for anb.fig
%      ANB, by itself, creates a new ANB or raises the existing
%      singleton*.
%
%      H = ANB returns the handle to a new ANB or the handle to
%      the existing singleton*.
%
%      ANB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANB.M with the given input arguments.
%
%      ANB('Property','Value',...) creates a new ANB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before anb_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to anb_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help anb

% Last Modified by GUIDE v2.5 19-Jun-2017 14:46:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @anb_OpeningFcn, ...
    'gui_OutputFcn',  @anb_OutputFcn, ...
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


% --- Executes just before anb is made visible.
function anb_OpeningFcn(~, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to anb (see VARARGIN)
setappdata(0,'MH',1);
setappdata(0,'ao',0);
setappdata(0,'bo',0);
setappdata(0,'yo',0);
setappdata(0,'zoo',0);
setappdata(0,'zo',0);
setappdata(0,'astar',0);
setappdata(0,'bstar',0);
setappdata(0,'ystar',0);


similar_fragments = {'CID','IMD','BIRD','SID','HCD'};
similar_fragments2 = {'ECD','ETD'};
similar_fragments3 = {'EDD','NETD'};
if any(strcmpi(getappdata(0,'Fragmentation'),similar_fragments))
    set(handles.zoo,'Enable','off');
    set(handles.zo,'Enable','off');
    set(handles.astar,'Enable','off');
    set(handles.ao,'Enable','off');
    %%
    set(handles.bstar,'Value',1);
    set(handles.bo,'Value',1);
    set(handles.ystar,'Value',1);
    set(handles.yo,'Value',1);
    
elseif any(strcmpi(getappdata(0,'Fragmentation'),similar_fragments2))
    set(handles.ao,'Enable','off');
    set(handles.bo,'Enable','off');
    set(handles.astar,'Enable','off');
    set(handles.bstar,'Enable','off');
    set(handles.yo,'Enable','off');
    set(handles.ystar,'Enable','off');
    %%
    set(handles.zoo,'Value',1);
    set(handles.zo,'Value',1);
    
elseif any(strcmpi(getappdata(0,'Fragmentation'),similar_fragments3))
    set(handles.zoo,'Enable','off');
    set(handles.zo,'Enable','off');
    set(handles.bo,'Enable','off');
    set(handles.bstar,'Enable','off');
    set(handles.yo,'Enable','off');
    set(handles.ystar,'Enable','off');
    %%
    set(handles.ao,'Value',1);
    set(handles.astar,'Value',1);
else
    set(handles.ao,'Value',1);
    set(handles.astar,'Value',1);
    set(handles.zoo,'Value',1);
    set(handles.zo,'Value',1);
    set(handles.bstar,'Value',1);
    set(handles.bo,'Value',1);
    set(handles.ystar,'Value',1);
    set(handles.yo,'Value',1);
end



% Choose default command line output for anb
uiwait(gcf);

% Update handles structure
% guidata(hObject, handles);

% UIWAIT makes anb wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = anb_OutputFcn(~, ~, ~)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
output={};
output{1,1} = getappdata(0,'ao');
output{2,1} = getappdata(0,'bo');
output{3,1} = getappdata(0,'yo');
output{4,1} = getappdata(0,'zo');
output{5,1} = getappdata(0,'zoo');
output{6,1} = getappdata(0,'astar');
output{7,1} = getappdata(0,'bstar');
output{8,1} = getappdata(0,'ystar');
output{9,1} = getappdata(0,'MH');
varargout{1,1} = output;



% --- Executes on button press in ao.
function ao_Callback(hObject, ~, ~) %#ok<*DEFNU>
% hObject    handle to ao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'zo',get(hObject,'Value'));% returns toggle state of astar
setappdata(0,'ao',get(hObject,'Value'));
setappdata(0,'bo',get(hObject,'Value'));
setappdata(0,'yo',get(hObject,'Value'));
setappdata(0,'zoo',get(hObject,'Value'));
setappdata(0,'astar',get(hObject,'Value'));
setappdata(0,'bstar',get(hObject,'Value'));
setappdata(0,'ystar',get(hObject,'Value'));

% --- Executes on button press in bo.
function bo_Callback(hObject, ~, ~)
% hObject    handle to bo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'zo',get(hObject,'Value'));% returns toggle state of astar
setappdata(0,'ao',get(hObject,'Value'));
setappdata(0,'bo',get(hObject,'Value'));
setappdata(0,'yo',get(hObject,'Value'));
setappdata(0,'zoo',get(hObject,'Value'));
setappdata(0,'astar',get(hObject,'Value'));
setappdata(0,'bstar',get(hObject,'Value'));
setappdata(0,'ystar',get(hObject,'Value'));


% --- Executes on button press in astar.
function astar_Callback(hObject, ~, ~)
% hObject    handle to astar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'zo',get(hObject,'Value'));% returns toggle state of astar
setappdata(0,'ao',get(hObject,'Value'));
setappdata(0,'bo',get(hObject,'Value'));
setappdata(0,'yo',get(hObject,'Value'));
setappdata(0,'zoo',get(hObject,'Value'));
setappdata(0,'astar',get(hObject,'Value'));
setappdata(0,'bstar',get(hObject,'Value'));
setappdata(0,'ystar',get(hObject,'Value'));


% --- Executes on button press in bstar.
function bstar_Callback(hObject, ~, ~)
% hObject    handle to bstar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

setappdata(0,'zo',get(hObject,'Value'));% returns toggle state of astar
setappdata(0,'ao',get(hObject,'Value'));
setappdata(0,'bo',get(hObject,'Value'));
setappdata(0,'yo',get(hObject,'Value'));
setappdata(0,'zoo',get(hObject,'Value'));
setappdata(0,'astar',get(hObject,'Value'));
setappdata(0,'bstar',get(hObject,'Value'));
setappdata(0,'ystar',get(hObject,'Value'));

% --- Executes on button press in ystar.
function ystar_Callback(hObject, ~, ~)
% hObject    handle to ystar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'zo',get(hObject,'Value'));% returns toggle state of astar
setappdata(0,'ao',get(hObject,'Value'));
setappdata(0,'bo',get(hObject,'Value'));
setappdata(0,'yo',get(hObject,'Value'));
setappdata(0,'zoo',get(hObject,'Value'));
setappdata(0,'astar',get(hObject,'Value'));
setappdata(0,'bstar',get(hObject,'Value'));
setappdata(0,'ystar',get(hObject,'Value'));


% --- Executes on button press in yo.
function yo_Callback(hObject, ~, ~)
% hObject    handle to yo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'zo',get(hObject,'Value'));% returns toggle state of astar
setappdata(0,'ao',get(hObject,'Value'));
setappdata(0,'bo',get(hObject,'Value'));
setappdata(0,'yo',get(hObject,'Value'));
setappdata(0,'zoo',get(hObject,'Value'));
setappdata(0,'astar',get(hObject,'Value'));
setappdata(0,'bstar',get(hObject,'Value'));
setappdata(0,'ystar',get(hObject,'Value'));

% --- Executes on button press in zo.
function zo_Callback(hObject, ~, ~)
% hObject    handle to zo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'zo',get(hObject,'Value'));% returns toggle state of astar
setappdata(0,'ao',get(hObject,'Value'));
setappdata(0,'bo',get(hObject,'Value'));
setappdata(0,'yo',get(hObject,'Value'));
setappdata(0,'zoo',get(hObject,'Value'));
setappdata(0,'astar',get(hObject,'Value'));
setappdata(0,'bstar',get(hObject,'Value'));
setappdata(0,'ystar',get(hObject,'Value'));
% Hint: get(hObject,'Value') returns toggle state of zo


% --- Executes on button press in zoo.
function zoo_Callback(hObject, ~, ~)
% hObject    handle to zoo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'zo',get(hObject,'Value'));% returns toggle state of astar
setappdata(0,'ao',get(hObject,'Value'));
setappdata(0,'bo',get(hObject,'Value'));
setappdata(0,'yo',get(hObject,'Value'));
setappdata(0,'zoo',get(hObject,'Value'));
setappdata(0,'astar',get(hObject,'Value'));
setappdata(0,'bstar',get(hObject,'Value'));
setappdata(0,'ystar',get(hObject,'Value'));
% Hint: get(hObject,'Value') returns toggle state of zoo

% --- Executes on button press in Okay.
function Okay_Callback(~, ~, handles)
% hObject    handle to Okay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'MH',getappdata(0,'MH'));
setappdata(0,'zo',get(handles.zo,'Value'));% returns toggle state of astar
setappdata(0,'ao',get(handles.ao,'Value'));
setappdata(0,'bo',get(handles.bo,'Value'));
setappdata(0,'yo',get(handles.yo,'Value'));
setappdata(0,'zoo',get(handles.zoo,'Value'));
setappdata(0,'astar',get(handles.astar,'Value'));
setappdata(0,'bstar',get(handles.bstar,'Value'));
setappdata(0,'ystar',get(handles.ystar,'Value'));
uiresume(gcbf);
close(gcf);


% --- Executes on key press with focus on Okay and none of its controls.
function Okay_KeyPressFcn(~, ~, ~)
% hObject    handle to Okay (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, ~, ~)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes during object creation, after setting all properties.
function Title_text_CreateFcn(hObject, ~, ~)
% hObject    handle to Title_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
Title=getappdata(0,'Title');
set(hObject,'String',Title);


% --- Executes on button press in MN.
function MN_Callback(~, ~, ~)
% hObject    handle to MN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'MH',0);
% Hint: get(hObject,'Value') returns toggle state of MN


% --- Executes on button press in MH.
function MH_Callback(~, ~, ~)
% hObject    handle to MH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'MH',1);
% Hint: get(hObject,'Value') returns toggle state of MH
