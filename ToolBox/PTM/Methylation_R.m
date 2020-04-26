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

function Sites = Methylation_R(protein_sequence, PTM_tolerance)


PTM_tolerance = str2double(PTM_tolerance);
% PTM_tolerance = 0.1;
Sites = {};
mod_weight = 14.0156;
mod_name = 'Methylation';
site = 'R';
x=0;
%initial score
score = 0;

% Var to store total argenine
TotalArg = 0;

%it will give us the sub-sequence
AA = [];

for i = 1:size(protein_sequence, 2); %loop will run over the whole protein length
    
    %variables to store sub-sequence
    b='';c='';d='';e='';f='';g='';h='';j='';k='';l='';m='';n='';
    
    if protein_sequence (1, i) == 'R';% it will check if amino acid at position i is 'R'
        TotalArg = TotalArg + 1;
        
        
        %it will score amino acid at position i-6
        if(i-6>0)
            b=(protein_sequence (1, i-6));
            switch protein_sequence (1, i-6)
                case {'A', 'I', 'M', 'Y', 'V'}
                    score =  0.03;
                case {'R'}
                    score =  0.15;
                case {'N' 'F'}
                    score =  0.02;
                case {'D' 'Q' 'L'}
                    score =  0.05;
                case {'G'}
                    score =  0.25;
                case {'E' 'K' 'T'}
                    score =  0.04;
                case {'H'}
                    score =  0.01;
                case {'P'}
                    score =  0.08;
                case {'S'}
                    score =  0.06;
                case { 'C' 'W'}
                    score =  0;
            end
        end
        
        %it will score amino acid at position i-5
        if(i-5>0)
            c=(protein_sequence (1, i-5));
            switch protein_sequence (1, i-5)
                case {'A'}
                    score = score * 0.09;
                case {'S' 'R'}
                    score = score * 0.1;
                case {'D' 'N' 'L' 'M' 'Y'}
                    score = score * 0.03;
                case {'G'}
                    score = score * 0.26;
                case {'E' 'V'}
                    score =  score * 0.04;
                case {'H' }
                    score =  score * 0.01;
                case {'I' 'K' 'T'}
                    score =  score * 0.02;
                case {'Q' 'F' 'P'}
                    score =  score * 0.05;
                case {'C' 'W'}
                    score =  score * 0;
                    
            end
        end
        
        %it will score amino acid at position i-4
        if(i-4>0)
            d=(protein_sequence (1, i-4));
            switch protein_sequence (1, i-4)
                case {'A' 'L'}
                    score =  score * 0.05;
                case {'R'}
                    score =  score * 0.19;
                case {'N' 'D' 'Q' 'F'}
                    score =  score * 0.03;
                case {'G'}
                    score =  score * 0.18;
                case {'E' 'K' 'T'}
                    score =  score * 0.04;
                case {'H'}
                    score =  score * 0.01;
                case {'I' 'M' 'V'}
                    score =  score * 0.02;
                case {'P'}
                    score =  score * 0.1;
                case {'S'}
                    score =  score * 0.08;
                case {'Y'}
                    score =  score * 0.06;
                case {'C' 'W'}
                    score =  score * 0;
            end
        end
        
        
        %it will score amino acid at position i-3
        if(i-3>0)
            e=(protein_sequence (1, i-3));
            switch protein_sequence (1, i-3)
                case {'A'}
                    score =  score * 0.06;
                case {'R' 'S'}
                    score =  score * 0.09;
                case {'N' 'L' 'M' 'Y'}
                    score =  score * 0.03;
                case {'D' 'E' 'T'}
                    score =  score * 0.02;
                case {'C' 'I'}
                    score =  score * 0.01;
                case {'G'}
                    score =  score * 0.29;
                case {'Q' 'K' 'F'}
                    score =  score * 0.05;
                case {'P'}
                    score =  score * 0.08;
                case {'V'}
                    score =  score * 0.04;
                case {'H' 'W'}
                    score =  score * 0;
            end
        end
        
        %it will score amino acid at position i-2
        if(i-2>0)
            f=(protein_sequence (1, i-2));
            switch protein_sequence (1, i-2)
                case {'A'}
                    score =  score * 0.1;
                case {'R'}
                    score =  score * 0.18;
                case {'N' 'C' 'H' 'F' 'T'}
                    score =  score * 0.01;
                case {'D' 'L' 'K' 'M' 'Y'}
                    score =  score * 0.03;
                case {'G'}
                    score =  score * 0.23;
                case {'E'}
                    score =  score * 0.05;
                case {'Q' 'I'}
                    score =  score * 0.02;
                case {'P' 'S'}
                    score =  score * 0.08;
                case {'V'}
                    score =  score * 0.04;
                case {'W'}
                    score =  score * 0;
            end
        end
        
        %it will score amino acid at position i-1
        if(i-1>0)
            g=(protein_sequence (1, i-1));
            switch protein_sequence (1, i-1)
                case {'A' 'L'}
                    score =  score * 0.05;
                case {'R'}
                    score =  score * 0.06;
                case {'N' 'I' 'F'}
                    score =  score * 0.03;
                case {'D'}
                    score =  score * 0.07;
                case {'G'}
                    score =  score * 0.32;
                case {'E' 'K' 'T' 'V' 'Y'}
                    score =  score * 0.02;
                case {'Q'}
                    score =  score * 0.04;
                case {'H' 'M'}
                    score =  score * 0.01;
                case {'P' 'S'}
                    score =  score * 0.1;
                case {'W' 'C'}
                    score =  score * 0;
            end
        end
        
        
        %it will score amino acid at position i+1
        if(size(protein_sequence, 2)>=i+1)
            h=(protein_sequence (1, i+1));
            switch protein_sequence (1, i+1)
                case {'A'}
                    score =  score * 0.07;
                case {'R'}
                    score =  score * 0.04;
                case {'N' 'H' 'I' 'T' 'Y'}
                    score =  score * 0.01;
                case {'D' 'E' 'Q' 'M' 'F' 'S' 'V'}
                    score =  score * 0.02;
                case {'G'}
                    score =  score * 0.56;
                case {'L'}
                    score =  score * 0.05;
                case {'K'}
                    score =  score * 0.03;
                case {'P'}
                    score =  score * 0.06;
                case {'W' 'C'}
                    score =  score * 0;
                    
            end
        end
        
        %it will score amino acid at position i+2
        if(size(protein_sequence, 2)>=i+2)
            j=(protein_sequence (1, i+2));
            switch protein_sequence (1, i+2)
                case {'A'}
                    score =  score * 0.07;
                case {'R'}
                    score =  score * 0.22;
                case {'N' 'C' 'M' 'W' 'Y'}
                    score =  score * 0.01;
                case {'D' 'E' 'H' 'I'}
                    score =  score * 0.02;
                case {'G'}
                    score =  score * 0.31;
                case {'Q'}
                    score =  score * 0.04;
                case {'L'}
                    score =  score * 0.06;
                case {'K' 'F' 'S' 'T' 'V'}
                    score =  score * 0.03;
                case {'P'}
                    score =  score * 0.05;
                    
            end
        end
        
        %it will score amino acid at position i+3
        if(size(protein_sequence, 2)>=i+3)
            k=(protein_sequence (1, i+3));
            switch protein_sequence (1, i+3)
                case {'A' 'P' 'S'}
                    score =  score * 0.08;
                case {'R' 'L'}
                    score =  score * 0.07;
                case {'N' 'D' 'V'}
                    score =  score * 0.03;
                case {'G'}
                    score =  score * 0.23;
                case {'E' 'M'}
                    score =  score * 0.04;
                case {'Q' 'H' 'K' 'T'}
                    score =  score * 0.02;
                case {'I'}
                    score =  score * 0.01;
                case {'F'}
                    score =  score * 0.09;
                case {'Y'}
                    score =  score * 0.05;
                case {'C' 'W'}
                    score =  score * 0;
            end
        end
        
        %it will score amino acid at position i+4
        if(size(protein_sequence, 2)>=i+4)
            l=(protein_sequence (1, i+4));
            switch protein_sequence (1, i+4)
                case {'A' 'S'}
                    score =  score * 0.06;
                case {'R'}
                    score =  score * 0.18;
                case {'N' 'M'}
                    score =  score * 0.02;
                case {'D' 'E' 'Q' 'L' 'K'}
                    score =  score * 0.04;
                case {'G'}
                    score =  score * 0.22;
                case {'H' 'I'}
                    score =  score * 0.05;
                case {'F' 'T' 'Y'}
                    score =  score * 0.03;
                case {'P'}
                    score =  score * 0.08;
                case {'V'}
                    score =  score * 0.05;
                case {'C' 'W'}
                    score =  score * 0;
            end
        end
        
        %it will score amino acid at position i+5
        if(size(protein_sequence, 2)>=i+5)
            m=(protein_sequence (1, i+5));  %Updated 20200426
            switch protein_sequence (1, i+5)
                case {'A'}
                    score =  score * 0.06;
                case {'R'}
                    score =  score * 0.09;
                case {'N' 'E' 'H' 'V'}
                    score =  score * 0.03;
                case {'D' 'L' 'K' 'F'}
                    score =  score * 0.04;
                case {'G'}
                    score =  score * 0.29;
                case {'Q' 'T'}
                    score =  score * 0.05;
                case {'I' 'M'}
                    score =  score * 0.02;
                case {'P' 'S'}
                    score =  score * 0.07;
                case {'Y'}
                    score =  score * 0.01;
                case {'C' 'W'}
                    score =  score * 0;
            end
        end
        
        %it will score amino acid at position i+6
        if(size(protein_sequence, 2)>=i+6)
            n=(protein_sequence (1, i+6));
            switch protein_sequence (1, i+6)
                case {'A' 'D' 'Q' 'L'}
                    score =  score * 0.05;
                case {'R'}
                    score =  score * 0.14;
                case {'N' 'E'}
                    score =  score * 0.04;
                case {'G'}
                    score =  score * 0.21;
                case {'H' 'I'}
                    score =  score * 0.01;
                case {'K' 'F' 'P'}
                    score =  score * 0.06;
                case {'M'}
                    score =  score * 0.03;
                case {'S'}
                    score =  score * 0.07;
                case {'T' 'W' 'Y' 'V'}
                    score =  score * 0.02;
                case {'C'}
                    score =  score * 0;
            end
        end
        
        %scalling the score according to maximum possible score
        %         score = score / 3.13;
        %         // Methylation_R
        min = 0;
        max = 0.25 * 0.26 * 0.19 * 0.29 * 0.23 * 0.32 * 0.56 * 0.31 * 0.23 * 0.22 * 0.29 * 0.21;
        norm_factor = log10(max);
        if (score == 0)
            score = 0;
        else
            score = norm_factor / log10(score);
        end
        if (score>=PTM_tolerance)
            %it will store the protein sub-sequence in AA_a .
            AA = [b ,c , d, e, f, g, (protein_sequence (1, i)), h, j ,k ,l ,m ,n];
            
            %             x = x + 1;
            %             Sites(x) = {i,score, mod_weight , mod_name, site, AA};
            data1 = {i,score, mod_weight , mod_name, site, AA};
            Sites = [Sites; data1];
            % it will display the position of argenine along with the sequence
            % and score for argenine at that position.
        end
    end
    
end

end
