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
function [Candidate_ProteinsList] = ParseDatabaseBatch_Truncation(Candidate_ProteinsListFull,Protein_ExperimentalMW,MWTolerance,Tags_ladder)

Candidate_ProteinsList = {};
Filtered_Protein=0;
noOfTags = numel(Tags_ladder);
FilterPSTs = getappdata(0,'FilterPSTs');

if FilterPSTs == 1
    for Num_Protein = 1: numel(Candidate_ProteinsListFull)
        Sequence = Candidate_ProteinsListFull{Num_Protein}{3};
        DBProtein_MW = Candidate_ProteinsListFull{Num_Protein}{2};
        if (DBProtein_MW - Protein_ExperimentalMW) > MWTolerance
            for num = 1 : noOfTags % for number of tags in the tag ladder
                tag = Tags_ladder{1, num}{1, 1}; % search for tag in the sequence
                if ~isempty(strfind(Sequence,tag))
                    Filtered_Protein= Filtered_Protein+1; % Molecular Weight as filter
                    Candidate_ProteinsList{Filtered_Protein}{1} = Candidate_ProteinsListFull{Num_Protein}{1}; %#ok<*AGROW>
                    Candidate_ProteinsList{Filtered_Protein}{2} = Candidate_ProteinsListFull{Num_Protein}{2};
                    Candidate_ProteinsList{Filtered_Protein}{3} = Sequence;
                    Candidate_ProteinsList{Filtered_Protein}{4} = 0; %store protein's MW score
                    break;
                end
            end
        end
    end
else
    for Num_Protein = 1: numel(Candidate_ProteinsListFull)
        Sequence = Candidate_ProteinsListFull{Num_Protein}{3};
        DBProtein_MW = Candidate_ProteinsListFull{Num_Protein}{2};
        if (DBProtein_MW - Protein_ExperimentalMW) > MWTolerance
            Filtered_Protein= Filtered_Protein+1; % Molecular Weight as filter
            Candidate_ProteinsList{Filtered_Protein}{1} = Candidate_ProteinsListFull{Num_Protein}{1}; %#ok<*AGROW>
            Candidate_ProteinsList{Filtered_Protein}{2} = Candidate_ProteinsListFull{Num_Protein}{2};
            Candidate_ProteinsList{Filtered_Protein}{3} = Sequence;
            Candidate_ProteinsList{Filtered_Protein}{4} = 0; %store protein's MW score
        end
    end
end
end