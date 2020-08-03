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

function [Candidate_ProteinsList, Candidate_ProteinsListT] = ParseDatabase(Protein_ExperimentalMW,MWTolerance,idx_file_dir,FilterDB,Fixed_Modifications,Variable_Modifications,Tags_ladder)
bio_Object = BioIndexedFile('FASTA',idx_file_dir);
MWeight=0;
TolExt=0;
NumEntries = bio_Object.NumEntries;
truncation = getappdata(0,'Truncation');
Truncated_Protein = 0;

Candidate_ProteinsList = cell(NumEntries,1);
Candidate_ProteinsListT = cell(NumEntries,1);
Filtered_Protein=0;
Truncated_Protein = 0;

Blind.Start = -1;
Blind.End = -1;
Blind.Mass = -1;

for Num_Protein = 1:NumEntries
    
    Entry = getEntryByIndex(bio_Object,Num_Protein);
    %% Extract Sequence and Header
    NewLine_chars = strfind(Entry,char(10));
    Header = Entry(2:NewLine_chars(1)-1); % header is separated by first NewLine char - get header without Newline char
    Sequence = Entry(NewLine_chars(1)+1:end);
    Sequence = strrep(Sequence,char(10),''); % remove new line chars from sequence too
    Sequence = strrep(Sequence,char(13),''); % remove carriage return from sequence too
    
    %% --- Calculate Molecular Weight of Database Protein
    [LeftIons, RightIons, mass] = Return_Protein_MW1(Sequence);
    
    Protein = {};
    Protein.Header = Header;
    Protein.Sequence = Sequence;
    Protein.OriginalSequence = Sequence;
    Protein.LeftIons = LeftIons;
    Protein.RightIons = RightIons;
    Protein.MolW = mass;
    Protein.MWScore = 0;
    Protein.Name = ''; %from database
    Protein.Id = ''; %from database
    Protein.EST_Score = 0;
    Protein.PTM_score = 0;
    Protein.PTM_name = '';
    Protein.PTM_seq_idx = -1;
    Protein.PTM_score = 0; %PTM score
    Protein.PTM_site = '';
    Protein.PTM_name = '';
    Protein.Terminal_Modification = 'None';
    Protein.TruncationIndex = -1;
    Protein.Truncation = 'None';
    Protein.Blind = Blind;
    Protein.LeftMatched_Index = [];
    Protein.RightMatched_Index = [];
    Protein.LeftPeak_Index = [];
    Protein.RightPeak_Index = [];
    Protein.LeftType = [];
    Protein.RightType = [];
    Protein.Match = 0;
    Protein.Match  = 0;
    Protein.Matches_Score = 0;
    Protein.Evalue = 0;
    DBProtein_MW = mass;
    
    if FilterDB
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
        
        if (truncation == 0)    %Updated 20200803
            if abs(DBProtein_MW + MWeight - Protein_ExperimentalMW)<= MWTolerance + TolExt
                Filtered_Protein= Filtered_Protein+1;
                Candidate_ProteinsList{Filtered_Protein} = Protein;
            end
            
        else %% For Truncation as well
            FilterPSTs = getappdata(0,'FilterPSTs');
            noOfTags = numel(Tags_ladder);
            
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
                            break;
                        end
                    end
                else
                    Truncated_Protein= Truncated_Protein+1; % Molecular Weight as filter
                    Candidate_ProteinsListT{Truncated_Protein} = Protein;
                end
            end
        end
    else
        Filtered_Protein= Filtered_Protein+1;
        Candidate_ProteinsList{Filtered_Protein} = Protein;
        Candidate_ProteinsListT{Filtered_Protein} = Protein;
    end
end
Candidate_ProteinsList = Candidate_ProteinsList(~cellfun('isempty', Candidate_ProteinsList));
Candidate_ProteinsListT = Candidate_ProteinsListT(~cellfun('isempty', Candidate_ProteinsListT));
end