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

function [Candidate_ProteinsList_Decoy] = ParseDatabaseDecoy(InputDB)
bio_Object = BioIndexedFile('FASTA',InputDB);
NumEntries = bio_Object.NumEntries;
Candidate_ProteinsList_Decoy = [];

for Num_Protein = 1:NumEntries
    Entry = getEntryByIndex(bio_Object,Num_Protein);
    NewLine_chars = strfind(Entry,char(10));
    Header = Entry(2:NewLine_chars(1)-1); % header is separated by first NewLine char - get header without Newline char
    Sequence = Entry(NewLine_chars(1)+1:end);
    Sequence = strrep(Sequence,char(10),''); % remove new line chars from sequence too
    Sequence = strrep(Sequence,char(13),''); % remove carriage return from sequence too
    
    for i = 1:3
        if i == 1
            s = strcat('>XXX_', Header);
        elseif i == 2
            s = strcat('>YYY_', Header);
        else
            s = strcat('>ZZZ_', Header);
        end
        Protein.Header = s;
        
        AAs = 'ABCDEFGHIKLMNOPQRSTUVWYZ';
        numRands = length(AAs); 
        sLength = length(Sequence);
        randString = AAs( ceil(rand(1,sLength)*numRands));
        Protein.Sequence = randString;    
        Candidate_ProteinsList_Decoy = [Candidate_ProteinsList_Decoy; Protein];
    end
end
end