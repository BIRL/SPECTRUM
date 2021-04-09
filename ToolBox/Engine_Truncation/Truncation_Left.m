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
function [Candidate_ProteinsList, RemainingProteins] = Truncation_Left(Candidate_ProteinsListInput)
AA_MW_Array;
BlindPTMvar = getappdata(0,'BlindPTM');
Candidate_ProteinsList = cell(numel(Candidate_ProteinsListInput),1);
ProteinIndex = 0;

%%% Updated 20210409   %% BELOW
%ExperimentalPeakList = getappdata(0,'Peaklist_Data');
PeakListMW = getappdata(0,'Fragments_Masses');
Intensity = getappdata(0,'Int');
ExperimentalPeakList = [PeakListMW, Intensity];%sortrows(getappdata(0,'Peaklist_Data'));
ExperimentalPeakList_Shifted = ExperimentalPeakList(:,1);
Protein_ExperimentalMW = ExperimentalPeakList_Shifted(end);  % For experimental MS1
%%% Updated 20210409   %% ABOVE

tol = 2;

if BlindPTMvar == 1
    RemainingProteins = cell(numel(Candidate_ProteinsListInput),1);
    RemainIndex = 0;
    for index = 1: numel(Candidate_ProteinsListInput)
        Protein_List = Candidate_ProteinsListInput{index,1};
        prtLength = numel(Protein_List.Sequence);
        %% shift experimental Mass by truncation mass
        TruncationMass = Protein_List.MolW - Protein_ExperimentalMW;
        
        %20181019 - Bug fix for zero-index error
        %start = ceil(TruncationMass / 128)-1;
        start = ceil(TruncationMass / 128);
        
        if TruncationMass > 0
            %% Find Truncation Location and Type
            LeftIndex = -1;
            
            for  m = start:prtLength
                diff_left = Protein_List.LeftIons(m) - TruncationMass;
                
                if abs(diff_left) <= tol %% No need to worry about Terminal Modifications!
                    LeftIndex = m; %% This index correspond to the New truncation site located at N-Terminous
                end
                
                if diff_left > tol
                    break;
                end
            end
            
            %% Save Data
            if  LeftIndex == -1
                RemainIndex = RemainIndex + 1;
                RemainingProteins(RemainIndex) = {Protein_List};
            else
                ProteinIndex = ProteinIndex + 1;
                Protein_List.Truncation = 'Left';
                Protein_List.LeftIons = Protein_List.LeftIons - Protein_List.LeftIons(LeftIndex);
                Protein_List.LeftIons(1:LeftIndex) = [];
                Protein_List.RightIons = Protein_List.RightIons(1:numel(Protein_List.Sequence) - LeftIndex); % as this will be the MW of protein - Water
                Sequence = Protein_List.Sequence(LeftIndex+1:numel(Protein_List.Sequence));
                Protein_List.Sequence = Sequence;
                
                if numel(Protein_List.Sequence) < 5
                    continue;
                end
                
                Protein_List.TruncationIndex = Protein_List.TruncationIndex + LeftIndex -1;
                Protein_List.MolW = Protein_List.RightIons(numel(Protein_List.Sequence)) + 1.0078250321 + 1.0078250321 + 15.9949146221;
                Candidate_ProteinsList(ProteinIndex) = {Protein_List};
            end
            
        end
    end
    RemainingProteins = RemainingProteins(~cellfun('isempty', RemainingProteins));
    Candidate_ProteinsList = Candidate_ProteinsList(~cellfun('isempty', Candidate_ProteinsList));
    
else
    RemainingProteins = [];
    for index = 1: numel(Candidate_ProteinsListInput)
        Protein_List = Candidate_ProteinsListInput{index};
        prtLength = numel(Protein_List.Sequence);
        
        %% shift experimental Mass by truncation mass
        TruncationMass = Protein_List.MolW - Protein_ExperimentalMW;
        
        %20181025 - Bug fix for zero-index error
        %start = ceil(TruncationMass / 256)-1;
        start = ceil(TruncationMass / 256);
        
        if TruncationMass > 0
            %% Find Truncation Location and Type
            LeftIndex = -1;
            
            for  m = start:prtLength
                diff_left = Protein_List.LeftIons(m) - TruncationMass;
                
                if abs(diff_left) <= tol %% No need to worry about Terminal Modifications!
                    LeftIndex = m; %% This index correspond to the New truncation site located at N-Terminous
                end
                
                if diff_left > tol
                    break;
                end
            end
            
            %% Save Data
            if  LeftIndex == -1
            else
                ProteinIndex = ProteinIndex + 1;
                Protein_List.Truncation = 'Left';
                Protein_List.LeftIons = Protein_List.LeftIons - Protein_List.LeftIons(LeftIndex);
                Protein_List.LeftIons(1:LeftIndex) = [];
                Protein_List.RightIons = Protein_List.RightIons(1:numel(Protein_List.Sequence) - LeftIndex); % as this will be the MW of protein - Water
                Sequence = Protein_List.Sequence(LeftIndex+1:numel(Protein_List.Sequence));
                Protein_List.Sequence = Sequence;
                
                if numel(Protein_List.Sequence) < 5
                    continue;
                end
                
                Protein_List.TruncationIndex = Protein_List.TruncationIndex + LeftIndex -1;
                Protein_List.MolW = Protein_List.RightIons(numel(Protein_List.Sequence)) + 1.0078250321 + 1.0078250321 + 15.9949146221;
                Candidate_ProteinsList{ProteinIndex} = Protein_List;
            end
            
        end
    end
    Candidate_ProteinsList = Candidate_ProteinsList(~cellfun('isempty', Candidate_ProteinsList));
end
end