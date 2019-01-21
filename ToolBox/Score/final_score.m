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
function final_score()
result=getappdata(0,'Matches');
ScoringWeight1 = getappdata(0,'w1');
ScoringWeight2 = getappdata(0,'w2');
ScoringWeight3 = getappdata(0,'w3');
PST = zeros(numel(result),1);

if ScoringWeight2 ~= 0
    for num_prot=1:numel(result)
        PST(num_prot) = result{num_prot}.EST_Score;
    end
    maxPST = max(PST);
    if(maxPST>1)
        PST = PST./maxPST;
    end
end

for num_prot = 1:numel(result)
    MW_Score = result{num_prot}.MWScore;
    PST_Score = PST(num_prot);
    Insilico_frag_Score = result{num_prot}.Matches_Score;
    final_score1 = ((ScoringWeight1*MW_Score)+(ScoringWeight2*PST_Score)+(ScoringWeight3*Insilico_frag_Score))/(ScoringWeight1+ScoringWeight2+ScoringWeight3);% calculating final score
    result{num_prot}.Final_Score = final_score1;
    
end
setappdata(0,'Matches',result);

