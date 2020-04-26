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

function Sites = Phosphorylation_Y(protein_sequence, PTM_tolerance)

PTM_tolerance = str2double(PTM_tolerance);
Sites = {};
mod_weight = 79.9663;
mod_name = 'Phosphorylation';
site = 'Y';
x=0;

%initial score
score = 0;

% Var to store total Tyrosine
TotalTyr = 0;

%it will give us the sub-sequence
AA = [];

for i = 1:size(protein_sequence, 2); %loop will run over the whole protein length
    
    
    if protein_sequence (1, i) == 'Y';% it will check if amino acid at position i is S
        TotalTyr = TotalTyr + 1;
        
        
        b='';c='';d='';e='';f='';g='';h='';j='';k='';l='';m='';n='';
        
        %it will score amino acid at position i-6
        if(i-6>0)
            b=(protein_sequence (1, i-6));
            switch protein_sequence (1, i-6)
                case {'A' 'P'}
                    score = 0.06;
                case {'R' 'D' 'G' 'K'}
                    score = 0.07;
                case {'N' 'Q' 'I'}
                    score = 0.04;
                case {'C' 'W'}
                    score = 0.01;
                case {'E' 'L'}
                    score = 0.08;
                case {'S'}
                    score = 0.09;
                case {'H' 'M'}
                    score = 0.02;
                case{'V' 'T'}
                    score = 0.05;
                case{'F' 'Y'}
                    score = 0.03;
            end
        end
        
        %it will score amino acid at position i-5
        if(i-5>0)
            c=(protein_sequence (1, i-5));
            switch protein_sequence (1, i-5)
                case {'A' 'D' 'G' 'L' 'K' 'P'}
                    score = score * 0.07;
                case {'N' 'I'}
                    score = score * 0.04;
                case {'V' 'T' 'Q'}
                    score = score * 0.05;
                case {'C' 'W'}
                    score = score * 0.01;
                case {'E'}
                    score = score * 0.08;
                case {'S'}
                    score = score * 0.09;
                case{'H' 'M'}
                    score = score * 0.02;
                case{'F' 'Y'}
                    score = score * 0.03;
                case{'R'}
                    score = score * 0.06;
            end
        end
        
        %it will score amino acid at position i-4
        if(i-4>0)
            d=(protein_sequence (1, i-4));
            switch protein_sequence (1, i-4)
                case {'A' 'R' 'K'}
                    score = score * 0.06;
                case {'N' 'Q' 'T' 'V'}
                    score = score * 0.05;
                case {'D' 'G'}
                    score = score * 0.08;
                case {'E'}
                    score = score * 0.09;
                case {'C' 'W'}
                    score = score * 0.01;
                case {'H' 'M'}
                    score = score * 0.02;
                case {'I' 'F' 'Y'}
                    score = score * 0.03;
                case {'L' 'P'}
                    score = score * 0.07;
                case {'S'}
                    score = score * 0.1;
            end
        end
        
        
        %it will score amino acid at position i-3
        if(i-3>0)
            e=(protein_sequence (1, i-3));
            switch protein_sequence (1, i-3)
                case {'A' 'R' 'L' 'K' 'P'}
                    score = score * 0.06;
                case {'N' 'Q' 'V' 'T'}
                    score = score * 0.05;
                case {'D' 'S'}
                    score = score * 0.09;
                case {'C' 'W'}
                    score = score * 0.01;
                case {'G'}
                    score = score * 0.08;
                case {'E'}
                    score = score * 0.11;
                case {'H' 'M' 'F'}
                    score = score * 0.02;
                case {'I' 'Y'}
                    score = score * 0.03;
            end
        end
        
        
        %it will score amino acid at position i-2
        if(i-2>0)
            f=(protein_sequence (1, i-2));
            switch protein_sequence (1, i-2)
                case {'A'}
                    score = score * 0.07;
                case {'R' 'N' 'T' 'V'}
                    score = score * 0.05;
                case {'D' 'G' 'S'}
                    score = score * 0.09;
                case {'C'}
                    score = score * 0.01;
                case {'E' 'P'}
                    score = score * 0.08;
                case {'H' 'F' 'M'}
                    score = score * 0.02;
                case {'Q'}
                    score = score * 0.04;
                case {'K' 'L'}
                    score = score * 0.06;
                case {'W'}
                    score = score * 0;
                case {'Y' 'I'}
                    score = score * 0.03;
            end
        end
        
        
        %it will score amino acid at position i-1
        if(i-1>0)
            g=(protein_sequence (1, i-1));
            switch protein_sequence (1, i-1)
                case {'A' 'P' 'T'}
                    score = score * 0.06;
                case {'N' 'R' 'Q'}
                    score = score * 0.04;
                case {'D' 'L'}
                    score = score * 0.09;
                case {'C' 'M'}
                    score = score * 0.01;
                case {'G' 'I' 'S' 'V'}
                    score = score * 0.07;
                case {'E'}
                    score = score * 0.08;
                case {'H' 'F'}
                    score = score * 0.02;
                case {'K'}
                    score = score * 0.05;
                case {'Y'}
                    score = score * 0.03;
                case {'W'}
                    score = score * 0;
            end
        end
        
        
        %it will score amino acid at position i+1
        if(size(protein_sequence, 2)>=i+1)
            h=(protein_sequence (1, i+1));
            switch protein_sequence (1, i+1)
                case {'A' 'L' 'G' 'V'}
                    score = score * 0.07;
                case {'R' 'Q'}
                    score = score * 0.05;
                case {'N' 'F' 'P'}
                    score = score * 0.03;
                case {'C' 'W'}
                    score = score * 0.01;
                case {'E'}
                    score = score * 0.1;
                case {'H' 'M'}
                    score = score * 0.02;
                case {'D'}
                    score = score * 0.08;
                case {'I' 'K' 'Y'}
                    score = score * 0.04;
                case {'S'}
                    score = score * 0.11;
                case {'T'}
                    score = score * 0.06;
            end
        end
        
        
        %it will score amino acid at position i+2
        if(size(protein_sequence, 2)>=i+2)
            j=(protein_sequence (1, i+2));
            switch protein_sequence (1, i+2)
                case {'A' 'D' 'G' 'L'}
                    score = score * 0.07;
                case {'R' 'N' }
                    score = score * 0.05;
                case {'V' 'T' 'P' 'K'}
                    score = score * 0.06;
                case {'E'}
                    score = score * 0.08;
                case {'C' 'M' 'H'}
                    score = score * 0.02;
                case {'S'}
                    score = score * 0.09;
                case {'Q' 'I'}
                    score = score * 0.04;
                case {'F' 'Y' }
                    score = score * 0.03;
                case {'W'}
                    score = score * 0.01;
            end
        end
        
        
        %it will score amino acid at position i+3
        if(size(protein_sequence, 2)>=i+3)
            k=(protein_sequence (1, i+3));
            switch protein_sequence (1, i+3)
                case {'A' 'I' 'T'}
                    score = score * 0.06;
                case {'R' 'D' 'G' 'E' 'K'}
                    score = score * 0.05;
                case {'N' 'Q' 'M' 'Y'}
                    score = score * 0.03;
                case {'C' 'W'}
                    score = score * 0.01;
                case {'H'}
                    score = score * 0.02;
                case {'L' 'P'}
                    score = score * 0.1;
                case {'F'}
                    score = score * 0.04;
                case {'S'}
                    score = score * 0.09;
                case {'V'}
                    score = score * 0.08;
            end
        end
        
        
        %it will score amino acid at position i+4
        if(size(protein_sequence, 2)>=i+4)
            l=(protein_sequence (1, i+4));
            switch protein_sequence (1, i+4)
                case {'A' 'K' 'D' 'T' 'V'}
                    score = score * 0.06;
                case {'R' 'G' 'L' 'P'}
                    score = score * 0.07;
                case {'N' 'Y'}
                    score = score * 0.04;
                case {'C' 'W'}
                    score = score * 0.01;
                case {'E'}
                    score = score * 0.08;
                case {'Q'}
                    score = score * 0.05;
                case {'H' 'M'}
                    score = score * 0.02;
                case {'I' 'F'}
                    score = score * 0.03;
                case {'S'}
                    score = score * 0.09;
            end
        end
        
        
        %it will score amino acid at position i+5
        if(size(protein_sequence, 2)>=i+5)
            m=(protein_sequence (1, i+5));    %Updated 20200426
            switch protein_sequence (1, i+5)
                case {'A' 'R' 'D'}
                    score = score * 0.06;
                case {'N' 'I' 'Y' 'V'}
                    score = score * 0.04;
                case {'C' 'W'}
                    score = score * 0.01;
                case {'G' 'E'}
                    score = score * 0.08;
                case {'Q' 'T'}
                    score = score * 0.05;
                case {'H' 'M'}
                    score = score * 0.02;
                case {'L' 'K' 'P'}
                    score = score * 0.07;
                case {'F'}
                    score = score * 0.03;
                case {'S'}
                    score = score * 0.09;
            end
        end
        
        
        %it will score amino acid at position i+6
        if(size(protein_sequence, 2)>=i+6)
            n=(protein_sequence (1, i+6));
            switch protein_sequence (1, i+6)
                case {'A' 'R' 'G' 'E' 'K' 'P'}
                    score = score * 0.07;
                case {'N' 'Q' 'I' 'Y'}
                    score = score * 0.04;
                case {'D' 'V'}
                    score = score * 0.06;
                case {'C' 'W'}
                    score = score * 0.01;
                case {'H' 'M'}
                    score = score * 0.02;
                case {'L' 'S'}
                    score = score * 0.08;
                case {'F'}
                    score = score * 0.03;
                case {'T'}
                    score = score * 0.05;
            end
        end
        
        
        %         score = score / 1.13;
        %         // Phosphorylation_Y
        min = 0;
        max = 0.09 * 0.09 * 0.10 * 0.11 * 0.09 * 0.09 * 0.11 * 0.09 * 0.10 * 0.09 * 0.09 * 0.08;
        norm_factor = log10(max);
        if (score == 0)
            score = 0;
        else
            score = norm_factor / log10(score);
        end
        
        %it will store the protein sub-sequence in AA .
        if (score>=PTM_tolerance)
            
            %it stores the protein sub-sequence
            AA = [b,c,d,e,f,g,(protein_sequence (1, i)), h, j, k, l, m,n];
            
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
