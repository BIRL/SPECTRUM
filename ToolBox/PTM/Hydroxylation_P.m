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

function Sites = Hydroxylation_P(protein_sequence, PTM_tolerance)

PTM_tolerance = str2double(PTM_tolerance);
Sites = {};

mod_weight = 15.9949;
mod_name = 'Hydroxylation';
site = 'P';
x=0;

% variable score is initialized
score = 0;

%Variable to store total number of Proline
TotalPro = 0;

%Varible to store sub-sequence of protein
AA = [];

for i = 1:size(protein_sequence, 2);
    if protein_sequence (1, i) == 'P';
        TotalPro = TotalPro + 1;
        
        
        %variables to store sub-sequence
        a='';b='';c='';d='';e='';f='';g='';h='';m='';j='';k='';l='';
        
        
        %It saves the score for i+1 position
        if(size(protein_sequence, 2)>=i+1)
            l=(protein_sequence (1, i+1));
            switch protein_sequence (1, i+1)
                
                case {'R' 'C' 'K' 'Y' 'V' 'I'}
                    score = 0.01;
                case {'A'}
                    score = 0.03;
                case {'G'}
                    score = 0.61;
                case {'P'}
                    score = 0.13;
                case {'T'}
                    score = 0.08;
                case {'S'}
                    score = 0.1;
                otherwise
                    score = 0;
                    
                    
            end
        end
        
        %It saves the score for i+2 position
        if(size(protein_sequence, 2)>=i+2)
            
            k=(protein_sequence (1, i+2));
            switch protein_sequence (1, i+2)
                
                case {'N' 'M'}
                    score = score * 0.01;
                case {'R' 'D' 'Q' 'H' 'I' 'F'}
                    score = score * 0.02;
                case {'L' 'K' 'V'}
                    score = score * 0.04;
                case {'S'}
                    score = score * 0.06;
                case {'G' 'E'}
                    score = score * 0.07;
                case {'T'}
                    score = score * 0.08;
                case {'A'}
                    score = score * 0.09;
                case {'Y'}
                    score = score * 0.12;
                case {'P'}
                    score = score * 0.25;
                otherwise
                    score = score * 0;
            end
        end
        
        
        %It saves the score for i+3 position
        if(size(protein_sequence, 2)>=i+3)
            
            j=(protein_sequence (1, i+3));
            switch protein_sequence (1, i+3)
                
                case {'E' 'I' 'L' 'M'}
                    score = score * 0.01;
                case {'N'}
                    score = score * 0.02;
                case {'G' 'V'}
                    score = score * 0.03;
                case {'T'}
                    score = score * 0.04;
                case {'Q'}
                    score = score * 0.05;
                case {'R' 'D' 'S'}
                    score = score * 0.06;
                case {'Y'}
                    score = score * 0.07;
                case {'K'}
                    score = score * 0.13;
                case {'A'}
                    score = score * 0.11;
                case {'P'}
                    score = score * 0.29;
                case {'H' 'C' 'F' 'W'}
                    score = score * 0;
            end
        end
        
        %It saves the score for i+4 position
        if(size(protein_sequence, 2)>=i+4)  %Updated 20200924  Equal to Sign Added
            
            m=(protein_sequence (1, i+4));
            switch protein_sequence (1, i+4)
                
                case {'R' 'D' 'C' 'I' 'M'}
                    score = score * 0.01;
                case {'V'}
                    score = score * 0.02;
                case {'T'}
                    score = score * 0.03;
                case {'S'}
                    score = score * 0.04;
                case {'A'}
                    score = score * 0.06;
                case {'K'}
                    score = score * 0.07;
                case {'P'}
                    score = score * 0.13;
                case {'G'}
                    score = score * 0.58;
                otherwise
                    score = score * 0;
                    
                    
                    
            end
        end
        
        
        %It saves the score for i+5 position
        if(size(protein_sequence, 2)>=i+5)
            
            h=(protein_sequence (1, i+5));
            switch protein_sequence (1, i+5)
                case {'H' 'M'}
                    score = score * 0.01;
                case {'N' 'Q' 'I' 'F' 'Y'}
                    score = score * 0.02;
                case {'D' 'V'}
                    score = score * 0.03;
                case {'R'}
                    score = score * 0.04;
                case {'L' 'S'}
                    score = score * 0.06;
                case {'G' 'E' 'K'}
                    score = score * 0.07;
                case {'T'}
                    score = score * 0.08;
                case {'A'}
                    score = score * 0.15;
                case {'P'}
                    score = score * 0.21;
                otherwise
                    score = score * 0;
                    
                    
                    
            end
        end
        
        
        %It saves the score for i+6 position
        if(size(protein_sequence, 2)>=i+6)  %Updated 20200924  Equal to Sign Added
            g=(protein_sequence (1, i+6));
            switch protein_sequence (1, i+6)
                
                case {'H' 'L' 'M'}
                    score = score * 0.01;
                case {'N' 'E' 'I'}
                    score = score * 0.02;
                case {'G' 'V'}
                    score = score * 0.03;
                case {'D'}
                    score = score * 0.04;
                case {'T' 'Q'}
                    score = score * 0.05;
                case {'S' 'Y'}
                    score = score * 0.07;
                case {'A' 'R'}
                    score = score * 0.08;
                case {'K'}
                    score = score * 0.12;
                case {'P'}
                    score = score * 0.29;
                otherwise
                    score = score * 0;
                    
            end
        end
        
        
        %it will score amino acid at position i-1
        if(i-1>0)
            
            f=(protein_sequence (1, i-1));
            switch protein_sequence (1, i-1)
                
                case {'N' 'D' 'H'}
                    score = score * 0.01;
                case {'Q' 'M'}
                    score = score * 0.02;
                case {'R' 'I' 'T' 'V'}
                    score = score * 0.03;
                case {'F'}
                    score = score * 0.04;
                case {'G' 'E'}
                    score = score * 0.05;
                case {'L'}
                    score = score * 0.06;
                case {'Y' 'S' 'K'}
                    score = score * 0.07;
                case {'A'}
                    score = score * 0.11;
                case {'P'}
                    score = score * 0.28;
                otherwise
                    score = score * 0;
                    
            end
        end
        
        %it will score amino acid at position i-2
        if(i-2>0)
            
            e=(protein_sequence (1, i-2));
            switch protein_sequence (1, i-2)
                
                case {'R' 'E' 'Q' 'I' 'K'}
                    score = score * 0.01;
                case {'L' 'V'}
                    score = score * 0.02;
                case {'T'}
                    score = score * 0.03;
                case {'Y'}
                    score = score * 0.06;
                case {'A'}
                    score = score * 0.07;
                case {'P' 'S'}
                    score = score * 0.08;
                case {'G'}
                    score = score * 0.6;
                otherwise
                    score = score * 0;
                    
            end
        end
        
        
        %it will score amino acid at position i-3
        if(i-3>0)
            
            d=(protein_sequence (1, i-3));
            switch protein_sequence (1, i-3)
                case {'Y'}
                    score = score * 0.01;
                case {'N' 'E' 'I' 'L' 'M'}
                    score = score * 0.02;
                case {'D' 'G' 'V'}
                    score = score * 0.03;
                case {'T'}
                    score = score * 0.04;
                case {'Q'}
                    score = score * 0.05;
                case {'K'}
                    score = score * 0.09;
                case {'R' 'S'}
                    score = score * 0.1;
                case {'A'}
                    score = score * 0.13;
                case {'P'}
                    score = score * 0.28;
                otherwise
                    score = score * 0;
                    
            end
        end
        
        
        %it will score amino acid at position i-4
        if(i-4>0)
            
            c=(protein_sequence (1, i-4));
            switch protein_sequence (1, i-4)
                case {'C' 'H' 'M'}
                    score = score * 0.01;
                case {'N' 'F'}
                    score = score * 0.02;
                case {'R' 'D' 'Q' 'I' 'T'}
                    score = score * 0.03;
                case {'V'}
                    score = score * 0.04;
                case {'L' 'S'}
                    score = score * 0.05;
                case {'Y' 'G'}
                    score = score * 0.07;
                case {'A'}
                    score = score * 0.08;
                case {'K' 'E'}
                    score = score * 0.09;
                case {'P'}
                    score = score * 0.25;
                otherwise
                    score = score * 0;
            end
        end
        
        
        %it will score amino acid at position i-5
        if(i-5>0)
            
            b=(protein_sequence (1, i-5));
            switch protein_sequence (1, i-5)
                
                case {'R' 'N' 'D' 'Q' 'Y' 'V'}
                    score = score * 0.01;
                case {'L'}
                    score = score * 0.02;
                case {'S'}
                    score = score * 0.03;
                case {'K' 'P'}
                    score = score * 0.06;
                case {'T'}
                    score = score * 0.08;
                case {'A'}
                    score = score * 0.09;
                case {'G'}
                    score = score * 0.58;
                otherwise
                    score = score * 0;
                    
            end
        end
        
        
        %it will score amino acid at position i-6
        if(i-6>0)
            a=(protein_sequence (1, i-6));
            switch protein_sequence (1, i-6)
                case {'N' 'E' 'I' 'M' 'Y'}
                    score = score * 0.02;
                case {'D' 'G' 'L' 'V'}
                    score = score * 0.03;
                case {'T'}
                    score = score * 0.04;
                case {'S'}
                    score = score * 0.05;
                case {'Q'}
                    score = score * 0.06;
                case {'R'}
                    score = score * 0.08;
                case {'K'}
                    score = score * 0.12;
                case {'A'}
                    score = score * 0.13;
                case {'P'}
                    score = score * 0.3;
                otherwise
                    score = score * 0;
            end
        end
        
        
        % score scalling according to maximum score
        %         score = score /4.52;
        % // Hydroxylation_P
        min = 0;
        max = 0.30 * 0.59 * 0.28 * 0.21 * 0.61 * 0.32 * 0.62 * 0.26 * 0.31 * 0.59 * 0.22 * 0.32;
        norm_factor = log10(max);
        if (score == 0)
            score = 0;
        else
            score = norm_factor / log10(score);
        end
        
        if (score>=PTM_tolerance)
            
            %it stores the protein sub-sequence
            AA = [a, b, c, d, e, f, (protein_sequence (1, i)),l,k,j,m,h,g];
            
            %             x = x * 1;
            %             Sites{x,1} = {i,score, mod_weight , mod_name, site, AA};
            %it displays position of Alanine along with the sub-sequence and
            
            data1 = {i,score, mod_weight , mod_name, site, AA};
            Sites = [Sites; data1];
            
            %score of Alanine at that position
        end
    end
    
end
end
