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
function [Candidate_ProteinsList_Modified] = BlindPTM_Truncation_Right(RemainingProteins_Right, PepTol, User_Hop_Threshold,PepUnit, sizeHopeInfo,Hop_Info_name, Hop_Info_AA, Hop_Info_end, Hop_Info_start)
Candidate_ProteinsList_Modified = cell(numel(RemainingProteins_Right),1);
ProteinIndex = 0;

% Experimental peak extraction and peak fliping.
%%% Updated 20210409   %% BELOW
%ExperimentalSpectrum = sortrows(getappdata(0,'Peaklist_Data'));
PeakListMW = getappdata(0,'Fragments_Masses');
Intensity = getappdata(0,'Int');
ExperimentalSpectrum = [PeakListMW, Intensity];%sortrows(getappdata(0,'Peaklist_Data'));
%%% Updated 20210409   %% ABOVE

MolW = ExperimentalSpectrum(size(ExperimentalSpectrum,1));

if size(ExperimentalSpectrum,1) == 1
    tolConv = ExperimentalSpectrum(size(ExperimentalSpectrum,1));
else
    tolConv = ExperimentalSpectrum(size(ExperimentalSpectrum,1)-1);
end

if sizeHopeInfo > 0
    %% Outer loop
    for index = 1: numel(RemainingProteins_Right)
        %% Prepare Right Truncation
        protein = RemainingProteins_Right{index};
        Sequence = protein.Sequence;
        
        %% Inner Loop variables
        HopI = 1;
        ThrI = 1;
        loop = 1;
        Shortlisted_Hops = {};
        Ladder_Index = 0;
        
        %% Inner Loop
        while(loop)
            Start = Hop_Info_start(HopI);
            
            if (Ladder_Index ~= 0 && Shortlisted_Hops{Ladder_Index,3} > Start)
                HopI = HopI + 1;
                if HopI >= sizeHopeInfo
                    break
                end
                continue;
            end
            
            diff =  Start - protein.LeftIons(ThrI);
            if diff <= User_Hop_Threshold && diff >= -User_Hop_Threshold
                AA = Hop_Info_AA(HopI);
                if AA(1) == Sequence(ThrI+1)
                    Mod = Hop_Info_name(HopI);
                    M = ModTable(Mod{1,1});
                    End = Hop_Info_end(HopI);
                    diff = abs( End - (protein.LeftIons(ThrI+1) + M));
                    if strcmp(PepUnit,'ppm')
                        diff = (diff/tolConv)*1000000;
                    elseif strcmp(PepUnit,'%')
                        diff = (diff/tolConv)*100;
                    end
                    if diff < PepTol
                        for i = ThrI+1 : numel(protein.LeftIons)
                            protein.LeftIons(i) = protein.LeftIons(i) + M;
                        end
                        
                        for i = numel(protein.Sequence)-ThrI : numel(protein.RightIons)
                            protein.RightIons(i) = protein.RightIons(i) + M;
                        end
                        
                        protein.MolW = protein.MolW + M;
                        Ladder_Index = Ladder_Index + 1;
                        Shortlisted_Hops{Ladder_Index,1} = Mod{1,1};
                        Shortlisted_Hops{Ladder_Index,2} = {AA};
                        Shortlisted_Hops{Ladder_Index,3} = End;
                        Shortlisted_Hops{Ladder_Index,4} = Start;
                        Shortlisted_Hops{Ladder_Index,5} = ThrI;
                    end
                end
            elseif diff > User_Hop_Threshold
                ThrI = ThrI + 1;
                if ThrI >= numel(protein.LeftIons)
                    break
                end
                continue;
            elseif diff < -User_Hop_Threshold
                HopI = HopI + 1;
                if HopI >= sizeHopeInfo
                    break
                end
                continue;
            end
            
            HopI = HopI + 1;
            if HopI >= sizeHopeInfo
                break
            end
            
        end
        
        if protein.PTM_seq_idx == -1
            protein.PTM_seq_idx = [];
        end
        
        for HopIndex = 1 : size(Shortlisted_Hops ,1)
            protein.PTM_name = [protein.PTM_name; {Shortlisted_Hops{HopIndex,1}}];
            protein.PTM_site = [protein.PTM_site; Shortlisted_Hops{HopIndex,2}];
            protein.PTM_seq_idx = [protein.PTM_seq_idx; Shortlisted_Hops{HopIndex,5}+1];
        end
        
        if size(Shortlisted_Hops ,1) > 0
            ProteinIndex = ProteinIndex + 1;
            Candidate_ProteinsList_Modified(ProteinIndex) = {protein};
        end
    end
end
Candidate_ProteinsList_Modified = Candidate_ProteinsList_Modified(~cellfun(@isempty, Candidate_ProteinsList_Modified));
end

function M = ModTable(Mod)

%Pyruvate
if (strcmp(Mod , 'Pyruvate-S'))
    M = -17.0265;
    
    %Pyruvate
elseif (strcmp(Mod , 'Pyruvate-C'))
    M = 70.0055;
    
    %Amidation
elseif (strcmp(Mod , 'Amidation'))
    M = -0.984016;
    
    %Citrullination
elseif (strcmp(Mod , 'Citrullination'))
    M =  0.984016;
    
    %Methylation
elseif (strcmp(Mod , 'Methylation'))
    M = 14.0156;
    
    %Hydroxylation
elseif (strcmp(Mod , 'Hydroxylation'))
    M = 15.9949;
    
    %Sulfoxide
elseif (strcmp(Mod , 'Sulfoxide'))
    M = 15.9949;
    
    %Formylation
elseif (strcmp(Mod , 'Formylation'))
    M = 27.9949;
    
    %DiMethylation
elseif (strcmp(Mod , 'DiMethylation'))
    M = 28.0313;
    
    % S-Nitrosylation
elseif (strcmp(Mod , 'S-Nitrosylation'))
    M = 28.9902;
    
    %Sulfone
elseif (strcmp(Mod , 'Sulfone'))
    M = 31.9898;
    
    %DiHydroxylation
elseif (strcmp(Mod , 'DiHydroxylation'))
    M = 31.9898;
    
    %TriMethylation
elseif (strcmp(Mod , 'TriMethylation'))
    M = 42.047;
    
    %Acetylation
elseif (strcmp(Mod , 'Acetylation'))
    M = 42.0106;
    
    %Gamma-Carboxyglutamic Acid
elseif (strcmp(Mod , 'Gamma-Carboxyglutamic-Acid'))
    M = 43.9898;
    
    %Nitration
elseif (strcmp(Mod , 'Nitration'))
    M = 44.9851;
    
    %Phosphorylation
elseif (strcmp(Mod , 'Phosphorylation'))
    M = 79.9663;
    
    %Pyrrolidone Aarboxylic Acid
elseif (strcmp(Mod , 'Pyrrolidone-Aarboxylic-Acid'))
    M = -17.0265;
    
    %O Linked Glycosylation
elseif (strcmp(Mod , 'O-linked-Glycosylation'))
    M = 203.0794;
    
    %Palmitoylation
elseif (strcmp(Mod , 'Palmitoylation'))
    M = 238.23;
    
    %Glutathionylation
elseif (strcmp(Mod , 'Glutathionylation'))
    M = 305.068;
    
    %N Linked Glycosylation
elseif (strcmp(Mod , 'N-linked-Glycosylation'))
    M = 317.122;
    
end
end

