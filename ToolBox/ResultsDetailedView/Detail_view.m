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

function varargout = Detail_view(varargin)
% DETAIL_VIEW MATLAB code for Detail_view.fig
%      DETAIL_VIEW, by itself, creates a new DETAIL_VIEW or raises the existing
%      singleton*.
%
%      H = DETAIL_VIEW returns the handle to a new DETAIL_VIEW or the handle to
%      the existing singleton*.
%
%      DETAIL_VIEW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DETAIL_VIEW.M with the given input arguments.
%
%      DETAIL_VIEW('Property','Value',...) creates a new DETAIL_VIEW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Detail_view_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Detail_view_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Detail_view

% Last Modified by GUIDE v2.5 13-Jan-2019 21:00:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Detail_view_OpeningFcn, ...
    'gui_OutputFcn',  @Detail_view_OutputFcn, ...
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


% --- Executes just before Detail_view is made visible.
function Detail_view_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Detail_view (see VARARGIN)

% Choose default command line output for Detail_view
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Detail_view wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Detail_view_OutputFcn(~, ~, handles)
%%
%%varibales contained data to be displayed
Tags_Ladder=getappdata(0,'Tags_Ladder');
Matches = getappdata(0,'Matches');
Fragments_Peaklist_Data = getappdata(0,'Peaklist_Data'); %#ok<*NASGU>
Index=getappdata(0,'Rank');
Match = Matches{Index,1};
index = getappdata(0,'Res');
Protein_Sequence=Match.Sequence;
Protein_Name=Match.Name;
Protein_ID=Match.Id;
Protein_Rank=index;
% AminoAcid_Matches= [num2str(Match.Match),' / ',num2str(length(Protein_Sequence))];
AminoAcid_Matches= [num2str(Match.Match)];
Protein_Score=Match.Final_Score;
Whole_Protein_Mass=Match.MolW;
Insilico = [];
BlindPTM = getappdata(0,'BlindPTM');
OriginalSequence = Match.OriginalSequence;
% OriginalSequence = 'MSITKDQIIEAVAAMSVMDVVELISAMEEKFGVSAAAAVAVAAGPVEAAEEKTEFDVILKAAGANKVAVIKAVRGATGLGLKEAKDLVESAPAALKEGVSKDDAEALKKALEEAGAEVEVK';
% OriginalSequence = 'MATMKDVARLAGVSTSTVSHVINKDRFVSEAITAKVEAAIKELNYAPSALARSLKLNQTHTIGMLITASTNPFYSELVRGVERSCFERGYSLVLCNTEGDEQRMNRNLETLMQKRVDGLLLLCTETHQPSREIMQRYPTVPTVMMDWAPFDGDSDLIQDNSLLGGDLATQYLIDKGHTRIACITGPLDKTPARLRLEGYRAAMKRAGLNIPDGYEVTGDFEFNGGFDAMRQLLSHPLRPQAVFTGNDAMAVGVYQALYQAELQVPQDIAVIGYDDIELASFMTPPLTTIHQPKDELGELAIDVLIHRITQPTLQQQRLQLTPILMERGSA';
% OriginalSequence = 'MPRSLKKGPFIDLHLLKKVEKAVESGDKKPLRTWSRRSTIFPNMIGLTIAVHNGRQHVPVFVTDEMVGHKLGEFAPTRTYRGHAADKKAKKK';
% Symbols_Modifications=[{'\varpi'},{texlabel('omega')},{texlabel('psi')},{texlabel('alpha')},{'\Theta'},{'\otimes'},{'\oplus'},{'\oslash'},{'\nabla'},{texlabel('Delta')},{'\clubsuit'},{'\heartsuit'},{'\spadesuit'},{'\diamondsuit'}];
% Name_Modifications=[{'Phos_Y'},{'Phos_T'},{'Phos_S'},{'Amid_F'},{'Acet_A'},{'Acet_K'},{'Acet_S'},{'Acet_R'},{'Meth_R'},{'Meth_K'},{'N-li_N'},{'O-li_S'},{'O-li_T'},{'Hydr_P'}];
symbols=[{'\varpi'},{texlabel('omega')},{texlabel('psi')},{texlabel('alpha')},{'\Theta'},{'\otimes'},{'\oplus'},{'\oslash'},{'\nabla'},{texlabel('Delta')},{'\clubsuit'},{'\heartsuit'},{'\spadesuit'},{'\diamondsuit'},{'\Re'},{'\zeta'},{'\perp'},{'\vee'},{'\omega'}];
Modifications=[{'Phosphorylation'},{'DiMethylation'},{'Methylation'},{'Acetylation'},{'Hydroxylation'},{'DiHydroxylation'},{'O-linked-Glycosylation'},{'Sulfoxide'},{'Glutathionylation'},{'Methylation_K'},{'S-Nitrosylation'},{'Palmitoylation'},{'Formylation'},{'Nitration'},{'N-linked-Glycosylation'},{'Sulfone'},{'Pyruvate'},{'Pyrrolidone-Aarboxylic-Acid'},{'Gamma-Carboxyglutamic-Acid'}];


Terminal_Modification = getappdata(0,'Othermodification_Terminal');
NME = Terminal_Modification(2);
NME_Acetylation = Terminal_Modification(3);

X_Axis_Position=0.6;
Y_Axis_Firstline=0.3;
Y_Axis_Secondline=-.4;
text(X_Axis_Position,Y_Axis_Firstline+0.8, '__________________________________________________________________________________________');
Display_Protein_Name=['>ID: ',Protein_ID,'                           Prot Name:  ',Protein_Name];
Display_Protein_Nameb=['                                                                                                         ID:  '];

format_Display_Protein_Name=text(X_Axis_Position-.1,Y_Axis_Firstline-0,Display_Protein_Name);
%format_Protein_ID=text(X_Axis_Position+.4,Y_Axis_Firstline-0,Display_Protein_Nameb);
set(format_Display_Protein_Name,'FontSize',10);
%set(format_Protein_ID,'FontSize',10);
set(format_Display_Protein_Name,'FontWeight','bold');
set(format_Display_Protein_Name,'color','b');
second_line=['  Mass:                                        Score:                                        Rank:                                       Matches:',]; %#ok<*NBRAK>
second_line2=['>             ',num2str(Whole_Protein_Mass) ,'                                     ',num2str(Protein_Score),'                                              ',num2str(Protein_Rank),'                                                       ',AminoAcid_Matches];
text(X_Axis_Position,Y_Axis_Secondline+0.01, '__________________________________________________________________________________________');
format_secondline=text(X_Axis_Position,Y_Axis_Secondline-0,second_line);
format_secondline2=text(X_Axis_Position-.1,Y_Axis_Secondline-0,second_line2);
set(format_secondline,'FontSize',9);
set(format_secondline,'FontWeight','bold');
set(format_secondline,'color','b');
set(format_secondline2,'FontSize',9);

%%

%::::::::::::::::::::display mass_protein::::::::::::::::::

X_Axis_Position_vertical_Line=1;

y1 = -2;
x_axis1 = 0.3;
y_axis1 = 1;


x_axis2 = -0.4;
y_axis2 = 1.3;

% % % % % x_axis3 = -0.2;
% % % % % y_axis3 = 0.8;

w2 = -0.1;
w3 = -0.3;
w4 = -1.0; % Coordinates weight: For Theoretical Mass display
w5 = -0.6; % Coordinates weight: For Experimental Mass display

%% PST determination
pst = [];
a = [];
for idx=1:length(Tags_Ladder)
    PST = strfind(Protein_Sequence, Tags_Ladder{1,idx}{1,1});
    if(~isempty(PST))
        a.start = PST;
        a.tag = Tags_Ladder{1,idx}{1,1};
        a.length = numel(a.tag);
        pst = [pst; a]; %#ok<*AGROW>
    end
end

setappdata(0,'pst',pst);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

xSeqConst = 1.5;
xNumConst = 2.3;

truncation = getappdata(0,'Truncation');
if isempty(truncation)
    truncation =0;
end

if strcmp(Match.Terminal_Modification, 'NME') || strcmp(Match.Terminal_Modification, 'NME_Acetylation')
    xSeq = xSeqConst + x_axis2;
    xNum = xNumConst + x_axis2;
    ySeq = w2-y_axis2;
    yNum = w3-y_axis2;
    handles.AA_sequence_disp=text(xSeq, ySeq, 'M');
    strikeThrough=text(xSeq-0.28, ySeq, '-----');
    set(strikeThrough,'color','r');
    set(strikeThrough,'FontWeight','bold');
    set(handles.AA_sequence_disp,'FontSize',11);
    x_axis1 = x_axis1+2.725;
    x_axis2 = x_axis2+2.725;
end

%% Left Truncation
if truncation == 1
    if strcmp(Match.Truncation, 'Left')
        for len=1:Match.TruncationIndex
            xSeq = xSeqConst + x_axis2;
            xNum = xNumConst + x_axis2;
            ySeq = w2-y_axis2;
            yNum = w3-y_axis2;
            handles.AA_sequence_disp=text(xSeq, ySeq, OriginalSequence(len));
            strikeThrough=text(xSeq-0.28, ySeq, '-----');
            set(strikeThrough,'color','r');
            set(strikeThrough,'FontWeight','bold');
            set(handles.AA_sequence_disp,'FontSize',11);
            x_axis1 = x_axis1+2.725;
            x_axis2 = x_axis2+2.725;
            
            if (rem( len , 15) == 0)
                x_axis1 = 0.3;
                x_axis2 = -0.4;
                
                y_axis1 = y_axis1 + 1.3;
                y_axis2 = y_axis2 + 1.3;
            end
            
        end
    end
end

%progressbar('Please wait! Constructing detailed candidate protein profile.');
%% Protein
for len=1:length(Protein_Sequence)
    %progressbar(len/length(Protein_Sequence));
    xSeq = xSeqConst + x_axis2;
    xNum = xNumConst + x_axis2;
    
    xThr = xSeqConst + x_axis2 + 0.1;
    xExp = xSeqConst + x_axis2 + 0.1;
    
    ySeq = w2-y_axis2;
    
    yThr = w4-y_axis2;
    yExp = w5-y_axis2;
    
    xRightThr = (xSeqConst + x_axis2 + 0.1);
    xRightExp = (xSeqConst + x_axis2 + 0.1);
    yRightThr = (w4-y_axis2 - 0.75);
    yRightExp = (w5-y_axis2 - 0.75);
    
    yNum = w3-y_axis2;
    handles.AA_sequence_disp=text(xSeq, ySeq, Protein_Sequence(len));
    handles.AA_number_disp=text(xNum, yNum, num2str(len));
    handles.Thr_mass_disp = text(xThr, yThr, '');
    handles.Exp_mass_disp = text(xExp, yExp, '');
    set(handles.Thr_mass_disp,'FontSize',7);
    set(handles.Exp_mass_disp,'FontSize',7);
    
    %% PST
    if(~isempty(pst))
        for idx = 1 : numel(pst)
            %idx
            if (len >= pst(idx).start(1,1) && len < pst(idx).start(1,1) + pst(idx).length)
                set(handles.AA_sequence_disp,'color','b')
            end
        end
    end
    
    set(handles.AA_number_disp,'FontSize',6.5);
    set(handles.AA_sequence_disp,'FontSize',11);
    if BlindPTM == 1
        if Match.Blind.Start ~= -1
            if Match.Blind.Start == len
                set(handles.AA_sequence_disp,'Color','m');
                set(handles.AA_number_disp,'Color', 'm');
                if rem(len,15) == 0
                    k=text((X_Axis_Position_vertical_Line+x_axis1-2.5),((y1-y_axis1)+2.1), num2str(Match.Blind.Mass));
                else
                    k=text((X_Axis_Position_vertical_Line+x_axis1-.5),((y1-y_axis1)+2.1), num2str(Match.Blind.Mass));
                end
                set(k,'FontSize', 11);
                set(k,'color','r');
            elseif len > Match.Blind.Start && len <= Match.Blind.End
                set(handles.AA_sequence_disp,'Color', 'm');
                set(handles.AA_number_disp,'Color', 'm');
            end
        end
    end
    %% Insilico
    
    handle_exp_mz = @insilico;
    PeakData = getappdata(0,'Peaklist_Data');
    %Left
    
    for leftI = 1 : numel(Match.LeftMatched_Index)
        if len == Match.LeftMatched_Index(leftI)
            
            tempLeftMatchedIndices = Match.LeftIons(Match.LeftMatched_Index);
            tempLeftPeakIndices = Match.LeftPeak_Index;
            
            if( len < 10)
                a = text(xSeq+1.3, ySeq, ']');
                handles.Exp_mass_disp = text(xExp, yExp, num2str(PeakData(tempLeftPeakIndices(leftI))));
                handles.Thr_mass_disp = text(xThr, yThr, num2str(tempLeftMatchedIndices(leftI)));
                
            elseif len > 9 && len <100
                a = text(xSeq+1.5, ySeq, ']');
                handles.Exp_mass_disp = text(xExp, yExp, num2str(PeakData(tempLeftPeakIndices(leftI))));
                handles.Thr_mass_disp = text(xThr, yThr, num2str(tempLeftMatchedIndices(leftI)));
            else
                a = text(xSeq+1.8, ySeq, ']');
                handles.Exp_mass_disp = text(xExp, yExp, num2str(PeakData(tempLeftPeakIndices(leftI))));
                handles.Thr_mass_disp = text(xThr, yThr, num2str(tempLeftMatchedIndices(leftI)));
            end
            
            set(a,'FontSize',16);
            set(handles.Exp_mass_disp,'FontSize',8);
            set(handles.Thr_mass_disp,'FontSize',8);
            
            set(handles.Exp_mass_disp,'color','[0.5 0 0]');
            set(handles.Thr_mass_disp,'color','[0,0.5,0]');
            break;
        end
    end
    
    %Right
    for rightI = 1 : numel(Match.RightMatched_Index)
        rr = numel(Match.Sequence)- Match.RightMatched_Index(rightI)+1;
        
        tempRightMatchedIndices = Match.RightIons(Match.RightMatched_Index);
        tempRightPeakIndices = Match.RightPeak_Index;
        
        if len == rr
            b = text(xSeq-0.5, ySeq, '[');
            
            handles.Exp_mass_disp = text(xRightExp, yRightExp, num2str(PeakData(tempRightPeakIndices(rightI))));
            handles.Thr_mass_disp = text(xRightThr, yRightThr, num2str(tempRightMatchedIndices(rightI)));

            set(b,'FontSize',16);
            set(handles.Exp_mass_disp,'FontSize',8);
            set(handles.Thr_mass_disp,'FontSize',8);
            set(handles.Exp_mass_disp,'color','[0.5 0 0]');
            set(handles.Thr_mass_disp,'color','[0,0.5,0]');
            break;
        end
    end
    
    %% PTM
    for ptmI = 1 : numel(Match.PTM_seq_idx)
        if len == Match.PTM_seq_idx(ptmI)
            name_mod=Match.PTM_name(ptmI);
            for bi=1:numel(symbols)
                if(strcmp(Modifications(bi),name_mod))
                    id_sym=bi;
                end
            end
            k=text((X_Axis_Position_vertical_Line+x_axis1-.2),((y1-y_axis1)+2), symbols(id_sym));
            set(k,'FontSize',12);
            set(k,'FontWeight','bold');
            set(k,'color','r');
        end
    end
    %     end
    x_axis1 = x_axis1+2.725;
    x_axis2 = x_axis2+2.725;
    
    if (rem( len , 15) == 0)
        x_axis1 = 0.3;
        x_axis2 = -0.4;
        
        y_axis1 = y_axis1 + 2.8; % For increasing the distance in between sequence [GUI]
        y_axis2 = y_axis2 + 2.8; % For increasing the distance in between sequence [GUI]
    end
    
end

%% Right Truncation
if truncation == 1
    if strcmp(Match.Truncation, 'Right')
        if strcmp(Match.Terminal_Modification, 'NME') || strcmp(Match.Terminal_Modification, 'NME_Acetylation')
            start = Match.TruncationIndex+2;
        else
            start = Match.TruncationIndex+1;
        end
        for len=start:length(OriginalSequence)
            xSeq = xSeqConst + x_axis2;
            xNum = xNumConst + x_axis2;
            ySeq = w2-y_axis2;
            yNum = w3-y_axis2;
            handles.AA_sequence_disp=text(xSeq, ySeq, OriginalSequence(len));
            strikeThrough=text(xSeq-0.28, ySeq, '-----');
            set(strikeThrough,'color','r');
            set(strikeThrough,'FontWeight','bold');
            set(handles.AA_sequence_disp,'FontSize',11);
            x_axis1 = x_axis1+2.725;
            x_axis2 = x_axis2+2.725;
            
            if (rem( len , 15) == 0)
                x_axis1 = 0.3;
                x_axis2 = -0.4;
                
                y_axis1 = y_axis1 + 1.3;
                y_axis2 = y_axis2 + 1.3;
            end
        end
    end
end


set(handles.slider2,'Value',1);

setappdata(0,'Match', Match);
clc
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider2_Callback(hObject, ~, handles) %#ok<*DEFNU>
b = get(hObject,'Value');
a=1-b-0.02;
OriginalSequence = 'MATMKDVARLAGVSTSTVSHVINKDRFVSEAITAKVEAAIKELNYAPSALARSLKLNQTHTIGMLITASTNPFYSELVRGVERSCFERGYSLVLCNTEGDEQRMNRNLETLMQKRVDGLLLLCTETHQPSREIMQRYPTVPTVMMDWAPFDGDSDLIQDNSLLGGDLATQYLIDKGHTRIACITGPLDKTPARLRLEGYRAAMKRAGLNIPDGYEVTGDFEFNGGFDAMRQLLSHPLRPQAVFTGNDAMAVGVYQALYQAELQVPQDIAVIGYDDIELASFMTPPLTTIHQPKDELGELAIDVLIHRITQPTLQQQRLQLTPILMERGSA';
pos=get(handles.axes1,'Position');
Matches=getappdata(0,'Matches');
index=getappdata(0,'Rank');
truncation = getappdata(0,'Truncation');

if isempty(truncation)
    truncation =0;
end

if truncation == 1
    Protein_Sequence= Matches{index}.OriginalSequence;
    len_pro=length(Protein_Sequence)-1;
    condition=ceil(len_pro/100);
else
    Protein_Sequence= Matches{index}.Sequence;
    len_pro=length(OriginalSequence)-1;
    condition=ceil(len_pro/100);
end
% display protein sequence
switch condition
    case 1
        set(handles.axes1,'Position',[pos(1) (a*30)+30 pos(3) pos(4)]);
    case 2
        set(handles.axes1,'Position',[pos(1) (a*60)+30 pos(3) pos(4)]);
    case 3
        set(handles.axes1,'Position',[pos(1) (a*80)+30 pos(3) pos(4)]);
    case 4
        set(handles.axes1,'Position',[pos(1) (a*160)+30 pos(3) pos(4)]);
    otherwise
        set(handles.axes1,'Position',[pos(1) (a*180)+30 pos(3) pos(4)]);
end


%30+(a*30)

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, ~, ~)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .6 .9]);
end

% --------to call legend
function uitoggletool2_OnCallback(~, ~, ~)
run('legend.m');

% --- Executes during object creation, after setting all properties.
function uipanel1_CreateFcn(~, ~, ~)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% --------------------------------------------------------------------
function Untitled_2_Callback(~, ~, ~)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function uitoggletool3_ClickedCallback(~, ~, ~)
% hObject    handle to uitoggletool3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run('Amino_Acid_Chart.m');


% --- Executes during object creation, after setting all properties.
function text_title_CreateFcn(hObject, ~, ~)
% hObject    handle to text_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
l=getappdata(0,'Title');
set(hObject,'String',l);



% --------------------------------------------------------------------
function uitoggletool5_ClickedCallback(~, ~, ~)
% hObject    handle to uitoggletool5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run('insilico.m');


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes when uipanel1 is resized.
function uipanel1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function uipushtool1_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run ('MassSpectrumVisualization.m');
run ('legend');
