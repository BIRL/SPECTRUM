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

function [computed_mass]=Return_Protein_MW(seq)% function to compute mass of proteins from database
AA_MW_Array;
mass=0.0;
H = 1.0078250321;O = 15.9949146221;
H2O = H+H+O;
len_pro=length(seq);

for index_AA=1:len_pro
    mass=(mass+ AA(double(seq(index_AA))-64));
end
computed_mass = mass+H2O;%  Mol.weight of proteins