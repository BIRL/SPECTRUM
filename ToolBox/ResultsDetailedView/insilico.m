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

function varargout = insilico(varargin)
% INSILICO MATLAB code for insilico.fig
%      INSILICO, by itself, creates a new INSILICO or raises the existing
%      singleton*.
%
%      H = INSILICO returns the handle to a new INSILICO or the handle to
%      the existing singleton*.
%
%      INSILICO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INSILICO.M with the given input arguments.
%
%      INSILICO('Property','Value',...) creates a new INSILICO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before insilico_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to insilico_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help insilico

% Last Modified by GUIDE v2.5 09-Jan-2019 12:24:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @insilico_OpeningFcn, ...
    'gui_OutputFcn',  @insilico_OutputFcn, ...
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


% --- Executes just before insilico is made visible.
function insilico_OpeningFcn(hObject,   ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to insilico (see VARARGIN)

% Choose default command line output for insilico
set(hObject,'Name','SPECTRUM - Matched Fragments');
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes insilico wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = insilico_OutputFcn(~, ~, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
AssembleInsilicoSpectraforDisplay

set(handles.FragTable,'Data',data);

% Get default command line output from handles structure
varargout{1} = handles.output;