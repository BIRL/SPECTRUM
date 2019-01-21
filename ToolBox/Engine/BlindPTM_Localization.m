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
function Matches = BlindPTM_Localization(Matches,Experimental_Protein_Mass)
BlindPTM = getappdata(0,'BlindPTM');
for index = 1 : numel(Matches)
    Matches{index,1}.Blind = {};
    Matches{index,1}.Blind.Start = -1;
    Matches{index,1}.Blind.End = -1;
    Matches{index,1}.Blind.Mass = -1;
    
    massDiff = (Experimental_Protein_Mass - Matches{index,1}.MolW);
    
    if BlindPTM == 1
        %(Arbitrary number less then weight of methyl group && 3*N-linked-Glycosylation)
        if massDiff > 13 && massDiff < 951.3660
            if numel(Matches{index,1}.LeftMatched_Index) > 0
                left = Matches{index,1}.LeftMatched_Index(numel(Matches{index,1}.LeftMatched_Index))+1;
            else
                left = 1;
            end
            
            if numel(Matches{index,1}.RightMatched_Index) >0
                right = numel(Matches{index,1}.LeftIons)-Matches{index,1}.RightMatched_Index(numel(Matches{index,1}.RightMatched_Index))+1;
            else
                right = numel(Matches{index,1}.LeftIons);
            end
            
            %% check if there is a mass difference between two matched fragments
            if left < right && left > 1 && right < numel(Matches{index,1}.LeftIons)
                Matches{index,1}.Blind.Start = left;
                Matches{index,1}.Blind.End = right;
                Matches{index,1}.Blind.Mass = massDiff;
                
                Matches{index}.MolW = Matches{index}.MolW + massDiff;
            end
            
            ERROR=abs(massDiff);
            if(ERROR==0)
                MW_score=1;   %diff=0 mw_score=1
            else
                MW_score=1/2^(ERROR);% compute mol_weight Score for proteins via mw_score=10/|diff|
            end
            Matches{index}.MWScore = MW_score;%store protein's
        else
            ERROR=abs(massDiff);
            if(ERROR==0)
                MW_score=1;   %diff=0 mw_score=1
            else
                MW_score=1/2^(ERROR);% compute mol_weight Score for proteins via mw_score=10/|diff|
            end
            Matches{index}.MWScore = MW_score;%store protein's
        end
    else
        ERROR=abs(massDiff);
        if(ERROR==0)
            MW_score=1;   %diff=0 mw_score=1
        else
            MW_score=1/2^(ERROR);% compute mol_weight Score for proteins via mw_score=10/|diff|
        end
        Matches{index}.MWScore = MW_score;%store protein's
    end
end
end