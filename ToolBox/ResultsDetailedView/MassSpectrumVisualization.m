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

function varargout = MassSpectrumVisualization(varargin)
% MASSSPECTRUMVISUALIZATION MATLAB code for MassSpectrumVisualization.fig
%      MASSSPECTRUMVISUALIZATION, by itself, creates a new MASSSPECTRUMVISUALIZATION or raises the existing
%      singleton*.
%
%      H = MASSSPECTRUMVISUALIZATION returns the handle to a new MASSSPECTRUMVISUALIZATION or the handle to
%      the existing singleton*.
%
%      MASSSPECTRUMVISUALIZATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MASSSPECTRUMVISUALIZATION.M with the given input arguments.
%
%      MASSSPECTRUMVISUALIZATION('Property','Value',...) creates a new MASSSPECTRUMVISUALIZATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MassSpectrumVisualization_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MassSpectrumVisualization_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MassSpectrumVisualization

% Last Modified by GUIDE v2.5 15-Jan-2019 20:43:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @MassSpectrumVisualization_OpeningFcn, ...
    'gui_OutputFcn',  @MassSpectrumVisualization_OutputFcn, ...
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


% --- Executes just before MassSpectrumVisualization is made visible.
function MassSpectrumVisualization_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MassSpectrumVisualization (see VARARGIN)

% Choose default command line output for MassSpectrumVisualization
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes MassSpectrumVisualization wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MassSpectrumVisualization_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

AssembleInsilicoSpectraforDisplay;

Fragments_Peaklist_Data = getappdata(0,'Peaklist_Data'); %Experimental data
Match = getappdata(0,'Match'); % Theoretical data

fragmentation_id = getappdata(0,'fragmentation_id');
fragmentation_ion = getappdata(0,'fragmentation_ion');
experimental_mz = getappdata(0,'experimental_mz');
theoretical_mz = getappdata(0,'theoretical_mz');
mass_difference = getappdata(0,'mass_difference');

hold on

stem(Fragments_Peaklist_Data(:,1) , Fragments_Peaklist_Data(:,2), 'Marker', 'none','color','[0 0 0]');% experiment plot
axis([0 max(Fragments_Peaklist_Data(:,1)) 0 max(Fragments_Peaklist_Data(:,2))+0.1]); % For axes scalling
xlabel('m/z');
set(gca, 'XTickLabelRotation',90);
ylabel('Normalized Relative Abundance');
set(gca,'TickDir','out');
set(gcf,'menu', 'none');
set(gcf,'toolbar', 'figure');
datacursormode on;
y = repelem(max(Fragments_Peaklist_Data(:,2)),numel(theoretical_mz)); % Acquiring maximum intensity 'y axis' for plotting other graphs
stem(theoretical_mz(:,1) , y, 'Marker', '*', 'MarkerSize', 7, 'color','[0 0.5 0]'); % theoretical plot
stem(experimental_mz (:,1) , y, 'color','[0.5 0 0]');
text(experimental_mz(:,1)+1, y+0.03, num2str(mass_difference(:,1))); % mass difference
text(experimental_mz(:,1)-5, y-0.23, num2str(experimental_mz(:,1)), 'Rotation', 90, 'color','[0.5 0 0]');
text(theoretical_mz(:,1)+1, y+0.05, num2str(theoretical_mz(:,1)), 'Rotation', 90, 'color','[0 0.5 0]');

varargout{1} = handles.output;
