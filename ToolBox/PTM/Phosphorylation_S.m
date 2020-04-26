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

function Sites = Phosphorylation_S(protein_sequence, PTM_tolerance)

Sites = {};
PTM_tolerance = str2double(PTM_tolerance);
mod_weight = 79.9663;
mod_name = 'Phosphorylation';
site = 'S';
x=0;

%initial score
score = 0;

% Var to store total Serine
TotalSer = 0;

%it will give us the sub-sequence
AA = [];

for i = 1:size(protein_sequence, 2); %loop will run over the whole protein length
    
    
    if protein_sequence (1, i) == 'S';% it will check if amino acid at position i is S
        TotalSer = TotalSer + 1;
        
        
        b='';c='';d='';e='';f='';g='';h='';j='';k='';l='';m='';n='';
        
        %it will score amino acid at position i-6
        if(i-6>0)
            b=(protein_sequence (1, i-6));
            switch protein_sequence (1, i-6)
                case {'A' 'G' 'L' 'K'}
                    score = 0.07;
                case {'R' 'E' 'P'}
                    score = 0.08;
                case {'N' 'I'}
                    score = 0.03;
                case {'D' 'V'}
                    score = 0.05;
                case {'C'}
                    score = 0.01;
                case {'Q'}
                    score = 0.04;
                case {'H' 'M' 'F' 'Y'}
                    score = 0.02;
                case{'S'}
                    score = 0.12;
                case{'T'}
                    score = 0.06;
                case {'W'}
                    score = 0;
            end
        end
        
        %it will score amino acid at position i-5
        if(i-5>0)
            c=(protein_sequence (1, i-5));
            switch protein_sequence (1, i-5)
                case {'A' 'G' 'K'}
                    score = score * 0.07;
                case {'R' 'L'}
                    score = score * 0.09;
                case {'N' 'I'}
                    score = score * 0.03;
                case {'D'}
                    score = score * 0.06;
                case {'C'}
                    score = score * 0.01;
                case {'E' 'P'}
                    score = score * 0.08;
                case{'H' 'M' 'F' 'Y'}
                    score = score * 0.02;
                case{'W'}
                    score = score * 0;
                case{'T' 'V'}
                    score = score * 0.05;
                case{'S'}
                    score = score * 0.12;
                case {'Q'}
                    score = score * 0.04;
            end
        end
        
        %it will score amino acid at position i-4
        if(i-4>0)
            d=(protein_sequence (1, i-4));
            switch protein_sequence (1, i-4)
                case {'A' 'G' 'L' 'K'}
                    score = score * 0.07;
                case {'R' 'E' 'P'}
                    score = score * 0.08;
                case {'N'}
                    score = score * 0.04;
                case {'D' 'Q' 'V'}
                    score = score * 0.05;
                case {'C' 'M'}
                    score = score * 0.01;
                case {'H' 'F' 'Y'}
                    score = score * 0.02;
                case {'I'}
                    score = score * 0.03;
                case {'W'}
                    score = score * 0;
                case {'T'}
                    score = score * 0.06;
                case {'S'}
                    score = score * 0.14;
            end
        end
        
        
        %it will score amino acid at position i-3
        if(i-3>0)
            e=(protein_sequence (1, i-3));
            switch protein_sequence (1, i-3)
                case {'A' 'D'}
                    score = score * 0.06;
                case {'R'}
                    score = score * 0.15;
                case {'N' 'I'}
                    score = score * 0.03;
                case {'C' 'M' 'Y'}
                    score = score * 0.01;
                case {'G' 'E' 'L' 'K' 'P'}
                    score = score * 0.07;
                case {'Q' 'V'}
                    score = score * 0.04;
                case {'H' 'F'}
                    score = score * 0.02;
                case {'S'}
                    score = score * 0.13;
                case {'T'}
                    score = score * 0.05;
                case {'W'}
                    score = score * 0;
            end
        end
        
        
        %it will score amino acid at position i-2
        if(i-2>0)
            f=(protein_sequence (1, i-2));
            switch protein_sequence (1, i-2)
                case {'A' 'E' 'L'}
                    score = score * 0.07;
                case {'N' 'Q' 'V'}
                    score = score * 0.04;
                case {'R' 'P'}
                    score = score * 0.09;
                case {'C' 'M' 'Y'}
                    score = score * 0.01;
                case {'G' 'D' 'T'}
                    score = score * 0.06;
                case {'H' 'F'}
                    score = score * 0.02;
                case {'K'}
                    score = score * 0.05;
                case {'S'}
                    score = score * 0.16;
                case {'W'}
                    score = score * 0;
                case {'I'}
                    score = score * 0.03;
            end
        end
        
        
        %it will score amino acid at position i-1
        if(i-1>0)
            g=(protein_sequence (1, i-1));
            switch protein_sequence (1, i-1)
                case {'A' 'R'}
                    score = score * 0.07;
                case {'N' 'Q' 'V'}
                    score = score * 0.04;
                case {'D' 'P'}
                    score = score * 0.08;
                case {'C' 'M'}
                    score = score * 0.01;
                case {'G' 'L'}
                    score = score * 0.09;
                case {'E'}
                    score = score * 0.06;
                case {'H' 'F' 'Y'}
                    score = score * 0.02;
                case {'I'}
                    score = score * 0.03;
                case {'K' 'T'}
                    score = score * 0.05;
                case {'S'}
                    score = score * 0.12;
                case {'W'}
                    score = score * 0;
            end
        end
        
        
        %it will score amino acid at position i*1
        if(size(protein_sequence, 2)>=i+1)
            h=(protein_sequence (1, i+1));
            switch protein_sequence (1, i+1)
                case {'A' 'R' 'T' 'V'}
                    score = score * 0.04;
                case {'N'}
                    score = score * 0.02;
                case {'D' 'L'}
                    score = score * 0.08;
                case {'C' 'H' 'M' 'W' 'Y'}
                    score = score * 0.01;
                case {'G' 'Q'}
                    score = score * 0.05;
                case {'E'}
                    score = score * 0.07;
                case {'I' 'F' 'K'}
                    score = score * 0.03;
                case {'P'}
                    score = score * 0.27;
                case {'S'}
                    score = score * 0.1;
            end
        end
        
        
        %it will score amino acid at position i+2
        if(size(protein_sequence, 2)>=i+2)
            j=(protein_sequence (1, i+2));
            switch protein_sequence (1, i+2)
                case {'A' 'L' 'T'}
                    score = score * 0.06;
                case {'R' 'K' 'V'}
                    score = score * 0.05;
                case {'N' 'I'}
                    score = score * 0.03;
                case {'D' 'G'}
                    score = score * 0.08;
                case {'C' 'M' 'Y'}
                    score = score * 0.01;
                case {'E'}
                    score = score * 0.11;
                case {'Q'}
                    score = score * 0.04;
                case {'H' 'F'}
                    score = score * 0.02;
                case {'S'}
                    score = score * 0.15;
                case {'W'}
                    score = score * 0;
                case {'P'}
                    score = score * 0.09;
            end
        end
        
        
        %it will score amino acid at position i+3
        if(size(protein_sequence, 2)>=i+3)
            k=(protein_sequence (1, i+3));
            switch protein_sequence (1, i+3)
                case {'A' 'R' 'L' 'K'}
                    score = score * 0.06;
                case {'N'}
                    score = score * 0.03;
                case {'D' 'P'}
                    score = score * 0.08;
                case {'C' 'M' 'Y'}
                    score = score * 0.01;
                case {'G'}
                    score = score * 0.07;
                case {'E'}
                    score = score * 0.13;
                case {'Q' 'V'}
                    score = score * 0.04;
                case {'H' 'I' 'F'}
                    score = score * 0.02;
                case {'T'}
                    score = score * 0.05;
                case {'W'}
                    score = score * 0;
                case {'S'}
                    score = score * 0.14;
            end
        end
        
        
        %it will score amino acid at position i+4
        if(size(protein_sequence, 2)>=i+4)
            l=(protein_sequence (1, i+4));
            switch protein_sequence (1, i+4)
                case {'A' 'R' 'T'}
                    score = score * 0.06;
                case {'N' 'I'}
                    score = score * 0.03;
                case {'D' 'G'}
                    score = score * 0.07;
                case {'C' 'Y'}
                    score = score * 0.01;
                case {'E'}
                    score = score * 0.1;
                case {'Q'}
                    score = score * 0.04;
                case {'H' 'M' 'F'}
                    score = score * 0.02;
                case {'L' 'P'}
                    score = score * 0.08;
                case {'W'}
                    score = score * 0;
                case {'V' 'K'}
                    score = score * 0.05;
                case {'S'}
                    score = score * 0.14;
            end
        end
        
        
        %it will score amino acid at position i+5
        if(size(protein_sequence, 2)>=i+5)
            m=(protein_sequence (1, i+5));  %Updated 20200426
            switch protein_sequence (1, i+5)
                case {'A' 'R' 'D' 'L'}
                    score = score * 0.07;
                case {'N' 'I'}
                    score = score * 0.03;
                case {'C' 'M' 'W'}
                    score = score * 0.01;
                case {'G' 'K'}
                    score = score * 0.06;
                case {'T' 'V'}
                    score = score * 0.05;
                case {'E' 'P'}
                    score = score * 0.09;
                case {'Q'}
                    score = score * 0.04;
                case {'H' 'Y' 'F'}
                    score = score * 0.02;
                case {'S'}
                    score = score * 0.12;
            end
        end
        
        
        %it will score amino acid at position i+6
        if(size(protein_sequence, 2)>=i+6)
            n=(protein_sequence (1, i+6));
            switch protein_sequence (1, i+6)
                case {'A' 'R' 'G' 'L' 'K'}
                    score = score * 0.07;
                case {'N' 'I'}
                    score = score * 0.03;
                case {'D' 'T'}
                    score = score * 0.06;
                case {'C' 'W'}
                    score = score * 0.01;
                case {'E'}
                    score = score * 0.09;
                case {'Q'}
                    score = score * 0.04;
                case {'H' 'M' 'F' 'Y'}
                    score = score * 0.02;
                case {'S'}
                    score = score * 0.12;
                case {'V'}
                    score = score * 0.05;
                case {'P'}
                    score = score * 0.08;
            end
        end
        
        
        %         score = score / 1.472744;
        
        %it will store the protein sub-sequence in AA .
        %         // Phosphorylation_S
        min = 0;
        max = 0.12 * 0.12 * 0.14 * 0.15 * 0.16 * 0.12 * 0.27 * 0.15 * 0.14 * 0.14 * 0.12 * 0.12;
        norm_factor = log10(max);
        if (score == 0)
            score = 0;
        else
            score = norm_factor / log10(score);
        end
        
        if (score>PTM_tolerance)
            
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
