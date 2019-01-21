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

function AA_Next=JoinInner(Home_peak,length_tags,Hop_Info,Num_AAs_Found,MaxLength,Length)
if Length == MaxLength
    AA_Next = Hop_Info{Home_peak};
else
    Length = Length + 1;
    AA_Next = Hop_Info{Home_peak};
    for Start_peak=Home_peak:(Num_AAs_Found-1)
        Hop_peak=(Start_peak+1);
        if(Hop_Info{Home_peak}{2} == Hop_Info{Hop_peak}{1})
            length_tags=length_tags+1;
            AA_Next = JoinInner(Hop_peak,length_tags,Hop_Info,Num_AAs_Found,MaxLength,Length);
            AA_Next = [Hop_Info{Home_peak};AA_Next]; %#ok<*AGROW>
        end
    end
end
end