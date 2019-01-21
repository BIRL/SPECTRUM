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

function Sites = MSONE(protein_sequence)
Sites = {};
mod_weight = 32.00;
mod_name = 'Sulfone';
site = 'M';
TotalCys = 0;

for i = 1:size(protein_sequence, 2); %loop will run over the whole protein length
    if protein_sequence (1, i) == 'M';% it will check if amino acid at position i is S
        TotalCys = TotalCys + 1;
        score = 1;
        %         b = (protein_sequence (1, i-6));
        %         c = (protein_sequence (1, i-5));
        %         d = (protein_sequence (1, i-4));
        %         e = (protein_sequence (1, i-3));
        %         f = (protein_sequence (1, i-2));
        %         g = (protein_sequence (1, i-1));
        %         h = (protein_sequence (1, i+1));
        %         j = (protein_sequence (1, i+2));
        %         k = (protein_sequence (1, i+3));
        %         l = (protein_sequence (1, i+4));
        %         m = (protein_sequence (1, i+5));
        %         n = (protein_sequence (1, i+6));
        
        %         AA = [b, c, d, e, f, g,(protein_sequence(1, i)), h, j, k, l, m, n];
        AA = [(protein_sequence(1, i))];
        data1 = {i, score, mod_weight , mod_name, site, AA};
        Sites = [Sites; data1];
    end
end
end
