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

function [Candidate_ProteinsList, Candidate_ProteinsListT] = ParseDatabaseBatch(Candidate_ProteinsListFull,Protein_ExperimentalMW,MWTolerance,Fixed_Modifications,Variable_Modifications,Tags_ladder)
Candidate_ProteinsList = cell(numel(Candidate_ProteinsListFull),1);
Filtered_Protein = 0;
MWeight=0;
TolExt=0;
truncation = getappdata(0,'Truncation');

if isempty(truncation)
    Candidate_ProteinsListT = [];
    for Num_Protein = 1: numel(Candidate_ProteinsListFull)
        Protein = Candidate_ProteinsListFull{Num_Protein};
        DBProtein_MW = Protein.MolW;
        
        % MW of proteins will be shifted to accomodate fixed and chemical mods
        if (~isempty(Fixed_Modifications) && ~isempty(Variable_Modifications))
            Sequence = Protein.Sequence;
            if (~isempty(Fixed_Modifications))
                MWeight = MW_Filter_modifier(Sequence,Fixed_Modifications);
            end
            % tolerance range will be extended to incorporate variably modified proteins
            if (~isempty(Variable_Modifications))
                TolExt = MW_Filter_modifier_Variable(Sequence,Variable_Modifications);
            end
        end
        
        if abs(DBProtein_MW + MWeight - Protein_ExperimentalMW)<= MWTolerance + TolExt
            Filtered_Protein= Filtered_Protein+1;
            Candidate_ProteinsList{Filtered_Protein} = Protein;
        end
    end
    Candidate_ProteinsList = Candidate_ProteinsList(~cellfun('isempty', Candidate_ProteinsList));
    
else %% For Truncation as well
    Candidate_ProteinsListT = cell(numel(Candidate_ProteinsListFull),1);
    FilterPSTs = getappdata(0,'FilterPSTs');
    noOfTags = numel(Tags_ladder);
    Truncated_Protein = 0;
    for Num_Protein = 1: numel(Candidate_ProteinsListFull)
        Protein = Candidate_ProteinsListFull{Num_Protein};
        Sequence = Protein.Sequence;
        DBProtein_MW = Protein.MolW;
        
        % MW of proteins will be shifted to accomodate fixed and chemical mods
        if (~isempty(Fixed_Modifications) && ~isempty(Variable_Modifications))
            if (~isempty(Fixed_Modifications))
                MWeight = MW_Filter_modifier(Sequence,Fixed_Modifications);
            end
            % tolerance range will be extended to incorporate variably modified proteins
            if (~isempty(Variable_Modifications))
                TolExt = MW_Filter_modifier_Variable(Sequence,Variable_Modifications);
            end
        end
        
        if abs(DBProtein_MW + MWeight - Protein_ExperimentalMW)<= MWTolerance + TolExt
            Filtered_Protein= Filtered_Protein+1;
            Candidate_ProteinsList{Filtered_Protein} = Protein;
        elseif (DBProtein_MW - Protein_ExperimentalMW) > MWTolerance
            if FilterPSTs == 1
                for TagNum = 1 : noOfTags % for number of tags in the tag ladder
                    tag=Tags_ladder{1, TagNum}{1, 1}; % search for tag in the sequence
                    if ~isempty(strfind(Sequence,tag))
                        Truncated_Protein= Truncated_Protein+1; % Molecular Weight as filter
                        Candidate_ProteinsListT{Truncated_Protein} = Protein;
                        %                         Candidate_ProteinsListT{Truncated_Protein}{4} = 0; %store protein's MW score
                        break;
                    end
                end
            else
                Truncated_Protein= Truncated_Protein+1; % Molecular Weight as filter
                Candidate_ProteinsListT{Truncated_Protein} = Protein;
                %                 Candidate_ProteinsListT{Truncated_Protein}{4} = 0; %store protein's MW score
            end
        end
    end
    Candidate_ProteinsList = Candidate_ProteinsList(~cellfun('isempty', Candidate_ProteinsList));
    Candidate_ProteinsListT = Candidate_ProteinsListT(~cellfun('isempty', Candidate_ProteinsListT));
end
end