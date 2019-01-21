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

function [AAMasses,AASymbol,AAName]=Monoisotopic_weight()
AAMasses=[57.0214600000000;71.0371100000000;87.0320300000000;97.0527600000000;99.0684100000000;101.047680000000;103.009190000000;113.084060000000;114.042930000000;115.026940000000;128.058580000000;128.094960000000;129.042590000000;131.040490000000;137.058910000000;147.068410000000;156.101110000000;163.063330000000;168.964203000000;186.079310000000;255.158295000000];
AASymbol=['G';'A';'S';'P';'V';'T';'C';'L';'N';'D';'Q';'K';'E';'M';'H';'F';'R';'Y';'U';'W';'O'];
AAName=[{'Gly'};{'Ala'};{'Ser'};{'Pro'};{'Val'};{'Thr'};{'Cys'};{'Leu'};{'Asn'};{'Asp'};{'Gln'};{'Lys'};{'Glu'};{'Met'};{'His'};{'Phe'};{'Arg'};{'Tyr'};{'Sec'};{'Trp'};{'Pyl'}];
end