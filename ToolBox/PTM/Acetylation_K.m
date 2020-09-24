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

function Sites = Acetylation_K(protein_sequence, PTM_tolerance)

Sites = {};

PTM_tolerance = str2double(PTM_tolerance);


mod_weight = 42.0106;
mod_name = 'Acetylation';
site = 'K';
x=0;
% variable score is initialized
score = 0;

%Variable to store total number of lysine
TotalLys = 0;

%Varible to store sub-sequence of protein
AA = [];

for i = 1:size(protein_sequence, 2);
    if protein_sequence (1, i) == 'K';
        TotalLys = TotalLys + 1;
        
        
        %variables to store sub-sequence
        a='';b='';c='';d='';e='';f='';g='';h='';m='';j='';k='';l='';
        
        
        %It saves the score for i+1 position
        if(size(protein_sequence, 2)>=i+1)
            l=(protein_sequence (1, i+1));
            switch protein_sequence (1, i+1)
                
                case {'W'};
                    score = 0.01;
                case {'M'};
                    score = 0.02;
                case {'Q'};
                    score = 0.03;
                case {'N' 'H' 'I' 'T'};
                    score = 0.04;
                case {'V' 'S' 'F' 'R'};
                    score = 0.05;
                case {'G' 'D' 'P'};
                    score = 0.06;
                case {'K'};
                    score = 0.07;
                case {'A' 'E' 'Y'};
                    score = 0.08;
                case {'L'};
                    score = 0.09;
                case {'C'};
                    score = 0;
                otherwise
                    score = 0;  %%-0.083  %Updated 20200426
                    
            end
        end
        
        %It saves the score for i+2 position
        if(size(protein_sequence, 2)>=i+2)
            
            k=(protein_sequence (1, i+2));
            switch protein_sequence (1, i+2)
                
                case {'W' 'C'};
                    score = score * 0.01;
                case {'M' 'H'};
                    score = score * 0.02;
                case {'Q' 'N'};
                    score = score * 0.03;
                case {'D' 'Y' 'T'};
                    score = score * 0.04;
                case {'P' 'F' 'R'};
                    score = score * 0.05;
                case {'G' 'S'};
                    score = score * 0.06;
                case {'K' 'V'};
                    score = score * 0.07;
                case {'A' 'I'};
                    score = score * 0.08;
                case {'E'};
                    score = score * 0.09;
                case {'L'};
                    score = score * 0.12;
                otherwise
                    score = 0;
            end
        end
        
        
        %It saves the score for i+3 position
        if(size(protein_sequence, 2)>=i+3)
            
            j=(protein_sequence (1, i+3));
            switch protein_sequence (1, i+3)
                
                case {'C' 'W'};
                    score = score * 0.01;
                case {'M' 'H'};
                    score = score * 0.02;
                case {'Y'};
                    score = score * 0.03;
                case {'N' 'Q' 'I' 'F'};
                    score = score * 0.04;
                case {'V' 'P' 'T'};
                    score = score * 0.05;
                case {'D' 'S'};
                    score = score * 0.06;
                case {'A' 'G' 'L'};
                    score = score * 0.07;
                case {'R' 'E'};
                    score = score * 0.08;
                case {'K'};
                    score = score * 0.11;
                otherwise
                    score = 0;
            end
        end
        
        %It saves the score for i+4 position
        if(size(protein_sequence, 2)>=i+4)  %Updated 20200924  Equal to Sign Added
            
            m=(protein_sequence (1, i+4));
            switch protein_sequence (1, i+4)
                
                case {'C' 'W'};
                    score = score * 0.01;
                case {'M' 'H'};
                    score = score * 0.02;
                case {'Y' 'N'};
                    score = score * 0.03;
                case {'P' 'Q' 'F'};
                    score = score * 0.04;
                case {'V' 'D' 'I'};
                    score = score * 0.05;
                case {'T' 'S'};
                    score = score * 0.06;
                case {'A' 'G' 'R'};
                    score = score * 0.07;
                case {'L' 'E'};
                    score = score * 0.08;
                case {'K'};
                    score = score * 0.14;
                otherwise
                    score = 0;
                    
                    
                    
            end
        end
        
        
        %It saves the score for i+5 position
        if(size(protein_sequence, 2)>=i+5)
            
            h=(protein_sequence (1, i+5));
            switch protein_sequence (1, i+5)
                case {'C' 'W'};
                    score = score * 0.01;
                case {'M' 'H'};
                    score = score * 0.02;
                case {'Y'};
                    score = score * 0.03;
                case {'P' 'Q' 'F' 'N' 'I'};
                    score = score * 0.04;
                case {'D' 'T'};
                    score = score * 0.05;
                case {'R' 'S' 'V'};
                    score = score * 0.06;
                case {'G' 'E'};
                    score = score * 0.07;
                case {'A'};
                    score = score * 0.08;
                case {'L'};
                    score = score * 0.09;
                case {'K'};
                    score = score * 0.14;
                otherwise
                    score = 0;
                    
                    
                    
            end
        end
        
        
        %It saves the score for i+6 position
        if(size(protein_sequence, 2)>=i+6)  %Updated 20200924  Equal to Sign Added
            g=(protein_sequence (1, i+6));
            switch protein_sequence (1, i+6)
                
                case {'C' 'W'};
                    score = score * 0.01;
                case {'M' 'H'};
                    score = score * 0.02;
                case {'Y''F'};
                    score = score * 0.03;
                case {'P' 'Q' 'N'};
                    score = score * 0.04;
                case {'D' 'T' 'I'};
                    score = score * 0.05;
                case {'S' 'V'};
                    score = score * 0.06;
                case {'G' 'E' 'R'};
                    score = score * 0.07;
                case {'A'};
                    score = score * 0.08;
                case {'L'};
                    score = score * 0.09;
                case {'K'};
                    score = score * 0.11;
                otherwise
                    score = 0;
                    
            end
        end
        
        
        %it will score amino acid at position i-1
        if(i-1>0)
            
            f=(protein_sequence (1, i-1));
            switch protein_sequence (1, i-1)
                
                case {'C' 'W'};
                    score = score * 0.01;
                case {'M' 'H'};
                    score = score * 0.02;
                case {'Y' 'P' 'R'};
                    score = score * 0.03;
                case {'F' 'N'};
                    score = score * 0.04;
                case {'Q' 'D' 'T' 'K' 'I'};
                    score = score * 0.05;
                case {'V'};
                    score = score * 0.06;
                case {'S'};
                    score = score * 0.07;
                case {'A'};
                    score = score * 0.08;
                case {'L'};
                    score = score * 0.09;
                case {'G' 'E'};
                    score = score * 0.11;
                otherwise
                    score = 0;
                    
            end
        end
        
        %it will score amino acid at position i-2
        if(i-2>0)
            
            e=(protein_sequence (1, i-2));
            switch protein_sequence (1, i-2)
                
                case {'C'};
                    score = score * 0.01;
                case {'M' 'H' 'R' 'W'};
                    score = score * 0.02;
                case {'Q'};
                    score = score * 0.03;
                case {'P' 'T' 'N'};
                    score = score * 0.04;
                case {'D' 'Y'};
                    score = score * 0.05;
                case {'E' 'I' 'K' 'S'};
                    score = score * 0.06;
                case {'V'};
                    score = score * 0.07;
                case {'G' 'F'};
                    score = score * 0.08;
                case {'A'};
                    score = score * 0.09;
                case {'L'};
                    score = score * 0.11;
                otherwise
                    score = 0;
                    
            end
        end
        
        
        %it will score amino acid at position i-3
        if(i-3>0)
            
            d=(protein_sequence (1, i-3));
            switch protein_sequence (1, i-3)
                
                case {'C' 'W'};
                    score = score * 0.01;
                case {'M'};
                    score = score * 0.02;
                case {'Y' 'H'};
                    score = score * 0.03;
                case {'R' 'F' 'N'};
                    score = score * 0.04;
                case {'D' 'Q' 'I' 'P'};
                    score = score * 0.05;
                case {'T' 'S' 'V'};
                    score = score * 0.06;
                case {'G' 'K'};
                    score = score * 0.07;
                case {'A' 'E' 'L'};
                    score = score * 0.09;
                    
                otherwise
                    score = 0;
                    
            end
        end
        
        
        %it will score amino acid at position i-4
        if(i-4>0)
            
            c=(protein_sequence (1, i-4));
            switch protein_sequence (1, i-4)
                case {'C' 'W'};
                    score = score * 0.01;
                case {'M'};
                    score = score * 0.02;
                case {'Y' 'H' 'F'};
                    score = score * 0.03;
                case {'N' 'I'};
                    score = score * 0.04;
                case {'D' 'R' 'Q'};
                    score = score * 0.05;
                case {'P' 'T' 'V'};
                    score = score * 0.06;
                case {'G' 'A' 'L'};
                    score = score * 0.07;
                case {'S'};
                    score = score * 0.08;
                case {'E'};
                    score = score * 0.09;
                case {'K'};
                    score = score * 0.11;
                otherwise
                    score = 0;
            end
        end
        
        
        %it will score amino acid at position i-5
        if(i-5>0)
            
            b=(protein_sequence (1, i-5));
            switch protein_sequence (1, i-5)
                
                case {'C' 'W'};
                    score = score * 0.01;
                case {'M' 'H'};
                    score = score * 0.02;
                case {'Y' 'F'};
                    score = score * 0.03;
                case {'N' 'D' 'Q'};
                    score = score * 0.04;
                case {'I' 'T' 'P'};
                    score = score * 0.05;
                case {'G' 'E'};
                    score = score * 0.06;
                case {'R' 'S' 'V'};
                    score = score * 0.07;
                case {'A'};
                    score = score * 0.08;
                case {'L'};
                    score = score * 0.09;
                case {'K'};
                    score = score * 0.12;
                otherwise
                    score = 0;
                    
            end
        end
        
        
        %it will score amino acid at position i-6
        if(i-6>0)
            a=(protein_sequence (1, i-6));
            switch protein_sequence (1, i-6)
                
                case {'C' 'W'};
                    score = score * 0.01;
                case {'M' 'H'};
                    score = score * 0.02;
                case {'Y'};
                    score = score * 0.03;
                case {'N' 'I' 'F' 'Q'};
                    score = score * 0.04;
                case {'D' 'T' 'P' 'V'};
                    score = score * 0.05;
                case {'G'};
                    score = score * 0.06;
                case {'R' 'S' 'E'};
                    score = score * 0.07;
                case {'A' 'L'};
                    score = score * 0.09;
                case {'K'};
                    score = score * 0.11;
                otherwise
                    score = 0;
            end
        end
        
        
        % score scalling according to maximum score
        %score = score /1.34;
        
        min = 0;
        max = 0.11 * 0.12 * 0.11 * 0.09 * 0.11 * 0.11 * 0.09 * 0.14 * 0.11 * 0.14 * 0.12 * 0.11;
        norm_factor = log10(max);
        if (score == 0)
            score = 0;
        else
            score = norm_factor / log10(score);
        end
        %it stores the protein sub-sequence
        
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
