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
function Sites = O_linked_glycosylation_T(protein_sequence, PTM_tolerance)

PTM_tolerance = str2double(PTM_tolerance);
Sites = {};

mod_weight = 203.0794;
mod_name = 'O-linked-Glycosylation';
site = 'T';
x=0;

% variable score is initialized
score = 0;

%Variable to store total number of Threonine
TotalThr = 0;

%Varible to store sub-sequence of protein
AA = [];

for i = 1:size(protein_sequence, 2);
    if protein_sequence (1, i) == 'T';
        TotalThr = TotalThr + 1;
        
        
        %variables to store sub-sequence
        a='';b='';c='';d='';e='';f='';g='';h='';m='';j='';k='';l='';
        
        
        %It saves the score for i+1 position
        if(size(protein_sequence, 2)>=i+1)
            l=(protein_sequence (1, i+1));
            switch protein_sequence (1, i+1)
                
                case {'Y'}
                    score = 0.01;
                case {'N' 'I' 'M' 'F'}
                    score = 0.02;
                case {'D'}
                    score = 0.03;
                case {'R' 'G' 'E' 'L'}
                    score = 0.04;
                case {'K'}
                    score = 0.06;
                case {'P'}
                    score = 0.07;
                case {'Q' 'V'}
                    score = 0.08;
                case {'A'}
                    score = 0.1;
                case {'T'}
                    score = 0.14;
                case {'S'}
                    score = 0.17;
                case {'C' 'H' 'W'}
                    score = 0;
            end
        end
        
        %It saves the score for i+2 position
        if(size(protein_sequence, 2)>=i+2)
            
            k=(protein_sequence (1, i+2));
            switch protein_sequence (1, i+2)
                
                case {'N'}
                    score = score * 0.01;
                case {'D' 'E' 'Q' 'I' 'K' 'F'}
                    score = score * 0.02;
                case {'L'}
                    score = score * 0.03;
                case {'R' 'H'}
                    score = score * 0.04;
                case {'V'}
                    score = score * 0.06;
                case {'G'}
                    score = score * 0.08;
                case {'P'}
                    score = score * 0.13;
                case {'S' 'T'}
                    score = score * 0.15;
                case {'A'}
                    score = score * 0.17;
                case {'C' 'M' 'W' 'Y'}
                    score = score * 0;
                    
            end
        end
        
        
        %It saves the score for i+3 position
        if(size(protein_sequence, 2)>=i+3)
            
            j=(protein_sequence (1, i+3));
            switch protein_sequence (1, i+3)
                
                case {'C'}
                    score = score * 0.01;
                case {'D' 'I' 'K' 'M' 'F' 'Y'}
                    score = score * 0.02;
                case {'R' 'N'}
                    score = score * 0.03;
                case {'E'}
                    score = score * 0.04;
                case {'G'}
                    score = score * 0.05;
                case {'Q'}
                    score = score * 0.06;
                case {'L'}
                    score = score * 0.07;
                case {'T'}
                    score = score * 0.09;
                case {'V' 'P'}
                    score = score * 0.11;
                case {'S'}
                    score = score * 0.14;
                case {'H' 'W'}
                    score = score * 0;
                case {'A'}
                    score = score * 0.13;
            end
        end
        
        %It saves the score for i+4 position
        if(size(protein_sequence, 2)>=i+4)  %Updated 20200924  Equal to Sign Added
            
            m=(protein_sequence (1, i+4));
            switch protein_sequence (1, i+4)
                
                case {'Q'}
                    score = score * 0.01;
                case {'N' 'H' 'M' 'F'}
                    score = score * 0.02;
                case {'D' 'I'}
                    score = score * 0.03;
                case {'R' 'E' 'P' 'Y'}
                    score = score * 0.04;
                case {'L' 'K'}
                    score = score * 0.05;
                case {'G' 'V'}
                    score = score * 0.07;
                case {'A'}
                    score = score * 0.11;
                case {'S'}
                    score = score * 0.14;
                case {'T'}
                    score = score * 0.18;
                case {'C' 'W'}
                    score = score * 0;
                    
            end
        end
        
        
        %It saves the score for i+5 position
        if(size(protein_sequence, 2)>=i+5)
            
            h=(protein_sequence (1, i+5));
            switch protein_sequence (1, i+5)
                case {'C' 'H' 'F'}
                    score = score * 0.01;
                case {'N' 'D' 'E' 'Q' 'Y'}
                    score = score * 0.02;
                case {'G'}
                    score = score * 0.03;
                case {'R' 'L' 'K'}
                    score = score * 0.08;
                case {'I' 'V'}
                    score = score * 0.09;
                case {'A' 'P'}
                    score = score * 0.11;
                case {'S' 'T'}
                    score = score * 0.1;
                case {'W' 'M'}
                    score = score * 0;
                    
            end
        end
        
        
        %It saves the score for i+6 position
        if(size(protein_sequence, 2)>=i+6)  %Updated 20200924  Equal to Sign Added
            g=(protein_sequence (1, i+6));
            switch protein_sequence (1, i+6)
                
                case {'N' 'D' 'M'}
                    score = score * 0.01;
                case {'C' 'F' 'Y'}
                    score = score * 0.02;
                case {'L'}
                    score = score * 0.03;
                case {'E' 'V'}
                    score = score * 0.04;
                case {'R' 'I'}
                    score = score * 0.05;
                case {'Q' 'H'}
                    score = score * 0.06;
                case {'G' 'K'}
                    score = score * 0.07;
                case {'A'}
                    score = score * 0.08;
                case {'P'}
                    score = score * 0.09;
                case {'T'}
                    score = score * 0.13;
                case {'S'}
                    score = score * 0.14;
                case {'W'}
                    score = score * 0;
                    
                    
                    
            end
        end
        
        
        %it will score amino acid at position i-1
        if(i-1>0)
            
            f=(protein_sequence (1, i-1));
            switch protein_sequence (1, i-1)
                
                case {'D' 'H' 'F'}
                    score = score * 0.01;
                case {'C' 'E' 'M'}
                    score = score * 0.02;
                case {'R'}
                    score = score * 0.03;
                case {'I' 'L' 'K'}
                    score = score * 0.04;
                case {'Q'}
                    score = score * 0.05;
                case {'G'}
                    score = score * 0.06;
                case {'A'}
                    score = score * 0.1;
                case {'P' 'S'}
                    score = score * 0.12;
                case {'T'}
                    score = score * 0.15;
                case {'V'}
                    score = score * 0.16;
                case {'W' 'Y' 'N'}
                    score = score * 0;
                    
                    
            end
        end
        
        %it will score amino acid at position i-2
        if(i-2>0)
            
            e=(protein_sequence (1, i-2));
            switch protein_sequence (1, i-2)
                
                case {'D' 'C' 'Y' 'E'}
                    score = score * 0.01;
                case {'N' 'H'}
                    score = score * 0.02;
                case {'R' 'I' 'F'}
                    score = score * 0.03;
                case {'Q'}
                    score = score * 0.04;
                case {'G' 'L'}
                    score = score * 0.07;
                case {'T'}
                    score = score * 0.08;
                case {'K' 'V'}
                    score = score * 0.09;
                case {'S'}
                    score = score * 0.11;
                case {'A'}
                    score = score * 0.12;
                case {'P'}
                    score = score * 0.16;
                case {'W' 'M'}
                    score = score * 0;
                    
            end
        end
        
        
        %it will score amino acid at position i-3
        if(i-3>0)
            
            d=(protein_sequence (1, i-3));
            switch protein_sequence (1, i-3)
                
                case {'E' 'H' 'W'}
                    score = score * 0.01;
                case {'N' 'D'}
                    score = score * 0.02;
                case {'G'}
                    score = score * 0.03;
                case {'Q' 'I'}
                    score = score * 0.04;
                case {'R' 'A' 'K'}
                    score = score * 0.05;
                case {'Y'}
                    score = score * 0.06;
                case {'L'}
                    score = score * 0.07;
                case {'T'}
                    score = score * 0.09;
                case {'S'}
                    score = score * 0.11;
                case {'V'}
                    score = score * 0.15;
                case {'P'}
                    score = score * 0.17;
                case {'C' 'M'}
                    score = score * 0;
            end
        end
        
        
        %it will score amino acid at position i-4
        if(i-4>0)
            
            c=(protein_sequence (1, i-4));
            switch protein_sequence (1, i-4)
                case {'H' 'M'}
                    score = score * 0.01;
                case {'N' 'I' 'Y'}
                    score = score * 0.02;
                case {'F'}
                    score = score * 0.03;
                case {'D' 'G' 'L' 'V' 'R'}
                    score = score * 0.05;
                case {'E' 'Q' 'K'}
                    score = score * 0.06;
                case {'P'}
                    score = score * 0.07;
                case {'A'}
                    score = score * 0.1;
                case {'T'}
                    score = score * 0.13;
                case {'S'}
                    score = score * 0.15;
                case {'C' 'W'}
                    score = score * 0;
                    
            end
        end
        
        
        %it will score amino acid at position i-5
        if(i-5>0)
            
            b=(protein_sequence (1, i-5));
            switch protein_sequence (1, i-5)
                
                case {'M' 'Y'}
                    score = score * 0.01;
                case {'N' 'C' 'F'}
                    score = score * 0.02;
                case {'H'}
                    score = score * 0.03;
                case {'I' 'G' 'E'}
                    score = score * 0.04;
                case {'A' 'D' 'Q'}
                    score = score * 0.05;
                case {'V'}
                    score = score * 0.06;
                case {'L' 'K'}
                    score = score * 0.07;
                case {'S' 'R'}
                    score = score * 0.08;
                case {'P'}
                    score = score * 0.11;
                case {'T'}
                    score = score * 0.13;
                case {'W'}
                    score = score * 0;
            end
        end
        
        
        %it will score amino acid at position i-6
        if(i-6>0)
            a=(protein_sequence (1, i-6));
            switch protein_sequence (1, i-6)
                
                case {'N'}
                    score = score * 0.01;
                case {'D' 'Q' 'H' 'M' 'F'}
                    score = score * 0.03;
                case {'R' 'I' 'L' 'V'}
                    score = score * 0.04;
                case {'E'}
                    score = score * 0.05;
                case {'G'}
                    score = score * 0.07;
                case {'K'}
                    score = score * 0.08;
                case {'A'}
                    score = score * 0.09;
                case {'P'}
                    score = score * 0.11;
                case {'S'}
                    score = score * 0.16;
                case {'T'}
                    score = score * 0.1;
                case {'W' 'Y' 'C'}
                    score = score * 0;
            end
        end
        
        
        % score scalling according to maximum score
        % // O_linked_glycosylation_T
        min = 0;
        max = 0.44 * 0.36 * 0.45 * 0.26 * 0.44 * 0.32 * 0.31 * 0.43 * 0.36 * 0.44 * 0.33 * 0.48;
        norm_factor = log10(max);
        if (score == 0)
            score = 0;
        else
            score = norm_factor / log10(score);
        end
        %it stores the protein sub-sequence
        AA = [a, b, c, d, e, f, (protein_sequence (1, i)),l,k,j,m,h,g];
        
        if (score>=PTM_tolerance)
            
            %it stores the protein sub-sequence
            AA = [a, b, c, d, e, f, (protein_sequence (1, i)),l,k,j,m,h,g];
            
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
