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
function [Candidate_ProteinsList_Final] = FIlter_Truncated_Proteins(Candidate_ProteinsList, Tags_ladder)
FilterPSTs = getappdata(0,'FilterPSTs');
Candidate_ProteinsList_Final = cell(numel(Candidate_ProteinsList),1);
idx = 0;
noOfTags = numel(Tags_ladder);

if FilterPSTs == 1
    for i = 1:numel(Candidate_ProteinsList)
        Sequence =  Candidate_ProteinsList{i, 1}.Sequence;
        for num = 1 : noOfTags % for number of tags in the tag ladder
            tag=Tags_ladder{1, num}{1, 1}; % search for tag in the sequence
            if ~isempty(strfind(Sequence,tag))
                idx = idx + 1;
                Candidate_ProteinsList{i, 1}.LeftIons = Candidate_ProteinsList{i, 1}.LeftIons(1:numel(Candidate_ProteinsList{i, 1}.LeftIons)-1);
                Candidate_ProteinsList{i, 1}.RightIons = Candidate_ProteinsList{i, 1}.RightIons(1:numel(Candidate_ProteinsList{i, 1}.RightIons)-1);
                Candidate_ProteinsList_Final{idx} = Candidate_ProteinsList{i};
                break;
            end
        end
    end
else
    for i = 1:numel(Candidate_ProteinsList)
        idx = idx + 1;
        Candidate_ProteinsList{i, 1}.LeftIons = Candidate_ProteinsList{i, 1}.LeftIons(1:numel(Candidate_ProteinsList{i, 1}.LeftIons)-1);
        Candidate_ProteinsList{i, 1}.RightIons = Candidate_ProteinsList{i, 1}.RightIons(1:numel(Candidate_ProteinsList{i, 1}.RightIons)-1);
        Candidate_ProteinsList_Final{idx} = Candidate_ProteinsList{i};
    end
end
Candidate_ProteinsList_Final = Candidate_ProteinsList_Final(~cellfun('isempty', Candidate_ProteinsList_Final));
end