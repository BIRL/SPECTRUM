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

function TolExt = MW_Filter_modifier_Variable(Protein_sequence,Variable_Modifications)
TolExt=0;
All_Fixed_PTMs = {};
newline = sprintf('\r');
Sequence = strrep(Protein_sequence, newline,'');
Fixed = {};
number_of_Variable_mods = numel(Variable_Modifications);
for Variable_modification_idx = 1 : number_of_Variable_mods
    Site_Idx = strfind(Variable_Modifications{Variable_modification_idx,1},'_');
    Site_Idx = Site_Idx(numel(Site_Idx));
    Site = Variable_Modifications{Variable_modification_idx,1}(Site_Idx+1);
    no_of_occournaces_F = length(strfind(Sequence,Site));
    if no_of_occournaces_F > 0
        Fixed.occournaces = no_of_occournaces_F;
        Fixed.Site = Site;
        Fixed.ModW = GetWeight(Variable_Modifications{Variable_modification_idx,1}(1:Site_Idx-1));
        All_Fixed_PTMs = [All_Fixed_PTMs Fixed]; %#ok<*AGROW>    %Updated 20200803
    end 
end
for index = 1:numel(All_Fixed_PTMs)
    TolExt = TolExt + (All_Fixed_PTMs{1,index}.occournaces*All_Fixed_PTMs{1,index}.ModW);
end
end