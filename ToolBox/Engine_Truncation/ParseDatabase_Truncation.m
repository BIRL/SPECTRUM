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
function [Candidate_ProteinsList] = ParseDatabase_Truncation(Protein_ExperimentalMW,MWTolerance,idx_file_dir,Tags_ladder)
 
bio_Object = BioIndexedFile('FASTA',idx_file_dir);
NumEntries = bio_Object.NumEntries;
Candidate_ProteinsList = {};
Filtered_Protein=0;

FilterPSTs = getappdata(0,'FilterPSTs');
noOfTags = numel(Tags_ladder);
 
for Num_Protein = 1: NumEntries
    Entry = getEntryByIndex(bio_Object,Num_Protein);
    
    %% Extract Sequence and Header
    NewLine_chars = strfind(Entry,char(10));
    Header = Entry(2:NewLine_chars(1)-1); % header is separated by first NewLine char - get header without Newline char
    Sequence = Entry(NewLine_chars(1)+1:end);
    Sequence = strrep(Sequence,char(10),''); % remove new line chars from sequence too
    Sequence = strrep(Sequence,char(13),''); % remove carriage return from sequence too
    DBProtein_MW = Return_Protein_MW(Sequence);
    
    
    if FilterPSTs == 1
        if (DBProtein_MW - Protein_ExperimentalMW) > MWTolerance
            for num = 1 : noOfTags % for number of tags in the tag ladder
                tag=Tags_ladder{1, num}{1, 1}; % search for tag in the sequence
                if ~isempty(strfind(Sequence,tag))
                    Filtered_Protein= Filtered_Protein+1; % Molecular Weight as filter
                    Candidate_ProteinsList{Filtered_Protein}{1} = Header;
                    Candidate_ProteinsList{Filtered_Protein}{2} = DBProtein_MW; %#ok<*AGROW>
                    Candidate_ProteinsList{Filtered_Protein}{3} = Sequence;
                    Candidate_ProteinsList{Filtered_Protein}{4} = 0; %store protein's MW score
                    break;
                end
            end
        end
    else
        if (DBProtein_MW - Protein_ExperimentalMW) > MWTolerance
            Filtered_Protein= Filtered_Protein+1; % Molecular Weight as filter
            Candidate_ProteinsList{Filtered_Protein}{1} = Header;
            Candidate_ProteinsList{Filtered_Protein}{2} = DBProtein_MW; %#ok<*AGROW>
            Candidate_ProteinsList{Filtered_Protein}{3} = Sequence;
            Candidate_ProteinsList{Filtered_Protein}{4} = 0; %store protein's MW score
        end
    end
    % initial List of candidate Proteins after applying
    
    
end
end

