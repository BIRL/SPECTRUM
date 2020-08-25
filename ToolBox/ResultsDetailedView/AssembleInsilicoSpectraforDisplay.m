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

Matches = getappdata(0,'Matches');
Fragments_Peaklist_Data = getappdata(0,'Peaklist_Data');

Terminal_Modification = getappdata(0,'Othermodification_Terminal');
NME = Terminal_Modification(2);
NME_Acetylation = Terminal_Modification(3);

Index = getappdata(0,'Rank');
Match = Matches{Index,1};
Fragmentation_Type = getappdata(0,'Fragmentation_type');
name = [];
ID = [];
mz = [];
thr = [];
Err = [];
Left = Match.LeftIons;
Right = Match.RightIons;
for LeftIndex = 1 : numel(Match.LeftMatched_Index)
    if strcmp (Match.LeftType{LeftIndex,1}, 'Left')
        if strcmp(Fragmentation_Type, 'ECD') || strcmp(Fragmentation_Type, 'ETD')
            name = [name;{'C'}]; %#ok<*AGROW>
        elseif strcmp(Fragmentation_Type, 'EDD') || strcmp(Fragmentation_Type, 'NETD')
            name = [name;{'A'}];
        else
            name = [name;{'B'}];
        end
    else
        name = [name; Match.LeftType{LeftIndex,1}];
        if strcmp(Match.LeftType{LeftIndex,1},'B''')
            Left = Match.LeftIons_bo;
        elseif strcmp(Match.LeftType{LeftIndex,1},'A''')
            Left = Match.LeftIons_ao;
        elseif strcmp(Match.LeftType{LeftIndex,1},'A*')
            Left = Match.LeftIons_astar;
        elseif strcmp(Match.LeftType{LeftIndex,1},'B*')
            Left = Match.LeftIons_bstar;
        end
    end
    xx = Match.LeftMatched_Index(LeftIndex);
    ID = [ID;xx];
    temp_thr = round ( Left(xx), 4 );     %Updated 20200826
    temp_mz = round ( Fragments_Peaklist_Data(Match.LeftPeak_Index(LeftIndex)), 4 );     %Updated 20200826
    temp_Err = round ( abs (temp_mz - temp_thr), 4 );     %Updated 20200826
    mz = [mz;temp_mz];
    thr = [thr; temp_thr];
    Err = [Err; temp_Err];
end

for RightIndex = numel(Match.RightMatched_Index):-1:1
    if strcmp (Match.RightType{RightIndex,1}, 'Right')
        if strcmp(Fragmentation_Type, 'ECD') || strcmp(Fragmentation_Type, 'ETD')
            name = [name;{'Z'}];
        elseif strcmp(Fragmentation_Type, 'EDD') || strcmp(Fragmentation_Type, 'NETD')
            name = [name;{'X'}];
        else
            name = [name;{'Y'}];
        end
    else
        name = [name; Match.RightType{RightIndex,1}];
        if strcmp(Match.RightType{RightIndex,1},'Z''')
            Right = Match.RightIons_zo;
        elseif strcmp(Match.RightType{RightIndex,1},'Z''''')
            Right = Match.RightIons_zoo;
        elseif strcmp(Match.RightType{RightIndex,1},'Y''')
            Right = Match.RightIons_yo;
        elseif strcmp(Match.RightType{RightIndex,1},'Y*')
            Right = Match.RightIons_ystar;
        end
        
    end
    rr = numel(Match.LeftIons)- Match.RightMatched_Index(RightIndex);
    ID = [ID;rr+2];
    temp_thr = round ( Right(Match.RightMatched_Index(RightIndex)), 4 );     %Updated 20200826
    temp_mz = round ( Fragments_Peaklist_Data(Match.RightPeak_Index(RightIndex)), 4 );     %Updated 20200826
    temp_Err = round ( abs (temp_mz - temp_thr), 4 );     %Updated 20200826
    mz = [mz;temp_mz];      %experimental_mz
    thr = [thr; temp_thr];  %theoretical_mz
    Err = [Err; temp_Err];
end

data = [];
for i = 1 : numel(mz)
    a = [num2cell(i) num2cell(ID(i))   cellstr(name(i,:))   num2cell(mz(i))  num2cell(thr(i))  num2cell(Err(i))];     %Updated 20200826
    data = [data;a];
end

%Setting up all values for MassSpectrumVisualization.m
setappdata(0,'fragmentation_id',ID);
setappdata(0,'fragmentation_ion',name);
setappdata(0,'experimental_mz',mz);
setappdata(0,'theoretical_mz',thr);
setappdata(0,'mass_difference',Err);