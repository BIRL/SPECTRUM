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

function Sites = Methylation_K(protein_sequence, PTM_tolerance)

PTM_tolerance = str2double(PTM_tolerance);
Sites = {};
%initial score
score = 0;

mod_weight = 14.0156;
mod_name = 'Methylation';
site = 'K';
x=0;

% Var to store total Lysine
TotalLys = 0;

%it will give us the sub-sequence
AA = [];

for i = 1:size(protein_sequence, 2);
    
    %variables to store sub-sequence
    b='';c='';d='';e='';f='';g='';h='';j='';k='';l='';m='';n='';
    
    if protein_sequence (1, i) == 'K';% it will check if amino acid at position i is 'R'
        TotalLys = TotalLys + 1;
        
        %it will score amino acid at position i-6
        if(i-6>0)
            b=(protein_sequence (1, i-6));
            switch protein_sequence (1, i-6)
                case {'A'}
                    score = 0.23;
                case {'D' 'C' 'Q' 'F'}
                    score = 0;
                case {'G' 'P'}
                    score = 0.11;
                case {'E' 'K' 'S'}
                    score = 0.05;
                case {'L' 'M' 'Y'}
                    score = 0.04;
                case {'T'}
                    score = 0.14;
                case {'V'}
                    score = 0.07;
                case {'R' 'N''H' 'I' 'W'}
                    score = 0.02;
            end
        end
        
        %it will score amino acid at position i-5
        if(i-5>0)
            c=(protein_sequence (1, i-5));
            switch protein_sequence (1, i-5)
                case {'A' 'G' 'S' 'T'}
                    score = score * 0.12;
                case {'R' 'N'}
                    score = score * 0.05;
                case {'D' 'H'}
                    score = score * 0.02;
                case {'C' 'Q' 'I' 'L' 'M' 'F' 'W' 'Y' 'V'}
                    score = score * 0;
                case {'E'}
                    score = score * 0.11;
                case {'K'}
                    score = score * 0.19;
                case {'P'}
                    score = score * 0.07;
            end
        end
        
        %it will score amino acid at position i-4
        if(i-4>0)
            d=(protein_sequence (1, i-4));
            switch protein_sequence (1, i-4)
                case {'A'}
                    score = score * 0.09;
                case {'R'}
                    score = score * 0.07;
                case {'N' 'V'}
                    score = score * 0.02;
                case {'D' 'G' 'L' 'F' 'S'}
                    score = score * 0.05;
                case {'C' 'E' 'H' 'P' 'T' 'Y'}
                    score = score * 0.04;
                case {'Q'}
                    score = score * 0.14;
                case {'K'}
                    score = score * 0.19;
                case {'I' 'M' 'W'}
                    score = score * 0;
            end
        end
        
        
        %it will score amino acid at position i-3
        if(i-3>0)
            e=(protein_sequence (1, i-3));
            switch protein_sequence (1, i-3)
                case {'A'}
                    score = score * 0.21;
                case {'R' 'V'}
                    score = score * 0.04;
                case {'N' 'C' 'E' 'Q' 'H' 'M' 'F' 'W' 'Y'}
                    score = score * 0;
                case {'D' 'K'}
                    score = score * 0.05;
                case {'G'}
                    score = score * 0.11;
                case {'I'}
                    score = score * 0.02;
                case {'L'}
                    score = score * 0.16;
                case {'P' 'S'}
                    score = score * 0.07;
                case {'T'}
                    score = score * 0.19;
            end
        end
        
        
        %it will score amino acid at position i-2
        if(i-2>0)
            f=(protein_sequence (1, i-2));
            switch protein_sequence (1, i-2)
                case {'A'}
                    score = score * 0.33;
                case {'R' 'H' 'P' 'S'}
                    score = score * 0.04;
                case {'N' 'K'}
                    score = score * 0.09;
                case {'D' 'E' 'I'}
                    score = score * 0.02;
                case {'C' 'Q' 'L' 'M' 'F' 'W' 'Y'}
                    score = score * 0;
                case {'G'}
                    score = score * 0.19;
                case {'T' 'V'}
                    score = score * 0.05;
            end
        end
        
        
        %it will score amino acid at position i-1
        if(i-1>0)
            g=(protein_sequence (1, i-1));
            switch protein_sequence (1, i-1)
                case {'A' 'C' 'S'}
                    score = score * 0.04;
                case {'R'}
                    score = score * 0.4;
                case {'N' 'Q' 'I' 'M' 'F' 'P' 'W' 'Y'}
                    score = score * 0;
                case {'D' 'H'}
                    score = score * 0.02;
                case {'G' 'E'}
                    score = score * 0.07;
                case {'L'}
                    score = score * 0.09;
                case {'K'}
                    score = score * 0.12;
                case {'T' 'V'}
                    score = score * 0.05;
            end
        end
        
        
        %it will score amino acid at position i+1
        if(size(protein_sequence, 2)>=i+1)
            h=(protein_sequence (1, i+1));
            switch protein_sequence (1, i+1)
                case {'A'}
                    score = score * 0.14;
                case {'R' 'D' 'I' 'F'}
                    score = score * 0.02;
                case {'N' 'G' 'E' 'L' 'M'}
                    score = score * 0.05;
                case {'C' 'H' 'P' 'W' 'Y'}
                    score = score * 0;
                case {'Q' 'T'}
                    score = score * 0.04;
                case {'K'}
                    score = score * 0.14;
                case {'S'}
                    score = score * 0.21;
                case {'V'}
                    score = score * 0.11;
            end
        end
        
        
        %it will score amino acid at position i+2
        if(size(protein_sequence, 2)>=i+2)
            j=(protein_sequence (1, i+2));
            switch protein_sequence (1, i+2)
                case {'A'}
                    score = score * 0.21;
                case {'R' 'N' 'D' 'Q' 'L' 'F' 'V'}
                    score = score * 0.04;
                case {'C' 'H' 'I' 'M' 'Y'}
                    score = score * 0;
                case {'G' 'P'}
                    score = score * 0.07;
                case {'E'}
                    score = score * 0.11;
                case {'K' 'S'}
                    score = score * 0.05;
                case {'T'}
                    score = score * 0.18;
                case {'W'}
                    score = score * 0.02;
            end
        end
        
        
        %it will score amino acid at position i+3
        if(size(protein_sequence, 2)>=i+3)
            k=(protein_sequence (1, i+3));
            switch protein_sequence (1, i+3)
                case {'A' 'S'}
                    score = score * 0.09;
                case {'R' 'D' 'Q' 'L' 'V'}
                    score = score * 0.05;
                case {'N' 'C' 'E' 'M' 'W' 'Y'}
                    score = score * 0;
                case {'G'}
                    score = score * 0.19;
                case {'H'}
                    score = score * 0.04;
                case {'I'}
                    score = score * 0.07;
                case {'P'}
                    score = score * 0.11;
                case {'K'}
                    score = score * 0.12;
                case {'F' 'T'}
                    score = score * 0.02;
            end
        end
        
        
        %it will score amino acid at position i+4
        if(size(protein_sequence, 2)>=i+4)
            l=(protein_sequence (1, i+4));
            switch protein_sequence (1, i+4)
                case {'A'}
                    score = score * 0.18;
                case {'R' 'D' 'E' 'K' 'S' 'Y'}
                    score = score * 0.05;
                case {'N' 'H' 'L' 'M' 'T'}
                    score = score * 0.02;
                case {'C' 'Q' 'W'}
                    score = score * 0;
                case {'G' }
                    score = score * 0.16;
                case {'I' 'V'}
                    score = score * 0.07;
                case {'P'}
                    score = score * 0.09;
                case {'F'}
                    score = score * 0.04;
            end
        end
        
        
        %it will score amino acid at position i+5
        if(size(protein_sequence, 2)>=i+5)
            m=(protein_sequence (1, i+5)); %Updated 20200426
            switch protein_sequence (1, i+5)
                case {'A'}
                    score = score * 0.11;
                case {'R' 'Q' 'S' 'Y'}
                    score = score * 0.04;
                case {'N' 'M'}
                    score = score * 0.02;
                case {'D' 'I' 'V'}
                    score = score * 0.05;
                case {'C' 'G' 'H' 'L' 'W'}
                    score = score * 0;
                case {'E' 'F'}
                    score = score * 0.09;
                case {'K'}
                    score = score * 0.18;
                case {'T'}
                    score = score * 0.14;
                case {'P'}
                    score = score * 0.07;
            end
        end
        
        
        %it will score amino acid at position i+6
        if(size(protein_sequence, 2)>=i+6)
            n=(protein_sequence (1, i+6));
            switch protein_sequence (1, i+6)
                case {'A' 'K'}
                    score = score * 0.19;
                case {'R' 'L' 'F' 'P' 'S' 'T'}
                    score = score * 0.04;
                case {'N' 'C' 'I'}
                    score = score * 0.02;
                case {'D'}
                    score = score * 0.11;
                case {'G' 'V'}
                    score = score * 0.12;
                case {'Q' 'E' 'H' 'M' 'W' 'Y'}
                    score = score * 0;
            end
        end
        
        
        %sCALLING THE SCORE ACCORDING TO MAXIMUM SCORE
        
        %         score = score / 2.71;
        %         // Methylation_K
        min = 0;
        max = 0.14 * 0.15 * 0.18 * 0.14 * 0.22 * 0.24 * 0.19 * 0.16 * 0.15 * 0.12 * 0.15 * 0.17;
        norm_factor = log10(max);
        if (score == 0)
            score = 0;
        else
            score = norm_factor / log10(score);
        end
        
        %it will store the protein sub-sequence in AA_a .
        
        if (score>=PTM_tolerance)
            
            %it stores the protein sub-sequence
            AA = [b ,c , d, e, f, g, (protein_sequence (1, i)), h, j ,k ,l ,m ,n];
            
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
