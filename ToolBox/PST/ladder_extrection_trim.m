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

%% This Function is used for the Extrection and the Triming of the Peptide
%  Sequece tags. It will also remove any duplicate entry present in the list
function Tag_ladder =  ladder_extrection_trim(Ladder,User_max_TagLength_Threshold,User_Taglength_min_threshold,User_tagError_threshold)

% Break the larger Tags into all possible smaller tags
% length_tags = 0;
% for LadderIndex = 1: size(Ladder_raw,1)
%     for startindex  = 1 : (size(Ladder_raw{LadderIndex,1},1))
%         for endindex = startindex : (size(Ladder_raw{LadderIndex,1},1))
%             length_tags = length_tags + 1;
%             Ladder{length_tags} = Ladder_raw{LadderIndex,1}(startindex:endindex,:); %#ok<AGROW>
%         end
%     end
% end
% 
% [dummy, Index] = sort(cellfun('size', Ladder, 1), 'ascend'); %#ok<ASGLU> %% arrange the ladder in the ascending order of their size
% Ladder = Ladder(Index);
% Ladder = Ladder';
% for LadderIndex = 1: size(Ladder,1) %% Find and remove the Ledder which violate Maximum and Minimum length condition
%     if ((size(Ladder{LadderIndex,1},1)) > User_max_TagLength_Threshold  || (size(Ladder{LadderIndex,1},1)) < User_Taglength_min_threshold)
%         Ladder{LadderIndex,1} = [];
%         
%     end
% end
% Ladder = Ladder(~cellfun('isempty',Ladder)); % trim the ladder cell array
Ladder = Ladder';

%% 

Tags = cell(1,numel(Ladder));
Errors = zeros(1,numel(Ladder));
TagLength = zeros(1,numel(Ladder));
Tags_Error_Array = zeros(1,numel(Ladder)); %%%
Tags_Intesnsity_Array = zeros(1,numel(Ladder)); %%%

for i = 1:numel(Ladder)
    Tag = blanks(size(Ladder{1,i},1));
    Error_sum = 0;
    Intensity_sum = 0;
    tagLength = size(Ladder{1,i},1);
    for row = 1:tagLength
        Tag(row) = Ladder{1,i}{row,6};
        error = Ladder{1,i}{row,8}^2;
        Intensity_sum = Intensity_sum + Ladder{1,i}{row,9};
        Error_sum = Error_sum + error;
    end
    Tags{i} = Tag;
    Errors(i) = Error_sum;
    TagLength(i) = tagLength;
    RMSE = sqrt(Error_sum)/tagLength; %%%
    Tags_Error_Array(i) = RMSE*10;%%%%
    Tags_Intesnsity_Array(i) = Intensity_sum /tagLength; %%%
end

[Tags,SortIdx] = sort(Tags);
Errors = Errors(SortIdx);
Tags_Error_Array = Tags_Error_Array(SortIdx);
Tags_Intesnsity_Array = Tags_Intesnsity_Array(SortIdx);
TagLength = TagLength(SortIdx);
% Ladder = Ladder(SortIdx);
[~,I]  = sort(cellfun(@length,Tags));
Tags = Tags(I);
Errors = Errors(I);
Tags_Error_Array = Tags_Error_Array(I);
Tags_Intesnsity_Array = Tags_Intesnsity_Array(I);
TagLength = TagLength(I);
% Ladder = Ladder(I);

% Find all the duplicate tags from the ladder list and only keep the one
% with the lowest Root Mean Square Error (RMSE).
if numel(unique(Tags)) ~= numel(Tags)
    start1 = 1;
    while(1)
        Error_sum = Errors(1,start1);
        Tag = Tags{1,start1};
        for start2 = start1+1:numel(Tags)
            Error_sum1 = Errors(1,start2);
            Tag1 = Tags{1,start2};
            if strcmpi(Tag,Tag1)
                %% IF
                if(Error_sum < Error_sum1)
                    Tags{1,start2} = '';
                    Errors(1,start2) = -1;
                    TagLength(1,start2) = -1;
                    Tags_Error_Array(1,start2) = -1;
                    Tags_Intesnsity_Array(1,start2) = -1;                    
                %% Else  
                %%%ADDED BELOW %Updated 20201216
                elseif (Error_sum > Error_sum1)
                        Tags{1,start1} = '';
                        Errors(1,start1) = -1;
                        TagLength(1,start1) = -1;
                        Tags_Error_Array(1,start1) = -1;
                        Tags_Intesnsity_Array(1,start1) = -1;
                        start1 = start2;
                else     %Error_sum == Error_sum1
                    if(Tags_Intesnsity_Array(1,start1) <= Tags_Intesnsity_Array(1,start2))
                        Tags{1,start1} = '';
                        Errors(1,start1) = -1;
                        TagLength(1,start1) = -1;
                        Tags_Error_Array(1,start1) = -1;
                        Tags_Intesnsity_Array(1,start1) = -1;
                        start1 = start2;
                    elseif(Tags_Intesnsity_Array(1,start1) > Tags_Intesnsity_Array(1,start2))   %file 210
                        Tags{1,start2} = '';
                        Errors(1,start2) = -1;
                        TagLength(1,start2) = -1;
                        Tags_Error_Array(1,start2) = -1;
                        Tags_Intesnsity_Array(1,start2) = -1;
                    end
                end
                %%%Added ABOVE %Updated 20201216
                %%%DISCARD BELOW %Updated 20201216
%                 else
%                     Tags{1,start1} = '';
%                     Errors(1,start1) = -1;
%                     TagLength(1,start1) = -1;
%                     Tags_Error_Array(1,start1) = -1;
%                     Tags_Intesnsity_Array(1,start1) = -1;
%                     start1 = start2;
%                 end
                %%%Discard ABOVE
            else
                start1 = start2;
                break;
            end
        end
        if start2 == numel(Tags)
            break;
        end
    end
end

Tags = Tags (~cellfun('isempty',Tags));
Errors(Errors==-1) = [];
TagLength(TagLength==-1) = [];
Tags_Error_Array(Tags_Error_Array==-1) = [];
Tags_Intesnsity_Array(Tags_Intesnsity_Array==-1) = [];

%% Filter tags according to fulltag error threshold -----
% % % % % % % % % % % % % % % Score_Error = zeros(1,numel(Errors));
% % % % % % % % % % % % % % % for index = 1:numel(Errors)
% % % % % % % % % % % % % % %     if (Tags_Error_Array(index) > User_tagError_threshold)
% % % % % % % % % % % % % % %         Tags{1,index} = '';
% % % % % % % % % % % % % % %         TagLength(1,index) = -1;
% % % % % % % % % % % % % % %         Tags_Intesnsity_Array(1,index) = -1;
% % % % % % % % % % % % % % %         Score_Error(index) = -1;
% % % % % % % % % % % % % % %     else
% % % % % % % % % % % % % % %         %% Score tags according to errors
% % % % % % % % % % % % % % %         Score_Error(index) = exp(-Tags_Error_Array(index)*2);
% % % % % % % % % % % % % % %     end
% % % % % % % % % % % % % % % end
% % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % Tags = Tags (~cellfun('isempty',Tags));
% % % % % % % % % % % % % % % TagLength(TagLength==-1) = [];
% % % % % % % % % % % % % % % Tags_Intesnsity_Array(Tags_Intesnsity_Array==-1) = [];
% % % % % % % % % % % % % % % Score_Error(Score_Error==-1) = [];
% % % % % % % % % % % % % % % 
%% SCORING TAG LENGTH
%% Tag_ladder Initilaization
% Tag_ladder.Score_Error = Score_Error;
Tag_ladder.Taglength = TagLength;
Tag_ladder.Tag =  Tags;
Tag_ladder.Tags_Error_Array = Tags_Error_Array;
Tag_ladder.Tags_Intesnsity_Array = Tags_Intesnsity_Array;
Tag_ladder.Errors = Errors;

end