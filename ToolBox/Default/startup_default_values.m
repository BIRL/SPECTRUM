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

function startup_default_values(~, ~, handles)

% Project title
jTitle = findjobj(handles.edit_ProjectTitle);
set(jTitle, 'FocusGainedCallback', @(h,e)emptyField(handles.edit_ProjectTitle,'Enter the Project Title'));
set(jTitle, 'FocusLostCallback', @(h,e)fillField(handles.edit_ProjectTitle,'Enter the Project Title'));

% Experiment Database

jSDatabase = findjobj(handles.edit_Database);
set(jSDatabase, 'FocusGainedCallback', @(h,e)emptyField(handles.edit_Database,'Browse to the Database'));
set(jSDatabase, 'FocusLostCallback', @(h,e)fillField(handles.edit_Database,'Browse to the Database'));

% Peaklist file
jSPeakfile = findjobj(handles.edit_Peaklist);
set(jSPeakfile, 'FocusGainedCallback', @(h,e)emptyField(handles.edit_Peaklist,'Browse for Experimental Data'));
set(jSPeakfile, 'FocusLostCallback', @(h,e)fillField(handles.edit_Peaklist,'Browse for Experimental Data'));

% Results Folder
jResults = findjobj(handles.edit_Results);
set(jResults, 'FocusGainedCallback', @(h,e)emptyField(handles.edit_Results,'Directory for Saving Results'));
set(jResults, 'FocusLostCallback', @(h,e)fillField(handles.edit_Results,'Directory for Saving Results'));

% Parameters Folder
jParameters = findjobj(handles.edit_Parameters);
set(jParameters, 'FocusGainedCallback', @(h,e)emptyField(handles.edit_Parameters,'Directory for Saving Parameters'));
set(jParameters, 'FocusLostCallback', @(h,e)fillField(handles.edit_Parameters,'Directory for Saving Parameters'));

% Experimental Protein Molecular Weight
jPMass = findjobj(handles.edit_ProteinMass);
set(jPMass, 'FocusGainedCallback', @(h,e)emptyField(handles.edit_ProteinMass,'0.0'));
set(jPMass, 'FocusLostCallback', @(h,e)fillField(handles.edit_ProteinMass,'0.0'));

% Total Molecular Weight
jTMW = findjobj(handles.edit_MolecularWeight);
set(jTMW, 'FocusGainedCallback', @(h,e)emptyField(handles.edit_MolecularWeight,'100'));
set(jTMW, 'FocusLostCallback', @(h,e)fillField(handles.edit_MolecularWeight,'100'));

% Peptide
jPeptide = findjobj(handles.edit_Peptide);
set(jPeptide, 'FocusGainedCallback', @(h,e)emptyField(handles.edit_Peptide,'0.5'));
set(jPeptide, 'FocusLostCallback', @(h,e)fillField(handles.edit_Peptide,'0.5'));

% PTM
jPTM = findjobj(handles.edit_PTM);
set(jPTM, 'FocusGainedCallback', @(h,e)emptyField(handles.edit_PTM,'0.5'));
set(jPTM, 'FocusLostCallback', @(h,e)fillField(handles.edit_PTM,'0.5'));
setappdata(0,'Othermodification_Cysteine','');
setappdata(0,'Othermodification_Methionine','');
% Tuned Protein Mol Weight
jPTM = findjobj(handles.edit_TunedMass);
set(jPTM, 'FocusGainedCallback', @(h,e)emptyField(handles.edit_TunedMass,'0.0'));
set(jPTM, 'FocusLostCallback', @(h,e)fillField(handles.edit_TunedMass,'0.0'));
setappdata(0,'Othermodification_Cysteine','');
setappdata(0,'Othermodification_Methionine','');




%%%%%%%% Functions for setting default values %%%%%%%%%%%%%%%%%%%%

% Project title
function emptyField(Obj,Str)
try
    if(strcmp(get(Obj,'String'),Str) && isequal(get(Obj,'ForegroundColor'),[0.6 0.6 0.6]))
        set(Obj,'String','');
    end
catch
    return
end

function fillField(Obj,Str)
try
    
    if(isempty(get(Obj,'String')) && isequal(get(Obj,'ForegroundColor'),[0.6 0.6 0.6]))
        set(Obj,'String',Str);
    end
catch
    return
end
%.....................................................

% Total Molecular Weight
% function totalmolwt_emptyField(handles)
% if(strcmp(get(handles.edit_MolecularWeight,'String'),'100') && isequal(get(handles.edit_MolecularWeight,'ForegroundColor'),[0.6 0.6 0.6]))
%     set(handles.edit_MolecularWeight,'String','');
% end
%
% function totalmolwt_fillField(handles)
% if(strcmp(get(handles.edit_MolecularWeight,'String'),'') && isequal(get(handles.edit_MolecularWeight,'ForegroundColor'),[0.6 0.6 0.6]))
%     set(handles.edit_MolecularWeight,'String','100');
% end
% ...................................................
%
% Peptide
% function peptide_emptyField(handles)
% if(strcmp(get(handles.edit_Peptide,'String'),'0.5') && isequal(get(handles.edit_Peptide,'ForegroundColor'),[0.6 0.6 0.6]))
%     set(handles.edit_Peptide,'String','');
% end
%
% function peptide_fillField(handles)
% if(strcmp(get(handles.edit_Peptide,'String'),'') && isequal(get(handles.edit_Peptide,'ForegroundColor'),[0.6 0.6 0.6]))
%     set(handles.edit_Peptide,'String','0.5');
% end
% ...................................................
%
% PTM
% function ptm_emptyField(handles)
% if(strcmp(get(handles.edit_PTM,'String'),'0.5') && isequal(get(handles.edit_PTM,'ForegroundColor'),[0.6 0.6 0.6]))
%     set(handles.edit_PTM,'String','');
% end
%
% function ptm_fillField(handles)
% if(strcmp(get(handles.edit_PTM,'String'),'')&& isequal(get(handles.edit_PTM,'ForegroundColor'),[0.6 0.6 0.6]))
%     set(handles.edit_PTM,'String','0.5');
% end


% -----------########---------------------------


