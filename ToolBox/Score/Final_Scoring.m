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

function varargout = Final_Scoring(varargin)
% FINAL_SCORING MATLAB code for Final_Scoring.fig
%      FINAL_SCORING, by itself, creates a new FINAL_SCORING or raises the existing
%      singleton*.
%
%      H = FINAL_SCORING returns the handle to a new FINAL_SCORING or the handle to
%      the existing singleton*.
%
%      FINAL_SCORING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINAL_SCORING.M with the given input arguments.
%
%      FINAL_SCORING('Property','Value',...) creates a new FINAL_SCORING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Final_Scoring_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Final_Scoring_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Final_Scoring

% Last Modified by GUIDE v2.5 12-Feb-2017 23:43:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Final_Scoring_OpeningFcn, ...
    'gui_OutputFcn',  @Final_Scoring_OutputFcn, ...
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


% --- Executes just before Final_Scoring is made visible.
function Final_Scoring_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Final_Scoring (see VARARGIN)

% Choose default command line output for Final_Scoring
handles.output = hObject;

set(handles.slider_MolecularWeight, 'Value', 1);
FilterPSTs = getappdata(0,'FilterPSTs');
set(handles.slider_PST, 'Value', 1);
set(handles.slider_InSilicoMass, 'Value', 1);


if FilterPSTs == 1
    set(handles.checkbox_PST,'Value',1);
    set(handles.checkbox_PST,'Enable','on');
else
    set(handles.checkbox_PST,'Value',0);
    set(handles.checkbox_PST,'Enable','off');
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Final_Scoring wait for user response (see UIRESUME)
%uiwait(handles.figure_FinalScoring);

%     setappdata(hObject,'MWSliderValue',get(handles.text_MWSliderValue,'String'));
%     setappdata(hObject,'PSTSliderValue',get(handles.text_MWSliderValue,'String'));
%     setappdata(hObject,'PTMSliderValue',get(handles.text_PTMSliderValue,'String'));
%     setappdata(hObject,'InSilicoSliderValue',get(handles.text_InSilicoSliderValue,'String'));



% --- Outputs from this function are returned to the command line.
function varargout = Final_Scoring_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiwait(gcf);
% Returning textbox values of all the sliders
output = {};
%     output{1,1} = getappdata(hObject,'MWSliderValue');
%     output{2,1} = getappdata(hObject,'PSTSliderValue');
%     output{3,1} = getappdata(hObject,'PTMSliderValue');
%     output{4,1} = getappdata(hObject,'InSilicoSliderValue');
varargout{1,1} = output;
% Get default command line output from handles structure
%varargout{1} = handles.output;




% --- Executes on button press in checkbox_PST.
function checkbox_PST_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_PST (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_PST


% --- Executes on button press in checkbox_InSilicoScore.
function checkbox_InSilicoScore_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_InSilicoScore (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_InSilicoScore


% --- Executes on slider movement.
function slider_MolecularWeight_Callback(hObject, eventdata, handles)
% hObject    handle to slider_MolecularWeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%% Getting slider value and update it in the text box moving with slider
SliderValue = get (hObject, 'Val');
set(hObject,'TooltipString', num2str(SliderValue)); % Setting tooltip string of the slider
% 62.2000 is x-axis position of the textbox and it is added with appropriate value of the slider
% multiplied with the number to adjust textbox move with the slider
PositionOfSliderValue = 62.2000 + SliderValue*28.7;
set(handles.text_MWSliderValue,'Position',[PositionOfSliderValue 13.15 4.6000 1.1538]) % Updating position of the textbox on x-axis
set(handles.text_MWSliderValue,'String',SliderValue) % updating the textbox with the slider value


% --- Executes during object creation, after setting all properties.
function slider_MolecularWeight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_MolecularWeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Min',0,'Max',1,'Value',0.5);


% --- Executes on slider movement.
function slider_PST_Callback(hObject, eventdata, handles)
% hObject    handle to slider_PST (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%% Getting slider value and update it in the text box moving with slider
SliderValue = get (hObject, 'Val');
set(hObject,'TooltipString', num2str(SliderValue)); % Setting tooltip string of the slider
% 62.2000 is x-axis position of the textbox and it is added with appropriate value of the slider
% multiplied with the number to adjust textbox move with the slider
PositionOfSliderValue = 62.2000 + SliderValue*28.7;
set(handles.text_PSTSliderValue,'Position',[PositionOfSliderValue 8.307 4.6000 1.1538]) % Updating position of the textbox on x-axis
set(handles.text_PSTSliderValue,'String',SliderValue) % updating the textbox with the slider value

% --- Executes during object creation, after setting all properties.
function slider_PST_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_PST (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

set(hObject,'Min',0,'Max',1,'Value',0.5);

% --- Executes on slider movement.
function slider_InSilicoMass_Callback(hObject, eventdata, handles)
% hObject    handle to slider_InSilicoMass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%% Getting slider value and update it in the text box moving with slider
SliderValue = get (hObject, 'Val');
set(hObject,'TooltipString', num2str(SliderValue)); % Setting tooltip string of the slider
% 62.2000 is x-axis position of the textbox and it is added with appropriate value of the slider
% multiplied with the number to adjust textbox move with the slider
PositionOfSliderValue = 62.2000 + SliderValue*28.5;
set(handles.text_InSilicoSliderValue,'Position',[PositionOfSliderValue 3.384 4.6000 1.1538]) % Updating position of the textbox on x-axis
set(handles.text_InSilicoSliderValue,'String',SliderValue) % updating the textbox with the slider value

% --- Executes during object creation, after setting all properties.
function slider_InSilicoMass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_InSilicoMass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

set(hObject,'Min',0,'Max',1,'Value',0.5);

% --- Executes on key press with focus on slider_MolecularWeight and none of its controls.


% --- Executes during object creation, after setting all properties.
function text_ComponentsSocre_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_ComponentsSocre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text_ToolboxVersion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_ToolboxVersion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
%disp('test')
f = filesep;
addpath(strcat('..',f))
version = fopen('SPECTRUM_Version.txt');
set(hObject,'String',fgetl(version));


% --- Executes during object creation, after setting all properties.
function text_MWSliderValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_MWSliderValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Setting position of the textbox to the center (0.5 value of the slider) on x-axis
set(hObject,'Position',[77 13.15 4.6000 1.1538])

% --- Executes during object creation, after setting all properties.
function text_PSTSliderValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_PSTSliderValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Setting position of the textbox to the center (0.5 value of the slider) on x-axis
set(hObject,'Position',[77 8.307 4.6000 1.1538])

% --- Executes during object creation, after setting all properties.
function text_InSilicoSliderValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_InSilicoSliderValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Setting position of the textbox to the center (0.5 value of the slider) on x-axis
set(hObject,'Position',[77 3.384 4.6000 1.1538])

%%--- Executes on button press in pushbutton_Next.
function pushbutton_Next_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
w1=0;w2=0;w3=0;
if(get(handles.checkbox_MolecularWeight,'Value'))
    w1=get(handles.slider_MolecularWeight,'Value'); % get value from slider to wieghtage to molecular weight score
end

if(get(handles.checkbox_PST,'Value'))
    w2=get(handles.slider_PST,'Value');% get value from slider to wieghtage to Pst score
end
if(get(handles.checkbox_InSilicoScore,'Value'))
    w3=get(handles.slider_InSilicoMass,'Value');% get value from slider to wieghtage to insilico fargmentation  score
end
setappdata(0,'w1',w1);
setappdata(0,'w2',w2);
setappdata(0,'w3',w3);
if(get(handles.checkbox_MolecularWeight,'Value')) ||(get(handles.checkbox_PST,'Value')||get(handles.checkbox_InSilicoScore,'Value'))
    final_score;
else
    errordlg('Select at least one parameter to score','Error','modal');
    return;
end

close(handles.figure_FinalScoring);
setappdata(0,'FScoringWindowClosed',false);
%---uiresume(gcbf);

% --- Executes when user attempts to close figure_FinalScoring.
function figure_FinalScoring_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure_FinalScoring (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes during object deletion, before destroying properties.
function figure_FinalScoring_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure_FinalScoring (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

setappdata(0,'FScoringWindowClosed',true);


% --- Executes on button press in checkbox_MolecularWeight.
function checkbox_MolecularWeight_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_MolecularWeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_MolecularWeight






% --- Executes during object creation, after setting all properties.
function Title_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
Title=getappdata(0,'Title');
set(hObject,'String',Title);
