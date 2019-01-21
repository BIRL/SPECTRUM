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

function varargout = SPECTRUM_ChemicalModifications(varargin)
% SPECTRUM_CHEMICALMODIFICATIONS MATLAB code for SPECTRUM_ChemicalModifications.fig
%      SPECTRUM_CHEMICALMODIFICATIONS, by itself, creates a new SPECTRUM_CHEMICALMODIFICATIONS or raises the existing
%      singleton*.
%
%      H = SPECTRUM_CHEMICALMODIFICATIONS returns the handle to a new SPECTRUM_CHEMICALMODIFICATIONS or the handle to
%      the existing singleton*.
%
%      SPECTRUM_CHEMICALMODIFICATIONS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPECTRUM_CHEMICALMODIFICATIONS.M with the given input arguments.
%
%      SPECTRUM_CHEMICALMODIFICATIONS('Property','Value',...) creates a new SPECTRUM_CHEMICALMODIFICATIONS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SPECTRUM_ChemicalModifications_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SPECTRUM_ChemicalModifications_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SPECTRUM_ChemicalModifications

% Last Modified by GUIDE v2.5 15-Feb-2017 17:14:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SPECTRUM_ChemicalModifications_OpeningFcn, ...
                   'gui_OutputFcn',  @SPECTRUM_ChemicalModifications_OutputFcn, ...
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


% --- Executes just before SPECTRUM_ChemicalModifications is made visible.
function SPECTRUM_ChemicalModifications_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SPECTRUM_ChemicalModifications (see VARARGIN)

% Choose default command line output for SPECTRUM_ChemicalModifications
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SPECTRUM_ChemicalModifications wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SPECTRUM_ChemicalModifications_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_Done.
function pushbutton_Done_Callback(~, ~, handles) %#ok<*DEFNU>
% hObject    handle to pushbutton_Done (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
C_Object=get(handles.uibuttongroup_Cysteine,'SelectedObject');
M_Object=get(handles.uibuttongroup_Methionine,'SelectedObject');
% T_Object=get(handles.uibuttongroup_Terminal,'SelectedObject');
T_Object = [get(handles.radiobutton_Terminal,'Value');get(handles.NME,'Value');get(handles.NME_ACETYLATION,'Value');get(handles.M_ACETYLATION,'Value')];
Tags = [cellstr('None'); cellstr('NME'); cellstr('NME_ACETYLATION'); cellstr('M_ACETYLATION')];
if strcmp('radiobutton_UNC',get(C_Object,'Tag'))
    setappdata(0,'Othermodification_Cysteine','');
else
   setappdata(0,'Othermodification_Cysteine',get(C_Object,'Tag'));% to get user defined chemical modifications on cysteine residue 
end
if strcmp('radiobutton_UNM',get(M_Object,'Tag'))
    setappdata(0,'Othermodification_Methionine','');
else
     setappdata(0,'Othermodification_Methionine',get(M_Object,'Tag'));% to get user defined chemical modifications on methionine residue
end
if strcmp('',get(T_Object,'Tag'))
    errordlg('Select at least one terminal modification','Search Error');
else
   setappdata(0,'Othermodification_Terminal',T_Object);% to get user defined chemical modifications on cysteine residue 
   close(SPECTRUM_ChemicalModifications);
end



% --- Executes during object creation, after setting all properties.
function text_title_CreateFcn(hObject, ~, ~)
% hObject    handle to text_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
Title=getappdata(0,'Title');
 set(hObject,'String',Title);
