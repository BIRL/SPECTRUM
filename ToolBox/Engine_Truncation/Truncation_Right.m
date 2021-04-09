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

function [Candidate_ProteinsList, RemainingProteins] = Truncation_Right(Candidate_ProteinsListInput)
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
        
        %% --- Calculate Molecular Weight of Database Protein
        Protein = Candidate_ProteinsListInput{index,1};
        prtLength = numel(Protein.Sequence);
        %% shift experimental Mass by truncation mass
        TruncationMass = Protein.MolW - Protein_ExperimentalMW;
        
        %20181019 - Bug fix for zero-index error
        %start = ceil(TruncationMass / 256)-1;
        start = ceil(TruncationMass / 256);
        
        if TruncationMass > 0
            %% Find Truncation Location and Type
            RightIndex = -1;
            
            for m = start:prtLength                
                diff_right = Protein.RightIons(m) - TruncationMass;
                
                if abs(diff_right) <= tol %% None
                    RightIndex = m;
                end
                
                if diff_right > tol
                    break;
                end
            end
            
            %% Save Data
            if  RightIndex == -1
                RemainIndex = RemainIndex + 1;
                RemainingProteins(RemainIndex) = {Protein};
            else
                ProteinIndex = ProteinIndex + 1;
                TruncationIndex  = prtLength - RightIndex;
                Protein.Truncation = 'Right';
                Protein.LeftIons = Protein.LeftIons(1:TruncationIndex);
                Protein.RightIons = Protein.RightIons - Protein.RightIons(RightIndex);
                Protein.RightIons(1:RightIndex) = [];
                Sequence= Protein.Sequence(1:TruncationIndex);
                Protein.Sequence = Sequence;
                
                if numel(Protein.Sequence) < 5
                    continue;
                end
                
                Protein.TruncationIndex =  TruncationIndex;
                Protein.MolW = Protein.RightIons(numel(Protein.Sequence)) + 1.0078250321 + 1.0078250321 + 15.9949146221;
                Candidate_ProteinsList{ProteinIndex} = Protein;
            end
            
        end
    end
    RemainingProteins = RemainingProteins(~cellfun('isempty', RemainingProteins));
    Candidate_ProteinsList = Candidate_ProteinsList(~cellfun('isempty', Candidate_ProteinsList));
else
    RemainingProteins = [];
    for index = 1: numel(Candidate_ProteinsListInput)
        %% --- Calculate Molecular Weight of Database Protein
        Protein = Candidate_ProteinsListInput{index};
        prtLength = numel(Protein.Sequence);
        %% shift experimental Mass by truncation mass
        TruncationMass = Protein.MolW - Protein_ExperimentalMW;
        
        start = ceil(TruncationMass / 168)-1;
        if TruncationMass > 0
            %% Find Truncation Location and Type
            RightIndex = -1;
            
            % m = 1:numel(Protein_List.Sequence)
            for  m = start:prtLength
                diff_right = Protein.RightIons(m) - TruncationMass;
                
                if abs(diff_right) <= tol 
                    RightIndex = m;
                end
                
                if diff_right > tol
                    break;
                end
            end
            
            %% Save Data
            if  RightIndex == -1
            else
                ProteinIndex = ProteinIndex + 1;
                TruncationIndex  = prtLength - RightIndex;
                Protein.Truncation = 'Right';
                Protein.LeftIons = Protein.LeftIons(1:TruncationIndex);
                Protein.RightIons = Protein.RightIons - Protein.RightIons(RightIndex);
                Protein.RightIons(1:RightIndex) = [];
                Sequence= Protein.Sequence(1:TruncationIndex);
                Protein.Sequence = Sequence;
                
                if numel(Protein.Sequence) < 5
                    continue;
                end
                
                Protein.TruncationIndex =  TruncationIndex;
                Protein.MolW = Protein.RightIons(numel(Protein.Sequence)) + 1.0078250321 + 1.0078250321 + 15.9949146221;
                Candidate_ProteinsList{ProteinIndex} = Protein;
            end
            
        end
    end
    Candidate_ProteinsList = Candidate_ProteinsList(~cellfun('isempty', Candidate_ProteinsList));
end
end