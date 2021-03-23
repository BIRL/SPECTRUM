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

function Modified_Protein_Seqs = PTMs_Generator_Insilico_Generator(Candidate_ProteinsList,Protein_sequence,Protein_ExperimentalMW,Protein_name,Protein_id,PTM_tol,fixed_modifications,variable_modifications,EST_Score,Othermodification_Cysteine,Othermodification_Methionine)
BlindPTM = getappdata(0,'BlindPTM');
Modified_Protein_Seqs = {};
Modified_Protein = {};
All_Var_PTMs = {};
All_Fixed_PTMs = {};
All_Cys = {};
All_Mets = {};
fixed_tol = 0;
newline = sprintf('\r');
Protein_sequence = strrep(Protein_sequence, newline,'');


if(~isempty(Othermodification_Cysteine))
    used_to_call_PTM_functions = strcat(Othermodification_Cysteine,'(',' ','''',Protein_sequence,'''',')',';');
    sites = eval(used_to_call_PTM_functions);
    All_Cys = [All_Fixed_PTMs; sites];
end


if(~isempty(Othermodification_Methionine))
    used_to_call_PTM_functions = strcat(Othermodification_Methionine,'(',' ','''',Protein_sequence,'''',')',';');
    sites = eval(used_to_call_PTM_functions);
    All_Mets = [All_Fixed_PTMs; sites];
end

if BlindPTM ~= 1
    number_of_variable_mods = numel(variable_modifications);
    for variable_modification_idx = 1 : number_of_variable_mods
        used_to_call_PTM_functions=num2str(cell2mat(variable_modifications(variable_modification_idx)));
        used_to_call_PTM_functions = strcat(used_to_call_PTM_functions,'(',' ','''',Protein_sequence,'''', ',' ,'''',num2str(PTM_tol),'''',')',';');
        sites = eval(used_to_call_PTM_functions);
        All_Var_PTMs = [All_Var_PTMs ; sites]; %#ok<*AGROW>
    end
end

number_of_fixed_mods = numel(fixed_modifications);
for fixed_modification_idx = 1 : number_of_fixed_mods
    used_to_call_PTM_functions=num2str(cell2mat(fixed_modifications(fixed_modification_idx)));
    used_to_call_PTM_functions = strcat(used_to_call_PTM_functions,'(',' ','''',Protein_sequence,'''', ',' ,'''',num2str(fixed_tol),'''',')',';');
    sites = eval(used_to_call_PTM_functions);
    All_Fixed_PTMs = [All_Fixed_PTMs; sites];
end
All_Fixed_PTMs = [All_Fixed_PTMs; All_Mets; All_Cys];

combinations = cell(1,size(All_Var_PTMs,1));
for index=1:size(All_Var_PTMs,1)
    combinations{index}= combnk(1:size(All_Var_PTMs,1),index); % make combinations of size 1,2,3.. till number of sites of modification
end

%% obtain modifications informations corresponding to combinations of indices of PTMs generated
structs_array = cell(1,size(All_Var_PTMs,1)+1);
for index = 1:size(combinations,2) % number of entries(columns) in combinations array
    for index1 = 1:size(combinations{1,index},1) % number of rows in each cell of combinations array
        for index2 = 1:size(combinations{1,index},2)  % number of columns in each cell of combinations array
            Combined_idx = combinations{1,index}(index1,index2);
            info = All_Var_PTMs(Combined_idx,:);
            PTM.seq_idx = info{1,1}; % position of site in sequence
            PTM.score = info{1,2}; %PTM score
            PTM.mod_MW = info{1,3};
            PTM.name = info{1,4};
            PTM.site = info{1,5}; % amino acid site
            structs_array{1,index}(index1,index2) = PTM;
        end
    end
end


Modified_Protein.PTM_score=0;
Modified_Protein.LeftIons = Candidate_ProteinsList.LeftIons;
Modified_Protein.RightIons = Candidate_ProteinsList.RightIons;
Modified_Protein.MolW = Candidate_ProteinsList.MolW;
Modified_Protein.Terminal_Modification = Candidate_ProteinsList.Terminal_Modification;

%% In case fixed modification is selected
if(~isempty(All_Fixed_PTMs))
    for fixedIndex = 1 : size((All_Fixed_PTMs),1)
        for prot_index = 1:numel(Protein_sequence)-1
            if prot_index >=  All_Fixed_PTMs{fixedIndex,1}
                Modified_Protein.LeftIons(prot_index)= Modified_Protein.LeftIons(prot_index)+ All_Fixed_PTMs{fixedIndex,3};
            end
        end
    end
    
    for fixedIndex = 1 : size((All_Fixed_PTMs),1)
        Modified_Protein.MolW = Modified_Protein.MolW + All_Fixed_PTMs{fixedIndex,3};
    end
    
    for fixedIndex = 1 : size((All_Fixed_PTMs),1)
        for prot_index = 1:numel(Protein_sequence)-1
            id = numel(Protein_sequence) - All_Fixed_PTMs{fixedIndex,1} + 1;
            if prot_index >= id
                Modified_Protein.RightIons(prot_index)= Modified_Protein.RightIons(prot_index)+ All_Fixed_PTMs{fixedIndex,3};
            end
        end
    end
end

%% In case no variable modification is selected
if(isempty(structs_array{1}) && ~isempty(All_Fixed_PTMs))
    
    Modified_Protein.Sequence = Protein_sequence;
    Modified_Protein.Name = Protein_name; %from database
    Modified_Protein.Id = Protein_id; %from database
    Modified_Protein.PTM_score=0;
    Modified_Protein.PTM_name='';
    Modified_Protein.PTM_site='';
    PTMIndex = 0;
    for fixedIndex = 1 : size((All_Fixed_PTMs),1)
        PTMIndex = PTMIndex+1;
        Modified_Protein.PTM_seq_idx(PTMIndex,1)=All_Fixed_PTMs{fixedIndex,1};
        Modified_Protein.PTM_score = Modified_Protein.PTM_score + All_Fixed_PTMs{fixedIndex,2}; %PTM score
        Modified_Protein.PTM_site=[Modified_Protein.PTM_site; {All_Fixed_PTMs{fixedIndex,5}}]; %#ok<CCAT1>
        Modified_Protein.PTM_name=[Modified_Protein.PTM_name; {All_Fixed_PTMs{fixedIndex,4}}]; %#ok<CCAT1>
    end
    Modified_Protein.EST_Score = EST_Score;
    ERROR=abs(Protein_ExperimentalMW- Modified_Protein.MolW);
    if(ERROR==0)
        Modified_Protein.MWScore=1;   %diff=0 mw_score=1
    else
        Modified_Protein.MWScore=1/2^(ERROR);% compute mol_weight Score for proteins via mw_score=10/|diff|
    end
    
    Modified_Protein.PTM_score = 1- exp(-Modified_Protein.PTM_score/3);
    Modified_Protein_Seqs = [ Modified_Protein_Seqs ; Modified_Protein ];
end
MolW = Modified_Protein.MolW;
Left = Modified_Protein.LeftIons;

%% If Variable modification is selected
for index = 1:size(structs_array,2)
    for index1 = 1:size(structs_array{1,index},1) % get rows in each cell of structs_array
        Modified_Protein.MolW = MolW;
        Modified_Protein.LeftIons = Left;
        for varIndex = 1:size(structs_array{1,index},2) % columns
            Modified_site = structs_array{1,index}(index1,varIndex);
            Modified_Protein.MolW = Modified_Protein.MolW + Modified_site.mod_MW;
            for prot_index = 1:numel(Protein_sequence)-1
                if prot_index >= Modified_site.seq_idx
                    Modified_Protein.LeftIons(prot_index)= Modified_Protein.LeftIons(prot_index)+ Modified_site.mod_MW;
                end
            end
        end
        H2O = 1.0078250321 + 1.0078250321 + 15.9949146221;
        for InsilicoIndex = 1: numel(Modified_Protein.LeftIons)
            Modified_Protein.RightIons(InsilicoIndex) = Modified_Protein.MolW - H2O - Modified_Protein.LeftIons(InsilicoIndex);
        end
        
        Modified_Protein.Sequence = Protein_sequence;
        Modified_Protein.Name = Protein_name; %from database
        Modified_Protein.Id = Protein_id; %from database
        Modified_Protein.PTM_score=0;         %Updated 20210322  -- Bug fixed
        Modified_Protein.PTM_name = '';
        Modified_Protein.PTM_site = '';
        PTMIndex = 0;
        for PTMIndex = 1:size(structs_array{1,index},2) % columns
            Modified_site = structs_array{1,index}(index1,PTMIndex);
            Modified_Protein.PTM_seq_idx(PTMIndex,1)=Modified_site.seq_idx;
            Modified_Protein.PTM_score = Modified_Protein.PTM_score + Modified_site.score; %PTM score
            Modified_Protein.PTM_site=[Modified_Protein.PTM_site; {Modified_site.site}];
            Modified_Protein.PTM_name=[Modified_Protein.PTM_name; {Modified_site.name}];
        end
        for fixedIndex = 1 : size((All_Fixed_PTMs),1)
            PTMIndex = PTMIndex+1;
            Modified_Protein.PTM_seq_idx(PTMIndex,1)=All_Fixed_PTMs{fixedIndex,1};
            Modified_Protein.PTM_score = Modified_Protein.PTM_score + All_Fixed_PTMs{fixedIndex,2}; %PTM score
            Modified_Protein.PTM_site=[Modified_Protein.PTM_site; {All_Fixed_PTMs{fixedIndex,5}}];
            Modified_Protein.PTM_name=[Modified_Protein.PTM_name; {All_Fixed_PTMs{fixedIndex,4}}]; %#ok<CCAT1>
        end
        ERROR=abs(Protein_ExperimentalMW- Modified_Protein.MolW);
        if(ERROR==0)
            Modified_Protein.MWScore=1;   %diff=0 mw_score=1
        else
            Modified_Protein.MWScore=1/2^(ERROR);% compute mol_weight Score for proteins via mw_score=10/|diff|
        end
        Modified_Protein.EST_Score = EST_Score;
        Modified_Protein.PTM_score = 1- exp(-Modified_Protein.PTM_score/3);
        Modified_Protein_Seqs = [ Modified_Protein_Seqs ; Modified_Protein ];
    end
end
end
