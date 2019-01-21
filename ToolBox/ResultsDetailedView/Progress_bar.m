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

function varargout = Progress_bar(varargin)
% PROGRESS_BAR MATLAB code for Progress_bar.fig
%      PROGRESS_BAR, by itself, creates a new PROGRESS_BAR or raises the existing
%      singleton*.
%
%      H = PROGRESS_BAR returns the handle to a new PROGRESS_BAR or the handle to
%      the existing singleton*.
%
%      PROGRESS_BAR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROGRESS_BAR.M with the given input arguments.
%
%      PROGRESS_BAR('Property','Value',...) creates a new PROGRESS_BAR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Progress_bar_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Progress_bar_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Progress_bar

% Last Modified by GUIDE v2.5 18-Mar-2015 15:26:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Progress_bar_OpeningFcn, ...
    'gui_OutputFcn',  @Progress_bar_OutputFcn, ...
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


% --- Executes just before Progress_bar is made visible.
function Progress_bar_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Progress_bar (see VARARGIN)

% Choose default command line output for Progress_bar
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Progress_bar wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Progress_bar_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
try
    %get path of file
    data_base=fopen('ubiquitin_db.text','r');
    pro_seq = fgetl(data_base);
    Number_prot=0;
    name='';
    hours=0;
    minutes=0;
    sec=0;
    c=0;
    
    while ischar(pro_seq)
        k = findstr('>', pro_seq);
        if(k==1)
            Number_prot=Number_prot+1;
            C = strsplit(pro_seq,'|');
            name=strcat(name,C(2),'|');
        end
        pro_seq = fgetl(data_base);
    end
    
    temp_var1=strjoin(name,'|');
    pronm=strsplit(temp_var1,'|');
    h=waitbar(0, 'Please wait...','name','SPECTRUM Progress Bar');
    hw=findobj(h,'Type','Patch');
    set(hw,'EdgeColor',[0 0 1],'FaceColor',[1 .6 .3])
    tic
    
    for k=1:Number_prot
        time=10000;
        temp_count=0;
        for i=1:time
            
            waitbar(i/time);
            time_elapse= num2str(toc);
            time_sec=strsplit(time_elapse,'.');
            sec=str2double(time_sec(1));
            
            
            sec=sec-(c*60);
            
            
            
            
            if~(sec==0)&&~mod(sec,60)
                minutes=minutes+1;
                c=c+1;
                
                
                
                
            end
            
            if (minutes==60)
                display(':(');
                hours=hours+1;
                minutes=0;
            end
            
            
            
            
            
            set( get(findobj(h,'type','axes'),'title'), 'FontSize',9);
            
            if(i<time/4)
                
                set( get(findobj(h,'type','axes'),'title'), 'string', ['Whole protein Molecular Weight Scoring....',strcat('ID :',pronm(k),'                             (',num2str(k),'/',num2str(Number_prot),')','_p_r_o_t_i_e_n_s     ','                            (',num2str(hours),':',num2str(minutes),':',num2str(sec),')')]);
                
            elseif(i>time/4) &&(i<time/2)
                set( get(findobj(h,'type','axes'),'title'), 'string', ['Expressed Sequence Tags Scoring......',strcat('ID :',pronm(k),'                             (',num2str(k),'/',num2str(Number_prot),')','_p_r_o_t_i_e_n_s     ','                            (',num2str(hours),':',num2str(minutes),':',num2str(sec),')')]);
                
            elseif(i>time/2)&&(i<(time/4+time/2))
                set( get(findobj(h,'type','axes'),'title'), 'string', ['Post-translational Modifications Scoring....',strcat('ID :',pronm(k),'                             (',num2str(k),'/',num2str(Number_prot),')','_p_r_o_t_i_e_n_s     ','                            (',num2str(hours),':',num2str(minutes),':',num2str(sec),')')]);
                
            elseif(i>(time/4+time/2))
                set( get(findobj(h,'type','axes'),'title'), 'string', ['In silico Vs In Vitro Spectrum scoring....',strcat('ID :',pronm(k),'                             (',num2str(k),'/',num2str(Number_prot),')','_p_r_o_t_i_e_n_s     ','                            (',num2str(hours),':',num2str(minutes),':',num2str(sec),')')]);
                
                
            end
            
            
            
        end
    end
    close(h)
    fclose(data_base);
catch
    return
end