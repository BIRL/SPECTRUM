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

%% This Fuction is used to pepare the PSTs for Protein Specific Scoring
function [Tag_Ladder] = Prep_Score_PSTs(User_Taglength_min_threshold,User_Taglength_max_threshold,User_hop_threshold,User_tagError_threshold )
Fragments_Peaklist_Data = getappdata(0,'Peaklist_Data');
size_pkList = size(Fragments_Peaklist_Data,1); % Size/number of the fragments peaks
% All fragment peaks will be extracted except the mass of the intact protein
prot_ExperimentalPeakList = sortrows(Fragments_Peaklist_Data(1:size_pkList,:));
% extract ESTs using the find peaks function
Tag_ladder = Extract_PSTs(prot_ExperimentalPeakList,User_Taglength_max_threshold,User_Taglength_min_threshold,User_hop_threshold,User_tagError_threshold);
if ~isempty(Tag_ladder)
    Tag_Ladder = {};
    for l = 1:size(Tag_ladder.Taglength,2)
        Tag_Ladder{l} = {cell2mat(Tag_ladder.Tag(l)),Tag_ladder.Taglength(l),Tag_ladder.Score_Error(l),Tag_ladder.Frequency(l)}; %#ok<*AGROW>
    end
else
    Tag_Ladder = {};
end

if not(isempty(Tag_Ladder))
    Temp_Ladder = {};
    Hop_threshold=getappdata(0,'Hop_threshold');
    
    %% PST correction for I,L,Q and K
    j=0;
    for i=1:length( Tag_Ladder)
        ind_se=strfind(Tag_Ladder{i}{1},'L');
        if not(isempty(ind_se))
            j=j+1;
            tem_seq=Tag_Ladder{i}{1};
            for ind=1:length(ind_se)
                tem_seq(ind_se(ind))='I';
                Temp_Ladder{j}{1}=tem_seq;
                Temp_Ladder{j}{2}=Tag_Ladder{i}{2};
                Temp_Ladder{j}{3}=Tag_Ladder{i}{3};
                Temp_Ladder{j}{4}=Tag_Ladder{i}{4};
                j=j+1;
            end
        end
        
        %%%
        ind_se=strfind(Tag_Ladder{i}{1},'D');
        if not(isempty(ind_se))
            j=j+1;
            tem_seq=Tag_Ladder{i}{1};
            for ind=1:length(ind_se)
                tem_seq(ind_se(ind))='B';
                Temp_Ladder{j}{1}=tem_seq;
                Temp_Ladder{j}{2}=Tag_Ladder{i}{2};
                Temp_Ladder{j}{3}=Tag_Ladder{i}{3};
                Temp_Ladder{j}{4}=Tag_Ladder{i}{4};
                j=j+1;
            end
        end
        
        %%%
        ind_se=strfind(Tag_Ladder{i}{1},'N');
        if not(isempty(ind_se))
            j=j+1;
            tem_seq=Tag_Ladder{i}{1};
            for ind=1:length(ind_se)
                tem_seq(ind_se(ind))='B';
                Temp_Ladder{j}{1}=tem_seq;
                Temp_Ladder{j}{2}=Tag_Ladder{i}{2};
                Temp_Ladder{j}{3}=Tag_Ladder{i}{3};
                Temp_Ladder{j}{4}=Tag_Ladder{i}{4};
                j=j+1;
                
            end
        end
        
        %%%
        ind_se=strfind(Tag_Ladder{i}{1},'E');
        if not(isempty(ind_se))
            j=j+1;
            tem_seq=Tag_Ladder{i}{1};
            for ind=1:length(ind_se)
                tem_seq(ind_se(ind))='Z';
                Temp_Ladder{j}{1}=tem_seq;
                Temp_Ladder{j}{2}=Tag_Ladder{i}{2};
                Temp_Ladder{j}{3}=Tag_Ladder{i}{3};
                Temp_Ladder{j}{4}=Tag_Ladder{i}{4};
                j=j+1;
            end
        end
        
        %%%
        ind_se=strfind(Tag_Ladder{i}{1},'Q');
        if not(isempty(ind_se))
            j=j+1;
            tem_seq=Tag_Ladder{i}{1};
            for ind=1:length(ind_se)
                tem_seq(ind_se(ind))='Z';
                Temp_Ladder{j}{1}=tem_seq;
                Temp_Ladder{j}{2}=Tag_Ladder{i}{2};
                Temp_Ladder{j}{3}=Tag_Ladder{i}{3};
                Temp_Ladder{j}{4}=Tag_Ladder{i}{4};
                j=j+1;
                
            end
        end

        if (double(string(Hop_threshold))>1.5) %20200124 Bug Fix  %%(Hop_threshold>1.5)
            ind_se=strfind(Tag_Ladder{i}{1},'Q');
            if not(isempty(ind_se))
                j=j+1;
                tem_seq=Tag_Ladder{i}{1};
                for ind=1:length(ind_se)
                    tem_seq(ind_se(ind))='K';
                    Temp_Ladder{j}{1}=tem_seq;
                    Temp_Ladder{j}{2}=Tag_Ladder{i}{2};
                    Temp_Ladder{j}{3}=Tag_Ladder{i}{3};
                    Temp_Ladder{j}{4}=Tag_Ladder{i}{4};
                    j=j+1;
                end
            end
        end
    end
    
    Temp_Ladder = Temp_Ladder(~cellfun('isempty',Temp_Ladder)); % trim the ladder cell array
    l=length(Tag_Ladder);
    for i=1:length(Temp_Ladder)
        l=l+1;
        Tag_Ladder{l}{1}=Temp_Ladder{i}{1};
        Tag_Ladder{l}{2}=Temp_Ladder{i}{2};
        Tag_Ladder{l}{3}=Temp_Ladder{i}{3};
        Tag_Ladder{l}{4}=Temp_Ladder{i}{4};
    end
end