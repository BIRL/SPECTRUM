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

function [Proteins_Insilico_Spectra] = Updated_ParseDatabase(Protein_ExperimentalMW,Tags_ladder,Candidate_ProteinsList,PTM_tol,fixed_modifications,variable_modifications )
f = filesep;
Othermodification_Cysteine=getappdata(0,'Othermodification_Cysteine');% to get user defined chemical modifications on cysteine residue
Othermodification_Methionine=getappdata(0,'Othermodification_Methionine');% to get user defined chemical modifications on methionine residue
Proteins_Insilico_Spectra = {};
Shortlisted_ModProteins_W = WithoutPTM_ParseDatabase(Tags_ladder,Candidate_ProteinsList);
Proteins_Insilico_Spectra = [Proteins_Insilico_Spectra; Shortlisted_ModProteins_W];
if(~isempty(Othermodification_Cysteine) && ~isempty(Othermodification_Methionine) && numel(variable_modifications)>0 && numel(fixed_modifications)>0)
    for  index = 1: numel(Shortlisted_ModProteins_W)
        Protein_id = Shortlisted_ModProteins_W{index,1}.Id; % Header
        Sequence = Shortlisted_ModProteins_W{index,1}.Sequence; % seq
        Protein_name = Shortlisted_ModProteins_W{index,1}.Name;
        
        if numel(Shortlisted_ModProteins_W) > 0
            Final_EST_Score = Shortlisted_ModProteins_W{index,1}.EST_Score;
        end
        
        %% Generate sequences with PTMs and filter according to MW
        initial_path= getappdata(0,'initial_path');
        addpath(strcat(initial_path,f,'PTM'));
        if numel(Shortlisted_ModProteins_W) > 0
            Shortlisted_ModProteins = PTMs_Generator_Insilico_Generator(Shortlisted_ModProteins_W{index,1},Sequence,Protein_ExperimentalMW,Protein_name,Protein_id,PTM_tol,fixed_modifications,variable_modifications,Final_EST_Score,Othermodification_Cysteine,Othermodification_Methionine);
            Proteins_Insilico_Spectra = [Proteins_Insilico_Spectra; Shortlisted_ModProteins]; %#ok<*AGROW>
        end
        rmpath(strcat(initial_path,f,'PTM'));
    end
end
