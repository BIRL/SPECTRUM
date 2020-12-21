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
function varargout = Compute_FDR(varargin)
% COMPUTE_FDR MATLAB code for Compute_FDR.fig
%      COMPUTE_FDR, by itself, creates a new COMPUTE_FDR or raises the existing
%      singleton*.
%
%      H = COMPUTE_FDR returns the handle to a new COMPUTE_FDR or the handle to
%      the existing singleton*.
%
%      COMPUTE_FDR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COMPUTE_FDR.M with the given input arguments.
%
%      COMPUTE_FDR('Property','Value',...) creates a new COMPUTE_FDR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Compute_FDR_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Compute_FDR_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Compute_FDR

% Last Modified by GUIDE v2.5 15-Jun-2018 04:39:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Compute_FDR_OpeningFcn, ...
                   'gui_OutputFcn',  @Compute_FDR_OutputFcn, ...
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


% --- Executes just before Compute_FDR is made visible.
function Compute_FDR_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Compute_FDR (see VARARGIN)

% Choose default command line output for Compute_FDR
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Compute_FDR wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Compute_FDR_OutputFcn(hObject, eventdata, handles) 
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
            {'*.csv;','Taregt Result File (*.csv)'},...
            'Select Target Result File');
            Complete_Taregt_File = fullfile(Target_File_Path,Target_File);
            set(handles.edit1,'String', Complete_Taregt_File);
            setappdata(0,'Complete_Taregt_File',Complete_Taregt_File)
            
catch exception %#ok<NASGU>
    errordlg('Peaklist file is missing.');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
        [Decoy_File,Decoy_File_Path] = uigetfile( ...
            {'*.csv;','Taregt Result File (*.csv)'},...
            'Select Decoy Result File');
            Complete_Decoy_File = fullfile(Decoy_File_Path,Decoy_File);
            set(handles.edit2,'String', Complete_Decoy_File);
            setappdata(0,'Complete_Decoy_File',Complete_Decoy_File)
            
catch exception %#ok<NASGU>
    errordlg('Peaklist file is missing.');
end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('Computing FDR, Please wait!');
E_Value_Threshold = 10^-10;
Complete_Decoy_File = getappdata(0,'Complete_Decoy_File');
Complete_Taregt_File = getappdata(0,'Complete_Taregt_File');

unsortedDecoyData = readtable( Complete_Decoy_File );
unsortedTargetData = readtable( Complete_Taregt_File );

DecoyData = sortrows(unsortedDecoyData, 7, 'descend');
TargetData = sortrows(unsortedTargetData, 7, 'descend');

Decoy = [];
for i = 1:numel(DecoyData.FileName)    %%Updated 20201219
Decoy = [Decoy; cellstr(DecoyData.FileName(i)) DecoyData.Score(i)];
end
Decoy = sortrows(Decoy,-2);

eValCount = 0;
Target = [];
for i = 1:numel(TargetData.FileName)
Target = [Target; cellstr(TargetData.FileName(i)) TargetData.Score(i)];
if TargetData.E_Value(i) <= E_Value_Threshold
    eValCount = eValCount + 1;
end
end
Target = sortrows(Target,-2);
Threshold = Target(:,2);

Cutoff = str2num(get(handles.FDR,'String'));

FDR_estimation = FDR(Target, Decoy, Threshold,Cutoff);

TargetDataWithFDR = TargetData(1:numel(FDR_estimation)-1,:);
TargetDataWithFDR.FDR = FDR_estimation(1:numel(FDR_estimation)-1);

protein = TargetDataWithFDR.ProteinHeader;
proteinCount = numel(unique(protein));

% eValFDRCount = 0;
% for i = 1:numel(TargetDataWithFDR.FileName)
% if TargetDataWithFDR.E_Value(i) <= E_Value_Threshold
%     eValFDRCount = eValFDRCount + 1;
% end
% end

Complete_Taregt_File_FDR = strcat(Complete_Taregt_File(1:numel(Complete_Taregt_File)-4),'_FDR.csv');
writetable(TargetDataWithFDR,Complete_Taregt_File_FDR)
expProteinString = ['Total protein count reported by Experiment:' ' ' num2str(numel(TargetData.ProteinHeader))];
evalProteinString = ['Total protein count reported by Experiment with E-value greater than 1E-10:' ' ' num2str(eValCount)];
totalProteinString = ['Total protein reported with' ' ' num2str(Cutoff) '% FDR:' ' ' num2str(numel(protein))];
%evalFDRProteinString = ['Total protein count reported with E-value greater than 1E-10 and' ' ' num2str(Cutoff) '% FDR:' ' ' num2str(eValFDRCount)];
proteinString = ['Unique proteins count reported with' ' ' num2str(Cutoff) '% FDR:' ' ' num2str(proteinCount)];
fid = fopen(Complete_Taregt_File_FDR, 'a');
fprintf(fid, '\n%s\n', expProteinString);
fprintf(fid, '%s\n', evalProteinString);
fprintf(fid, '%s\n', totalProteinString);
%fprintf(fid, '%s\n', evalFDRProteinString);
fprintf(fid, '%s\n', proteinString);
fclose(fid);
msgbox({'FDR Computed !';'Target File Updated.'},'FDR Computed'); 



function FDR_Callback(hObject, eventdata, handles)
% hObject    handle to FDR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FDR as text
%        str2double(get(hObject,'String')) returns contents of FDR as a double


% --- Executes during object creation, after setting all properties.
function FDR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FDR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
