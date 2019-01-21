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

function OUTPUT_file (a, projectname)
f1=fopen(strcat(projectname,'.ou'),'a');
fprintf(f1,'%s \n','<<<<<<<<<<<<<<<<<<<<<OUTPUT>>>>>>>>>>>>>>>>>>');
fprintf(f1,'%s \n',datestr(datetime('now')));

switch a
    case 1
        
        Candidate_ProteinsList_Initial=getappdata(0,'Candidate_ProteinsList_Initial');
        Num_proT_list=length(Candidate_ProteinsList_Initial);
        fprintf(f1,'%s\n',strcat('No. of candidate proteins in initial list = ',num2str(Num_proT_list)));
        
    otherwise
        fprintf(f1,'%s\n',num2str(a));
end
fclose(f1);
end