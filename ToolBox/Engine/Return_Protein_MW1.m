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

function [LeftIons, RightIons, mass]=Return_Protein_MW1(seq)% function to compute mass of proteins from database
AA_MW_Array;
H = 1.0078250321;O = 15.9949146221;
H2O = H+H+O;
len_pro=length(seq);

LeftIons = zeros(length(seq),1);
RightIons = zeros(length(seq),1);

RightIons(1) = AA(double(seq(numel(seq)))-64);
LeftIons(1) = AA(double(seq(1))-64);
for m = 2:len_pro
    LeftIons(m) = (LeftIons(m-1) + AA(double(seq(m))-64));
    RightIons(m) = (RightIons(m-1) + AA(double(seq(numel(seq)+1-m))-64));
end


mass = RightIons(numel(RightIons));
mass = mass+H2O;%  Mol.weight of proteins