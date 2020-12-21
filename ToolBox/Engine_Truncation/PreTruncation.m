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
function [Candidate_ProteinsList_Left,Candidate_ProteinsList_Right] = PreTruncation(Candidate_ProteinsListInput,MW_threshold)
Terminal_Modification = getappdata(0,'Othermodification_Terminal');
None = Terminal_Modification(1);
NME = Terminal_Modification(2);
NME_Acetylation = Terminal_Modification(3);
M_Acetylation = Terminal_Modification(4);
x = sum(Terminal_Modification(:) == 1);

BatchMode = getappdata(0, 'Batch');

Candidate_ProteinsList_Left = cell(numel(Candidate_ProteinsListInput),1);
Candidate_ProteinsList_Right = cell(numel(Candidate_ProteinsListInput)*x,1);

LeftIndex = 0;
RightIndex = 0;


AcetylationWeight = 42.0106;
AA_MW_Array;
ExperimentalPeakList = getappdata(0,'Peaklist_Data');
Protein_ExperimentalMW = ExperimentalPeakList(1);

for index = 1: numel(Candidate_ProteinsListInput)
    Protein = Candidate_ProteinsListInput{index,1};
    Sequence = Protein.Sequence;
    ProteinLength = numel(Sequence);
    
    LeftIonsBackUp = Protein.LeftIons;
    RightIonsBackUp = Protein.RightIons;
    
    if BatchMode == 1
        %% ---- Extract Database Protein ID and Name ---------
        IdSeparatorIndex = strfind(Protein.Header,'|');
        NameSeparatorIndex = strfind(Protein.Header,'=');
        Protein.Id = Protein.Header(IdSeparatorIndex(1)+1:IdSeparatorIndex(2)-1);
        Protein.Name = Protein.Header(IdSeparatorIndex(2)+1:NameSeparatorIndex(1)-4);
    end
    
    %% Save Copy for Right Truncation
    PreTruncationIndex = ProteinLength;
    start = ceil((Protein_ExperimentalMW + MW_threshold) / 168)-1;
    
    LeftIons = LeftIonsBackUp; %%%%
    for m = start:1:ProteinLength %20200210 Updated By  start:2:ProteinLength
        if LeftIons(m) - Protein_ExperimentalMW > MW_threshold
            PreTruncationIndex = m;
            break;
        end
    end
    
    Protein.TruncationIndex = PreTruncationIndex;
    %         Protein.TruncationIndex') = PreTruncationIndex;
    
    tmpSeq = Sequence(1:PreTruncationIndex);
    tmpSeqLength = numel(tmpSeq);
    %         Protein.Sequence = tmpSeq;
    Protein.Sequence = tmpSeq;
    
    LeftIons = LeftIons(1:PreTruncationIndex);
    MolW = LeftIons(tmpSeqLength) + 1.0078250321 + 1.0078250321 + 15.9949146221;
    
    %% Right Ion Stuff
    TruncationIndex = ProteinLength - PreTruncationIndex;
    RightIons = RightIonsBackUp; %%%
    if TruncationIndex ~= 0
        InsilicoTruncationIdxMass = RightIons(TruncationIndex);
        RightIons = RightIons(TruncationIndex+1:ProteinLength);
        RightIons = RightIons - InsilicoTruncationIdxMass;
    end
    
    if None == 1
        RightIndex = RightIndex + 1;
        Protein.MolW = MolW;
        Protein.LeftIons = LeftIons;
        Protein.RightIons = RightIons;
        Candidate_ProteinsList_Right{RightIndex} = Protein;
    end
    if tmpSeq(1) == 'M'
        if NME == 1
            RightIndex = RightIndex + 1;
            %Updated 20201216 BELOW
            temp = Protein;
            temp.Terminal_Modification = 'NME';
            temp.MolW = MolW - AA(double('M')-64);
            temp.LeftIons = LeftIons - AA(double('M')-64);
            temp.LeftIons(1) = [];  
            temp.RightIons(length(Protein.Sequence))= [];   %Updated 20201222  %Bug Fixed 
            temp.EST_Score = Protein.EST_Score * (numel(Protein.Sequence)/(numel(Protein.Sequence)-1));
            temp.Sequence = tmpSeq(2:tmpSeqLength);
            Candidate_ProteinsList_Right{RightIndex} = temp;
            %Updated 20201216 ABOVE
        end
        if NME_Acetylation == 1
            RightIndex = RightIndex + 1;
            %Updated 20201216 BELOW
            temp = Protein;
            temp.Terminal_Modification = 'NME_Acetylation';
            temp.MolW = MolW - AA(double('M')-64) + AcetylationWeight;
            temp.LeftIons = LeftIons - AA(double('M')-64)+ AcetylationWeight;
            temp.LeftIons(1) = [];
            temp.RightIons(length(Protein.Sequence))= [];   %Updated 20201222  %Bug Fixed
            temp.EST_Score = Protein.EST_Score * (numel(Protein.Sequence)/(numel(Protein.Sequence)-1));
            temp.Sequence = tmpSeq(2:tmpSeqLength);
            Candidate_ProteinsList_Right{RightIndex} = temp;
            %Updated 20201216 ABOVE
        end
        if M_Acetylation == 1
            RightIndex = RightIndex + 1;
            %Updated 20201216 BELOW
            temp = Protein;
            temp.Terminal_Modification = 'M_Acetylation';
            temp.Sequence = tmpSeq;
            temp.MolW = MolW + AcetylationWeight;
            temp.LeftIons = LeftIons + AcetylationWeight;
            Candidate_ProteinsList_Right{RightIndex} = temp;
            %Updated 20201216 ABOVE
        end
    end
    
    %% Save Copy for Left Truncation
    PreTruncationIndex = ProteinLength;
    RightIons = RightIonsBackUp;
    
    start = ceil((Protein_ExperimentalMW + MW_threshold) / 168)-1;
    for m = start:1:ProteinLength %20200210 Updated By  start:2:ProteinLength
        if RightIons(m) - Protein_ExperimentalMW > MW_threshold
            PreTruncationIndex = m;
            break;
        end
    end
    
    TruncationIndex  = ProteinLength - PreTruncationIndex + 1;
    Protein.TruncationIndex = TruncationIndex;
    TempSequence = Sequence(TruncationIndex:ProteinLength);
    Protein.Sequence = TempSequence;
    RightIons = RightIons(1:PreTruncationIndex);
    
    %% Left Ion Stuff
    if TruncationIndex-1 ~= 0
        LeftIndex = LeftIndex + 1;
        Protein.MolW = RightIons(numel(TempSequence)) + 1.0078250321 + 1.0078250321 + 15.9949146221;
        Protein.Terminal_Modification = 'None';
        LeftIons = LeftIonsBackUp;
        InsilicoTruncationIdxMass = LeftIons(TruncationIndex-1);
        LeftIons = LeftIons(TruncationIndex:ProteinLength);
        LeftIons = LeftIons - InsilicoTruncationIdxMass;
        
        Protein.LeftIons = LeftIons;
        Protein.RightIons = RightIons;
        
        Candidate_ProteinsList_Left{LeftIndex} = Protein; %#ok<*AGROW>
    end
end
Candidate_ProteinsList_Left = Candidate_ProteinsList_Left(~cellfun('isempty', Candidate_ProteinsList_Left));
Candidate_ProteinsList_Right = Candidate_ProteinsList_Right(~cellfun('isempty', Candidate_ProteinsList_Right));
end