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

function varargout = Amino_Acid_Chart(varargin)
% TABLE_AA MATLAB code for Table_AA.fig
%      TABLE_AA, by itself, creates a new TABLE_AA or raises the existing
%      singleton*.
%
%      H = TABLE_AA returns the handle to a new TABLE_AA or the handle to
%      the existing singleton*.
%
%      TABLE_AA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TABLE_AA.M with the given input arguments.
%
%      TABLE_AA('Property','Value',...) creates a new TABLE_AA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Table_AA_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Table_AA_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Table_AA

% Last Modified by GUIDE v2.5 16-Mar-2016 15:00:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Table_AA_OpeningFcn, ...
    'gui_OutputFcn',  @Table_AA_OutputFcn, ...
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


% --- Executes just before Table_AA is made visible.
function Table_AA_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Table_AA (see VARARGIN)
set(hObject,'Name','SPECTRUM - Amino Acid Chart');
% Choose default command line output for Table_AA
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Table_AA wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Table_AA_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
protein_data= {'Alanin','Ala','A';'Arginine','Arg','R';'Asparagine','Asn','N';...
    'Aspartic acid','Asp','D';'Cysteine','Cys','C';'Glycine','Gly','G';...
    'Glutamic acid','Glu','E';'Glutamine','Gln','Q';'Histidine','His','H';...
    'Isoleucine','Ile','I'; 'Lysine','Lys','K';'Leucine','Leu','L';...
    'Methionine','Met','M';'Phenylalanine','Phe','F';'Proline','Pro','P';...
    'Serine','Ser','S';'Threonine','Thr','T';'Tryptophan','Trp','W';...
    'Tyrosine','Tyr','Y';'Valine','Val','V';'Selenocysteine','Sec','U';'Pyrrolysine','Pyl','O'};

set(handles.AA_tab,'Data',protein_data)

% Get default command line output from handles structure
varargout{1} = handles.output;
