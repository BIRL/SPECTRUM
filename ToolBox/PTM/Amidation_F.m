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

function Sites = Amidation_F(protein_sequence, PTM_tolerance)


PTM_tolerance = str2double(PTM_tolerance);
Sites = {};

mod_weight = -0.984016;
mod_name = 'Amidation';  %%Updated 20200426
site = 'F';
x=0;

% variable score is initialized
score = 0;

%Variable to store total number of Phenylalanine
TotalPhe = 0;

%Varible to store sub-sequence of protein
AA = [];

for i = 1:size(protein_sequence, 2);
    if protein_sequence (1, i) == 'F';
        TotalPhe = TotalPhe + 1;
        
        
        %variables to store sub-sequence
        a='';b='';c='';d='';e='';f='';
        
        
        %it will score amino acid at position i-1
        if(i-1>0)
            
            f=(protein_sequence (1, i-1));
            switch protein_sequence (1, i-1)
                
                case {'A' 'I' 'L' 'K' 'S' 'T' 'V'}
                    score = 0.01;
                case {'G'}
                    score = 0.02;
                case {'H'}
                    score = 0.03;
                case {'D'}
                    score = 0.15;
                case {'R'}
                    score = 0.72;
                case {'N' 'C' 'E' 'Q' 'M' 'F' 'P' 'W' 'Y'};
                    score = 0;
                    
                    
            end
        end
        
        %it will score amino acid at position i-2
        if(i-2>0)
            
            e=(protein_sequence (1, i-2));
            switch protein_sequence (1, i-2)
                
                case {'A' 'R' 'C' 'T' 'Y' 'V'} ;
                    score = score * 0.01;
                case {'D' 'Q' 'H' 'K' 'P' 'S'};
                    score = score * 0.02;
                case {'E' 'F'};
                    score = score * 0.03;
                case {'I'};
                    score = score * 0.04;
                case {'G'};
                    score = score * 0.21;
                case {'L'};
                    score = score * 0.22;
                case {'M'};
                    score = score * 0.29;
                case {'N' 'W'};
                    score = score * 0;
                    
                    
            end
        end
        
        
        %it will score amino acid at position i-3
        if(i-3>0)
            
            d=(protein_sequence (1, i-3));
            switch protein_sequence (1, i-3)
                
                case {'M'}
                    score = score * 0.01;
                case {'D' 'G' 'H' 'L' 'P'}
                    score = score * 0.02;
                case {'A'}
                    score = score * 0.03;
                case {'V'}
                    score = score * 0.04;
                case {'R' 'K' 'S' 'Y'}
                    score = score * 0.05;
                case {'Q'}
                    score = score * 0.16;
                case {'F'}
                    score = score * 0.32;
                case {'W'}
                    score = score * 0.14;
                case {'N' 'C' 'E' 'T' 'I'}
                    score = score * 0;
                    
                    
                    
            end
        end
        
        
        %it will score amino acid at position i-4
        if(i-4>0)
            
            c=(protein_sequence (1, i-4));
            switch protein_sequence (1, i-4)
                case {'Q' 'K' 'M' 'T' 'V'}
                    score = score * 0.01;
                case {'I' 'S' 'W'}
                    score = score * 0.02;
                case {'E' 'F'};
                    score = score * 0.03;
                case {'A'};
                    score = score * 0.05;
                case {'R' 'N'};
                    score = score * 0.08;
                case {'P' 'L'};
                    score = score * 0.11;
                case {'D'};
                    score = score * 0.19;
                case {'G'};
                    score = score * 0.2;
                case {'C' 'H' 'Y'};
                    score = score * 0;
                    
            end
        end
        
        
        %it will score amino acid at position i-5
        if(i-5>0)
            
            b=(protein_sequence (1, i-5));
            switch protein_sequence (1, i-5)
                
                case {'I'};
                    score = score * 0.01;
                case {'L'};
                    score = score * 0.02;
                case {'N' 'H' 'F' 'W' 'V'};
                    score = score * 0.03;
                case {'M'};
                    score = score * 0.04;
                case {'A' 'G' 'Q' 'Y'};
                    score = score * 0.05;
                case {'R' 'P'};
                    score = score * 0.06;
                case {'T' 'S'};
                    score = score * 0.07;
                case {'K'};
                    score = score * 0.09;
                case {'D'};
                    score = score * 0.1;
                case {'C'};
                    score = score * 0;
                case {'E'}
                    score = score * 0.16;
                    
                    
            end
        end
        
        
        %it will score amino acid at position i-6
        if(i-6>0)
            a=(protein_sequence (1, i-6));
            switch protein_sequence (1, i-6)
                
                case {'C' 'L' 'T' 'W'}
                    score = score * 0.01;
                case {'I' 'M' 'V'}
                    score = score * 0.02;
                case {'H'}
                    score = score * 0.03;
                case {'A' 'N' 'E' 'P'}
                    score = score * 0.06;
                case {'Q' 'S'}
                    score = score * 0.07;
                case {'K'}
                    score = score * 0.08;
                case {'G'}
                    score = score * 0.09;
                case {'Y'}
                    score = score * 0.1;
                case {'R' 'D'}
                    score = score * 0.11;
                case {'F'}
                    score =score * 0;
                    
            end
        end
        
        
        % score scalling according to maximum score
        %         score = score /1.79;
        %         // Amidation_F
        min = 0;
        max = 0.11 * 0.16 * 0.19 * 0.32 * 0.29 * 0.72;
        norm_factor = log10(max);
        if (score == 0)
            score = 0;
        else
            score = norm_factor / log10(score);
        end
        
        
        %it stores the protein sub-sequence
        
        if (score>=PTM_tolerance)
            
            %it stores the protein sub-sequence
            AA = [ a, b, c, d, e, f, (protein_sequence (1, i))];
            
            
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
