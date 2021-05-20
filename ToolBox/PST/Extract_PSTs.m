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

function LaddersList =  Extract_PSTs(Peak_List, User_max_TagLength_Threshold,User_Taglength_min_threshold,User_Hop_Threshold,User_tagError_threshold)

LaddersList={};

[AminoAcidsMasses,AminoAcidsSymbol,AminoAcidsName]=Monoisotopic_weight();
HopInfo={} ;
Ladder_Index = 00; %index ladder
Num_AA=21; % Standard Amino Acids

for Peak_Index = 1:(size(Peak_List,1)-1) % Hop_Index
    for Hop_Index = (Peak_Index+1) : size(Peak_List,1)
        Peaks_MW_Difference = Peak_List(Hop_Index) - Peak_List(Peak_Index);
        for AminoAcid_Index = 1:Num_AA % number itration increase from 20 to 39 :20 unmodified and 33 for PTM and 39 if other modification are selected
            TagError = Peaks_MW_Difference - AminoAcidsMasses(AminoAcid_Index);
            absError = abs(TagError);
            if  absError <= User_Hop_Threshold
                Ladder_Index =Ladder_Index + 1;
                HopInfo{Ladder_Index} = {Peak_Index,Hop_Index,Peak_List(Peak_Index),...
                    Peak_List(Hop_Index),Peaks_MW_Difference, ...
                    AminoAcidsSymbol(AminoAcid_Index),AminoAcidsName(AminoAcid_Index),TagError...
                    (Peak_List(Peak_Index,2)+Peak_List(Hop_Index,2))/2};
            else
                if TagError < -User_Hop_Threshold
                    break;
                end
            end
        end
    end
end

%Num_AAs_Found=(length(HopInfo)-1);
Num_AAs_Found=(length(HopInfo));

length_tags=1;
Ladder_raw={};
index = 1;
for Home_peak=1:(Num_AAs_Found-1)   %(Num_AAs_Found-1)
    for Strat_peak=1:(Num_AAs_Found-1)   %(Num_AAs_Found-1)
        AA_NextAdder=''; %#ok<NASGU>
        Hop_peak=(Strat_peak+1);
        if(HopInfo{Home_peak}{2}==HopInfo{Hop_peak}{1})
            
            AA_NextAdder =[HopInfo{Home_peak};HopInfo{Hop_peak}]; %#ok<*AGROW>
            Ladder_raw{index,1}= AA_NextAdder;
            index = index + 1;
            % branches and position
            %             AA_Next=Join(Hop_peak,length_tags,HopInfo,Num_AAs_Found,User_max_TagLength_Threshold+1);
            %             for iter = 1 : numel(AA_Next)
            %                 AA_NextAdder=[HopInfo{Home_peak};AA_Next{iter,1}]; %#ok<*AGROW>
            %                 Ladder_raw{length_tags,1}= AA_NextAdder;
            %                 length_tags = length_tags+1;
            %             end
        end
        if (HopInfo{Home_peak}{2} < HopInfo{Hop_peak}{1})
            break;
        end
    end
end

if(~isempty(Ladder_raw))
    Ladder_raw = MultipleTags(Ladder_raw, User_max_TagLength_Threshold,User_Taglength_min_threshold,User_Hop_Threshold,User_tagError_threshold, HopInfo);
    LaddersList = ladder_extrection_trim(Ladder_raw,User_max_TagLength_Threshold,User_Taglength_min_threshold,User_tagError_threshold);
end
end