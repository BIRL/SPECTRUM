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

function tag_ladder=Tag_sizeone(Tags_Ladder)
tag_ladder={};
index=0;
if (length(Tags_Ladder)==1)
    tag_ladder=Tags_Ladder;
else
    for idx=1:length(Tags_Ladder)
        if(Tags_Ladder{idx}{2}==1)
            index=index+1;
            tag_ladder{index}=Tags_Ladder{idx};
        end
    end
end

