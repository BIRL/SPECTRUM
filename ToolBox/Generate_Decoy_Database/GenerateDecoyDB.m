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
function varargout = GenerateDecoyDB(varargin)
% GENERATEDECOYDB MATLAB code for GenerateDecoyDB.fig
%      GENERATEDECOYDB, by itself, creates a new GENERATEDECOYDB or raises the existing
%      singleton*.
%
%      H = GENERATEDECOYDB returns the handle to a new GENERATEDECOYDB or the handle to
%      the existing singleton*.
%
%      GENERATEDECOYDB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GENERATEDECOYDB.M with the given input arguments.
%
%      GENERATEDECOYDB('Property','Value',...) creates a new GENERATEDECOYDB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GenerateDecoyDB_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GenerateDecoyDB_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GenerateDecoyDB

% Last Modified by GUIDE v2.5 28-Dec-2018 09:00:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GenerateDecoyDB_OpeningFcn, ...
                   'gui_OutputFcn',  @GenerateDecoyDB_OutputFcn, ...
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


% --- Executes just before GenerateDecoyDB is made visible.
function GenerateDecoyDB_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GenerateDecoyDB (see VARARGIN)

% Choose default command line output for GenerateDecoyDB
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GenerateDecoyDB wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GenerateDecoyDB_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
        [Target_File,Target_File_Path] = uigetfile( ...
            {'*.fasta;','Input DB file(*.fasta)'},...
            'Input Protein Database File');
            InputDB = fullfile(Target_File_Path,Target_File);
            set(handles.edit1,'String', InputDB);
            setappdata(0,'InputDB',InputDB)
            
catch exception %#ok<NASGU>
    errordlg('Peaklist file is missing.');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
            OutputDir = uigetdir;
            set(handles.edit2,'String', OutputDir);
            setappdata(0,'OutputDir',OutputDir)
            
catch exception %#ok<NASGU>
    errordlg('Peaklist file is missing.');
end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('Generating Decoy DB, Please wait!');
InputDB = getappdata(0,'InputDB');
OutputDir = getappdata(0,'OutputDir');
Candidate_ProteinsList_Decoy = ParseDatabaseDecoy(InputDB);
S = strcat(OutputDir,filesep,'DecoyDB.fasta');
fid = fopen( S, 'wt' );
for i = 1:numel(Candidate_ProteinsList_Decoy)
  protein = Candidate_ProteinsList_Decoy(i);
  fprintf( fid, '%s\n', protein.Header);
  fprintf( fid, '%s\n', protein.Sequence);
end
fclose(fid);
msgbox('Decoy DB Generated at Selected Folder with filename DecoyDB.fasta!'); %Updated 20200206



