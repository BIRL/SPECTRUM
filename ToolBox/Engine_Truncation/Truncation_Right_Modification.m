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

function [Candidate_ProteinsList] = Truncation_Right_Modification(Candidate_ProteinsListInput, Peptide_Tolerance, PepUnit, Frag_technique)

Candidate_ProteinsList = cell(numel(Candidate_ProteinsListInput),1);
ProteinIndex = 0;

%%% Updated 20210409   %% BELOW
%ExperimentalPeakList = getappdata(0,'Peaklist_Data');
PeakListMW = getappdata(0,'Fragments_Masses');
Intensity = getappdata(0,'Int');
ExperimentalPeakList = [PeakListMW, Intensity];%sortrows(getappdata(0,'Peaklist_Data'));
ExperimentalPeakList_Shifted = ExperimentalPeakList(:,1);
Protein_ExperimentalMW = ExperimentalPeakList_Shifted(end);
%%% Updated 20210409   %% ABOVE

H = 1.007825035;
C = 12.0000;
O = 15.99491463;
N = 14.003074;
Electron = 0.000549; %#ok<NASGU>
OH = O + H;
CO = C + O;
NH = N + H;

%20181019 - Fixing the overloaded function error
%tol = 2
% Experimental peak extraction and peak fliping.
ExperimentalSpectrum = ExperimentalPeakList; % Updated 20210410 %sortrows(getappdata(0,'Peaklist_Data'));
% MolW = ExperimentalSpectrum(size(ExperimentalSpectrum,1));

if size(ExperimentalSpectrum,1) == 1
    tolConv = ExperimentalSpectrum(size(ExperimentalSpectrum,1));
else
    tolConv = ExperimentalSpectrum(size(ExperimentalSpectrum,1)-1);
end

%20181024 - Fixing the units for tolerance
%tol = (Peptide_Tolerance/tolConv)*1000000; %Convert tol to ppm             

tol = 0;
if strcmp(PepUnit,'ppm')
    tol = (Peptide_Tolerance/tolConv)*1000000;
elseif strcmp(PepUnit,'%')
    tol = (Peptide_Tolerance/tolConv)*100;
end

for index = 1: numel(Candidate_ProteinsListInput)
    %% --- Calculate Molecular Weight of Database Protein
    Protein_List = Candidate_ProteinsListInput{index,1};
    
    %% shift experimental Mass by truncation mass
    TruncationMass = Protein_List.MolW - Protein_ExperimentalMW;
    
    
    similar_fragments = {'CID','IMD','BIRD','SID','HCD'};
    similar_fragments2 = {'ECD','ETD'};
    similar_fragments3 = {'EDD','NETD'};
    
    if any(strcmpi(Frag_technique,similar_fragments))
        TruncationMass = TruncationMass + OH + (2*H);
    end
    if any(strcmpi(Frag_technique,similar_fragments2))
        TruncationMass = TruncationMass + OH - NH;
    end
    if any(strcmpi(Frag_technique,similar_fragments3))
        TruncationMass = TruncationMass + OH + CO;
    end
    
    if TruncationMass > 0
        %% Find Truncation Location and Type
        RightIndex = -1;
        
        for  m = 1:numel(Protein_List.Sequence)
            diff_right = Protein_List.RightIons(m) - TruncationMass;
            
            if abs(diff_right) <= tol %% None
                RightIndex = m;
            end
            
            if diff_right > tol
                break;
            end
        end
        
        %% Save Data
        if  RightIndex ~= -1
            ProteinIndex = ProteinIndex + 1;
            TruncationIndex  = length(Protein_List.Sequence) - RightIndex;
            Protein_List.Truncation = 'Right';
            Protein_List.LeftIons = Protein_List.LeftIons(1:TruncationIndex);
            Protein_List.RightIons = Protein_List.RightIons - Protein_List.RightIons(RightIndex);
            Protein_List.RightIons(1:RightIndex) = [];
            Sequence = Protein_List.Sequence(1:TruncationIndex);
            Protein_List.Sequence = Sequence;
            
            if numel(Protein_List.Sequence) < 5
                continue;
            end
            
            Protein_List.TruncationIndex =  TruncationIndex;
            Protein_List.MolW = Protein_List.RightIons(numel(Protein_List.Sequence)) + 1.0078250321 + 1.0078250321 + 15.9949146221;
            Candidate_ProteinsList(ProteinIndex) = {Protein_List};
        end
        
    end
end
Candidate_ProteinsList = Candidate_ProteinsList(~cellfun('isempty', Candidate_ProteinsList));
end