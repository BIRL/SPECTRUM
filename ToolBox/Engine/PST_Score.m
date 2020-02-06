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

function [Final_EST_Score] = PST_Score(Tags_ladder,Sequence)
%% Scan database protein sequence for PSTs
Final_EST_Score = 0 ;
number_of_tags_found = 0;
idx=numel(Tags_ladder);


for num = 1 : numel(Tags_ladder) % for number of tags in the tag ladder
    tag=Tags_ladder{1, idx}{1, 1}; % search for tag in the sequence
    if ~isempty(strfind(Sequence,tag))
        found_index=strfind(Sequence,tag);
        if length(found_index)==1;
            Sequence(found_index:found_index+length(tag))='*';
            number_of_tags_found = number_of_tags_found + 1;
        else
            for k=1:length(found_index)
                Sequence(found_index(k):found_index(k)+length(tag))='*';
                number_of_tags_found = number_of_tags_found + 1;
            end
        end
        no_of_occournaces=number_of_tags_found ;
        if(isnan(Tags_ladder{1, idx}{1, 4}))
            Final_EST_Score = Final_EST_Score +(no_of_occournaces*( Tags_ladder{1, idx}{1, 2} + Tags_ladder{1, idx}{1, 3}));
        else
            %%%20200206 Formula Updated
            Final_EST_Score = Final_EST_Score +(no_of_occournaces*(Tags_ladder{1, idx}{1, 3} + Tags_ladder{1, idx}{1, 4})); % simple sum right now
        end
    end
    idx=idx-1;
end
Final_EST_Score = Final_EST_Score / numel(Sequence);
end
