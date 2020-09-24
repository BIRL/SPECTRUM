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

function Sites = Acetylation_A(protein_sequence, PTM_tolerance)

PTM_tolerance = str2double(PTM_tolerance);
Sites = {};
mod_weight = 42.0106;
mod_name = 'Acetylation';
site = 'A';

% variable score is initialized
score = 0;
x = 0;
%Variable to store total number of Alanine
TotalAla = 0;

%Varible to store sub-sequence of protein
AA = [];

for i = 1:size(protein_sequence, 2);
    
    if protein_sequence (1, i) == 'A';
        TotalAla = TotalAla + 1;
        
        
        %variables to store sub-sequence
        g='';h='';m='';j='';k='';l='';
        
        
        %It saves the score for i+1 position
        if(size(protein_sequence, 2)>=i+1)
            l=(protein_sequence (1, i+1));
            switch protein_sequence (1, i+1)
                
                case {'R' 'H' 'M' 'Y'};
                    score = 0.01;
                case {'N' 'C' 'K' 'F'};
                    score = 0.02;
                case {'L' 'V'};
                    score = 0.03;
                case {'Q'};
                    score = 0.04;
                case {'G'};
                    score = 0.06;
                case {'T'};
                    score = 0.09;
                case {'A'};
                    score = 0.24;
                case {'D'};
                    score = 0.11;
                case {'E' 'S'};
                    score = 0.14;
                case {'W' 'I' 'P'};
                    score = 0;
                otherwise
                    score = 0;
                    
            end
        end
        
        %It saves the score for i+2 position
        if(size(protein_sequence, 2)>=i+2)
            
            k=(protein_sequence (1, i+2));
            switch protein_sequence (1, i+2)
                
                case {'Y' 'M' 'H' 'C'};
                    score = score * 0.01;
                case {'I'};
                    score = score * 0.02;
                case {'R' 'K'};
                    score = score * 0.03;
                case {'D' 'N' 'F'};
                    score = score * 0.04;
                case {'T'};
                    score = score * 0.05;
                case {'E'};
                    score = score * 0.06;
                case {'G' 'V'};
                    score = score * 0.07;
                case {'Q' 'L' 'P'};
                    score = score * 0.08;
                case {'S'};
                    score = score * 0.09;
                case {'A'};
                    score = score * 0.17;
                case {'W'};
                    score = score * 0;
                otherwise
                    score = 0;
            end
        end
        
        
        %It saves the score for i+3 position
        if(size(protein_sequence, 2)>=i+3)
            
            j=(protein_sequence (1, i+3));
            switch protein_sequence (1, i+3)
                
                case {'C' 'W' 'M' 'Y'};
                    score = score * 0.01;
                case {'R' 'F' 'H'};
                    score = score * 0.02;
                case {'N' 'Q' 'I' 'K'};
                    score = score * 0.03;
                case {'T'};
                    score = score * 0.05;
                case {'D'};
                    score = score * 0.06;
                case {'E' 'V' 'L'};
                    score = score * 0.09;
                case {'G' 'S'};
                    score = score * 0.1;
                case {'A'};
                    score = score * 0.17;
                otherwise
                    score = 0;
            end
        end
        
        %It saves the score for i+4 position
        if(size(protein_sequence, 2)>=i+4)  %Updated 20200924  Equal to Sign Added
            
            m=(protein_sequence (1, i+4));
            switch protein_sequence (1, i+4)
                
                case {'H' 'M' 'W'};
                    score = score * 0.01;
                case {'N' 'K' 'F' 'Y'};
                    score = score * 0.02;
                case {'I'};
                    score = score * 0.03;
                case {'R' 'Q'};
                    score = score * 0.04;
                case {'D' 'L'};
                    score = score * 0.07;
                case {'P' 'S' 'V'};
                    score = score * 0.08;
                case {'G' 'T'};
                    score = score * 0.09;
                case {'E'};
                    score = score * 0.1;
                case {'A'};
                    score = score * 0.14;
                otherwise
                    score = 0;
                    
                    
                    
            end
        end
        
        
        %It saves the score for i+5 position
        if(size(protein_sequence, 2)>=i+5)
            
            h=(protein_sequence (1, i+5));
            switch protein_sequence (1, i+5)
                case {'C' 'W' 'H' 'M'};
                    score = score * 0.01;
                case {'I' 'F' 'Y'};
                    score = score * 0.02;
                case {'N'};
                    score = score * 0.03;
                case {'R' 'T'};
                    score = score * 0.04;
                case {'K' 'P'};
                    score = score * 0.05;
                case {'D' 'Q' 'V'};
                    score = score * 0.06;
                case {'G'};
                    score = score * 0.08;
                case {'E' 'S'};
                    score = score * 0.09;
                case {'A'};
                    score = score * 0.15;
                case {'L'};
                    score = score * 0.1;
                otherwise
                    score = 0;
                    
                    
                    
            end
        end
        
        
        %It saves the score for i+6 position
        if(size(protein_sequence, 2)>=i+6)  %Updated 20200924  Equal to Sign Added
            g=(protein_sequence (1, i+6));
            switch protein_sequence (1, i+6)
                
                case {'M'};
                    score = score * 0.01;
                case {'C' 'F' 'Y' 'H'};
                    score = score * 0.02;
                case {'R' 'N' 'Q' 'I'};
                    score = score * 0.04;
                case {'T' 'K'};
                    score = score * 0.05;
                case {'D'};
                    score = score * 0.06;
                case {'G'};
                    score = score * 0.07;
                case {'P' 'V' 'E' 'L'};
                    score = score * 0.08;
                case {'S'};
                    score = score * 0.1;
                case {'A'};
                    score = score * 0.12;
                otherwise
                    score = 0;
                    
            end
        end
        
        
        %score scalling according to higest score
        %score = score/0.99;
        
        min = 0;
        max = 0.24 * 0.17 * 0.17 * 0.14 * 0.15 * 0.12;
        norm_factor = log10(max);
        if (score == 0)
            score = 0;
        else
            score = norm_factor / log10(score);
        end
        
        
        if (score>=PTM_tolerance)
            
            %it stores the protein sub-sequence
            AA = [(protein_sequence (1, i)),l,k,j,m,h,g];
            
            %             x = x + 1;
            %             Sites{x,1} = {i,score, mod_weight , mod_name, site, AA};
            %it displays position of Alanine along with the sub-sequence and
            
            data1 = {i,score, mod_weight , mod_name, site, AA};
            Sites = [Sites; data1];
            
            %score of Alanine at that position
        end
    end
end
end
