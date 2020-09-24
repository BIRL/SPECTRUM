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

function Sites = O_linked_glycosylation_S(protein_sequence, PTM_tolerance)

PTM_tolerance = str2double(PTM_tolerance);
Sites = {};

mod_weight = 203.0794;
mod_name = 'O-linked-Glycosylation';
site = 'S';
x=0;

% variable score is initialized
score = 0;

%Variable to store total number of serine
TotalSer = 0;

%Varible to store sub-sequence of protein
AA = [];

for i = 1:size(protein_sequence, 2);
    if protein_sequence (1, i) == 'S';
        TotalSer = TotalSer + 1;
        
        
        %variables to store sub-sequence
        a='';b='';c='';d='';e='';f='';g='';h='';m='';j='';k='';l='';
        
        
        %It saves the score for i+1 position
        if(size(protein_sequence, 2)>=i+1)
            l=(protein_sequence (1, i+1));
            switch protein_sequence (1, i+1)
                
                case {'C' 'H' 'Y'};
                    score = 0.01;
                case {'D' 'I' 'K'};
                    score = 0.02;
                case {'Q' 'V'};
                    score = 0.03;
                case {'R'};
                    score = 0.04;
                case {'G'};
                    score = 0.06;
                case {'L'};
                    score = 0.07;
                case {'S'};
                    score = 0.09;
                case {'P'};
                    score = 0.1;
                case {'E'};
                    score = 0.16;
                case {'A'};
                    score = 0.14;
                case {'T'};
                    score = 0.2;
                case {'N' 'M' 'F' 'W'}
                    score = 0;
            end
        end
        
        %It saves the score for i+2 position
        if(size(protein_sequence, 2)>=i+2)
            
            k=(protein_sequence (1, i+2));
            switch protein_sequence (1, i+2)
                
                case {'D' 'K' 'M' 'F' 'W'}
                    score = score * 0.01;
                case {'Q' 'I' 'L'}
                    score = score * 0.02;
                case {'R' 'E'}
                    score = score * 0.03;
                case {'V'}
                    score = score * 0.05;
                case {'T'}
                    score = score * 0.07;
                case {'G'}
                    score = score * 0.11;
                case {'S'}
                    score = score * 0.12;
                case {'P' }
                    score = score * 0.17;
                case {'A'}
                    score = score * 0.3;
                case {'N' 'C' 'H' 'Y'}
                    score = score * 0;
                    
            end
        end
        
        
        %It saves the score for i+3 position
        if(size(protein_sequence, 2)>=i+3)
            
            j=(protein_sequence (1, i+3));
            switch protein_sequence (1, i+3)
                
                case {'R' 'N' 'C' 'M' 'F' 'Y'};
                    score = score * 0.01;
                case {'E' 'H'};
                    score = score * 0.02;
                case {'Q' 'L'};
                    score = score * 0.03;
                case {'I'};
                    score = score * 0.04;
                case {'G' 'V'};
                    score = score * 0.05;
                case {'S'};
                    score = score * 0.08;
                case {'D'};
                    score = score * 0.09;
                case {'T'};
                    score = score * 0.1;
                case {'A'};
                    score = score * 0.17;
                case {'W' 'K'}
                    score = score * 0;
                case {'P'}
                    score = score * 0.26;
            end
        end
        
        %It saves the score for i+4 position
        if(size(protein_sequence, 2)>=i+4)  %Updated 20200924  Equal to Sign Added
            
            m=(protein_sequence (1, i+4));
            switch protein_sequence (1, i+4)
                
                case {'R' 'E' 'M' 'W' 'Y' 'H'};
                    score = score * 0.01;
                case {'N' 'D' 'Q' 'K'};
                    score = score * 0.02;
                case {'I' 'L'};
                    score = score * 0.04;
                case {'G'};
                    score = score * 0.05;
                case {'A' 'V'};
                    score = score * 0.06;
                case {'S'};
                    score = score * 0.11;
                case {'T'};
                    score = score * 0.31;
                case {'P'};
                    score = score * 0.2;
                case {'C' 'F'};
                    score = score * 0;
                    
            end
        end
        
        
        %It saves the score for i+5 position
        if(size(protein_sequence, 2)>=i+5)
            
            h=(protein_sequence (1, i+5));
            switch protein_sequence (1, i+5)
                case {'C' 'M' 'F'};
                    score = score * 0.01;
                case {'N' 'D' 'E' 'I' 'K' 'Y'};
                    score = score * 0.02;
                case {'Q' 'H'};
                    score = score * 0.03;
                case {'V'};
                    score = score * 0.06;
                case {'L'};
                    score = score * 0.07;
                case {'S' 'T'};
                    score = score * 0.08;
                case {'R'};
                    score = score * 0.1;
                case {'G'};
                    score = score * 0.16;
                case {'P'};
                    score = score * 0.11;
                case {'A'};
                    score = score * 0.14;
                case {'W'};
                    score = score * 0;
                    
            end
        end
        
        
        %It saves the score for i+6 position
        if(size(protein_sequence, 2)>=i+6)  %Updated 20200924  Equal to Sign Added
            g=(protein_sequence (1, i+6));
            switch protein_sequence (1, i+6)
                
                case {'D' 'C' 'M' 'Y'};
                    score = score * 0.01;
                case {'E' 'I' 'K'};
                    score = score * 0.02;
                case {'Q'};
                    score = score * 0.03;
                case {'R'};
                    score = score * 0.04;
                case {'A' 'G' 'V'};
                    score = score * 0.05;
                case {'L'};
                    score = score * 0.07;
                case {'T'};
                    score = score * 0.09;
                case {'H'};
                    score = score * 0.1;
                case {'S'};
                    score = score * 0.12;
                case {'P'};
                    score = score * 0.29;
                case {'W' 'F' 'N'};
                    score = score * 0;
                    
                    
                    
            end
        end
        
        
        %it will score amino acid at position i-1
        if(i-1>0)
            
            f=(protein_sequence (1, i-1));
            switch protein_sequence (1, i-1)
                
                case {'R' 'N' 'E' 'H' 'K' 'M' 'Y'};
                    score = score * 0.01;
                case {'Q'};
                    score = score * 0.02;
                case {'L'};
                    score = score * 0.03;
                case {'I' 'F'};
                    score = score * 0.04;
                case {'A'};
                    score = score * 0.06;
                case {'V'};
                    score = score * 0.08;
                case {'S'};
                    score = score * 0.09;
                case {'G'};
                    score = score * 0.13;
                case {'P'};
                    score = score * 0.14;
                case {'T'}
                    score = score * 0.31;
                case {'W' 'C' 'D'};
                    score = score * 0;
                    
                    
            end
        end
        
        %it will score amino acid at position i-2
        if(i-2>0)
            
            e=(protein_sequence (1, i-2));
            switch protein_sequence (1, i-2)
                
                case {'C' 'D' 'H' 'I' 'M'};
                    score = score * 0.01;
                case {'R' 'Q' 'L' 'K' 'Y'};
                    score = score * 0.02;
                case {'E'};
                    score = score * 0.04;
                case {'N' 'G' 'T'};
                    score = score * 0.06;
                case {'S'};
                    score = score * 0.11;
                case {'V'};
                    score = score * 0.13;
                case {'P'};
                    score = score * 0.21;
                case {'A'};
                    score = score * 0.18;
                case {'W' 'F'}
                    score = score * 0;
                    
            end
        end
        
        
        %it will score amino acid at position i-3
        if(i-3>0)
            
            d=(protein_sequence (1, i-3));
            switch protein_sequence (1, i-3)
                
                case {'N' 'C' 'H' 'K' 'M' 'Y'};
                    score = score * 0.01;
                case {'R' 'Q' 'I' 'L' 'F'};
                    score = score * 0.02;
                case {'W'};
                    score = score * 0.03;
                case {'E'};
                    score = score * 0.04;
                case {'S' 'T' 'V'};
                    score = score * 0.07;
                case {'G'};
                    score = score * 0.12;
                case {'A'};
                    score = score * 0.14;
                case {'D'};
                    score = score * 0.15;
                case {'P'};
                    score = score * 0.16;
            end
        end
        
        
        %it will score amino acid at position i-4
        if(i-4>0)
            
            c=(protein_sequence (1, i-4));
            switch protein_sequence (1, i-4)
                case {'C' 'W' 'Y'};
                    score = score * 0.01;
                case {'R' 'Q' 'I' 'M' 'F' 'V' 'N'};
                    score = score * 0.02;
                case {'G' 'K'};
                    score = score * 0.04;
                case {'L' 'E'};
                    score = score * 0.05;
                case {'T'};
                    score = score * 0.07;
                case {'A'};
                    score = score * 0.08;
                case {'H'};
                    score = score * 0.09;
                case {'S'};
                    score = score * 0.11;
                case {'P'};
                    score = score * 0.16;
                case {'D'};
                    score = score * 0.14;
                    
            end
        end
        
        
        %it will score amino acid at position i-5
        if(i-5>0)
            
            b=(protein_sequence (1, i-5));
            switch protein_sequence (1, i-5)
                
                case {'N' 'H' 'F' 'Y'};
                    score = score * 0.01;
                case {'I' 'M'};
                    score = score * 0.02;
                case {'D' 'Q'};
                    score = score * 0.03;
                case {'V' 'L'};
                    score = score * 0.04;
                case {'E'};
                    score = score * 0.05;
                case {'K' 'S'};
                    score = score * 0.07;
                case {'P'};
                    score = score * 0.08;
                case {'T'};
                    score = score * 0.09;
                case {'R'};
                    score = score * 0.1;
                case {'A'};
                    score = score * 0.14;
                case {'G'};
                    score = score * 0.17;
                case {'C' 'W'};
                    score = score * 0;
            end
        end
        
        
        %it will score amino acid at position i-6
        if(i-6>0)
            a=(protein_sequence (1, i-6));
            switch protein_sequence (1, i-6)
                
                case {'M' 'Y'};
                    score = score * 0.01;
                case {'D' 'C' 'Q' 'H' 'K' 'F' 'W'};
                    score = score * 0.02;
                case {'R' 'N' 'I'};
                    score = score * 0.03;
                case {'E' 'V'};
                    score = score * 0.04;
                case {'G' 'L'};
                    score = score * 0.05;
                case {'A'};
                    score = score * 0.07;
                case {'P'};
                    score = score * 0.18;
                case {'S'};
                    score = score * 0.21;
                case {'T'};
                    score = score * 0.14;
                    
            end
        end
        
        
        % score scalling according to maximum score
        %         score = score /2.7;
        
        
        % // O_linked_glycosylation_S
        min = 0;
        max = 0.21 * 0.17 * 0.16 * 0.16 * 0.21 * 0.31 * 0.20 * 0.30 * 0.26 * 0.31 * 0.14 * 0.29;
        norm_factor = log10(max);
        if (score == 0)
            score = 0;
        else
            score = norm_factor / log10(score);
        end
        
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
