%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           SPECTRUM: A MATLAB Toolbox for Top-down Proteomics     %
%                           Version 1.0.0                          %
%        Copyright (c) Biomedical Informatics Research Laboratory, %
%          Lahore University of Management Sciences Lahore (LUMS), %
%                           Pakistan.                              %
%                (http://biolabs.lums.edu.pk/BIRL)                 %
%                    (safee.ullah@gmail.com)                       %
%                 Last Modified on: 22-January-2019                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function varargout = SPECTRUM(varargin)
% SPECTRUM MATLAB code for SPECTRUM.fig
%      SPECTRUM, by itself, creates a new SPECTRUM or raises the existing
%      singleton*.
%      H = SPECTRUM returns the handle to a new SPECTRUM or the handle to
%      the existing singleton*.
%      SPECTRUM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPECTRUM.M with the given input arguments.
%      SPECTRUM('Property','Value',...) creates a new SPECTRUM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SPECTRUM_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SPECTRUM_OpeningFcn via varargin.
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
% See also: GUIDE, GUIDATA, GUIHANDLES
% Edit the above text to modify the response to help SPECTRUM
% Last Modified by GUIDE v2.5 21-Jan-2019 17:03:52
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @SPECTRUM_OpeningFcn, ...
    'gui_OutputFcn',  @SPECTRUM_OutputFcn, ...
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

% --- Executes just before SPECTRUM is made visible.
function SPECTRUM_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SPECTRUM (see VARARGIN)
% Choose default command line output for SPECTRUM

handles.output = hObject;
% Update handles structure

guidata(hObject, handles);

%Revert to low level graphics to avoid crash in exe mode
opengl('save', 'software');

setDefaultParameters(hObject, eventdata, handles);


% --- Outputs from this function are returned to the command line.
function varargout = SPECTRUM_OutputFcn(~, ~, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes when user attempts to close SPECTRUM.
function SPECTRUM_CloseRequestFcn(hObject, ~, ~)
% hObject    handle to SPECTRUM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: delete(hObject) closes the figure
delete(hObject);

% --- Executes during object creation, after setting all properties.
function SPECTRUM_CreateFcn(hObject, eventdata, handles) %#ok<*DEFNU>


function edit_ProjectTitle_Callback(hObject, ~, ~)
% hObject    handle to edit_ProjectTitle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

setappdata(0,'Project_Title', get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function menu_BatchFileType_CreateFcn(hObject, ~, ~)
% hObject    handle to menu_BatchFileType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_DatabaseDirectory_Callback(~, ~, ~)
% hObject    handle to edit_DatabaseDirectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of edit_DatabaseDirectory as text
%        str2double(get(hObject,'String')) returns contents of edit_DatabaseDirectory as a double


% --- Executes during object creation, after setting all properties.
function edit_DatabaseDirectory_CreateFcn(hObject, ~, ~)
% hObject    handle to edit_DatabaseDirectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton_ExperimentalData.
function pushbutton_ExperimentalData_Callback(~, ~, handles)
% hObject    handle to pushbutton_ExperimentalData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% hObject    handle to pushbutton_Peaklist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Single Search Mode: Browse a single menu_File
try
    if(get(handles.radiobutton_SingleSearch,'Value') == 1)
        [Single_File,Single_File_Path] = uigetfile( ...
            {'*.txt;*.mzXML;*.mzML;*.mgf;*.txt','Data Files (*.txt, *.mzXML, *.mzML, *.mgf)'},...
            'Select a file');
        if(Single_File)
            Single_File_Directory = fullfile(Single_File_Path,Single_File);
            % Fixing 0 comes when user browses but doesnot select the path
            if(Single_File == 0)
                Single_File_Directory = get(handles.edit_ExperimentalData,'String');
                set(handles.edit_ExperimentalData,'String',Single_File_Directory);
            else
                set(handles.edit_ExperimentalData,'String',Single_File_Directory);
                set(handles.edit_ExperimentalData,'ForegroundColor', [0 0 0]);
            end %if(Single_File == 0)
            % TooltipString
            set(handles.edit_ExperimentalData,'TooltipString',  get(handles.edit_ExperimentalData,'String'));
            % Exporitng the Single Mode menu_File along with its path
            Single_Search_File = [Single_File_Path,Single_File];
            setappdata(0,'Single_Peaklist_Data',Single_Search_File);
            %   setappdata(handles.SPECTRUM,'Peaklist_Data',Single_Search_File);
            % Assign experimental protein mass to Protein Mass field upon browsing for peaklist file
            Set_ProteinMass_Field (handles,Single_Search_File);
        end
        % Batch Search Mode: Browse Whole Folder
    else % For BATCH search mode
        Batch_Files_Directory = uigetdir;
        if(Batch_Files_Directory)
            % Take files according to the file format selected in Batch mode
            % Fixing 0 comes when user browse but not select the path
            if(Batch_Files_Directory == 0)
                Batch_Files_Directory = get(handles.edit_ExperimentalData,'String');
                set(handles.edit_ExperimentalData,'String',Batch_Files_Directory);
            else
                set(handles.edit_ExperimentalData,'String',Batch_Files_Directory);
                set(handles.edit_ExperimentalData,'foregroundColor', [0 0 0]);
            end
            set(handles.edit_ExperimentalData,'TooltipString', get(handles.edit_ExperimentalData,'String'));
            % Exporting Folder for Data Browsed in Batch Mode
            Batch_Files = Filtering_Batch_File_Format(handles,Batch_Files_Directory);
            setappdata(0,'Batch_Peaklist_Data',Batch_Files);
        end  % if(handles.Single_Search_Mode == 1)
    end
catch exception %#ok<NASGU>
    errordlg('Peaklist file is missing.');
end

function edit_ExperimentalData_Callback(~, ~, ~)

% --- Executes during object creation, after setting all properties.
function edit_ExperimentalData_CreateFcn(hObject, ~, ~)
% hObject    handle to edit_ExperimentalData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton__Database.
function pushbutton__Database_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton__Database (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Database_Directory = uigetdir;
if(Database_Directory)
    % Fixing 0 comes when user browse but not select the path
    if(Database_Directory == 0)
        Database_Directory = get(handles.edit_DatabaseDirectory,'String');
        set(handles.edit_DatabaseDirectory,'String',Database_Directory);
        set(handles.menu_Database,'Enable','on');
    else
        set(handles.edit_DatabaseDirectory,'String',Database_Directory);
        set(handles.edit_DatabaseDirectory,'ForegroundColor',[0 0 0]);
    end
    %TooltipString
    Database_Tooltip = get(handles.edit_DatabaseDirectory,'String');
    set(handles.edit_DatabaseDirectory,'TooltipString', Database_Tooltip);
    % Displaying fasta files menu database
    Dislpaly_Fasta_menuDatabase(handles, Database_Directory);
    if(getappdata(0,'DB_IS'))
        errordlg('No Database found in selected folder','DataBase!','modal');
        return
    end
    setappdata(0,'Database_Path',Database_Directory);
    menu_Database_Callback(hObject, eventdata, handles);
end

% --- Executes on button press in checkbox_TunedMass.
function checkbox_TunedMass_Callback(~, ~, handles)
if get(handles.checkbox_TunedMass,'Value') == 1
    set(handles.NeutralMass,'Enable','on');
else
    set(handles.NeutralMass,'Enable','off');
end


function edit_ProteinMass_Callback(~, ~, ~)

% --- Executes during object creation, after setting all properties.
function edit_ProteinMass_CreateFcn(hObject, ~, ~)
% hObject    handle to edit_ProteinMass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_TunedMass_Callback(~, ~, ~)

% --- Executes during object creation, after setting all properties.
function edit_TunedMass_CreateFcn(hObject, ~, ~)
% hObject    handle to edit_TunedMass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% function for Assign experimental protein mass to Protein Mass field upon browsing for peaklist file
function Set_ProteinMass_Field (handles,path)
f = filesep;
% extension = path(numel(path)-2:numel(path));
[pathstr,name,extension] = fileparts(path) ;
if(strcmp(extension,'.txt'))
    Imported_Data =  importdata(path);
    Expermintal_Protein_Mass = Imported_Data(1,1);
    set(handles.edit_ProteinMass,'String',Expermintal_Protein_Mass);
    set(handles.edit_ProteinMass,'ForegroundColor', [0 0 0]);
    setappdata(0,'Experimental_Protein_Mass',Expermintal_Protein_Mass);
elseif (strcmpi(extension,'.mgf'))
    progressbar_heading = 1;  % progressbar_heading = 1
    setappdata(0, 'progressbar_heading',progressbar_heading);
    
    addpath(strcat(pwd,f,'Datareader'));
    file = fliplr(strtok(fliplr(path),f));
    Directory=path(1:numel(path)-numel(file));
    MGF_Reader(Directory,file);
    DirectoryContents=dir(fullfile(Directory, '*.txt'));
    previous = '';
    
    progressbar('SPECTRUM is importing data. Please wait...');
    for i= 1:size(DirectoryContents,1)
        SS = strcat(Directory,DirectoryContents(i).name);
        Imported_Data =  importdata(SS);
        progressbar(i/(size(DirectoryContents,1)));
        if(numel(Imported_Data)>numel(previous) && Imported_Data(1,1)> 113) %Checking the file for max number of scans and MS1 should be greater than 113. Although no mass of protein is equal to this but we are considering as GG but still its a peptide    %Updated 20210111
            previous = Imported_Data;
            Expermintal_Protein_Mass = Imported_Data(1,1);
            set(handles.edit_ProteinMass,'String',Expermintal_Protein_Mass);
            set(handles.edit_ProteinMass,'ForegroundColor', [0 0 0]);
            setappdata(0,'Experimental_Protein_Mass',Expermintal_Protein_Mass);
            setappdata(0,'Single_Peaklist_Data',SS);
        end
    end
elseif (strcmpi(extension,'.mzxml'))
    progressbar('Please wait while mzXML file is deconvolving...');
    progressbar(0.1/3);
    progressbar_heading = 2; % progressbar_heading = 2
    setappdata(0, 'progressbar_heading',progressbar_heading);
    
    progressbar(0.4/3);
    deconvmzxml = '';
    try
        deconvmzxml = system(['java -Xmx200M -jar MsDeconvConsole.jar'  ' ' path]); %Dr.Safee     -Xmx200M
    catch Exception
        try
            deconvmzxml = system(['java -Xmx4G -jar MsDeconvConsole.jar'  ' ' path]);
        catch Exception2
            deconvmzxml = system(['java -Xmx2G -jar MsDeconvConsole.jar'  ' ' path]);
            msgbox ('Warning: Insufficient system memory, MsDeconv might not function properly!');
        end
    end
    progressbar(2.3/3); %Progressbar
    
    fullfilename = get(handles.edit_ExperimentalData,'String');
    fullfilename = strrep(fullfilename, '.mzXML', '_msdeconv.mgf');
    %Directory = get(handles.edit_ExperimentalData,'String');
    [filepath,file,ext] = fileparts(fullfilename);
    addpath(strcat(pwd,'\Datareader')) % For adding into the path of MGF_Reader.m
    file = strcat(file,ext);
    progressbar(2.8/3); %Progressbar
    MGF_Reader(filepath, file);
    
    DirectoryContents=dir(fullfile(filepath, '*.txt'));
    previous = '';
    progressbar('SPECTRUM is importing data. Please wait...');
    for i= 1:size(DirectoryContents,1)
        SS = strcat(filepath,f,DirectoryContents(i).name);
        Imported_Data =  importdata(SS);
        progressbar(i/(size(DirectoryContents,1)));
        if(numel(Imported_Data)>numel(previous) && Imported_Data(1,1)> 113) %Checking the file for max number of scans and MS1 should be greater than 113. Although no mass of protein is equal to this but we are considering as GG but still its a peptide    %Updated 20210111
            previous = Imported_Data;
            Expermintal_Protein_Mass = Imported_Data(1,1);
            set(handles.edit_ProteinMass,'String',Expermintal_Protein_Mass);
            set(handles.edit_ProteinMass,'ForegroundColor', [0 0 0]);
            setappdata(0,'Experimental_Protein_Mass',Expermintal_Protein_Mass);
            setappdata(0,'Single_Peaklist_Data',SS);
        end
    end
elseif (strcmpi(extension,'.mzml'))
    progressbar('Please wait while mzML file is deconvolving...');
    progressbar(0.1/3);
    progressbar_heading = 3; % progressbar_heading = 3
    setappdata(0, 'progressbar_heading',progressbar_heading);
    
    addpath(strcat(pwd,f,'Datareader'));
    file = fliplr(strtok(fliplr(path),f));
    Directory = path(1:numel(path)-numel(file));
    
    fullfilename = [Directory file];
    fullfilename_mzXML = strrep(fullfilename, '.mzML', '.mzXML');
    %setenv('OPENMS_DATA_PATH', [pwd '\OpenMS\']);
    setenv('OPENMS_DATA_PATH', [pwd '\OpenMS\share']);
    system([pwd '\OpenMS\FileConverter.exe -in' ' ' strcat(Directory, file) ' ' '-out' ' ' fullfilename_mzXML]);
    progressbar(.75/3);
    deconvmzxml = system(['java -jar MsDeconvConsole.jar'  ' ' fullfilename_mzXML]);
    progressbar(2.89/3);
    
    
    fullfilename = strrep(fullfilename_mzXML, '.mzXML', '_msdeconv.mgf');
    
    [filepath,file,ext] = fileparts(fullfilename);
    addpath(strcat(pwd,'\Datareader')) % For adding into the path of MGF_Reader.m
    file = strcat(file,ext);
    progressbar(2.95/3); %Progressbar
    
    %   file = fliplr(strtok(fliplr(path),f));
    %   Directory=path(1:numel(path)-numel(file));
    MGF_Reader(Directory,file);
    
    DirectoryContents=dir(fullfile(Directory, '*.txt'));
    previous = '';
    progressbar('SPECTRUM is importing data. Please wait...');
    for i= 1:size(DirectoryContents,1)
        SS = strcat(Directory,DirectoryContents(i).name);
        Imported_Data =  importdata(SS);
        progressbar(i/(size(DirectoryContents,1)));
        if(numel(Imported_Data)>numel(previous) && Imported_Data(1,1)> 113) %Checking the file for max number of scans and MS1 should be greater than 113. Although no mass of protein is equal to this but we are considering as GG but still its a peptide    %Updated 20210111
            previous = Imported_Data;
            Expermintal_Protein_Mass = Imported_Data(1,1);
            set(handles.edit_ProteinMass,'String',Expermintal_Protein_Mass);
            set(handles.edit_ProteinMass,'ForegroundColor', [0 0 0]);
            setappdata(0,'Experimental_Protein_Mass',Expermintal_Protein_Mass);
            setappdata(0,'Single_Peaklist_Data',SS);
        end
    end
end

% --- Executes during object creation, after setting all properties.
function menu_Fragmentation_CreateFcn(hObject, ~, ~)
% hObject    handle to menu_Fragmentation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_Parameters_Callback(~, ~, ~)

% --- Executes during object creation, after setting all properties.
function edit_Parameters_CreateFcn(hObject, ~, ~)
% hObject    handle to edit_Parameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function menu_Database_Callback(hObject, ~, handles)
% hObject    handle to menu_Database (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f = filesep;
Menu_Database_List = cellstr(get(handles.menu_Database,'String'));% returns db_selected_menu contents as cell array
Menu_Database_Selected_Value = Menu_Database_List{get(hObject,'Value')}; %returns selected item from db_selected_menu
% Database Path is concatenated with the database selected in menu_Database
Selected_Database = strcat(getappdata(0,'Database_Path'),f,Menu_Database_Selected_Value);
setappdata(0,'Selected_Database',Selected_Database);

% --- Executes on button press in checkbox_ProteinMass.
function checkbox_ProteinMass_Callback(~, ~, ~)

% Hint: get(hObject,'Value') returns toggle state of checkbox_ProteinMass
% --- Executes during object creation, after setting all properties.
function menu_Database_CreateFcn(hObject, ~, ~)
% hObject    handle to menu_Database (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% function for displaying fasta files menu database
function Dislpaly_Fasta_menuDatabase(handles, Folder)
f = filesep;
FASTA_Format = strcat(f,'*.fasta');
Database = strcat(Folder,FASTA_Format);
Database_Files = dir(Database);
if(~isempty(Database_Files))
    setappdata(0,'DB_IS',0)
    if (~isequal({Database_Files.name},{}))
        set(handles.menu_Database,'String',{Database_Files.name});
    else
        set(handles.menu_Database,'Enable','off')
    end
else
    setappdata(0,'DB_IS',1);
end

function edit_MolecularWeight_Callback(hObject, ~, ~)
% hObject    handle to edit_MolecularWeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(isempty(get(hObject,'String')))
    errordlg({'Protein Molecular Weight Tolerance is required! ';'Default Protein Molecular Weight Tolerance is restored'},'Missing Parameter!','modal');
    set(hObject,'String','100');
    set(hObject,'ForegroundColor',[.5 .5 .5]);
else
    if((str2double(get(hObject,'String'))>=0)&& ~isempty(str2double(get(hObject,'String'))))
        setappdata(0,'Molecular_Weight_Tol',str2double(get(hObject,'String')));
        set(hObject,'ForegroundColor',[0 0 0]);
    else
        errordlg({'Invalid Protein Molecular Weight Tolerance!';'Default Protein Molecular Weight Tolerance is restored'},'Invalid Input!','modal');
        set(hObject,'String','100');
        set(hObject,'ForegroundColor',[.5 .5 .5]);
    end%returns contents of Tol_MW_field as a double
end

function edit_Peptide_Callback(hObject, ~, ~)
% hObject    handle to edit_Peptide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(isempty(get(hObject,'String')))
    errordlg({'Peptide Tolerance is required! ';'Default  Tolerance is restored'},'Missing Parameter!','modal');
    set(hObject,'String','0.5');
    set(hObject,'ForegroundColor',[.5 .5 .5]);
else
    if((str2double(get(hObject,'String'))>=0)&& ~isempty(str2double(get(hObject,'String'))&&(str2double(get(hObject,'String'))<=1)))
        setappdata(0,'Peptide_Tol',str2double(get(hObject,'String')));
        set(hObject,'ForegroundColor',[0 0 0]);
    else
        errordlg('Invalid Peptide Tolerance!','Invalid Input!','modal');
        set(hObject,'String','0.5');
        set(hObject,'ForegroundColor',[.5 .5 .5]);
    end%returns contents of Tol_MW_field as a double
end

function edit_PTM_Callback(hObject, ~, ~)
% hObject    handle to edit_PTM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data(see GUIDATA)
if(isempty(get(hObject,'String')))
    errordlg({'PTM Tolerance is required! ';'Default  Tolerance is restored'},'Missing Parameter!','modal');
    set(hObject,'String','0.5');
    set(hObject,'ForegroundColor',[.5 .5 .5]);
else
    if((str2double(get(hObject,'String'))>=0)&& ~isempty(str2double(get(hObject,'String')))&&(str2double(get(hObject,'String'))<=1))
        setappdata(0,'PTM_Tol',str2double(get(hObject,'String')));
        set(hObject,'ForegroundColor',[0 0 0]);
    else
        errordlg('PTM Tolerance!','Invalid Input!','modal');
        set(hObject,'String','0.5');
        set(hObject,'ForegroundColor',[.5 .5 .5]);
    end%returns contents of Tol_MW_field as a double
end

% --- Executes on selection change in menu_PeptideUnits.
function menu_PeptideUnits_Callback(~, ~, ~)

% --- Executes during object creation, after setting all properties.
function menu_PeptideUnits_CreateFcn(hObject, ~, ~)
% hObject    handle to menu_PeptideUnits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit_MolecularWeight_CreateFcn(hObject, ~, ~)
% hObject    handle to edit_MolecularWeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit_PTM_CreateFcn(hObject, ~, ~)
% hObject    handle to edit_PTM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function menu_MolecularWeightUnits_CreateFcn(hObject, ~, ~)
% hObject    handle to menu_MolecularWeightUnits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit_Peptide_CreateFcn(hObject, ~, ~)
% hObject    handle to edit_Peptide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function menu_BatchFileType_Callback(~, ~, handles)
% hObject    handle to menu_BatchFileType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Batch_Directory = get(handles.edit_ExperimentalData,'String');
Batch_Files = Filtering_Batch_File_Format(handles,Batch_Directory);
setappdata(0,'Batch_Peaklist_Data',Batch_Files);

function menu_SingleFileType_Callback(~, ~, handles)
% hObject    handle to menu_BatchFileType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SingleSearch = get(handles.edit_ExperimentalData,'String');
%Current_Peaklist_Path = Filtering_Batch_File_Format(handles,SingleSearch);
Set_ProteinMass_Field (handles,Current_Peaklist_Path)
setappdata(0,'Single_Peaklist_Data',Current_Peaklist_Path);

% --- Executes on button press in pushbutton_Results.
function pushbutton_Results_Callback(~, ~, handles)
% hObject    handle to pushbutton_Results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Results_Directory = uigetdir;
% Fixing 0 comes when user browse but not select the path
if(Results_Directory == 0)
    Results_Directory = get(handles.edit_Results,'String');
    set(handles.edit_Results,'String',Results_Directory);
    %set(handles.edit_Results,'ForegroundColor',[0 0 0]);
else
    set(handles.edit_Results,'String',Results_Directory);
    set(handles.edit_Results,'ForegroundColor',[0 0 0]);
end
%Tooltip String
Results_Tooltip = get(handles.edit_Results,'String');
set(handles.edit_Results,'TooltipString', Results_Tooltip);

function menu_ProteinsOutput_Callback(hObject, ~, ~)
% hObject    handle to menu_ProteinsOutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Proteins_Output_List = cellstr(get(hObject,'String'));
% no_of_output = Proteins_Output_List{get(hObject,'Value')}; %returns selected item from Proteins Output
% setappdata(0,'Proteins_Output', no_of_output);

% --- Executes during object creation, after setting all properties.
function menu_ProteinsOutput_CreateFcn(hObject, ~, ~)
% hObject    handle to menu_ProteinsOutput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in menu_OutputFormat.
function menu_OutputFormat_Callback(~, ~, ~)

% --- Executes during object creation, after setting all properties.
function menu_OutputFormat_CreateFcn(hObject, ~, ~)
% hObject    handle to menu_OutputFormat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_Results_Callback(~, ~, ~)

% --- Executes during object creation, after setting all properties.
function edit_Results_CreateFcn(hObject, ~, ~)
% hObject    handle to edit_Results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton_Parameters.
function pushbutton_Parameters_Callback(~, ~, handles)
% hObject    handle to pushbutton_Parameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Parameters_Directory = uigetdir;
% Fixing 0 comes when user browse but not select the path
if(Parameters_Directory == 0)
    Parameters_Directory = get(handles.edit_Parameters,'String');
    set(handles.edit_Parameters,'String',Parameters_Directory);
    %set(handles.edit_Parameters,'ForegroundColor',[0 0 0]);
else
    set(handles.edit_Parameters,'String',Parameters_Directory);
    set(handles.edit_Parameters,'ForegroundColor',[0 0 0]);
end
% Tooltip String
Parameters_Tooltip = get(handles.edit_Parameters,'String');
set(handles.edit_Parameters,'TooltipString', Parameters_Tooltip);

function radiobutton_SingleSearch_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_SingleSearch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.menu_Database,'Enable','on')
set (handles.menu_BatchFileType,'Visible','off');
set (handles.text_BatchFileType,'Visible','off');
set (handles.edit_ProteinMass,'Enable','off');
set (handles.text_ProteinMass,'Enable','on');
set (handles.text_ProteinMassUnit,'Enable','on'); % Dalton text
set(handles.checkbox_TunedMass,'Enable','on');
set(handles.text_TunedMass,'Enable','on');
set(handles.text_TunedMassUnit,'Enable','on'); % Dalton text
set(handles.text_MSdataFile,'String','MS Data File');
set (handles.radiobutton_SingleSearch,'Value',1);
set (handles.radiobutton_BatchMode,'Value',0);
set(handles.text_SingleFileType,'Visible','off'); 
set(handles.menu_SingleFileType,'Visible','off'); 
pushbutton_Reset_Callback(hObject, eventdata, handles);
HandleIon{1,1}=0;
HandleIon{2,1}=0;
HandleIon{3,1}=0;
HandleIon{4,1}=0;
HandleIon{5,1}=0;
HandleIon{6,1}=0;
HandleIon{7,1}=0;
HandleIon{8,1}=0;
HandleIon{9,1}=0; %It tells us about Mass mode
setappdata(0,'HandleIon',HandleIon);

% --- Executes on button press in radiobutton_BatchMode.
function radiobutton_BatchMode_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_BatchMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton_BatchMode
% % % % % % % % set(handles.checkbox_TunedMass,'Enable','off');
set(handles.menu_Database,'Enable','on')
set(handles.edit_ProteinMass,'Enable','off');
% % % % % % set(handles.text_ProteinMass,'Enable','off');
% % % % % % set(handles.text_ProteinMassUnit,'Enable','off'); % Dalton text
% % % % % % set(handles.checkbox_TunedMass,'Enable','off');
% % % % % % set(handles.text_TunedMass,'Enable','off');
% % % % % % set(handles.text_TunedMassUnit,'Enable','off'); % Dalton text
set(handles.text_MSdataFile,'String','MS Data Directory');
set (handles.radiobutton_BatchMode,'Value',1);
set (handles.radiobutton_SingleSearch,'Value',0);
pushbutton_Reset_Callback(hObject, eventdata, handles);
set(handles.radiobutton_SingleSearch,'Value',0);
set(handles.menu_BatchFileType,'Visible','on');
set(handles.menu_SingleFileType,'Visible','off');
set(handles.text_BatchFileType,'Visible','on');
set(hObject,'Value',1);
HandleIon{1,1}=0;
HandleIon{2,1}=0;
HandleIon{3,1}=0;
HandleIon{4,1}=0;
HandleIon{5,1}=0;
HandleIon{6,1}=0;
HandleIon{7,1}=0;
HandleIon{8,1}=0;
HandleIon{9,1}=0; %It tells us about Mass mode
setappdata(0,'HandleIon',HandleIon);

% --- Executes on button press in pushbutton_HandleZIon.
function pushbutton_HandleZIon_Callback(~, ~, ~)
% hObject    handle to pushbutton_HandleZIon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f = filesep;
setappdata(0,'Title','SPECTRUM');
addpath(strcat(pwd,f,'Fragments'));
data = anb;
setappdata(0,'HandleIon',data);
rmpath(strcat(pwd,f,'Fragments'));

function menu_Fragmentation_Callback(hObject, ~, ~)
% hObject    handle to menu_Fragmentation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns menu_Fragmentation contents as cell array
%        contents{get(hObject,'Value')} returns selected item from menu_Fragmentation

Fragmentation_Types_List = get(hObject,'String'); % Gives list of fragmentation techniques
Fragmentation_Type_Selected_Index = get(hObject,'Value'); % Return index of particular fragmentation technique selected by user
Fragmentation_Type_Selected = Fragmentation_Types_List{Fragmentation_Type_Selected_Index}; % Particular fragmentation technique selected by user
%     if (isequal(Fragmentation_Type_Selected,'ECD')) % Hanle Z Ion will be enable only for 'ECD' fragmentation technique
%         set (handles.checkbox_HandleZIon,'Enable','on')
%     else
%         set (handles.checkbox_HandleZIon,'Enable','off')
%     end
% Exporitng fragmentation technique selected by the user
setappdata(0,'Fragmentation_type',Fragmentation_Type_Selected);
setappdata(0,'Fragmentation',Fragmentation_Type_Selected);

% --- Executes on button press in pushbutton_DeleteFixedModifications.
function pushbutton11_Callback(~, ~, ~)

% --- Executes on button press in pushbutton_DeleteVariableModifications.
function pushbutton12_Callback(~, ~, ~)
% hObject    handle to pushbutton_DeleteVariableModifications (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pushbutton_AddFixedModifications.
function pushbutton15_Callback(~, ~, ~)
% hObject    handle to pushbutton_AddFixedModifications (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on selection change in listbox_VariableModifications.
function listbox_VariableModifications_Callback(~, ~, ~)
% hObject    handle to listbox_VariableModifications (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns listbox_VariableModifications contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_VariableModifications

% --- Executes during object creation, after setting all properties.
function listbox_VariableModifications_CreateFcn(hObject, ~, ~)
% hObject    handle to listbox_VariableModifications (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_FixedModifications.
function listbox_FixedModifications_Callback(~, ~, ~)

% --- Executes during object creation, after setting all properties.
function listbox_FixedModifications_CreateFcn(hObject, ~, ~)
% hObject    handle to listbox_FixedModifications (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in listbox_Modifications.
function listbox_Modifications_Callback(~, ~, ~)

% --- Executes during object creation, after setting all properties.
function listbox_Modifications_CreateFcn(hObject, ~, ~)
% hObject    handle to listbox_Modifications (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pushbutton_ChemicalModifications_Callback(~, ~, ~)
% hObject    handle to pushbutton_OtherModification (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'Title','SPECTRUM');
f = filesep;
addpath(strcat(pwd,f,'ChemicalModifications'));
SPECTRUM_ChemicalModifications;

function pushbutton_AddFixedModifications_Callback(~, ~, handles)
% hObject    handle to pushbutton_AddFixedModifications (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Modifications_List = get(handles.listbox_Modifications,'String'); % Get Total Modifications list
Modifications_List_Selected_Index = get(handles.listbox_Modifications,'Value'); % Get index of seleted modification from the total modifications list
Modifications_List_Size = size(Modifications_List,1); % return the size of total Modifications List
Modifications_Selected = cell(Modifications_List_Size,1);
if ~isempty(Modifications_List_Selected_Index) && ~isempty(Modifications_List)
    % Modification selected from the total modifications list
    for i=1:size(Modifications_List_Selected_Index,2)
        
        Modifications_List_Selected_Value = Modifications_List_Selected_Index(i);
        Modifications_Selected{i} = Modifications_List{Modifications_List_Selected_Value};
    end
    count = 0;
    for i=1:Modifications_List_Size
        if (ischar(Modifications_Selected{i}))
            count = count+1;
        end
    end
    % All modifications that are selected by the user are included in the list
    Modifications_Selected_List = cell(count,1);
    for i=1:count
        Modifications_Selected_List{i} = Modifications_Selected{i};
    end
    % --- Selected modification added from total Mofication listbox to Fixed Modification listbox
    % Assigning the selected modifications list to fixed modifications listbox
    Fixed_Modifications = get(handles.listbox_FixedModifications,'String');
    % Vertical concatenation of selected modifications list to fixed modifications listbox
    Modifications_to_Fixed_Modifications = strvcat(char(Modifications_Selected_List),char(Fixed_Modifications)); %#ok<DSTRVCT>
    Modifications_to_Fixed_Modifications = unique(cellstr(Modifications_to_Fixed_Modifications));
    set(handles.listbox_FixedModifications,'String',Modifications_to_Fixed_Modifications) % cell array of strings from char array
    set(handles.listbox_Modifications,'Value',[]); % clear selection - highlighted value
    % Exporting fixed modifications
    setappdata(0,'Fixed_Modifications',Modifications_to_Fixed_Modifications);
    % Delete the selected values from the total modidifications list ------
    % % --- Selected modification subtracted from total Mofication listbox
    Modifications_List_Selected_Index_Del = Modifications_List_Selected_Index(1)-1;
    if (Modifications_List_Selected_Index_Del <=0)
        Modifications_List_Selected_Index_Del = 1;
    end
    if ~isempty(Modifications_List)
        Modifications_List(Modifications_List_Selected_Index) = [];
        set(handles.listbox_Modifications,'String',Modifications_List,'Value',Modifications_List_Selected_Index_Del); % clear selection - highlighted value
    end
end

% --- Executes on button press in pushbutton_DeleteFixedModifications.
function pushbutton_DeleteFixedModifications_Callback(~, ~, handles)
% hObject    handle to pushbutton_DeleteFixedModifications (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get modifications list from fixed modifcations listbox that were added from total modifications listbox
Fixed_Modifications_List = get(handles.listbox_FixedModifications,'String');
Fixed_Modifications_List_Selected_Index = get(handles.listbox_FixedModifications,'Value'); % Get Index of the selected modification from fixed modifications listbox
if ~isempty(Fixed_Modifications_List) && ~isempty(Fixed_Modifications_List_Selected_Index)
    % Return the indeces of modifcations seleted in fixed modifications listbox (in order to move back to toal modifications listbox)
    Fixed_Modifications_Selected = Fixed_Modifications_List(Fixed_Modifications_List_Selected_Index);
    Modifications_List = get(handles.listbox_Modifications,'String'); % Get list of modifications from total modifications listbox
    Fixed_Modifications_to_Modifications = strvcat(char(Fixed_Modifications_Selected),char(Modifications_List)); %#ok<DSTRVCT> % Vertically concatenate the list
    %  final = cellstr(final);% cell array of strings from char array
    Fixed_Modifications_to_Modifications = unique(cellstr(Fixed_Modifications_to_Modifications)); %remove duplicates
    % Modifications has been copied from fixed modications listbox to total modifications listbox
    set(handles.listbox_Modifications,'String',Fixed_Modifications_to_Modifications)
    set(handles.listbox_Modifications,'Value',[]); % clear selection
    %------ delete variable mods  ----------------------------
    % Delete the modification from fixed modifications listbox (that now have moved to total modifications listbox)
    Fixed_Modifications_List_Selected_Index_Del = Fixed_Modifications_List_Selected_Index(1)-1;
    if ( Fixed_Modifications_List_Selected_Index_Del <=0)
        Fixed_Modifications_List_Selected_Index_Del = 1;
    end
    if ~isempty(Fixed_Modifications_List)
        Fixed_Modifications_List(Fixed_Modifications_List_Selected_Index) = [];
        % clear selection - highlighted value
        set(handles.listbox_FixedModifications,'String',Fixed_Modifications_List,'Value',Fixed_Modifications_List_Selected_Index_Del); % clear selection - highlighted value
    end
end


function pushbutton_AddVariableModifications_Callback(~, ~, handles)
% hObject    handle to pushbutton_AddVariableModifications (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Modifications_List = get(handles.listbox_Modifications,'String'); % Get Total Modifications list
Modifications_List_Selected_Index = get(handles.listbox_Modifications,'Value'); % Get index of seleted modification from the total modifications list
Modifications_List_Size = size(Modifications_List,1); % return the size of total Modifications List
Modifications_Selected = cell(Modifications_List_Size,1);
if ~isempty(Modifications_List_Selected_Index) && ~isempty(Modifications_List)
    % Modification selected from the total modifications list
    for i=1:size(Modifications_List_Selected_Index,2)
        Modifications_List_Selected_Value = Modifications_List_Selected_Index(i);
        Modifications_Selected{i} = Modifications_List{Modifications_List_Selected_Value};
    end
    %-------- For removing empty spaces from the selections list as initially it was made the size of total modidifcations to cater all possible selections -----
    count = 0;
    for i=1:Modifications_List_Size
        if (ischar(Modifications_Selected{i}))
            count = count+1;
        end
    end
    % --- transfer to toolbarbutton_resetallfields array "list" -----
    % All modifications that are selected by the user are included in the list
    Modifications_Selected_List = cell(count,1);
    for i=1:count
        Modifications_Selected_List{i} = Modifications_Selected{i};
    end
    % --- Selected modification added from total Mofication listbox to Variable Modification listbox
    % Assigning the selected modifications list to variable modifications listbox
    Variable_Modifications = get(handles.listbox_VariableModifications,'String');
    % Vertical concatenation of selected modifications list to fixed modifications listbox
    Modifications_to_Variable_Modifications = strvcat(char(Modifications_Selected_List),char(Variable_Modifications)); %#ok<DSTRVCT>
    Modifications_to_Variable_Modifications = unique(cellstr(Modifications_to_Variable_Modifications));
    set(handles.listbox_VariableModifications,'String',Modifications_to_Variable_Modifications) % cell array of strings from char array
    set(handles.listbox_Modifications,'Value',[]); % clear selection - highlighted value
    % Exporting Variable modifications
    setappdata(0,'Variable_Modifications',Modifications_to_Variable_Modifications);
    % Delete the selected values from the total modidifications list ------
    % --- Selected modification subtracted from total Mofication listbox
    Modifications_List_Selected_Index_Del = Modifications_List_Selected_Index(1)-1;
    if (Modifications_List_Selected_Index_Del <=0)
        Modifications_List_Selected_Index_Del = 1;
    end
    if ~isempty(Modifications_List)
        Modifications_List(Modifications_List_Selected_Index) = [];
        set(handles.listbox_Modifications,'String',Modifications_List,'Value',Modifications_List_Selected_Index_Del); % clear selection - highlighted value
    end
end

% --- Executes on button press in pushbutton_DeleteVariableModifications.
function pushbutton_AddVariableModifications_Callback_Callback(~, ~, handles)
% hObject    handle to pushbutton_DeleteVariableModifications (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get modifications list from variable modifcations listbox that were added from total modifications listbox
Variable_Modifications_List = get(handles.listbox_VariableModifications,'String');
Variable_Modifications_List_Selected_Index = get(handles.listbox_VariableModifications,'Value'); % Get Index of the selected modification from variable modifications listbox
if ~isempty(Variable_Modifications_List) && ~isempty(Variable_Modifications_List_Selected_Index)
    % Return the indeces of modifcations seleted in variable modifications listbox (in order to move back to toal modifications listbox)
    Variable_Modifications_Selected = Variable_Modifications_List(Variable_Modifications_List_Selected_Index);
    Modifications_List = get(handles.listbox_Modifications,'String'); % Get list of modifications from total modifications listbox
    Variable_Modifications_to_Modifications = strvcat(char(Variable_Modifications_Selected),char(Modifications_List)); %#ok<DSTRVCT> % Vertically concatenate the list
    %  final = cellstr(final);% cell array of strings from char array
    Variable_Modifications_to_Modifications = unique(cellstr(Variable_Modifications_to_Modifications)); %remove duplicates
    % Modifications has been copied from fixed modications listbox to total modifications listbox
    set(handles.listbox_Modifications,'String',Variable_Modifications_to_Modifications)
    set(handles.listbox_Modifications,'Value',[]); % clear selection
    %------ delete variable mods  ----------------------------
    % Delete the modification from fixed modifications listbox (that now have moved to total modifications listbox)
    Variable_Modifications_List_Selected_Index_Del = Variable_Modifications_List_Selected_Index(1)-1;
    if ( Variable_Modifications_List_Selected_Index_Del <=0)
        Variable_Modifications_List_Selected_Index_Del = 1;
    end
    if ~isempty(Variable_Modifications_List)
        Variable_Modifications_List(Variable_Modifications_List_Selected_Index) = [];
        % clear selection - highlighted value
        set(handles.listbox_VariableModifications,'String',Variable_Modifications_List,'Value',Variable_Modifications_List_Selected_Index_Del); % clear selection - highlighted value
    end
end

% --- Executes on button press in pushbutton_DeleteVariableModifications.
function pushbutton_DeleteVariableModifications_Callback(~, ~, handles)
% hObject    handle to pushbutton_DeleteVariableModifications (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get modifications list from variable modifcations listbox that were added from total modifications listbox
Variable_Modifications_List = get(handles.listbox_VariableModifications,'String');
Variable_Modifications_List_Selected_Index = get(handles.listbox_VariableModifications,'Value'); % Get Index of the selected modification from variable modifications listbox
if ~isempty(Variable_Modifications_List) && ~isempty(Variable_Modifications_List_Selected_Index)
    % Return the indeces of modifcations seleted in variable modifications listbox (in order to move back to toal modifications listbox)
    Variable_Modifications_Selected = Variable_Modifications_List(Variable_Modifications_List_Selected_Index);
    Modifications_List = get(handles.listbox_Modifications,'String'); % Get list of modifications from total modifications listbox
    Variable_Modifications_to_Modifications = strvcat(char(Variable_Modifications_Selected),char(Modifications_List)); %#ok<DSTRVCT> % Vertically concatenate the list
    %  final = cellstr(final);% cell array of strings from char array
    Variable_Modifications_to_Modifications = unique(cellstr(Variable_Modifications_to_Modifications)); %remove duplicates
    % Modifications has been copied from fixed modications listbox to total modifications listbox
    set(handles.listbox_Modifications,'String',Variable_Modifications_to_Modifications)
    set(handles.listbox_Modifications,'Value',[]); % clear selection
    %------ delete variable mods  ----------------------------
    % Delete the modification from fixed modifications listbox (that now have moved to total modifications listbox)
    Variable_Modifications_List_Selected_Index_Del = Variable_Modifications_List_Selected_Index(1)-1;
    if ( Variable_Modifications_List_Selected_Index_Del <=0)
        Variable_Modifications_List_Selected_Index_Del = 1;
    end
    if ~isempty(Variable_Modifications_List)
        Variable_Modifications_List(Variable_Modifications_List_Selected_Index) = [];
        % clear selection - highlighted value
        set(handles.listbox_VariableModifications,'String',Variable_Modifications_List,'Value',Variable_Modifications_List_Selected_Index_Del); % clear selection - highlighted value
    end
end

function pushbutton_Reset_Callback(~, ~, handles)
% hObject    handle to pushbutton_Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%reset all setappdata
% clear all text_ProteinMassUnit fields
T_Object = [1;0;0;0];
appdata = get(0,'ApplicationData');
fns = fieldnames(appdata);
for num_ele= 1:numel(fns)
    rmappdata(0,fns{num_ele});
end
set(handles.edit_TunedMass,'String','0.0');
set(handles.edit_TunedMass,'ForegroundColor',[0.6 0.6 0.6]);
% set(handles.edit_ProjectTitle,'String','Enter the Project Title');
%set(handles.edit_ProjectTitle,'ForegroundColor',[0.6 0.6 0.6]);
set(handles.edit_PTM,'String','0.5');
set(handles.edit_PTM,'ForegroundColor',[0.6 0.6 0.6]);
set(handles.edit_MolecularWeight,'String','250');
set(handles.edit_MolecularWeight,'ForegroundColor',[0.6 0.6 0.6]);
set(handles.edit_Peptide,'String','25');
set(handles.edit_Peptide,'ForegroundColor',[0.6 0.6 0.6]);
set(handles.edit_ProteinMass,'String','0.0');
set(handles.edit_ProteinMass,'ForegroundColor',[0.6 0.6 0.6]);
set(handles.edit_Results,'String','Directory for Saving Results');
set(handles.edit_Results,'ForegroundColor',[0.6 0.6 0.6]);
set(handles.edit_Parameters,'String','Directory for Saving Parameters');
set(handles.edit_Parameters,'ForegroundColor',[0.6 0.6 0.6]);
set(handles.menu_Database,'Enable','on');
set(handles.edit_DatabaseDirectory,'String','Browse to the Database Directory');
set(handles.edit_DatabaseDirectory,'ForegroundColor',[0.6 0.6 0.6]);
set(handles.edit_ExperimentalData,'String','Browse for Experimental Data');
set(handles.edit_ExperimentalData,'ForegroundColor',[0.6 0.6 0.6]);
% clear selected mods
set(handles.listbox_FixedModifications,'String',{},'Value',[]);
set(handles.listbox_VariableModifications,'String',{},'Value',[]);
mod={'Phosphorylation_Y';'Phosphorylation_T';'Phosphorylation_S';'Hydroxylation_P';...
    'Amidation_F';'Acetylation_A';'Acetylation_K';'Acetylation_S';'Acetylation_M';'Methylation_R';...
    'Methylation_K';'N_linked_glycosylation_N';'O_linked_glycosylation_S';'O_linked_glycosylation_T'};
set(handles.listbox_Modifications,'String',mod); % clear selection
% clear experiment selection
if (get(handles.radiobutton_BatchMode,'Value') == get(handles.radiobutton_BatchMode,'Max'))
    set (handles.radiobutton_SingleSearch,'Value',1);
    set (handles.radiobutton_BatchMode,'Value',0);
    set (handles.menu_BatchFileType,'Visible','off');
    set (handles.text_BatchFileType,'Visible','off');
    %     set (handles.edit_ProteinMass,'Enable','off');
    %     set (handles.text_ProteinMass,'Enable','off');
    %     set (handles.text_ProteinMassUnit,'Enable','off'); % Dalton text
end
set (handles.menu_Database,'String','Select Database');
set (handles.menu_Database,'Value',1);
set (handles.menu_Fragmentation,'Value',1);
set (handles.menu_MolecularWeightUnits,'Value',1);
set (handles.menu_PeptideUnits,'Value',3);
setappdata(0,'Othermodification_Methionine','');
setappdata(0,'Othermodification_Cysteine','');
setappdata(0,'Othermodification_Terminal',T_Object);
set(handles.Trunc,'Value',0);
setappdata(0,'Truncation',0);
% clear checkboxes
set(handles.checkbox_ProteinMass,'Value',0);
set(handles.checkbox_TunedMass,'Value',0);
set(handles.checkbox_BlindPTM,'Value',0);
set(handles.NeutralMass,'Enable','off');
HandleIon{1,1}=0;
HandleIon{2,1}=0;
HandleIon{3,1}=0;
HandleIon{4,1}=0;
HandleIon{5,1}=0;
HandleIon{6,1}=0;
HandleIon{7,1}=0;
HandleIon{8,1}=0;
HandleIon{9,1}=0; %It tells us about Mass mode
setappdata(0,'HandleIon',HandleIon);

function pushbutton_Cancel_Callback(~, ~, handles)
% hObject    handle to pushbutton_Cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
appdata = get(0,'ApplicationData');
fns = fieldnames(appdata);
for num_ele= 1:numel(fns)
    rmappdata(0,fns{num_ele});
end
close(handles.SPECTRUM);

%% Executes on button press in pushbutton_Next.
function pushbutton_Next_Callback(~, ~, handles)
% hObject    handle to pushbutton_Next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Save parameters, settings and screenshot ot Parameters folder upon clicking pushbutton_Next
% toolbarbutton_SaveCurrentParametersSettings_ClickedCallback(hObject, eventdata, handles)
% submenu_Screenshot_Callback(hObject, eventdata, handles)
% Globally accessed Variables

%% will be used for adding and removing paths
f = filesep;
initial_path=pwd;

%% To remove conflicts with MATLAB Signal Toolbox
w = warning ('off','all');
rmpath(strcat(matlabroot,f,'toolbox',f,'signal',f,'signal')); % remove path and suppress warning
warning(w);

%% Debug Mode Initialization
setappdata(0,'Title','SPECTRUM');
Debug=(get(handles.menu_debug,'Checked'));
setappdata(0,'Debug',Debug); % debugger mod is on

%% Check if the current directory is the app-root directory
tool=strsplit(initial_path,f);
if(strcmp('ToolBox',tool(length(tool))))
    if((~isempty(get(handles.edit_ProjectTitle,'String')) && (~strcmp(get(handles.edit_ProjectTitle,'String'),'Enter the Project Title'))))
        
        Database_Path = getappdata(0,'Database_Path'); % Database path of single and batch search modes
        Selected_Database = getappdata(0,'Selected_Database'); % Concatenated: Database_Path + Database selected from menu_Database
        if(isempty(Database_Path) )
            msgbox('Select database');
            return
        end
        
        Single_Peaklist_Data = getappdata(0,'Single_Peaklist_Data'); % Peaklist data for SINGLE search mode
        Batch_Peaklist_Data = getappdata(0,'Batch_Peaklist_Data'); % Peaklist data for BATCH search mode
        if(isempty(Single_Peaklist_Data)&& get(handles.radiobutton_SingleSearch,'Value'))
            msgbox('Select Peaklist File');
            return
        elseif(isempty(Batch_Peaklist_Data)&& ~get(handles.radiobutton_SingleSearch,'Value'))
            msgbox('Select Peaklist Files');
            return
        end
        
        MW_Tolerance = getappdata(0,'Molecular_Weight_Tol'); % Molecular Weight tolerance
        MWTolIndex = get(handles.menu_MolecularWeightUnits,'Value');
        if(MWTolIndex == 1)
            MWunit = 'Da';
        elseif (MWTolIndex == 2)
            MWunit = 'mmu';
        elseif (MWTolIndex == 3)
            MWunit = 'ppm';
        else
            MWunit = '%';
        end
        
        Peptide_Tolerance = getappdata(0,'Peptide_Tol'); % Peptide tolerance
        PepTolIndex = get(handles.menu_PeptideUnits,'Value');
        if(PepTolIndex == 1)
            PepUnit = 'Da';
        elseif (PepTolIndex == 2)
            PepUnit = 'mmu';
        elseif (PepTolIndex == 3)
            PepUnit = 'ppm';
        else
            PepUnit = '%';
        end
        
        PTM_Tolerance = getappdata(0,'PTM_Tol'); % PTM tolerance
        setappdata(0,'BlindPTM', get(handles.checkbox_BlindPTM,'Value'));
        BlindPTMvar = get(handles.checkbox_BlindPTM,'Value');
        Fixed_Modifications = getappdata(0','Fixed_Modifications'); % Fixed Modifications
        Variable_Modifications = getappdata(0,'Variable_Modifications'); % Variable Modifications
        
        Fragmentation_Type = getappdata(0,'Fragmentation_type'); % Fragmentation type
        HandleIon = getappdata(0,'HandleIon'); % Fragment specific Special Ion Information
        if (isempty(HandleIon))
            HandleIon{1,1}=0;
            HandleIon{2,1}=0;
            HandleIon{3,1}=0;
            HandleIon{4,1}=0;
            HandleIon{5,1}=0;
            HandleIon{6,1}=0;
            HandleIon{7,1}=0;
            HandleIon{8,1}=0;
            HandleIon{9,1}=0; % Mass Mode Information
            setappdata(0,'HandleIon',HandleIon);
        end
        
        Experimental_Protein_Mass = getappdata(0,'Experimental_Protein_Mass'); % Experimental Proein Mass (Protein mass)
        FilterDB=get(handles.checkbox_ProteinMass,'Value');% get option to filter database
        setappdata(0,'FilterDB',FilterDB);
        
        %SAVING RESULTS FOLDER PATH
        if(~strcmp('Directory for Saving Results',get(handles.edit_Results,'String')))
            Result_Folder = get(handles.edit_Results,'String'); % retuns path of the Results folder
            setappdata(0,'Result_Folder',Result_Folder);
        else
            errordlg('Please specify Folder to save Results','Path missing!','modal');
            return;
        end
        if(~strcmp('Directory for Saving Results',get(handles.edit_Parameters,'String')))
            Parameters = get(handles.edit_Results,'String'); %#ok<NASGU> % retuns path of the Results folder
        else
            errordlg('Please specify Folder to save Parameters','Path missing!','modal');
            return;
        end
        
        setappdata(0,'tuner', get(handles.checkbox_TunedMass, 'Value'));
        setappdata(0,'neutral',get(handles.NeutralMass,'string'));
        setappdata(0, 'Batch', get(handles.radiobutton_SingleSearch,'Value'));
        
        %20190111 - Abdul Rehman: Adding parameter saving code
        Project_Title=getappdata(0,'Project_Title');
        
        fullname = fullfile(strcat(Project_Title,'.parameters')); %#ok<NASGU>
        CurrentWorkingDirectory = fileparts(mfilename('fullpath'));
        path = fullfile(strcat(CurrentWorkingDirectory,f,'Parameters',f));
        
        %Save_File = strcat(getappdata(0,'Parameters_Folder'),f,Project_Title,'_SearchParameters','.txt');
        Save_File = strcat(path, fullname);
        SearchParamFile = fopen(Save_File,'w');
        
        if(get(handles.radiobutton_SingleSearch,'Value') == 1)
            fprintf(SearchParamFile,'%s%s\n','Experiment:','Single');
        else
            fprintf(SearchParamFile,'%s%s\n','Experiment:','Batch');
        end
        
        Menu_Database_List = get(handles.menu_Database,'String');
        if iscell(Menu_Database_List)
            Menu_Database_Selected = get(handles.menu_Database,'Value');
            fprintf(SearchParamFile,'%s%s\n','Database Selected: ',Menu_Database_List{Menu_Database_Selected});
        else
            fprintf(SearchParamFile,'%s%s\n','Database Selected: ', Menu_Database_List);
        end
        
        fprintf(SearchParamFile,'%s%s\n','Protein Mass (Da): ',get(handles.edit_ProteinMass,'String'));
        
        if (get(handles.checkbox_ProteinMass,'Value') == get(handles.checkbox_ProteinMass,'Max'))
            checked = 'Yes';
        else
            checked = 'No';
        end
        fprintf(SearchParamFile,'%s%s\n','Filter DB for intact Protein Mass: ',checked);
        
        
        if (get(handles.checkbox_TunedMass,'Value') == get(handles.checkbox_TunedMass,'Max'))
            checked = 'Yes';
        else
            checked = 'No';
        end
        fprintf(SearchParamFile,'%s%s\n','Tune Whole Protein Molecular Weight: ',checked);
        
        Fragmentation_Types_List = get(handles.menu_Fragmentation,'String');
        Fragmentation_Types_Selected = get(handles.menu_Fragmentation,'Value');
        fprintf(SearchParamFile,'%s%s\n','Fragmentation Type Selected: ',Fragmentation_Types_List{Fragmentation_Types_Selected});
        
        % Saving Tolerances Values
        fprintf(SearchParamFile,'%s%s\n','Molecular Weight Tolerance: ',get(handles.edit_MolecularWeight,'String'));
        fprintf(SearchParamFile,'%s%s\n','Peptide Tolerance: ',get(handles.edit_Peptide,'String'));
        fprintf(SearchParamFile,'%s%s\n','PTM Tolerance: ',get(handles.edit_PTM,'String'));
        
        % Saving Tolerance Units
        MW_Units_List = get(handles.menu_MolecularWeightUnits,'String');
        MW_Units_List = cellstr(MW_Units_List);
        MW_Units_Selected = get(handles.menu_MolecularWeightUnits,'Value');
        fprintf(SearchParamFile,'%s%s\n','Molecular Weight Tolerance Unit: ',MW_Units_List{MW_Units_Selected});
        
        Peptide_Units_List = get(handles.menu_PeptideUnits,'String');
        Peptide_Units_Selected = get(handles.menu_PeptideUnits,'Value');
        fprintf(SearchParamFile,'%s%s\n','Peptide Tolerance Unit: ',Peptide_Units_List{Peptide_Units_Selected});
        
        if BlindPTMvar == 1
            fprintf(SearchParamFile,'%s%s\n','Blind PTM Search: ','Yes');
        else
            fprintf(SearchParamFile,'%s%s\n','Blind PTM Search: ','No');
        end
        
        truncation = getappdata(0,'Truncation');
        if isempty(truncation)
            truncation =0;
        end
        if truncation == 1
            fprintf(SearchParamFile,'%s%s\n','Truncated Protein: ','Yes');
        else
            fprintf(SearchParamFile,'%s%s\n','Truncated Protein: ','No');
        end
        
        %% Single Search Mode
        if get(handles.radiobutton_SingleSearch,'Value') == 1
            setappdata(0,'w2',1); %% Will be used for running PST Filter, It will be user defined in batch Mode
            %% Exporting objects to other GUIs from SINGLE search mode
            [pathstr,name,extension] = fileparts(Single_Peaklist_Data);
            if strcmpi(extension,'.mzxml')
                mzXML_Objects();
            elseif strcmpi(extension,'.mzml')
                mzML_Objects();
            else
                Export_Objects (handles, Single_Peaklist_Data);
            end
            
            % Loading the whole protein mass tuner
            if get(handles.checkbox_TunedMass, 'Value') == 1 % Executes when Auto-Tune Checkobx is on
                Slider_Value=50;
                addpath('IntactMassTuner');
                [Tuned_MolWt, ~,~ ,~,~] =  MassTuner(Slider_Value,Experimental_Protein_Mass,MW_Tolerance);
                %                 if(abs(Tuned_MolWt - Experimental_Protein_Mass) > 3)
                %                     button = questdlg(sprintf('INVALID PARAMETERS - Either MS1 or MS2 are not accurate enough to perform Mass Tuning.\nWould you still like to run Mass Tuner?'),'SPECTRUM');
                %                     if strcmp(button,'Yes')
                %                         WholeProteinMWEstimator
                %                     else
                %                         msgbox(sprintf('Protein Search Couldn''t complete.\nDeactivate Auto-Tune option in main GUI to proceed.'), 'Error','warn');
                %                         return
                %                     end
                %                 else
                %                     WholeProteinMWEstimator;
                %                 end
                
                Tuned_Mass = getappdata(0,'Tuned_Mass');  %Updated 20210504  %
                if(abs(Tuned_MolWt - Experimental_Protein_Mass) < 3)   
                    Experimental_Protein_Mass = str2double(Tuned_Mass);  %Tuned_MolWt; %Updated 20210410  %
                end
                % Fetching the tuned mass from WholeProteinMWEstimator window
                set(handles.edit_TunedMass,'String',Tuned_Mass); % The fetched Tuned Mass assigned to the Tuned Mass in Main window
                set(handles.edit_TunedMass,'ForegroundColor',[0 0 0]); % Black Color
            else
                setappdata(0,'WindowClosed',false);
            end % if ((get(handles.checkbox_TunedMass, 'Value')) == 1)
            
            % if tolerance are very large
            if(strcmp(MWunit,'Da'))
                if(1000<MW_Tolerance)
                    warning_window = warndlg({'Too much time may be required for the selected protein molecular weight tolerance! ','                         Pressing OK  to continue'},'Warning!','modal');
                    if(isequal(warning_window.Visible,'on'))
                        uiwait
                    end
                end
            end
            
            if(strcmp(PepUnit,'Da'))
                if(2<Peptide_Tolerance)
                    warning_window = warndlg({'Too much time may be required for the selected peptide tolerance! ','                         Pressing OK  to continue'},'Warning!','modal');
                    if(isequal(warning_window.Visible,'on'))
                        uiwait
                    end
                end
            end
            
            if(2<str2num(get(handles.edit_PTM,'String'))) %#ok<ST2NM>
                warning_window = warndlg({'Too much time may be required for the selected PTM tolerance! ','                         Pressing OK  to continue'},'Warning!','modal');
                if(isequal(warning_window.Visible,'on'))
                    uiwait
                end
            end
            
            if(~strcmp(get(handles.edit_TunedMass,'String'),'0.0') || get(handles.checkbox_TunedMass,'Value') == 0) % When Tuned Mass is not empty
                try
                    %% Opening PST GUI for PST Parameters
                    addpath(strcat(pwd,f,'PST'));
                    if(getappdata(0,'WindowClosed') == false)
                        PST_gui1;
                    end
                    User_EST_parameters{1}=getappdata(0,'Mini_TagLength');
                    User_EST_parameters{2}=getappdata(0,'Max_TagLength');
                    User_EST_parameters{3}=getappdata(0,'Hop_threshold');
                    User_EST_parameters{4}=getappdata(0,'TagError_threshold');
                    FilterPSTs = getappdata(0,'FilterPSTs');
                    
                    %20190111 - Abdul Rehman: Adding support for saving
                    %parameters
                    fprintf(SearchParamFile,'\n');
                    
                    %                     if FilterPSTs == 1
                    %                         fprintf(SearchParamFile,'%s%s\n','Filter PSTs: ','Yes');
                    % %                         fprintf(SearchParamFile,'%s%s\n','Minimum Tag Length: ',User_EST_parameters{1});
                    % %                         fprintf(SearchParamFile,'%s%s\n','Maximum Tag Length: ',User_EST_parameters{2});
                    % %                         fprintf(SearchParamFile,'%s%s\n','PST Hop Threshold: ',User_EST_parameters{3});
                    % %                         fprintf(SearchParamFile,'%s%s\n','PST Error Threshold: ',User_EST_parameters{4});
                    %                     else
                    %                         fprintf(SearchParamFile,'%s%s\n', 'Filter PSTs: ', 'No');
                    %                     end
                    
                    if(isequal(getappdata(0,'condition'),2))
                        return
                    end
                    rmpath(strcat(pwd,f,'PST'))
                    
                    %                     %20190111 - Abdul Rehman: Adding support for saving
                    %                     %parameters
                    FilterPSTs = getappdata(0,'FilterPSTs');
                    if FilterPSTs == 1
                        fprintf(SearchParamFile,'%s%s\n','Filter PSTs: ','Yes');
                        fprintf(SearchParamFile,'%s%s\n','Minimum Length of Sequence Tag: ',User_EST_parameters{1});
                        fprintf(SearchParamFile,'%s%s\n','Maximum Length of Sequence Tag: ',User_EST_parameters{2});
                        fprintf(SearchParamFile,'%s%s\n','Tolerance For Each Hop: ',User_EST_parameters{3});
                        fprintf(SearchParamFile,'%s%s\n','Tolerance for Whole EST: ',User_EST_parameters{4});
                    else
                        fprintf(SearchParamFile,'%s%s\n', 'Filter PSTs: ', 'No');
                    end
                    
                    %% SAVING PARAMETERS -- To save parameters of PST-gui into the project_title.parameters menu_File
                    title = get(handles.edit_ProjectTitle,'String');
                    fullname = fullfile(strcat(title,'.parameters'));
                    CurrentWorkingDirectory = fileparts(mfilename('fullpath'));
                    path = fullfile(strcat(CurrentWorkingDirectory,f,'Parameters',f));
                    fpath = fullfile(strcat(path,fullname));
                    file = fopen(fpath,'a+');
                    %                     fprintf(file,'%s%s\n','Minimum Length of Sequence Tag: ',User_EST_parameters{1});
                    %                     fprintf(file,'%s%s\n','Maximum Length of Sequence Tag: ',User_EST_parameters{2});
                    %                     fprintf(file,'%s%s\n','Tolerance For Each Hop: ',User_EST_parameters{3});
                    %                     fprintf(file,'%s%s\n','Tolerance for Whole EST: ',User_EST_parameters{4});
                    fclose(file);
                    
                    %% ........Engine start........ %%
                    totalTime = tic;
                    progressbar('SPECTRUM: Performing Search');
                    
                    %% Generate Peptide Sequence Tafs for filtering Candidate Proteins
                    
                    if FilterPSTs == 1
                        addpath(strcat(pwd,f,'PST'));
                        Tags_Ladder = Prep_Score_PSTs(str2num(User_EST_parameters{1}),str2num(User_EST_parameters{2}),str2num(User_EST_parameters{3}),str2num(User_EST_parameters{4})); %#ok<ST2NM>
                        rmpath(strcat(pwd,f,'PST'))
                    else
                        Tags_Ladder = {};
                    end
                    progressbar(1/8);
                    
                    %% Load Protein Database
                    addpath(strcat(pwd,f,'Engine'));
                    [Candidate_ProteinsList_Initial,Candidate_ProteinsList_Truncated] = ParseDatabase(Experimental_Protein_Mass,MW_Tolerance,Selected_Database,FilterDB,Fixed_Modifications,Variable_Modifications,Tags_Ladder);
                    rmpath(strcat(pwd,f,'Engine'));
                    progressbar(2/8);
                    
                    % Write in Debug file
                    if(strcmp(Debug,'on'))
                        addpath(strcat(pwd,f,'Debug'));
                        %%%%%% write ouput in file %%%%%%%%%%%
                        display(length(Candidate_ProteinsList_Initial));
                        setappdata(0,'Candidate_ProteinsList_Initial',Candidate_ProteinsList_Initial);
                        OUTPUT_file(1,title);
                        rmpath(strcat(pwd,f,'Debug'));
                    end
                    
                    %% Score Proteins on Intact Protein Mass
                    addpath(strcat(pwd,f,'Score'));
                    Candidate_ProteinsList_MW = Score_Mol_Weight(Candidate_ProteinsList_Initial,Experimental_Protein_Mass);
                    rmpath(strcat(pwd,f,'Score'));
                    progressbar(3/8);
                    
                    % Write in Debug file
                    if(strcmp(Debug,'on'))
                        display(length(Candidate_ProteinsList_Initial));
                    end
                    
                    % Write in Debug file
                    if(strcmp(Debug,'on'))
                        addpath(strcat(pwd,f,'Debug'));
                        setappdata(0,'Tags_Ladder',Tags_Ladder);
                        OUTPUT_file(2,title);
                        rmpath(strcat(pwd,f,'Debug'));
                    end
                    
                    addpath(strcat(pwd,f,'Engine'));
                    %% Generate Insilico Fragments and Score Proteins on PSTs - Also Generate Modified Proteoforms
                    Candidate_ProteinsList = Updated_ParseDatabase(Experimental_Protein_Mass,Tags_Ladder,Candidate_ProteinsList_MW,PTM_Tolerance,Fixed_Modifications,Variable_Modifications );
                    progressbar(4/8);
                    
                    %% Modify Insilico fragments according to fragmentation type
                    Candidate_ProteinsList = Insilico_frags_Generator_modifier(Candidate_ProteinsList,Fragmentation_Type,HandleIon);
                    progressbar(5/8);
                    
                    %% Blind-PTM Search and localization
                    if BlindPTMvar == 1
                        [sizeHopeInfo,Hop_Info_name, Hop_Info_AA, Hop_Info_end, Hop_Info_start] = BlindPTM_Extraction();
                        Candidate_ProteinsListModified = BlindPTM(Candidate_ProteinsList,Peptide_Tolerance, 1,PepUnit,sizeHopeInfo,Hop_Info_name, Hop_Info_AA, Hop_Info_end, Hop_Info_start);
                    else
                        Candidate_ProteinsListModified = [];
                    end
                    Candidate_ProteinsList = [Candidate_ProteinsList; Candidate_ProteinsListModified];
                    progressbar(6/8);
                    
                    %% Spectral Comparison
                    Matches = Insilico_Score(Candidate_ProteinsList,getappdata(0,'Fragments_Masses'), getappdata(0,'Int'),Peptide_Tolerance,PepUnit); %Updated 20210410 %% Use mass diff to estimate blind ptms.
                    
                    %% Localizing Unknown mass shift
                    Matches = BlindPTM_Localization(Matches,Experimental_Protein_Mass);
                    
                    %% Truncation Starts
                    truncation = getappdata(0,'Truncation');
                    if isempty(truncation)
                        truncation =0;
                    end
                    TruncatedMatches = [];
                    if truncation == 1
                        addpath(strcat(pwd,f,'Engine_Truncation'));
                        
                        [Candidate_ProteinsList_Left,Candidate_ProteinsList_Right] = PreTruncation(Candidate_ProteinsList_Truncated,MW_Tolerance);
                        
                        %% Ordinary Truncation
                        [Candidate_ProteinsList_Left, RemainingProteins_Left] = Truncation_Left(Candidate_ProteinsList_Left);
                        [Candidate_ProteinsList_Right, RemainingProteins_Right] = Truncation_Right(Candidate_ProteinsList_Right);
                        Candidate_ProteinsList_UnModified = [Candidate_ProteinsList_Left; Candidate_ProteinsList_Right];
                        
                        %% In silico Treatment
                        Candidate_ProteinsList_UnModified = Insilico_frags_Generator_modifier(Candidate_ProteinsList_UnModified,Fragmentation_Type,HandleIon);
                        if BlindPTMvar == 1
                            RemainingProteins_Right = Insilico_frags_Generator_modifier(RemainingProteins_Right,Fragmentation_Type,HandleIon);
                            RemainingProteins_Left = Insilico_frags_Generator_modifier(RemainingProteins_Left,Fragmentation_Type,HandleIon);
                            
                            %% Blind PTM localization
                            [RemainingProteins_Right_Modified] = BlindPTM_Truncation_Right(RemainingProteins_Right, Peptide_Tolerance, 1, PepUnit, sizeHopeInfo,Hop_Info_name, Hop_Info_AA, Hop_Info_end, Hop_Info_start);
                            [RemainingProteins_Left_Modified] = BlindPTM_Truncation_Left(RemainingProteins_Left, Peptide_Tolerance, 1, PepUnit, sizeHopeInfo,Hop_Info_name, Hop_Info_AA, Hop_Info_end, Hop_Info_start);
                            
                            %% Modified Truncation
                            [Candidate_ProteinsList_Modified_Right] = Truncation_Right_Modification(RemainingProteins_Right_Modified,Peptide_Tolerance,PepUnit, Fragmentation_Type);
                            [Candidate_ProteinsList_Modified_Left] = Truncation_Left_Modification(RemainingProteins_Left_Modified,Peptide_Tolerance,PepUnit, Fragmentation_Type);
                        else
                            Candidate_ProteinsList_Modified_Right = [];
                            Candidate_ProteinsList_Modified_Left = [];
                        end
                        %% Final Scoring
                        Candidate_ProteinsList = [Candidate_ProteinsList_UnModified;Candidate_ProteinsList_Modified_Left;Candidate_ProteinsList_Modified_Right];
                        Candidate_ProteinsList = FIlter_Truncated_Proteins(Candidate_ProteinsList, Tags_Ladder);
                        TruncatedMatches = Insilico_Score(Candidate_ProteinsList,getappdata(0,'Fragments_Masses'), getappdata(0,'Int'),Peptide_Tolerance,PepUnit);  %Updated 20210410 %% Use mass diff to estimate blind ptms.
                        rmpath(strcat(pwd,f,'Engine_Truncation'));
                    end
                    rmpath(strcat(pwd,f,'Engine'));
                    Matches = [Matches; TruncatedMatches];
                    progressbar(7/8);
                    
                    %% Scoring
                    cd(strcat(pwd,f,'Score'));
                    setappdata(0,'Matches',Matches);
                    setappdata(0,'Tags_Ladder',Tags_Ladder);
                    if(isempty(Matches))
                        msgbox('No result found please search with other set of parameters');
                        cd(initial_path);
                    else
                        Final_Scoring;
                        setappdata(0,'w1',getappdata(0,'w1'));
                        setappdata(0,'w2',getappdata(0,'w2'));
                        setappdata(0,'w3',getappdata(0,'w3'));
                        result=getappdata(0,'Matches');
                        setappdata(0,'Matches',result);
                        cd(initial_path);
                        
                        %% Compute E-Value
                        addpath(strcat(pwd,f,'EValue'));
                        Matches=getappdata(0,'Matches');
                        if numel(Matches) ~= 0
                            Matches =  PrSM_Evalue(Matches);
                        end
                        rmpath(strcat(pwd,f,'EValue'));
                        setappdata(0,'Matches',Matches);
                        progressbar(7.8/8);
                        addpath(strcat(pwd,f,'ResultsSummaryView'));
                        progressbar(8/8);
                        if(getappdata(0,'FScoringWindowClosed') == false)
                            Result;
                        end
                    end
                    Elapsed = toc(totalTime);
                    fprintf('Elapsed Time %d seconds.\n',Elapsed);
                catch ME
                    msgbox('Search couldn''t complete please check your search parameters and data file. If problem still persists report bug on GitHub','SPECTRUM','Modal');
                    disp(['ID: ' ME.identifier])
                end
            end
        else
            %%  Batch Experiment Mode
            try
                addpath(strcat(pwd,f,'PST'));
                PST_gui1;
                if(isequal(getappdata(0,'condition'),2))
                    return
                end
                
                User_EST_parameters{1}=getappdata(0,'Mini_TagLength');
                User_EST_parameters{2}=getappdata(0,'Max_TagLength');
                User_EST_parameters{3}=getappdata(0,'Hop_threshold');
                User_EST_parameters{4}=getappdata(0,'TagError_threshold');
                
                
                % SAVING PARAMETERS -- To save parameters of PST-gui into the project_title.parameters menu_File
                title = get(handles.edit_ProjectTitle,'String');
                fullname = fullfile(strcat(title,'.parameters')); %#ok<NASGU>
                CurrentWorkingDirectory = fileparts(mfilename('fullpath'));
                path = fullfile(strcat(CurrentWorkingDirectory,f,'Parameters',f));     %#ok<NASGU>
            catch exception
                title = get(handles.edit_ProjectTitle,'String');% log file
                cd(strcat(pwd,f,'Debug'));
                Debug_file(title,exception)
                errordlg(getReport(exception,'basic','hyperlinks','off'));
                return
            end
            
            
            setappdata(0,'User_EST_parameters',User_EST_parameters);
            setappdata(0,'BatchFolderContents',Batch_Peaklist_Data);
            setappdata(0,'path', get(handles.edit_ExperimentalData,'String'));
            setappdata(0,'initial_path',pwd);
            initial_path= pwd; %#ok<NASGU>
            
            addpath(strcat(pwd,f,'Score'));
            Final_Scoring;
            
            addpath(strcat(pwd,f,'Engine'));
            
            addpath(strcat(pwd,f,'EValue'));
            addpath(strcat(pwd,f,'ChemicalModifications'));
            addpath(strcat(pwd,f,'Datareader'));
            addpath(strcat(pwd,f,'Debug'));
            addpath(strcat(pwd,f,'Engine_Truncation'));
            addpath(strcat(pwd,f,'IntactMassTuner'));
            addpath(strcat(pwd,f,'PST'));
            addpath(strcat(pwd,f,'Results'));
            addpath(strcat(pwd,f,'Score'));
            
            setappdata(0,'Type_file',get(handles.menu_BatchFileType,'Value'));
            setappdata(0,'PepUnit',get(handles.menu_PeptideUnits,'Value'));
            setappdata(0,'MWunit',get(handles.menu_MolecularWeightUnits,'Value'));
            
            %% Batch Run
            tic
            BatchRun();
            toc
            
            rmpath(strcat(pwd,f,'Engine'));
            
            rmpath(strcat(pwd,f,'EValue'));
            rmpath(strcat(pwd,f,'ChemicalModifications'));
            rmpath(strcat(pwd,f,'Datareader'));
            rmpath(strcat(pwd,f,'Debug'));
            rmpath(strcat(pwd,f,'Engine_Truncation'));
            rmpath(strcat(pwd,f,'IntactMassTuner'));
            rmpath(strcat(pwd,f,'PST'));
            rmpath(strcat(pwd,f,'Results'));
            rmpath(strcat(pwd,f,'Score'));
            
            if (getappdata(0,'isResultAvailable') == 1)   %Updated 20210427 %(getappdata(0,'P_condotion')==1)
                msgbox('Results  are  saved  in  Result  folder','SPECTRUM','Modal');
            else
                msgbox('Search couldn''t complete please check your search parameters and data file.','SPECTRUM','Modal');
            end
        end
        
        %20190111 - Abdul Rehman: Adding support for saving
        %parameters
        
        FilterPSTs = getappdata(0,'FilterPSTs');
        if FilterPSTs == 1
            fprintf(SearchParamFile,'%s%s\n','Filter PSTs: ','Yes');
            fprintf(SearchParamFile,'%s%s\n','Minimum Length of Sequence Tag: ',User_EST_parameters{1});
            fprintf(SearchParamFile,'%s%s\n','Maximum Length of Sequence Tag: ',User_EST_parameters{2});
            fprintf(SearchParamFile,'%s%s\n','Tolerance For Each Hop: ',User_EST_parameters{3});
            fprintf(SearchParamFile,'%s%s\n','Tolerance for Whole EST: ',User_EST_parameters{4});
        else
            fprintf(SearchParamFile,'%s%s\n', 'Filter PSTs: ', 'No');
        end
        
        %20190111 - Abdul Rehman: Adding support for saving parameters
        w1 = getappdata(0,'w1');
        w2 = getappdata(0,'w2');
        w3 = getappdata(0,'w3');
        
        fprintf(SearchParamFile,'%s%s\n','Intact Mass Scoring Weight: ', num2str(w1));
        fprintf(SearchParamFile,'%s%s\n','PST Scoring Weight: ', num2str(w2));
        fprintf(SearchParamFile,'%s%s\n','In silico Scoring Weight: ',num2str(w3));
        
        fclose(SearchParamFile);
        
    else
        msgbox('Project Title Missing');
    end
else
    msgbox('Please Set the current path to SPECTRUM(ToolBox)','Set Path','modal');
    uiwait;
    cd(uigetdir());
end

% --------------------------------------------------------------------
function menu_File_Callback(~, ~, ~)
% hObject    handle to menu_File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function submenu_Reset_Callback(hObject, eventdata, handles)
% hObject    handle to submenu_Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pushbutton_Reset_Callback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function submenu_SaveCurrentParametersSettings_Callback(hObject, eventdata, handles)
% hObject    handle to submenu_SaveCurrentParametersSettings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Save parameters and settigns in Project_Title.parameters and Project_Title.settings files
toolbarbutton_SaveCurrentParametersSettings_ClickedCallback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function submenu_LoadUserSavedParametersSettings_Callback(hObject, eventdata, handles)
% hObject    handle to submenu_LoadUserSavedParametersSettings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Browse for loading user saved Project_Title.parameters and Project_Title.settings
toolbarbutton_LoadUserSavedParametersSettings_ClickedCallback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function submenu_Print_Callback(~, ~, ~)
% hObject    handle to submenu_Print (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
display('');

% --------------------------------------------------------------------
function submenu_Exit_Callback(~, ~, ~)
% hObject    handle to submenu_Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    close(gcf);
catch
    return
end

% --------------------------------------------------------------------
function menu_Tools_Callback(~, ~, ~)

% --------------------------------------------------------------------
function submenu_Screenshot_Callback(~, ~, handles)
% hObject    handle to submenu_Screenshot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Take screenshot of SPECTRUM
%SAVING RESULTS FOLDER PATH
f = filesep;
if((~isempty(get(handles.edit_ProjectTitle,'String')) && (~strcmp(get(handles.edit_ProjectTitle,'String'),'Enter the Project Title')) && ~isempty(get(handles.edit_Parameters,'String'))))
    param = strcat('.',f,'Parameters');
    cd (param);
    exportFig = strcat('..',f,'ExportFigure');
    addpath (exportFig);
    export_fig(handles.SPECTRUM);
    cd ('..');
else
    msgbox('No Project Folder Selected or Project Title Missing');
    return;
end

% --------------------------------------------------------------------
function menu_debug_Callback(hObject, ~, ~)
if (strcmp(get(hObject,'Checked'),'off'))
    set(hObject,'Checked','on');
else
    set(hObject,'Checked','of');
end

% --------------------------------------------------------------------
function toolbarbutton_ResetAllFields_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to toolbarbutton_ResetAllFields (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Reseting field by calling pushbutton_Reset
pushbutton_Reset_Callback(hObject, eventdata, handles);

% --------------------------------------------------------------------
% --- Loads default parameters and settings from default.parameters,
% batch_default.settings and single_default.settings files
function toolbarbutton_LoadDefaultParametersSettings_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to toolbarbutton_LoadDefaultParametersSettings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setDefaultParameters(hObject, eventdata, handles)

function setDefaultParameters(hObject, eventdata, handles)
f = filesep;
T_Object = [1;0;0;0];
mod={'Phosphorylation_Y';'Phosphorylation_T';'Phosphorylation_S';'Hydroxylation_P';...
    'Amidation_F';'Acetylation_A';'Acetylation_K';'Acetylation_S';'Methylation_R';...
    'Methylation_K';'N_linked_glycosylation_N';'O_linked_glycosylation_S';'O_linked_glycosylation_T'};
set(handles.listbox_Modifications,'String',mod); % clear selection
set(handles.checkbox_ProteinMass,'Value',1);
% for setting other modifications NON
setappdata(0,'Othermodification_Methionine','');
setappdata(0,'Othermodification_Cysteine','');
setappdata(0,'Othermodification_Terminal',T_Object);
setappdata(0, 'Truncation', 0);
set(handles.Trunc,'Value',0);
try
    handles.Load_Default_file = 1; % To handle default.settings and Project_Title.settings files (Saved by the user)
    Parameters_File = fopen(fullfile(strcat(pwd,f,'Settings',f,'default.parameters'))); % Read default.parameters file
    automatic_load_parameters(hObject, eventdata, handles, Parameters_File);     % fuction call to load parameters
    if(get(handles.radiobutton_SingleSearch,'Value') == 1) % Load Settings for SINGLE Search Mode
        Settings_File = fopen(fullfile(strcat(pwd,f,'Settings',f,'single_default.settings')));
        set(handles.text_SingleFileType,'Value',1);
        set(handles.text_SingleFileType,'Visible','off');
        set(handles.menu_SingleFileType,'Value',1);
        set(handles.menu_SingleFileType,'Visible','off');
    else % Load Settings for BATCH Search Mode
        Settings_File = fopen(fullfile(strcat(pwd,f,'Settings',f,'batch_default.settings')));
        set(handles.menu_BatchFileType,'Value',1);
    end
    %fuction call to load settings
catch exception %#ok<NASGU>
    msgbox('Please Set the current path to SPECTRUM(Toolbox)','Set Path','modal');
    uiwait
    cd(uigetdir());
end
try
    automatic_load_settings(hObject, eventdata, handles, Settings_File);
catch error
    errordlg('default setting file encounter unexpected error','Setting error!','modal');
end

% --------------------------------------------------------------------
function toolbarbutton_SaveCurrentParametersSettings_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to toolbarbutton_SaveCurrentParametersSettings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    if((~isempty(get(handles.edit_ProjectTitle,'String')) && (~strcmp(get(handles.edit_ProjectTitle,'String'),'Enter the Project Title'))))
        if(~isempty(get(handles.edit_Parameters,'String')))
            Destination_for_Saving = get(handles.edit_Parameters,'String');
        elseif(isempty(get(handles.edit_Parameters,'String')) && ~isempty(get(handles.edit_Results,'String')))
            Destination_for_Saving = get(handles.edit_Results,'String');
        end
    else
        msgbox('No Project Folder Selected or Project Title Missing');
    end
    Project_Title = get(handles.edit_ProjectTitle,'String'); % returns name of the project
    setappdata(0,'Project_Title',Project_Title);
    % For saving parameters menu_File: Project_Title.parameters
    Save_Parameters_Path = fullfile(Destination_for_Saving,strcat(Project_Title,'.parameters'));
    Save_Parameters_File = fopen(Save_Parameters_Path,'wt');
    automatic_save_parameters_ClickedCallback(hObject, eventdata, handles,Save_Parameters_File); % Defined on (line 572)
    % For saving settings menu_File: Project_Title.settings
    Save_Settings_Path = fullfile(Destination_for_Saving,strcat(Project_Title,'.settings'));
    Save_Settings_File = fopen(Save_Settings_Path,'wt');
    automatic_save_settings_ClickedCallback(hObject, eventdata, handles,Save_Settings_File); % Define on (line 626)
catch exception
    disp(getReport(exception,'basic','hyperlinks','off'));
end

% --------------------------------------------------------------------
function toolbarbutton_LoadUserSavedParametersSettings_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to toolbarbutton_LoadUserSavedParametersSettings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f = filesep;
try
    handles.Load_Default_file = 0;  % To handle default.settings and Project_Title.settings files (Saved by the user)
    % Browse for menu_File for loading Parameters
    initialpath=pwd;
    cd(strcat(initialpath,f,'Parameters'));%parameters folder is selected as working  directory
    [Browse_Parameters_File, Browse_Parameters_Path] = uigetfile({'*.parameters','Parameters Files (*.parameters)'},'Select a Parameters file');
    Parameters_File = fopen(fullfile(Browse_Parameters_Path,Browse_Parameters_File));
    automatic_load_parameters(hObject, eventdata, handles, Parameters_File); % Defined on (line 905)
    % Browse for menu_File for loading Settings
catch exception %#ok<NASGU>
    errordlg('Parameter file is not selected!');
    cd(initialpath)
    return
end
try
    % [Browse_Settings_File, Browse_Settings_Path] = uigetfile({'*.settings','Setting Files (*.settings)'},'Select a Settings file');
    Settings_File_name=strsplit(Browse_Parameters_File,'.');
    File_setting=strcat(Browse_Parameters_Path,Settings_File_name(1),'.settings');
    Settings_File = fopen(File_setting{1});
    automatic_load_settings(hObject, eventdata, handles,  Settings_File); % Defined on (line 806)
    cd(initialpath)
catch exception %#ok<NASGU>
    errordlg('Setting file is not selected! ');
    cd(initialpath)
    return
end

% --------------------------------------------------------------------
function Print_ClickedCallback(~, ~, ~)
% hObject    handle to Print (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f = filesep;
addpath(strcat(pwd,f,'ExportFigure'));
export_fig snap.png;

% --- Executes during object creation, after setting all properties.
function edit_ProjectTitle_CreateFcn(hObject, ~, ~)
% hObject    handle to edit_ProjectTitle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function automatic_load_parameters(~, eventdata, handles, Parameters_File)
formatSpec = 'Output File Format:%s Thrash Paramters: %s Database Selected:%s Protein Mass (Da):%s Filter DB for intact Protein Mass:%s Tune Whole Protein Molecular Weight:%s Fragmentation Type Selected:%s Molecular Weight Tolerance:%sPeptide Tolerance:%s PTM Tolerance:%s Minimum Length of Sequence Tag:%s Tolerance For Each Hop:%s Tolerance for Whole EST:%s Auto-Tune Intact Mass:%s Blind PTM Search:%s';

[Cell_info,pos] = textscan(Parameters_File,formatSpec,'Delimiter', '\n','CollectOutput', true); %#ok<ASGLU>
%%--------- loading fields -------



% set(handles.NeutralMass,'Enable','off');
set(handles.edit_ProteinMass,'String',Cell_info{1}{4});
set(handles.edit_ProteinMass,'ForegroundColor',[0 0 0]);
set(handles.edit_MolecularWeight,'String',Cell_info{1}{8});
set(handles.edit_MolecularWeight,'ForegroundColor',[0 0 0]);
set(handles.edit_Peptide,'String',Cell_info{1}{9});
set(handles.edit_Peptide,'ForegroundColor',[0 0 0]);
% Peptide tolerance will be used in fragment tolerance for tuning intact protein mass
%setappdata(0,'Peptide_Tol',Cell_info{1}{9})
set(handles.edit_PTM,'String',Cell_info{1}{10});
set(handles.edit_PTM,'ForegroundColor',[0 0 0]);
if (isequal(Cell_info{1}{5},'Yes'))
    set(handles.checkbox_ProteinMass,'Value',1);
    
end
if (isequal(Cell_info{1}{6},'Yes'))
    set(handles.checkbox_TunedMass,'Value',1);
    set(handles.NeutralMass,'Enable','on');
end
Fragmentation_Types_List = get (handles.menu_Fragmentation,'String');
Fragmentation_Types_List_Size = size(Fragmentation_Types_List,1);
for i=1:Fragmentation_Types_List_Size
    if (isequal(Fragmentation_Types_List{i},Cell_info{1}{7}))
        set(handles.menu_Fragmentation,'Value',i);
    end
end
% Loading Tolerance Units
% Tolerance_Format = 'Molecular Weight Tolerance Unit :%s Peptide Tolerance Unit :%s';
Tolerance_Format = 'Molecular Weight Tolerance Unit:%sPeptide Tolerance Unit:%s';
Tolerances_from_File = textscan(Parameters_File,Tolerance_Format,'Delimiter','\n','CollectOutput', true);
Tolerance_Units = cell(2,1);%Tolerances has 2 unit values stored now MW Tol + Peptide Tol
if (~isempty(Tolerances_from_File))
    for i = 1:numel(Tolerance_Units)
        remain = Tolerances_from_File{1,1}{1,i};
        while true
            [Respective_Tol_Unit, remain] = strtok(remain, ': '); %#ok<STTOK>
            if isempty(Respective_Tol_Unit),  break;  end
            [x, status] = str2num(Respective_Tol_Unit); %#ok<ST2NM,ASGLU> % check to see if it is a value or unit
            if (status == 1) %conversion to number successful
                Tolerances_from_File{1,1}{1,i} = Respective_Tol_Unit;
            else
                Tolerance_Units{i,1} = Respective_Tol_Unit;
            end
        end
    end
end
% Setting Units to Molecular Weight Tolerance and Peptide Tolerance that
% are extracted from the menu_File (default.parameters)
MW_Units_List = get (handles.menu_MolecularWeightUnits,'String');
MW_Units_List = cellstr(MW_Units_List);
MW_Units_List_Size = size(MW_Units_List,1);
for i=1:MW_Units_List_Size
    if (isequal(MW_Units_List{i},Tolerance_Units{1,1}))
        set(handles.menu_MolecularWeightUnits,'Value',i);
    end
end
Peptide_Unit_List = get (handles.menu_PeptideUnits,'String');
Peptide_Unit_List_Size = size(Peptide_Unit_List,1);
for i=1:Peptide_Unit_List_Size
    if (isequal(Peptide_Unit_List{i},Tolerance_Units{2,1}))
        set(handles.menu_PeptideUnits,'Value',i);
    end
end
% Modifications: Extracting modifications information from the menu_File
Modification_Format = '%s';
Modifications_from_File = textscan(Parameters_File,Modification_Format,'Delimiter', '\n','CollectOutput', true);
Modifications_Default = Modifications_from_File{1};
Fixed_Modifications = find(ismember(Modifications_Default,'Fixed Modifications Selected :'));
Variable_Modifications = find(ismember(Modifications_Default,'Variable Modifications Selected :'));
Fixed_Modifications_Selected = Modifications_Default(Fixed_Modifications+1:Variable_Modifications-1);
Variable_Modifications_Selected = Modifications_Default(Variable_Modifications+1:end);
set(handles.listbox_FixedModifications,'String',Fixed_Modifications_Selected,'Value',1);
set(handles.listbox_VariableModifications,'String',Variable_Modifications_Selected,'Value',1);
fclose(Parameters_File);
% Resolving default load parameters....The values that were loaded by default were not able to assigned to the respective fields.
% So each field functions are called to load values explicitly
edit_MolecularWeight_Callback(handles.edit_MolecularWeight, eventdata, handles);
edit_Peptide_Callback(handles.edit_Peptide, eventdata, handles);
edit_PTM_Callback(handles.edit_PTM, eventdata, handles);
menu_Database_Callback(handles.menu_Database, eventdata, handles);
menu_Fragmentation_Callback(handles.menu_Fragmentation, eventdata, handles);
% database selection
Folder=getappdata(0,'Selected_Database');
Dislpaly_Fasta_menuDatabase(handles, Folder);
set(handles.menu_Database,'Enable','on');
List_database = get (handles.menu_Database,'String');
if(~isequal(List_database,'Select Database'))
    Nummber_database = size(List_database,1);
    for i=1:Nummber_database
        if (isequal(List_database{i},Cell_info{1}{3}))
            set(handles.menu_Database,'Value',i);
        end
    end
end

%Auto tune
set(handles.checkbox_TunedMass,'Value',0);

%Blind PTM
set(handles.checkbox_BlindPTM,'Value',0);

function automatic_load_settings(~, eventdata, handles, Settings_File)
formatSpec = 'Experiment: %s Database Folder:%s Data:%s Results/Settings Folder:%s Parameters Folder:%s';
Cell_info = textscan(Settings_File,formatSpec,'Delimiter', '\n','CollectOutput', true);
fclose(Settings_File);
if(handles.Load_Default_file == 1) % For loading default settings
    % Get current path and concetnate it with the respective directory of Database
    Current_Database_Path = '';
    Current_Database_Path= fullfile(strcat(pwd,Cell_info{1}{2}));
    
    set (handles.edit_DatabaseDirectory,'String',Current_Database_Path);
    set(handles.edit_DatabaseDirectory,'TooltipString', Current_Database_Path);
    % Resolving default load settings....The values that were loaded by default were not able to assigned to the respective fields
    % So each field functions are called to load values explicitly . global variables and menu_Database
    setappdata(0,'Database_Path',Current_Database_Path);
    % Get current path and concetnate it with the respective directory of Peaklist files
    Current_Peaklist_Path = fullfile(strcat(pwd,Cell_info{1}{3}));
    set (handles.edit_ExperimentalData,'String',Current_Peaklist_Path);
    set(handles.edit_ExperimentalData,'TooltipString', Current_Peaklist_Path);
    
    if get(handles.radiobutton_SingleSearch,'Value') == 1 % For Single Search mode
        setappdata(0,'Single_Peaklist_Data',Current_Peaklist_Path);
        % Assign experimental protein mass to Protein Mass field upon browsing for peaklist file
        Set_ProteinMass_Field (handles,Current_Peaklist_Path);
    else  % For Batch Search Mode
        Batch_Files = Filtering_Batch_File_Format(handles,Current_Peaklist_Path);
        setappdata(0,'Batch_Peaklist_Data',Batch_Files);
    end
    
    resultspath = fullfile(strcat(pwd,Cell_info{1}{4}));
    set (handles.edit_Results,'String',resultspath);
    set(handles.edit_Results,'TooltipString', resultspath);
    parapath = fullfile(strcat(pwd,Cell_info{1}{5}));
    set (handles.edit_Parameters,'String',parapath);
    set(handles.edit_Parameters,'TooltipString', parapath);
else % For loading user saved settings
    set (handles.edit_DatabaseDirectory,'String',Cell_info{1}{2});
    set(handles.edit_DatabaseDirectory,'TooltipString', Cell_info{1}{2});
    setappdata(0,'Database_Path',Cell_info{1}{2});
    set (handles.edit_ExperimentalData,'String',Cell_info{1}{3});
    set (handles.edit_ExperimentalData,'TooltipString',Cell_info{1}{3});
    if get(handles.radiobutton_SingleSearch,'Value') == 1 % For Single Search mode
        setappdata(0,'Single_Peaklist_Data',Cell_info{1}{3});
    else  % For Batch Search Mode
        % Take files according to the file format selected in Batch mode
        Batch_Files = Filtering_Batch_File_Format(handles,Cell_info{1}{3});
        setappdata(0,'Batch_Peaklist_Data',Batch_Files);
    end
    set (handles.edit_Results,'String',Cell_info{1}{4});
    set(handles.edit_Results,'TooltipString', Cell_info{1}{4});
    set (handles.edit_Parameters,'String',Cell_info{1}{5});
    set(handles.edit_Parameters,'TooltipString', Cell_info{1}{5});
end
% Displaying fasta files menu database
Database_Path = getappdata(0,'Database_Path');
Dislpaly_Fasta_menuDatabase(handles, Database_Path);
% Setting font color black
set(handles.edit_DatabaseDirectory,'ForegroundColor',[0 0 0]);
set(handles.edit_ExperimentalData,'ForegroundColor',[0 0 0]);
set(handles.edit_Results,'ForegroundColor',[0 0 0]);
set(handles.edit_Parameters,'ForegroundColor',[0 0 0]);
% Resolving default load settings....menu_Database
menu_Database_Callback(handles.menu_Database, eventdata, handles);

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over edit_ProjectTitle.
function edit_ProjectTitle_ButtonDownFcn(~, ~, handles)
% hObject    handle to edit_ProjectTitle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_ProjectTitle,'String','  ');
set(handles.edit_ProjectTitle,'ForegroundColor',[0 0 0]);

% --- Executes on key press with focus on edit_ProjectTitle and none of its controls.
function edit_ProjectTitle_KeyPressFcn(~, ~, handles)
% hObject    handle to edit_ProjectTitle (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_ProjectTitle,'ForegroundColor',[0 0 0]);

% --- Executes during object deletion, before destroying properties.
function edit_ProjectTitle_DeleteFcn(~, ~, ~)
% hObject    handle to edit_ProjectTitle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function pushbutton_Peaklist_Callback(~, ~, handles)
% hObject    handle to pushbutton_Peaklist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Single Search Mode: Browse a single menu_File
try
    if(get(handles.radiobutton_SingleSearch,'Value') == 1)
        [Single_File,Single_File_Path] = uigetfile( ...
            {'*.txt;*.mzXML;*.mgf;*.txt','Data Files (*.txt)'},...
            'Select a file');
        if(Single_File)
            Single_File_Directory = fullfile(Single_File_Path,Single_File);
            % Fixing 0 comes when user browse but not select the path
            if(Single_File == 0)
                Single_File_Directory = get(handles.edit_Peaklist,'String');
                set(handles.edit_Peaklist,'String',Single_File_Directory);
            else
                set(handles.edit_Peaklist,'String',Single_File_Directory);
                set(handles.edit_Peaklist,'ForegroundColor', [0 0 0]);
            end %if(Single_File == 0)
            % TooltipString
            set(handles.edit_Peaklist,'TooltipString',  get(handles.edit_Peaklist,'String'));
            % Exporitng the Sinle Mode menu_File along with its path
            Single_Search_File = [Single_File_Path,Single_File];
            setappdata(0,'Single_Peaklist_Data',Single_Search_File);
            
            % Assign experimental protein mass to Protein Mass field upon browsing for peaklist file
            Set_ProteinMass_Field (handles,Single_Search_File);
        end
        % Batch Search Mode: Browse Whole Folder
    else % For BATCH search mode
        Batch_Files_Directory = uigetdir;
        if(Batch_Files_Directory)
            % Take files according to the file format selected in Batch mode
            % Fixing 0 comes when user browse but not select the path
            if(Batch_Files_Directory == 0)
                Batch_Files_Directory = get(handles.edit_Peaklist,'String');
                set(handles.edit_Peaklist,'String',Batch_Files_Directory);
            else
                set(handles.edit_Peaklist,'String',Batch_Files_Directory);
                set(handles.edit_Peaklist,'foregroundColor', [0 0 0]);
            end
            set(handles.edit_Peaklist,'TooltipString', get(handles.edit_Peaklist,'String'));
            Batch_Files = Filtering_Batch_File_Format(handles,Batch_Files_Directory);
            setappdata(0,'Batch_Peaklist_Data',Batch_Files);
        end  % if(handles.Single_Search_Mode == 1)
    end
catch exception %#ok<NASGU>
    errordlg('Peaklist file is missing.');
end

function Export_Objects (~, Peaks_File)
try
    Imported_Data =  importdata(Peaks_File);
    m = max(Imported_Data(:,2));
    HandleIon = getappdata(0,'HandleIon');
    for i = 2 : size(Imported_Data,1)
        %% Used for converting mono isotopic mass into mz value
        if (HandleIon{9,1} == 0)
            Imported_Data(i,1) = Imported_Data(i,1)+1.00727647;
        end
        Imported_Data(i,2) = Imported_Data(i,2)/m;
    end
    
    %%% Updated 20210409   %% BELOW
    temp_Imported_Data = Imported_Data(2:end, :);
    Sorted = sortrows(temp_Imported_Data,1);
    %Sorted = sortrows(Imported_Data,1);
    PeakListMW = Sorted(:,1);
    Intensity = Sorted(:,2);
    PeakListMW(end+1) = Imported_Data(1,1);
    Intensity(end+1) = Imported_Data(1,2);
    setappdata(0,'Peaklist_Data',Imported_Data);  % MS1 then, MS2s with their intensities [Original Order]
    setappdata(0,'Fragments_Masses',PeakListMW);  % MS2s (in ascending order) then, MS1 only 
    setappdata(0,'Int',Intensity);                % Only intensities of corresponding to the PeakListMW (MS values)
    %%% Updated 20210409   %% ABOVE
    
catch exception %#ok<NASGU>
    msgbox('File not found or Invalid Data File');
end

function mzXML_Objects (~, ~)
try
    Imported_Data = getappdata(0,'PeakData');
    m = max(Imported_Data(:,2));
    HandleIon = getappdata(0,'HandleIon');
    for i = 2 : size(Imported_Data,1)
        %% Used for converting mono isotopic mass into mz value
        if (HandleIon{9,1} == 0)
            Imported_Data(i,1) = Imported_Data(i,1)+1.00727647;
        end
        Imported_Data(i,2) = Imported_Data(i,2)/m;
    end
    Sorted = sortrows(Imported_Data,1);
    PeakListMW = Sorted(:,1);
    Intensity = Sorted(:,2);
    setappdata(0,'Peaklist_Data',Imported_Data);
    setappdata(0,'Fragments_Masses',PeakListMW);
    setappdata(0,'Int',Intensity);
catch exception %#ok<NASGU>
    msgbox('File not found or Invalid Data File');
end

function mzML_Objects (~, ~)
try
    Imported_Data = getappdata(0,'PeakData');
    m = max(Imported_Data(:,2));
    HandleIon = getappdata(0,'HandleIon');
    for i = 2 : size(Imported_Data,1)
        %% Used for converting mono isotopic mass into mz value
        if (HandleIon{9,1} == 0)
            Imported_Data(i,1) = Imported_Data(i,1)+1.00727647;
        end
        Imported_Data(i,2) = Imported_Data(i,2)/m;
    end
    Sorted = sortrows(Imported_Data,1);
    PeakListMW = Sorted(:,1);
    Intensity = Sorted(:,2);
    setappdata(0,'Peaklist_Data',Imported_Data);
    setappdata(0,'Fragments_Masses',PeakListMW);
    setappdata(0,'Int',Intensity);
catch exception %#ok<NASGU>
    msgbox('File not found or Invalid Data File');
end


% fucntion for Taking files according to the file format selected in Batch mode
function Files = Filtering_Batch_File_Format(handles,Directory)
f = filesep;
Batch_FileForm_List = get(handles.menu_BatchFileType,'String');
Batch_FileForm_Selected = get(handles.menu_BatchFileType,'Value');

%if strcmp(Batch_FileForm_List{Batch_FileForm_Selected}, '.txt')
if strcmp(Batch_FileForm_List, '.txt')
    Files = dir(fullfile(Directory, '*.txt'));
% elseif strcmp(Batch_FileForm_List{Batch_FileForm_Selected}, '.mgf')
%     Files = dir(fullfile(Directory, '*.mgf'));
%     if ~(isempty(Files))
%         addpath(strcat(pwd,f,'Datareader'));
%         for f_num=1:length(Files)
%             MGF_Reader(Directory,Files(f_num).name);
%         end
%         Files=dir(fullfile(Directory, '*.txt'));
%     end
% elseif strcmp(Batch_FileForm_List{Batch_FileForm_Selected}, '.mzXML')
%     Files = dir(fullfile(Directory, '*.mzXML'));
    
end

% --- Executes during object creation, after setting all properties.
function text_title_CreateFcn(hObject, ~, ~)
% hObject    handle to text_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
version = fopen('SPECTRUM_Version.txt');
l=fgetl(version);
i=1;
while not(i==2)
    l=fgetl(version);
    i=i+1;
end
setappdata(0,'Title',l);
set(hObject,'String',l);

function automatic_save_parameters_ClickedCallback(~, ~, handles,Save_Parameters_File)
fprintf(Save_Parameters_File,'%s%s\n','Thrash Paramters: ','None');
Menu_Database_List = get(handles.menu_Database,'String');
if iscell(Menu_Database_List)
    Menu_Database_Selected = get(handles.menu_Database,'Value');
    fprintf(Save_Parameters_File,'%s%s\n','Database Selected: ',Menu_Database_List{Menu_Database_Selected});
else
    fprintf(Save_Parameters_File,'%s%s\n','Database Selected: ', Menu_Database_List);
end
fprintf(Save_Parameters_File,'%s%s\n','Protein Mass (Da): ',get(handles.edit_ProteinMass,'String'));
% Saving Checkboxes
if (get(handles.checkbox_ProteinMass,'Value') == get(handles.checkbox_ProteinMass,'Max'))
    checked = 'Yes';
else
    checked = 'No';
end
fprintf(Save_Parameters_File,'%s%s\n','Filter Protein Database for Intact Protein Mass: ',checked);
if (get(handles.checkbox_TunedMass,'Value') == get(handles.checkbox_TunedMass,'Max'))
    checked = 'Yes';
else
    checked = 'No';
end
fprintf(Save_Parameters_File,'%s%s\n','Tune Whole Protein Molecular Weight: ',checked);
Fragmentation_Types_List = get(handles.menu_Fragmentation,'String');
Fragmentation_Types_Selected = get(handles.menu_Fragmentation,'Value');
fprintf(Save_Parameters_File,'%s%s\n','Fragmentation Type Selected: ',Fragmentation_Types_List{Fragmentation_Types_Selected});
% Saving Tolerances Values
fprintf(Save_Parameters_File,'%s%s\n','Molecular Weight Tolerance: ',get(handles.edit_MolecularWeight,'String'));
fprintf(Save_Parameters_File,'%s%s\n','Peptide Tolerance: ',get(handles.edit_Peptide,'String'));
fprintf(Save_Parameters_File,'%s%s\n','PTM Tolerance: ',get(handles.edit_PTM,'String'));
% Saving Tolerance Units
MW_Units_List = get(handles.menu_MolecularWeightUnits,'String');
MW_Units_List = cellstr(MW_Units_List);
MW_Units_Selected = get(handles.menu_MolecularWeightUnits,'Value');
fprintf(Save_Parameters_File,'%s%s\n','Molecular Weight Tolerance Unit: ',MW_Units_List{MW_Units_Selected});
Peptide_Units_List = get(handles.menu_PeptideUnits,'String');
Peptide_Units_Selected = get(handles.menu_PeptideUnits,'Value');
fprintf(Save_Parameters_File,'%s%s\n','Peptide Tolerance Unit: ',Peptide_Units_List{Peptide_Units_Selected});
% Saving Modifications
fprintf(Save_Parameters_File,'%s\n','Fixed Modifications Selected: ');
Fixed_Modifications_List = get(handles.listbox_FixedModifications,'String');
for Fixed_Modifications_Selected = 1:numel(Fixed_Modifications_List)
    fprintf(Save_Parameters_File,'%s\n',Fixed_Modifications_List{Fixed_Modifications_Selected,:});
end
fprintf(Save_Parameters_File,'%s\n','Variable Modifications Selected: ');
Variable_Modifications_List = get(handles.listbox_VariableModifications,'String');
for Variable_Modifications_Selected = 1:numel(Variable_Modifications_List)
    fprintf(Save_Parameters_File,'%s\n',Variable_Modifications_List{Variable_Modifications_Selected,:});
end
fclose(Save_Parameters_File);

% --- Called by:
% toolbarbutton_SaveCurrentParametersSettings_ClickedCallback() (line 544)
% pushbutton_Next_Callback() (line 1284)
% --- Save settings in Project_Title.settings
function automatic_save_settings_ClickedCallback(~, ~, handles,Save_Settings_File)

if (get(handles.radiobutton_SingleSearch,'Value') == 1)
    fprintf(Save_Settings_File,'%s%s\n','Experiment :','Single');
else
    fprintf(Save_Settings_File,'%s%s\n','Experiment :','Batch');
end
fprintf(Save_Settings_File,'%s%s\n','Database Folder :',get(handles.edit_DatabaseDirectory,'String'));
fprintf(Save_Settings_File,'%s%s\n','Data :',get(handles.edit_ExperimentalData,'String'));
fprintf(Save_Settings_File,'%s%s\n','Results/Settings Folder :',get(handles.edit_Results,'String'));
fprintf(Save_Settings_File,'%s%s\n','Parameters Folder :',get(handles.edit_Parameters,'String'));
fclose(Save_Settings_File);

function SPECTRUM_WindowButtonDownFcn(~, ~, ~)
function SPECTRUM_WindowButtonMotionFcn (~, ~, ~)

function checkbox_BlindPTM_Callback(~, ~, handles)
blind =  get(handles.checkbox_BlindPTM,'Value');
if blind == 1
    set(handles.listbox_VariableModifications, 'Enable', 'off');
    set(handles.pushbutton_AddVariableModifications, 'Enable', 'off');
    set(handles.pushbutton_DeleteVariableModifications, 'Enable', 'off');
else
    set(handles.listbox_VariableModifications, 'Enable', 'on');
    set(handles.pushbutton_AddVariableModifications, 'Enable', 'on');
    set(handles.pushbutton_DeleteVariableModifications, 'Enable', 'on');
end



function NeutralMass_Callback(hObject, eventdata, handles)
% hObject    handle to NeutralMass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NeutralMass as text
%        str2double(get(hObject,'String')) returns contents of NeutralMass as a double


% --- Executes during object creation, after setting all properties.
function NeutralMass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NeutralMass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Trunc.
function Trunc_Callback(hObject, eventdata, handles)
% hObject    handle to Trunc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Truncation = get(handles.Trunc,'Value');
setappdata(0, 'Truncation', Truncation);

% Hint: get(hObject,'Value') returns toggle state of Trunc

% --- Executes during object creation, after setting all properties.
function menu_SingleFileType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to menu_SingleFileType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function radiobutton_BatchMode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radiobutton_BatchMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in popupmenu11.
function popupmenu11_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu11 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu11


% --- Executes during object creation, after setting all properties.
function popupmenu11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in menu_SingleFileType.
function popupmenu13_Callback(hObject, eventdata, handles)
% hObject    handle to menu_SingleFileType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns menu_SingleFileType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from menu_SingleFileType


% --- Executes during object creation, after setting all properties.
function popupmenu13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to menu_SingleFileType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

