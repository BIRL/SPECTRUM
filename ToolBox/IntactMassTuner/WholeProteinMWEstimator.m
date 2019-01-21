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

function varargout = WholeProteinMWEstimator(varargin)
% FIGURE_WHOLEPROTEINMWESTIMATOR M-file for figure_WholeProteinMWEstimator.fig
%      FIGURE_WHOLEPROTEINMWESTIMATOR, by itself, creates a new FIGURE_WHOLEPROTEINMWESTIMATOR or raises the existing
%      singleton*.
%
%      H = FIGURE_WHOLEPROTEINMWESTIMATOR returns the handle to a new FIGURE_WHOLEPROTEINMWESTIMATOR or the handle to
%      the existing singleton*.
%
%      FIGURE_WHOLEPROTEINMWESTIMATOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FIGURE_WHOLEPROTEINMWESTIMATOR.M with the given input arguments.
%
%      FIGURE_WHOLEPROTEINMWESTIMATOR('Property','Value',...) creates a new FIGURE_WHOLEPROTEINMWESTIMATOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before WholeProteinMWEstimator_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to WholeProteinMWEstimator_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help figure_WholeProteinMWEstimator

% Last Modified by GUIDE v2.5 12-Feb-2017 22:10:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @WholeProteinMWEstimator_OpeningFcn, ...
    'gui_OutputFcn',  @WholeProteinMWEstimator_OutputFcn, ...
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


function WholeProteinMWEstimator_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SPECTRUM (see VARARGIN)
% Choose default command line output for SPECTRUM
% Sets x and y coordinates labels
% try
xLabel = 'Molecular Weights (Da)';
xlabel(xLabel,'FontName','MS Sans Serif');
xlabel(xLabel,'FontUnits','pixels');
xlabel(xLabel,'FontWeight','normal');
xlabel(xLabel,'FontSize',10);

yLabel = 'Frequency';
ylabel(yLabel,'FontName','MS Sans Serif');
ylabel(yLabel,'FontUnits','pixels');
ylabel(yLabel,'FontWeight','normal');
ylabel(yLabel,'FontSize',10);



set(handles.slider_Tolerance, 'min', 1.0);
set(handles.slider_Tolerance, 'max', 150.0);
set(handles.slider_Tolerance, 'Value', 50.0);

% Check on all the checkboxes by default
set(handles.checkbox_FragmentSums,'Value',1)
setappdata(handles.figure_WholeProteinMWEstimator,'SumsofFragmentMasses',get(handles.checkbox_FragmentSums,'Value'))
set(handles.checkbox_FragmentFrequencies,'Value',1)
setappdata(handles.figure_WholeProteinMWEstimator,'FragmentFrequency',get(handles.checkbox_FragmentFrequencies,'Value'));
set(handles.checkbox_Peak_wiseIntensity,'Value',1)
setappdata(handles.figure_WholeProteinMWEstimator,'Peak_wiseIntensity',get(handles.checkbox_Peak_wiseIntensity,'Value'));

handles.output = hObject;
% Clear_at_start(handles); % to reset all fields when gui loads
% Update handles structure
% Calls slider_Tolerance_Callback to generate event when the window open for the first time
induce_slider_Tolerance_Callback (hObject, eventdata, handles);
%     catch exception
%         errordlg(getReport(exception,'basic','hyperlinks','off'));
%     end

guidata(hObject, handles);

% UIWAIT makes SPECTRUM wait for user response (see UIRESUME)
uiwait(handles.figure_WholeProteinMWEstimator);

% --- Outputs from this function are returned to the command line.
function varargout = WholeProteinMWEstimator_OutputFcn(~, ~, ~) %#ok<*STOUT>
% --- Executes during object creation, after setting all properties.
function edit_WholeProtPPMTolerance_CreateFcn(hObject, ~, ~) %#ok<*DEFNU>
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit_TunedMass_Callback(~, ~, ~)
% --- Executes during object creation, after setting all properties.
function edit_TunedMass_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject,'String','0.0') % Default value of Protien Tuned Mass
% --- Executes during object creation, after setting all properties.
function edit_ExperimentalMass_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --- Executes on button press in checkbox_FragmentSums.
function checkbox_FragmentSums_Callback(hObject, ~, handles)
setappdata(handles.figure_WholeProteinMWEstimator,'SumsofFragmentMasses',get(hObject,'Value'));
% --- Executes on button press in checkbox_FragmentFrequencies.
function checkbox_FragmentFrequencies_Callback(hObject, ~, handles)
setappdata(handles.figure_WholeProteinMWEstimator,'FragmentFrequency',get(hObject,'Value'));
% --- Executes on button press in checkbox_Peak_wiseIntensity.
function checkbox_Peak_wiseIntensity_Callback(hObject, ~, handles)
setappdata(handles.figure_WholeProteinMWEstimator,'Peak_wiseIntensity',get(hObject,'Value'));
% --- Executes during object creation, after setting all properties.
function checkbox_Peak_wiseIntensity_CreateFcn(hObject, ~, ~)
set(hObject, 'Value', 1);
% --- Executes during object creation, after setting all properties.
% --- Executes during object creation, after setting all properties.
function checkbox_FragmentFrequencies_CreateFcn(hObject, ~, ~)
set(hObject, 'Value', 1);
% --- Executes during object creation, after setting all properties.
function checkbox_FragmentSums_CreateFcn(hObject, ~, ~)
set(hObject, 'Value', 1);
% --- Executes on slider movement.
function slider_Tolerance_Callback(hObject, eventdata, handles)
induce_slider_Tolerance_Callback (hObject, eventdata, handles);
% --- Executes during object creation, after setting all properties.
function slider_Tolerance_CreateFcn(hObject, ~, ~)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Min',0,'Max',2000,'Value',150.5);
% --- Executes during object creation, after setting all properties.
function figure_WholeProteinMWEstimator_CreateFcn(~, ~, ~)
% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over edit_TunedMass.
function edit_TunedMass_ButtonDownFcn(~, ~, ~)
function edit_WholeProtPPMTolerance_Callback(~, ~, ~)
function edit_WholeProtPPMTolerance_ButtonDownFcn(~, ~, ~)
function text_TolerancePPM_CreateFcn(~, ~, ~)
% --- Executes during object creation, after setting all properties.
function text_ExperimentalMass_CreateFcn(~, ~, ~)
function edit_ExperimentalMass_Callback(~, ~, ~)



function text_ToolboxVersion_CreateFcn(hObject, ~, ~)
version = fopen('SPECTRUM_Version.txt');
set(hObject,'String',fgetl(version));





function figure_WholeProteinMWEstimator_CloseRequestFcn(hObject, ~, ~)
delete(hObject);
function figure_WholeProteinMWEstimator_DeleteFcn(~, ~, ~)
setappdata(0,'WindowClosed',true);
function Title_CreateFcn(hObject, ~, ~)
Title=getappdata(0,'Title');
set(hObject,'String',Title);



function pushbutton_Next_Callback(~, ~, handles)
Tuned_Mass=get(handles.edit_TunedMass,'String');
setappdata(0,'Tuned_Mass',Tuned_Mass);
uiresume();
close(gcf);
setappdata(0,'WindowClosed',false);

function induce_slider_Tolerance_Callback (hObject, ~, handles)
clc;
% try
%Fetch value from the slider (current control)
Slider_Value = get (handles.slider_Tolerance, 'Val');
MW_Tolerance = getappdata(0,'Molecular_Weight_Tol');

%Update the edit_WholeProtPPMTolerance text box with the new value of Tolerance
set (handles.edit_WholeProtPPMTolerance, 'String', Slider_Value);
Experimental_Protein_Mass = getappdata(0,'Experimental_Protein_Mass');
%[Fragments_SumofMolWt,Fragments_MaxIntensity,Fragments_Selected_SumofIntensity,x,y,Tuned_MolWt] = FilterProteinMWs(Slider_Value);
% [Tuned_MolWt,Fragments_SumofMolWt,Fragments_MaxIntensity ,Histc_Unique_Fragments_MolWt,Unique_Fragments_Occurrences] =  FilterProteinMWs(Slider_Value,Experimental_Protein_Mass);
[Tuned_MolWt, Fragments_SumofMolWt,Fragments_MaxIntensity ,Histc_Unique_Fragments_MolWt,Unique_Fragments_Occurrences] =  MassTuner(Slider_Value,Experimental_Protein_Mass,MW_Tolerance);
%set (handles.edit_ExperimentalMass,'String', ProtMW);


set(handles.edit_ExperimentalMass,'String',Experimental_Protein_Mass);
set (handles.edit_TunedMass,'String', Tuned_MolWt);

%Update the plot with the new conjugated whole protein MW
SumsofFragmentMasses = getappdata(handles.figure_WholeProteinMWEstimator,'SumsofFragmentMasses');
FragmentFrequency = getappdata(handles.figure_WholeProteinMWEstimator,'FragmentFrequency');
Peak_wiseIntensity = getappdata(handles.figure_WholeProteinMWEstimator,'Peak_wiseIntensity');

hold on
cla
%global variables SumsofFragmentMasses,FragmentFrequency,Peak_wiseIntensity when contain the value 1 the
%respective intensity or frequency is plotted

if SumsofFragmentMasses ==1
    line([Fragments_SumofMolWt Fragments_SumofMolWt],[1 0]);
end
if FragmentFrequency == 1
    plot(Histc_Unique_Fragments_MolWt,Unique_Fragments_Occurrences, 'k','LineWidth',2);
end
if Peak_wiseIntensity == 1 && numel(Fragments_MaxIntensity) ~= 0
    plot(Fragments_MaxIntensity(:,1),Fragments_MaxIntensity(:,2), '*');
end
% 
%     catch exception
%         errordlg('error in induce_slider_Tolerance_Callback');
%     end


guidata(hObject,handles);


