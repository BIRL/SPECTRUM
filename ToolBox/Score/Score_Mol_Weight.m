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

function [Candidate_ProteinsList] = Score_Mol_Weight(Candidate_ProteinsList,Prot_Intact_MW)
for index = 1:length(Candidate_ProteinsList)
    mass = Candidate_ProteinsList{index}.MolW;    
    ERROR = abs(Prot_Intact_MW - mass);
    if(ERROR == 0)
        MW_score = 1;   %diff=0 mw_score=1
    else
        MW_score = 1/2^(ERROR);% compute mol_weight Score for proteins via mw_score=10/|diff|
    end
    Candidate_ProteinsList{index}.MWScore = MW_score;%store protein's
end