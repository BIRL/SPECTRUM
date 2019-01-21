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

function w = GetWeight(Mod)

if strcmp(Mod, 'Phosphorylation')
    w = 79.9663;
elseif strcmp(Mod, 'Hydroxylation')
    w = 15.9949;
elseif strcmp(Mod, 'Amidation')
    w = -0.9840;
elseif strcmp(Mod, 'Acetylation')
    w = 42.0106;
elseif strcmp(Mod, 'Methylation')
    w = 14.0157;
elseif strcmp(Mod, 'O_linked_glycosylation')
    w = 203.0794;
elseif strcmp(Mod, 'N_linked_glycosylation')
    w = 317.122;
elseif strcmp(Mod, 'MSONE')
    w = 32.00;
elseif strcmp(Mod, 'MSO')
    w = 147.0354;
elseif strcmp(Mod, 'Cys_CM')
    w = 161.01466;
elseif strcmp(Mod, 'Cys_CAM')
    w = 160.03065;
elseif strcmp(Mod, 'Cys_PE')
    w = 208.067039;
elseif strcmp(Mod, 'Cys_PAM')
    w = 174.04631;
else
    w = 0;
end
end