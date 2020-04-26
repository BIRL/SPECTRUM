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

function Sites = N_linked_glycosylation_N(protein_sequence, PTM_tolerance)


PTM_tolerance = str2double(PTM_tolerance);
% PTM_tolerance = 0.1;
Sites = {};
mod_weight = 317.122;
mod_name = 'N-linked-Glycosylation';
site = 'N';

%initail score
score = 0;

%Variable to store total Asn
TotalAsn = 0;

%Variable to store Sub-Sequence 0f protein
AA = [];


for i = 1:size(protein_sequence, 2);% loop will run over the length of the whole protein sequence.
    
    %Variables to store sub-sequence
    b='';c='';d='';e='';f='';g='';h='';j='';k='';l='';m='';n='';
    
    
    if protein_sequence (1, i) == 'N';%check whether amino acid at position i is 'Asn'
        
        
        %it will score amino acid at position i-6
        if(i-6>0)
            b=(protein_sequence (1, i-6));
            switch protein_sequence (1, i-6)
                case {'A' 'D' 'E' 'F'}
                    score =  0.05;
                case {'R' 'Q' 'K' 'Y'}
                    score =  0.04;
                case {'N' 'T' 'V'}
                    score =  0.07;
                case {'C' 'W' 'H' 'M'}
                    score =  0.02;
                case {'G' 'I' 'P' 'S'}
                    score =  0.06;
                case {'L'}
                    score =  0.09;
            end
        end
        
        %it will score amino acid at position i-5
        if(i-5>0)
            c=(protein_sequence (1, i-5));
            switch protein_sequence (1, i-5)
                case {'A' 'I'}
                    score = score * 0.07;
                case {'Q' 'R' 'F' 'Y'}
                    score = score * 0.04;
                case {'N' 'G' 'V'}
                    score = score * 0.06;
                case {'D' 'E' 'K' 'P'}
                    score = score * 0.05;
                case {'C'}
                    score =  score * 0.03;
                case {'H' 'M' 'W'}
                    score =  score * 0.02;
                case {'L' 'S' 'T'}
                    score =  score * 0.08;
            end
        end
        
        %it will score amino acid at position i-4
        if(i-4>0)
            d=(protein_sequence (1, i-4));
            switch protein_sequence (1, i-4)
                case {'A' 'E' 'K' 'F' 'P' 'Y'}
                    score =  score * 0.05;
                case {'R' 'D' 'Q'}
                    score =  score * 0.04;
                case {'C' 'H' }
                    score =  score * 0.03;
                case {'G' 'S' 'T'}
                    score =  score * 0.07;
                case {'I' 'N'}
                    score =  score * 0.06;
                case {'L'}
                    score =  score * 0.09;
                case {'M' 'W'}
                    score =  score * 0.02;
                case {'V'}
                    score =  score * 0.08;
            end
        end
        
        
        %it will score amino acid at position i-3
        if(i-3>0)
            e=(protein_sequence (1, i-3));
            switch protein_sequence (1, i-3)
                case {'A' 'T'}
                    score =  score * 0.06;
                case {'R' 'N' 'E' 'I' 'P' 'Y'}
                    score =  score * 0.05;
                case {'D' 'Q' 'F' }
                    score =  score * 0.04;
                case {'C'}
                    score =  score * 0.03;
                case {'G' 'K' 'S'}
                    score =  score * 0.07;
                case {'H' 'M' 'W'}
                    score =  score * 0.02;
                case {'L' 'V'}
                    score =  score * 0.08;
            end
        end
        
        %it will score amino acid at position i-2
        if(i-2>0)
            f=(protein_sequence (1, i-2));
            switch protein_sequence (1, i-2)
                case {'A' 'G' 'I' 'F'}
                    score =  score * 0.06;
                case {'R' 'D' 'Q' 'K'}
                    score =  score * 0.04;
                case {'N' 'E' 'P' 'Y'}
                    score =  score * 0.05;
                case {'C' 'H'}
                    score =  score * 0.03;
                case {'L'}
                    score =  score * 0.1;
                case {'M' 'W'}
                    score =  score * 0.02;
                case {'S' 'T' 'V'}
                    score =  score * 0.07;
            end
        end
        
        %it will score amino acid at position i-1
        if(i-1>0)
            g=(protein_sequence (1, i-1));
            switch protein_sequence (1, i-1)
                case {'A' 'G' 'T'}
                    score =  score * 0.07;
                case {'R' 'N' 'I' 'F' 'Y'}
                    score =  score * 0.05;
                case {'D' 'E' 'K' 'P' }
                    score =  score * 0.04;
                case {'C' 'Q' }
                    score =  score * 0.03;
                case {'H' 'W'}
                    score =  score * 0.02;
                case {'L'}
                    score =  score * 0.1;
                case {'M'}
                    score =  score * 0.01;
                case {'S'}
                    score =  score * 0.09;
                case {'V'}
                    score =  score * 0.08;
            end
        end
        
        
        %it will score amino acid at position i+1
        if(size(protein_sequence, 2)>=i+1)
            h=(protein_sequence (1, i+1));
            switch protein_sequence (1, i+1)
                case {'A' 'T'}
                    score =  score * 0.06;
                case {'R'}
                    score =  score * 0.03;
                case {'N' 'D'}
                    score =  score * 0.05;
                case {'C' 'E' 'Q' 'K' 'F' 'Y'}
                    score =  score * 0.04;
                case {'G' 'S'}
                    score =  score * 0.9;
                case {'H' 'M' }
                    score =  score * 0.02;
                case {'I' 'L'}
                    score =  score * 0.08;
                case {'W'}
                    score =  score * 0.01;
                case {'P'}
                    score  =  score * 0;
                case {'V'}
                    score =  score * 0.1;
                    
            end
        end
        
        %it will score amino acid at position i+2
        if(size(protein_sequence, 2)>=i+2)
            j=(protein_sequence (1, i+2));
            switch protein_sequence (1, i+2)
                case {'S'}
                    score =  score * 0.36;
                case {'T'}
                    score =  score * 0.63;
                otherwise
                    score =  score * 0;
                    
            end
        end
        
        %it will score amino acid at position i+3
        if(size(protein_sequence, 2)>=i+3)
            k=(protein_sequence (1, i+3));
            switch protein_sequence (1, i+3)
                case {'A' 'G' 'E' 'I'}
                    score =  score * 0.06;
                case {'R' 'Q' 'Y'}
                    score =  score * 0.04;
                case {'N' 'D' 'K' 'F'}
                    score =  score * 0.05;
                case {'C' 'W'}
                    score =  score * 0.03;
                case {'H'}
                    score =  score * 0.02;
                case {'L'}
                    score =  score * 0.11;
                case {'M'}
                    score =  score * 0.01;
                case {'T' 'V'}
                    score =  score * 0.07;
                case {'S'}
                    score =  score * 0.09;
                case {'P'}
                    score =  score * 0;
            end
        end
        
        %it will score amino acid at position i+4
        if(size(protein_sequence, 2)>=i+4)
            l=(protein_sequence (1, i+4));
            switch protein_sequence (1, i+4)
                case {'A' 'N' 'E' 'P'}
                    score =  score * 0.06;
                case {'R' 'Q' 'K' 'Y'}
                    score =  score * 0.04;
                case {'D' 'G'}
                    score =  score * 0.05;
                case {'C' 'H' 'M' 'W'}
                    score =  score * 0.02;
                case {'I' 'V'}
                    score =  score * 0.07;
                case {'L' 'T'}
                    score =  score * 0.05;
                case {'F'}
                    score =  score * 0.03;
                case {'S'}
                    score =  score * 0.08;
            end
        end
        
        %it will score amino acid at position i+5
        if(size(protein_sequence, 2)>=i+5)
            m=(protein_sequence (1, i+5));  %Updated 20200426
            switch protein_sequence (1, i+5)
                case {'A' 'N' 'D' 'G' 'E'}
                    score =  score * 0.06;
                case {'R' 'Q' 'K' 'F' 'Y'}
                    score =  score * 0.04;
                case {'C'}
                    score =  score * 0.03;
                case {'H' 'M' 'W'}
                    score =  score * 0.02;
                case {'I' 'S'}
                    score =  score * 0.07;
                case {'L'}
                    score =  score * 0.1;
                case {'P' 'T'}
                    score =  score * 0.05;
                case {'V'}
                    score =  score * 0.08;
            end
        end
        
        %it will score amino acid at position i+6
        if(size(protein_sequence, 2)>=i+6)
            n=(protein_sequence (1, i+6));
            switch protein_sequence (1, i+6)
                case {'A' 'R' 'D'}
                    score =  score * 0.05;
                case {'N' 'E' 'I' 'P'}
                    score =  score * 0.06;
                case {'C' 'F'}
                    score =  score * 0.03;
                case {'G' 'T' 'V'}
                    score =  score * 0.07;
                case {'Q' 'K' 'Y'}
                    score =  score * 0.04;
                case {'H' 'W'}
                    score =  score * 0.02;
                case {'L' 'S'}
                    score =  score * 0.09;
                case {'M'}
                    score =  score * 0.01;
            end
        end
        
        %scalling the score according to maximum possible score
        %         score = score / 1.66;
        
        %         // N_linked_glycosylation_N
        min = 0;
        max = 0.09 * 0.08 * 0.09 * 0.08 * 0.1 * 0.1 * 0.1 * 0.63 * 0.11 * 0.09 * 0.1 * 0.09;
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
