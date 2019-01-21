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

function varargout = legend(varargin)
% LEGEND MATLAB code for legend.fig
%      LEGEND, by itself, creates a new LEGEND or raises the existing
%      singleton*.
%
%      H = LEGEND returns the handle to a new LEGEND or the handle to
%      the existing singleton*.
%
%      LEGEND('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LEGEND.M with the given input arguments.
%
%      LEGEND('Property','Value',...) creates a new LEGEND or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before legend_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to legend_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help legend

% Last Modified by GUIDE v2.5 16-Jan-2019 17:22:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @legend_OpeningFcn, ...
    'gui_OutputFcn',  @legend_OutputFcn, ...
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


% --- Executes just before legend is made visible.
function legend_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to legend (see VARARGIN)
set(hObject,'Name','SPECTRUM - Legend');
% Choose default command line output for legend
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes legend wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = legend_OutputFcn(~, ~, handles)
symbols=[{'\varpi'},{texlabel('omega')},{texlabel('psi')},{texlabel('alpha')},{'\Theta'},{'\otimes'},{'\oplus'},{'\oslash'},{'\nabla'},{texlabel('Delta')},{'\clubsuit'},{'\heartsuit'},{'\spadesuit'},{'\diamondsuit'},{'\Re'},{'\zeta'},{'\perp'},{'\vee'},{'\omega'}];
Modifications=[{'Phosphorylation'},{'DiMethylation'},{'Methylation'},{'Acetylation'},{'Hydroxylation'},{'DiHydroxylation'},{'O-Linked-Glycosylation'},{'Sulfoxide'},{'Glutathionylation'},{'Methylation_K'},{'S-Nitrosylation'},{'Palmitoylation'},{'Formylation'},{'Nitration'},{'N-Linked-Glycosylation'},{'Sulfone'},{'Pyruvate'},{'Pyrrolidone-Aarboxylic-Acid'},{'Gamma-Carboxyglutamic-Acid'}];
legend =text(0.5,0.09,'Legend:');
%set(legend,'FontWeight','bold');
set(legend,'FontSize',16);
set(legend,'color',[.4 .5 .3]);
x_axis3=0.5;
y_axis3=-2.8;
for num_modifications=1:numel(symbols)
    if num_modifications < 19
        format_modifications=text(.5+x_axis3,y_axis3+1,Modifications(num_modifications));
        set(format_modifications,'FontSize',9.5);
        format_symbols=text(0+x_axis3,y_axis3+1.2,symbols(num_modifications));
        set(format_symbols,'FontSize',12);
        set(format_symbols,'color','r');
        x_axis3=x_axis3+5.6;
    else
        format_modifications=text(2.5+x_axis3,y_axis3+1,Modifications(num_modifications));
        set(format_modifications,'FontSize',9.5);
        format_symbols=text(2.0+x_axis3,y_axis3+1.2,symbols(num_modifications));
        set(format_symbols,'FontSize',12);
        set(format_symbols,'color','r');
    end
    if num_modifications==4 ||num_modifications==8||num_modifications==12 ||num_modifications==16
        y_axis3=y_axis3-1.5;
        x_axis3=0.5;
    end
end
y_axis3=y_axis3-1.5;
x_axis3=0.5;
blu=text(0+x_axis3,y_axis3+1,'\bullet');
set(blu,'color','r');
set(blu,'FontSize',18);
set(blu,'FontWeight','bold');
text(0.5+x_axis3,y_axis3+0.8,'Blind PTM Mass');
x_axis3=x_axis3+4.85;
blu=text(0+x_axis3,y_axis3+1,'\bullet');
set(blu,'color','b');
set(blu,'FontSize',18);
text(0.5+x_axis3,y_axis3+0.8,'Peptide Sequence Tag');
x_axis3=x_axis3+6.15;
blu=text(0+x_axis3,y_axis3+1,'\bullet');
set(blu,'color','m');
set(blu,'FontSize',18);
text(0.5+x_axis3,y_axis3+0.8,'Amino Acids - Possible Blind PTM Sites');

y_axis3=y_axis3-1.5;
x_axis3=0.5;

blu = text(0+x_axis3,y_axis3+0.8,'X');
blu1 = text(-0.15+x_axis3,y_axis3+0.8,'---');
set(blu,'FontSize',14);
set(blu,'FontWeight','bold');
set(blu1,'Color','r');
set(blu1,'FontSize',14);
set(blu1,'FontWeight','bold');
text(0.5+x_axis3,y_axis3+0.6,' Truncated Amino Acid');
x_axis3=x_axis3+5.6;


blu=text(x_axis3+0.3,y_axis3+1,']');
set(blu,'FontSize',16);
set(blu,'FontWeight','bold');
text(0.7+x_axis3,y_axis3+0.6,'N-Terminal Fragment Match');
x_axis3=x_axis3+7.6;
blu=text(x_axis3+0.1,y_axis3+1,'[');
set(blu,'FontSize',16);
set(blu,'FontWeight','bold');
text(0.5+x_axis3,y_axis3+0.6,'C-Terminal Fragment Match');
% null=text(.5,-7.5,'\phi');
% set(null,'FontSize',14);
% set(null,'color',[0,.5,0]);
% text(1,-7.5,'NULL');

%a := Symbol::subScript(a, b);

blu = text(x_axis3-13.1,y_axis3-1,'A_{n}] / [A_{n}');
set(blu,'FontSize',8);
set(blu,'FontWeight','bold');
blu = text(x_axis3-11,y_axis3-1,'An Amino acid with its index');
set(blu,'FontSize',9.5);


blu_S = text(x_axis3-13,y_axis3-2.9,'Mass Differnce between Experimental and Theoretical Peaks');
set(blu_S,'FontWeight','bold');
set(blu_S,'FontSize',9.5);
set(blu_S,'color','[0 0 0]');

blu_S = text(x_axis3-3,y_axis3-1,'Experimental Mass');
set(blu_S,'FontWeight','bold');
set(blu_S,'FontSize',9.5);
set(blu_S,'color','[0.5 0 0]');

blu_S = text(x_axis3+2.5,y_axis3-1,'Theoretical Mass');
set(blu_S,'FontWeight','bold');
set(blu_S,'FontSize',9.5);
set(blu_S,'color','[0,0.5,0]')


varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2
