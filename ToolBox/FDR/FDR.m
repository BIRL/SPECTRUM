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
function FDR_estimation = FDR(Target, Decoy, Threshold,Cutoff)
FDR_estimation = [];
Cutoff = Cutoff/100;

for i =1:numel(Threshold)
    TargetShortlisted =[];
    DecoyShortlisted =[];
    TO =  0; DO = 0; TB = 0; DB = 0;
    
    for j = 1:numel(Decoy)/2
        if Decoy{j,2}> Threshold{i}
            DecoyShortlisted = [DecoyShortlisted; Decoy(j,:)];
        end
    end
    for k = 1:numel(Target)/2
        if Target{k,2}>= Threshold{i}
            TargetShortlisted = [TargetShortlisted; Target(k,:)];
        end
    end
    
    if(isempty(DecoyShortlisted))
        TO = numel(TargetShortlisted)/2;
        DO = numel(DecoyShortlisted)/2;
    end
    
    if(isempty(TargetShortlisted))
        TO = numel(TargetShortlisted)/2;
        DO = numel(DecoyShortlisted)/2;
    end
    
    if(~isempty(TargetShortlisted) && ~isempty(DecoyShortlisted))
        TO_Elements=setdiff(TargetShortlisted(:,1),DecoyShortlisted(:,1));
        DO_Elements=setdiff(DecoyShortlisted(:,1),TargetShortlisted(:,1));
        TO = numel(TO_Elements);
        DO = numel(DO_Elements);
        Common = intersect(TargetShortlisted(:,1),DecoyShortlisted(:,1));
        
        for idx = 1:numel(Common)
            DecoyScore = 0;
            TargetScore = 0;
            
            for j = 1:numel(DecoyShortlisted)/2
                if strcmp(DecoyShortlisted{j,1}, Common(idx))
                    DecoyScore = DecoyShortlisted{j,2};
                    break;
                end
            end
            
            for j = 1:numel(Target)/2
                if strcmp(TargetShortlisted{j,1}, Common(idx))
                    TargetScore = TargetShortlisted{j,2};
                    break;
                end
            end
            
            if TargetScore >= DecoyScore
                TB = TB + 1;
            else
                DB = DB + 1;
            end
            
        end
    end
    FDRxx = (2*DB+DO)/(TO+TB+DB);
    FDR_estimation = [FDR_estimation; FDRxx];
    if FDRxx > Cutoff
        break;
    end
end