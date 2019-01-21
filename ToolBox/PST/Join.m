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

function AA_Next=Join(Home_peak,length_tags,Hop_Info,Num_AAs_Found,MaxLength)

AA_Next= {};
Length = 1;
iter = 1;
for Start_peak=Home_peak:(Num_AAs_Found)
    Hop_peak=(Start_peak+1);
    AA_NextOuter = Hop_Info{Home_peak};
    AA_Next{iter,1}  = AA_NextOuter;
    if(Hop_Info{Home_peak}{2} == Hop_Info{Hop_peak}{1})
        length_tags=length_tags+1;
        AA_NextInner = JoinInner(Hop_peak,length_tags,Hop_Info,Num_AAs_Found,MaxLength,Length);
        AA_NextOuter = [AA_NextOuter;AA_NextInner]; %#ok<*AGROW>
        AA_Next{iter,1}  = AA_NextOuter;
        iter = iter+1;
    end
end
end