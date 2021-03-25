function  Tag_Ladder = FindUniquePstAgain( Temp_Ladder, User_tagError_threshold )

Size = size(Temp_Ladder,2);
Tags = cell(1,Size);
Errors = zeros(1,Size);
TagLength = zeros(1,Size);
Tags_Error_Array = zeros(1,Size); %%%
Tags_Intesnsity_Array = zeros(1,Size); %%%

for i = 1: numel(Temp_Ladder)
    tempInfo = Temp_Ladder{1, i};
    
    %tempTag = blanks(size(tempInfo{1, 1},2))
    
    Tags{1,i} = tempInfo{1, 1};
    
   
    Errors(1,i) = tempInfo{1, 2};
    TagLength(1,i) = tempInfo{1, 3};
    Tags_Error_Array(1,i) = tempInfo{1, 4};
    Tags_Intesnsity_Array(1,i) = tempInfo{1, 5};
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
Score_Error = zeros(1,numel(Errors));
for index = 1:numel(Errors)
    if (Tags_Error_Array(index) > User_tagError_threshold)
        Tags{1,index} = '';
        TagLength(1,index) = -1;
        Tags_Intesnsity_Array(1,index) = -1;
        Score_Error(index) = -1;
    else
        %% Score tags according to errors
        Score_Error(index) = exp(-Tags_Error_Array(index)*2);
    end
end

Tags = Tags (~cellfun('isempty',Tags));
TagLength(TagLength==-1) = [];
Tags_Intesnsity_Array(Tags_Intesnsity_Array==-1) = [];
Score_Error(Score_Error==-1) = [];

%% SCORING TAG LENGTH
%% Tag_ladder Initilaization
Tag_ladder.Score_Error = Score_Error;
Tag_ladder.Taglength = TagLength;
Tag_ladder.Tag =  Tags;
Scoreforlength = (TagLength).^2;
Tag_ladder.Frequency =  Tags_Intesnsity_Array.*Scoreforlength;


if ~isempty(Tag_ladder)
    Tag_Ladder = {};
    for l = 1:size(Tag_ladder.Taglength,2)
        Tag_Ladder{l} = {cell2mat(Tag_ladder.Tag(l)),Tag_ladder.Taglength(l),Tag_ladder.Score_Error(l),Tag_ladder.Frequency(l)}; %#ok<*AGROW>
    end
else
    Tag_Ladder = {};
end



end

