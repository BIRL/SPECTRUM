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
function keepProtein = FIlter_Proteins_PST(Tags_ladder,Sequence)
keepProtein = 0;
noOfTags = numel(Tags_ladder);
for num = 1 : noOfTags % for number of tags in the tag ladder
    tag=Tags_ladder{1, num}{1, 1}; % search for tag in the sequence
    if ~isempty(strfind(Sequence,tag))
        keepProtein = 1;
        break;
    end
end
end