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

function MWeight = MW_Filter_modifier(Protein_sequence,fixed_modifications)
MWeight=0;
All_Fixed_PTMs = {};
newline = sprintf('\r');
Sequence = strrep(Protein_sequence, newline,'');
Fixed = {};
Othermodification_Cysteine=getappdata(0,'Othermodification_Cysteine');% to get user defined chemical modifications on cysteine residue
if(~isempty(Othermodification_Cysteine))
    no_of_occournaces_C = length(strfind(Sequence,'C'));
    if no_of_occournaces_C > 0
        Fixed.occournaces = no_of_occournaces_C;
        Fixed.Site = 'C';
        Fixed.ModW = GetWeight(Othermodification_Cysteine);
    end
    All_Fixed_PTMs = [All_Fixed_PTMs Fixed];
end

Fixed = {};
Othermodification_Methionine=getappdata(0,'Othermodification_Methionine');% to get user defined chemical modifications on methionine residue
if(~isempty(Othermodification_Methionine))
    no_of_occournaces_M = length(strfind(Sequence,'M'));
    if no_of_occournaces_M > 0
        Fixed.occournaces = no_of_occournaces_M;
        Fixed.Site = 'M';
        Fixed.ModW = GetWeight(Othermodification_Methionine);
    end
    All_Fixed_PTMs = [All_Fixed_PTMs Fixed];
end

Fixed = {};
number_of_fixed_mods = numel(fixed_modifications);
for fixed_modification_idx = 1 : number_of_fixed_mods
    Site_Idx = strfind(fixed_modifications{fixed_modification_idx,1},'_');
    Site_Idx = Site_Idx(numel(Site_Idx));
    Site = fixed_modifications{fixed_modification_idx,1}(Site_Idx+1);
    no_of_occournaces_F = length(strfind(Sequence,Site));
    if no_of_occournaces_F > 0
        Fixed.occournaces = no_of_occournaces_F;
        Fixed.Site = Site;
        Fixed.ModW = GetWeight(fixed_modifications{fixed_modification_idx,1}(1:Site_Idx-1));
        All_Fixed_PTMs = [All_Fixed_PTMs Fixed]; %#ok<*AGROW>    %Updated 20200803
    end
end

for index = 1:numel(All_Fixed_PTMs)
    MWeight = MWeight + (All_Fixed_PTMs{1,index}.occournaces*All_Fixed_PTMs{1,index}.ModW);
end
end