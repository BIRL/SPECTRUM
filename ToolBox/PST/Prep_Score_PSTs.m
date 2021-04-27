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

%Updated Below 20210427
% Fragments_Peaklist_Data = getappdata(0,'Peaklist_Data');

% % All fragment peaks will be extracted except the mass of the intact protein
% prot_ExperimentalPeakList = sortrows(Fragments_Peaklist_Data(1:size_pkList,:));

Fragments_Masses = getappdata(0,'Fragments_Masses');
size_pkList = size(Fragments_Masses ,1); % Size/number of the fragments peaks

Intensity = getappdata(0,'Int');
prot_ExperimentalPeakList = [Fragments_Masses Intensity]
%Updated Above 20210427

% extract ESTs using the find peaks function
Tag_ladder = Extract_PSTs(prot_ExperimentalPeakList,User_Taglength_max_threshold,User_Taglength_min_threshold,User_hop_threshold,User_tagError_threshold);
if ~isempty(Tag_ladder)
    Tag_Ladder = {};
    for l = 1:size(Tag_ladder.Taglength,2)
        Tag_Ladder{l} = {cell2mat(Tag_ladder.Tag(l)),Tag_ladder.Errors(l),...
            Tag_ladder.Taglength(l),Tag_ladder.Tags_Error_Array(l),...
            Tag_ladder.Tags_Intesnsity_Array(l)}; %#ok<*AGROW>
    end
else
    Tag_Ladder = {};
end

%% Accomodate Isoforms %%Updated 20210325
if not(isempty(Tag_Ladder))
    Temp_Ladder = {};
    Hop_threshold=getappdata(0,'Hop_threshold');
    
    User_Hop_threshold = double(string(Hop_threshold));
    
    %% PST correction for I,L,Q and K
    j=1;
    StartIndex = 1;
    EndIndex = size(Tag_Ladder,2);
    ResidueForReplacement = { 'L', 'D', 'N', 'E', 'Q' };
    LoopRun = true;
    Change = 0;  % Flag Use to break While Loop
    while LoopRun
        for i = StartIndex: EndIndex
            Change = 0;
            StartindexResidueAA = 1;
            for indexResidueAA = StartindexResidueAA:size(ResidueForReplacement,2)
                BeforeAccomodatePst = Tag_Ladder{i}{1};
                OldResidue = ResidueForReplacement{indexResidueAA};
                CheckResidue = strfind(BeforeAccomodatePst,OldResidue);
                if size(CheckResidue,1) ~= 0
                    if (OldResidue == 'L')    %%Here I think Switch Case will be more better....!!!!
                        newResidue = "I";
                    elseif (OldResidue == 'D')
                        newResidue = "B";
                    elseif (OldResidue == 'N')
                        newResidue = "B";
                    elseif (OldResidue == 'E')
                        newResidue = "Z";
                    elseif (OldResidue == 'Q' && User_Hop_threshold <= 1.5)
                        newResidue = "Z";
                    elseif (OldResidue == 'Q' && User_Hop_threshold > 1.5)
                        newResidue = "K";
                    end
                    for iter = 1: size(BeforeAccomodatePst,2)
                        if BeforeAccomodatePst(1, iter) == OldResidue
                            ResidueInserted = BeforeAccomodatePst;
                            ResidueInserted(1, iter) = newResidue;
                            
                            l = length(Tag_Ladder);
                            l = l + 1;
                            Tag_Ladder{l}{1}=ResidueInserted;
                            Tag_Ladder{l}{2}=Tag_Ladder{i}{2};
                            Tag_Ladder{l}{3}=Tag_Ladder{i}{3};
                            Tag_Ladder{l}{4}=Tag_Ladder{i}{4};
                            Tag_Ladder{l}{5}=Tag_Ladder{i}{5};
                            Change = 1;
                            BeforeAccomodatePst = ResidueInserted;
                        end
                    end
                end
            end
        end
        StartIndex =  EndIndex + 1;
        EndIndex = size(Tag_Ladder, 2);
        
        if (StartIndex > EndIndex && Change == 0)
            LoopRun = false;
            break;
        end
    end
    
    Tag_Ladder = FindUniquePstAgain( Tag_Ladder, User_tagError_threshold );
end
