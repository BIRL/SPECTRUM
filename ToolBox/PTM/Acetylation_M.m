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

function Sites = Acetylation_M(protein_sequence, PTM_tolerance)

PTM_tolerance = str2double(PTM_tolerance);
Sites = {};

mod_weight = 42.0106;
mod_name = 'Acetylation';
site = 'M';

% variable score is initialized
score = 0;
x = 0;
%Variable to store total number of Methionine
TotalMet = 0;

%Varible to store sub-sequence of protein
AA = [];

for i = 1:size(protein_sequence, 2);
    
    if protein_sequence (1, i) == 'M';
        TotalMet = TotalMet + 1;
        
        score =0;
        %variables to store sub-sequence
        g='';h='';m='';j='';k='';l='';
        
        
        %It saves the score for i+1 position
        if(size(protein_sequence, 2)>=i+1)
            l=(protein_sequence (1, i+1));
            switch protein_sequence (1, i+1)
                
                case {'A' 'I' 'K' 'S' 'T'}
                    score = 0.01;
                case {'R' 'C' 'G' 'H' 'P' 'W' 'Y'}
                    score = 0;
                case {'N'}
                    score = 0.09;
                case {'D'}
                    score = 0.28;
                case {'E'}
                    score = 0.39;
                case {'Q' 'V'}
                    score = 0.03;
                case {'M' 'F'}
                    score = 0.04;
                case {'L'}
                    score = 0.12;
            end
        end
        
        %It saves the score for i+2 position
        if(size(protein_sequence, 2)>=i+2)
            
            k=(protein_sequence (1, i+2));
            switch protein_sequence (1, i+2)
                
                case {'A'}
                    score = score * 0.1;
                case {'R' 'I'}
                    score = score * 0.02;
                case {'N'}
                    score = score * 0.04;
                case {'D'}
                    score = score * 0.06;
                case {'C' 'H' 'M' 'F' 'W' 'Y'}
                    score = score * 0.01;
                case {'G'}
                    score = score * 0.09;
                case {'E' 'L'}
                    score = score * 0.08;
                case {'Q' 'T' 'V'}
                    score = score * 0.05;
                case {'K'}
                    score = score * 0.03;
                case {'P'}
                    score = score * 0.14;
                case {'S'}
                    score = score * 0.11;
            end
        end
        
        
        %It saves the score for i+3 position
        if(size(protein_sequence, 2)>=i+3)
            
            j=(protein_sequence (1, i+3));
            switch protein_sequence (1, i+3)
                
                case {'A' 'E' 'Q'}
                    score = score * 0.09;
                case {'N' 'G' 'S'}
                    score = score * 0.08;
                case {'R' 'Y'}
                    score = score * 0.02;
                case {'D'}
                    score = score * 0.05;
                case {'C' 'H'}
                    score = score * 0.01;
                case {'I' 'K'}
                    score = score * 0.04;
                case {'L' 'T' 'V'}
                    score = score * 0.07;
                case {'M' 'W'}
                    score = score * 0;
                case {'F'}
                    score = score * 0.03;
                case {'P'}
                    score = score * 0.06;
            end
        end
        
        %It saves the score for i+4 position
        if(size(protein_sequence, 2)>=i+4)  %Updated 20200924  Equal to Sign Added
            
            m=(protein_sequence (1, i+4));
            switch protein_sequence (1, i+4)
                
                
                case {'A' 'E' 'Q'}
                    score = score * 0.1;
                case {'R' 'H' 'Y'}
                    score = score * 0.02;
                case {'N'}
                    score = score * 0.03;
                case {'D' 'K'}
                    score = score * 0.05;
                case {'C' 'I'}
                    score = score * 0.06;
                case {'L' 'P' 'S' 'V'}
                    score = score * 0.07;
                case {'M' 'F'}
                    score = score * 0.01;
                case {'T'}
                    score = score * 0.04;
                case {'W'}
                    score = score * 0;
                case {'G'}
                    score = score * 0.08;
            end
        end
        
        
        %It saves the score for i+5 position
        if(size(protein_sequence, 2)>=i+5)
            
            h=(protein_sequence (1, i+5));
            switch protein_sequence (1, i+5)
                case {'A' 'Q'}
                    score = score * 0.07;
                case {'R' 'C' 'M' 'F'}
                    score = score * 0.02;
                case {'N' 'I'}
                    score = score * 0.03;
                case {'D' 'T' 'K'}
                    score = score * 0.05;
                case {'V'}
                    score = score * 0.04;
                case {'G' 'P'}
                    score = score * 0.08;
                case {'E' 'S'}
                    score = score * 0.11;
                case {'H' 'Y'}
                    score = score * 0.01;
                case {'L'}
                    score = score * 0.12;
                case {'W'}
                    score = score * 0;
            end
        end
        
        
        %It saves the score for i+6 position
        if(size(protein_sequence, 2)>=i+6)  %Updated 20200924  Equal to Sign Added
            g=(protein_sequence (1, i+6));
            switch protein_sequence (1, i+6)
                
                case {'A'}
                    score = score * 0.09;
                case {'R' 'Q' 'T'}
                    score = score * 0.04;
                case {'N'}
                    score = score * 0.02;
                case {'D'}
                    score = score * 0.05;
                case {'C' 'K' 'V'}
                    score = score * 0.06;
                case {'G'}
                    score = score * 0.08;
                case {'I' 'H' 'F' 'Y'}
                    score = score * 0.03;
                case {'L' 'S'}
                    score = score * 0.1;
                case {'M'}
                    score = score * 0.01;
                case {'P' 'E'}
                    score = score * 0.07;
                otherwise %W=0
                    score = 0;
                    
            end
        end
        
        %score scalling according to maximum score
        % score = score / 0.94;
        
        
        min = 0;
        max = 0.39 * 0.14 * 0.09 * 0.10 * 0.12 * 0.10;
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
