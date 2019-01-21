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
function [Candidate_ProteinsList] = LoadDatabaseBatch(idx_file_dir)
bio_Object = BioIndexedFile('FASTA',idx_file_dir);
NumEntries = bio_Object.NumEntries;
Candidate_ProteinsList = cell(NumEntries,1);

Blind.Start = -1;
Blind.End = -1;
Blind.Mass = -1;

for Num_Protein = 1: NumEntries
    Entry = getEntryByIndex(bio_Object,Num_Protein);
    
    %% Extract Sequence and Header
    NewLine_chars = strfind(Entry,char(10));
    Header = Entry(2:NewLine_chars(1)-1); % header is separated by first NewLine char - get header without Newline char
    Sequence = Entry(NewLine_chars(1)+1:end);
    Sequence = strrep(Sequence , char(10),''); % remove new line chars from sequence too
    Sequence = strrep(Sequence , char(13),''); % remove carriage return from sequence too
    
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
    
    
    %%
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
    
    Candidate_ProteinsList{Num_Protein} = Protein;
end
end