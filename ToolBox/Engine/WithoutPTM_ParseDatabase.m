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
function [Candidate_ProteinsList] = WithoutPTM_ParseDatabase(Tags_ladder,Candidate_ProteinsListInput )
Candidate_ProteinsList = cell(numel(Candidate_ProteinsListInput),1);
ProteinIndex = 0;
AcetylationWeight = 42.0106;
AA_MW_Array;
FilterPSTs = getappdata(0,'FilterPSTs');
Terminal_Modification = getappdata(0,'Othermodification_Terminal');
None = Terminal_Modification(1);
NME = Terminal_Modification(2);
NME_Acetylation = Terminal_Modification(3);
M_Acetylation = Terminal_Modification(4);
BatchMode = getappdata(0, 'Batch');
ScoringWeight2 = getappdata(0,'w2');
for index = 1: numel(Candidate_ProteinsListInput)
    %% Initialize Protein
    Protein = Candidate_ProteinsListInput{index};
    Sequence = Protein.Sequence;
    %% Scan database protein sequence for ESTs
    
    if FilterPSTs == 1
        if ScoringWeight2 == 0
            keepProtein = FIlter_Proteins_PST(Tags_ladder,Sequence);
            if keepProtein == 0
                continue;
            end
            Final_EST_Score = 0;
        else
            [Final_EST_Score] = PST_Score(Tags_ladder,Sequence); %#ok<*ASGLU>
            if Final_EST_Score == 0
                continue;
            end
        end
    else
        Final_EST_Score = 0;
    end
    
    
    % %     if FilterPSTs == 1
    % %         [Final_EST_Score] = PST_Score(Tags_ladder,Sequence); %#ok<*ASGLU>
    % %         if Final_EST_Score == 0
    % %             continue;
    % %         end
    % %     else
    % %         Final_EST_Score = 0;
    % %     end
    Protein.EST_Score = Final_EST_Score;
    
    if BatchMode == 1
        %% ---- Extract Database Protein ID and Name ---------
        IdSeparatorIndex = strfind(Protein.Header,'|');
        NameSeparatorIndex = strfind(Protein.Header,'=');
        Protein.Id = Protein.Header(IdSeparatorIndex(1)+1:IdSeparatorIndex(2)-1);
        Protein.Name = Protein.Header(IdSeparatorIndex(2)+1:NameSeparatorIndex(1)-4);
    end
    
    %% Fragmentation
    Protein.LeftIons(length(Sequence))= []; % as this will be the MW of protein - water
    Protein.RightIons(length(Sequence))= []; % as this will be the MW of protein - Water
    
    %% Storing protein data in structure
    
    if None == 1
        ProteinIndex = ProteinIndex + 1;
        Candidate_ProteinsList{ProteinIndex} = Protein; %#ok<*AGROW>
    end
    
    if Protein.Sequence(1) == 'M'
        if NME == 1
            ProteinIndex = ProteinIndex + 1;
            temp = Protein;
            temp.Terminal_Modification = 'NME';
            temp.MolW = Protein.MolW - AA(double('M')-64);
            temp.LeftIons = Protein.LeftIons - AA(double('M')-64);
            temp.LeftIons(1) = [];
            temp.RightIons(length(Sequence)-1)= [];
            temp.EST_Score = Protein.EST_Score * (numel(Sequence)/(numel(Sequence)-1));
            temp.Sequence = Sequence (2:numel(Sequence));
            Candidate_ProteinsList{ProteinIndex} = temp; %#ok<*AGROW>
        end
        
        if NME_Acetylation == 1
            ProteinIndex = ProteinIndex + 1;
            temp = Protein;
            temp.Terminal_Modification = 'NME_Acetylation';
            temp.MolW = Protein.MolW - AA(double('M')-64) + AcetylationWeight;
            temp.LeftIons = Protein.LeftIons - AA(double('M')-64)+ AcetylationWeight;
            temp.LeftIons(1) = [];
            temp.RightIons(length(Sequence)-1)= [];
            temp.EST_Score = Protein.EST_Score * (numel(Sequence)/(numel(Sequence)-1));
            temp.Sequence = Sequence (2:numel(Sequence));
            Candidate_ProteinsList{ProteinIndex} = temp; %#ok<*AGROW>
        end
        
        if M_Acetylation == 1
            ProteinIndex = ProteinIndex + 1;
            temp = Protein;
            temp.Terminal_Modification = 'M_Acetylation';
            temp.MolW = Protein.MolW + AcetylationWeight;
            temp.LeftIons = Protein.LeftIons + AcetylationWeight;
            Candidate_ProteinsList{ProteinIndex} = temp; %#ok<*AGROW>
        end
    end
end
Candidate_ProteinsList = Candidate_ProteinsList(~cellfun('isempty', Candidate_ProteinsList));

if size(Candidate_ProteinsList,2)>1     %Updated 20200826
    Candidate_ProteinsList = Candidate_ProteinsList';
end
end