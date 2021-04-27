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
function BatchRun()
progressbar('SPECTRUM');
data = {};
csvData = [cellstr('File Name'),cellstr('Protein Header'),cellstr('Terminal Modification'),cellstr('Protein Sequence'),cellstr('Protein Tuncation'),cellstr('Truncation Position'),cellstr('Score'),cellstr('Molecular Weight'),cellstr('No of Modifications'),cellstr('No of Fragments Matched'),cellstr('Run Time'),cellstr('E-Value')];
%setappdata(0,'P_condotion',1);  %Updated 20210427
Database_Path = getappdata(0,'Database_Path'); %#ok<*NASGU> % Database path of single and batch search modes
Selected_Database = getappdata(0,'Selected_Database'); % Concatenated: Database_Path + Database selected from menu_Database
Batch_Peaklist_Data = getappdata(0,'Batch_Peaklist_Data'); % Peaklist data for BATCH search mode
DirectoryContents=getappdata(0,'BatchFolderContents');
Path=getappdata(0,'path');

BlindPTMvar = getappdata(0,'BlindPTM');
MW_Tolerance = getappdata(0,'Molecular_Weight_Tol'); % Molecular Weight tolerance
MWTolIndex = getappdata(0,'MWunit');
if(MWTolIndex == 1)
    MWunit = 'Da';
elseif (MWTolIndex == 2)
    MWunit = 'mmu';
elseif (MWTolIndex == 3)
    MWunit = 'ppm';
else
    MWunit = '%';
end
Peptide_Tolerance = getappdata(0,'Peptide_Tol'); % Peptide tolerance
FilterPSTs = getappdata(0,'FilterPSTs');
PepTolIndex = getappdata(0,'PepUnit');
if(PepTolIndex == 1)
    PepUnit = 'Da';
elseif (PepTolIndex == 2)
    PepUnit = 'mmu';
elseif (PepTolIndex == 3)
    PepUnit = 'ppm';
else
    PepUnit = '%';
end

f = filesep;
initial_path=pwd;
setappdata(0,'inital',initial_path);

ArrayOfDbFetch = 0.0;
ArrayOfMassTuner = 0.0;
ArrayOfUpdated_ParseDatabase = 0.0;
ArrayOfInsilico_frags_Generator_modifier = 0.0;
ArrayOfSpectralComparison = 0.0;
ArrayOfTruncation = 0.0;
ArrayOfEvalue = 0.0;
ArrayOfPst = 0.0;
ArrayOfBlindPtm = 0.0;


PTM_Tolerance = getappdata(0,'PTM_Tol'); % Peptide tolerance
HandleIon = getappdata(0,'HandleIon');
User_EST_parameters=getappdata(0,'User_EST_parameters');
Fixed_Modifications = getappdata(0,'Fixed_Modifications'); % Fixed Modifications
Variable_Modifications = getappdata(0,'Variable_Modifications'); % Variable Modifications
Fragmentation_Type = getappdata(0,'Fragmentation_type'); % Fragmentation type
Experimental_Protein_Mass = getappdata(0,'Experimental_Protein_Mass'); % Experimental Proein Mass (Protein mass)
Project_Title=getappdata(0,'Project_Title');
progressbar('SPECTRUM: Loading Database');

tic;
Candidate_ProteinsList_Full = LoadDatabaseBatch(Selected_Database);
ArrayOfDbFetch = ArrayOfDbFetch + toc;

progressbar('SPECTRUM: Performing Search');




for i= 1:size(DirectoryContents,1)     % for mgf and text files  (all files present in specified folder)
    clc;
    batchModeTimer = tic;
    progressbar(i/(size(DirectoryContents,1)+1));
    Batch_Peaklist_Data(i).name = Batch_Peaklist_Data(i).name(1:end-4);
    %% add path
    Save_Batch_File = strcat(getappdata(0,'Result_Folder'),f,Project_Title,'_',Batch_Peaklist_Data(i).name,'.results');
    Batch_Search_File = [Path,f,DirectoryContents(i).name];
    
    if(getappdata(0,'Type_file')==1)
        Imported_Data =  importdata(Batch_Search_File);
        m = max(Imported_Data(:,2));
        HandleIon = getappdata(0,'HandleIon');
        for tupleIndex = 2 : size(Imported_Data,1)
            %% Used for converting mono isotopic mass into mz value
            if (HandleIon{9,1} == 0)
                Imported_Data(tupleIndex,1) = Imported_Data(tupleIndex,1)+1.00727647;
            end
            Imported_Data(tupleIndex,2) = Imported_Data(tupleIndex,2)/m;
        end
        Sorted = sortrows(Imported_Data,1);
        PeakListMW = Sorted(:,1);
        Intensity = Sorted(:,2);
        setappdata(0,'Peaklist_Data',Imported_Data);
        setappdata(0,'Fragments_Masses',PeakListMW);
        setappdata(0,'Int',Intensity);
        Experimental_Protein_Mass = Imported_Data(1,1);
        
    elseif(getappdata(0,'Type_file')==2)
        file_data = mzxmlread(Batch_Search_File);
        data_all=mzxml2peaks(file_data, 'Levels', 2);
        [dummy, Index] = sort(cellfun('size',data_all,1), 'descend'); %#ok<*ASGLU>
        data_all_sort=data_all(Index);
        Imported_Data =data_all_sort{1};
        m = max(Imported_Data(:,2));
        HandleIon = getappdata(0,'HandleIon');
        for tupleIndex = 1 : size(Imported_Data,1)
            %% Used for converting mono isotopic mass into mz value
            if (HandleIon{9,1} == 0)
                Imported_Data(tupleIndex,1) = Imported_Data(tupleIndex,1)+1.00727647;
            end
            Imported_Data(tupleIndex,2) = Imported_Data(tupleIndex,2)/m;
        end
        Sorted = sortrows(Imported_Data,1);
        PeakListMW = Sorted(:,1);
        Intensity = Sorted(:,2);
        setappdata(0,'Peaklist_Data',Imported_Data);
        setappdata(0,'Fragments_Masses',PeakListMW);
        setappdata(0,'Int',Intensity);
        [data_all,times]=mzxml2peaks(file_data, 'Levels', 1);
        [dummy, Index] = sort(cellfun('size',data_all,1), 'descend');
        Protein_Mass=data_all{Index(1)};
        Experimental_Protein_Mass=Protein_Mass(length(Protein_Mass));
    else
        Imported_Data =  importdata(Batch_Search_File);
        m = max(Imported_Data(:,2));
        HandleIon = getappdata(0,'HandleIon');
        for tupleIndex = 2 : size(Imported_Data,1)
            %% Used for converting mono isotopic mass into mz value
            if (HandleIon{9,1} == 0)
                Imported_Data(tupleIndex,1) = Imported_Data(tupleIndex,1)+1.00727647;
            end
            Imported_Data(tupleIndex,2) = Imported_Data(tupleIndex,2)/m;
        end
        Sorted = sortrows(Imported_Data,1);
        PeakListMW = Sorted(:,1);
        Intensity = Sorted(:,2);
        setappdata(0,'Peaklist_Data',Imported_Data);
        setappdata(0,'Fragments_Masses',PeakListMW);
        setappdata(0,'Int',Intensity);
        Experimental_Protein_Mass = Imported_Data(1,1);
        
    end
    
    %%% Updated 20210409   %% BELOW
    % Adding here to cater all file formats
    temp_Imported_Data = Imported_Data(2:end, :);
    Sorted = sortrows(temp_Imported_Data,1);
    %Sorted = sortrows(Imported_Data,1);
    PeakListMW = Sorted(:,1);
    Intensity = Sorted(:,2);
    PeakListMW(end+1) = Imported_Data(1,1);
    Intensity(end+1) = Imported_Data(1,2);
    setappdata(0,'Peaklist_Data',Imported_Data);  % MS1 then, MS2s with their intensities [Original Order]
    setappdata(0,'Fragments_Masses',PeakListMW);  % MS2s (in ascending order) then, MS1 only 
    setappdata(0,'Int',Intensity);                % Only intensities of corresponding to the PeakListMW (MS values)
    %%% Updated 20210409   %% ABOVE
    
    
    
    try
        %% tuner
        if getappdata(0,'tuner') == 1 % Executes when Auto-Tune Checkobx is on
            Slider_Value=50;   %Updated 20210410
            
            tic;
            [Tuned_MolWt, ~,~ ,~,~] =  MassTuner(Slider_Value,Experimental_Protein_Mass,MW_Tolerance);
            ArrayOfMassTuner = ArrayOfMassTuner + toc;
            
            if(abs(Tuned_MolWt - Experimental_Protein_Mass) < 3)
                Tuned_Mass = Tuned_MolWt;
                Experimental_Protein_Mass = Tuned_Mass;
                %Upated 20210410 BELOW
%                 set(handles.edit_TunedMass,'String',Tuned_Mass); % The fetched Tuned Mass assigned to the Tuned Mass in Main window
%                 set(handles.edit_TunedMass,'ForegroundColor',[0 0 0]); % Black Color
                %Upated 20210410 ABOVE
            end % if ((get(handles.checkbox_TunedMass, 'Value')) == 1)
        end
        
        %% Engine
        if FilterPSTs == 1
            tic;
            Tags_Ladder = Prep_Score_PSTs(str2num(User_EST_parameters{1}),str2num(User_EST_parameters{2}),str2num(User_EST_parameters{3}),str2num(User_EST_parameters{4})); %#ok<ST2NM>
            ArrayOfPst = ArrayOfPst + toc;
        else
            Tags_Ladder = {};
        end
        
        FilterDB=getappdata(0,'FilterDB');
        if FilterDB
            tic;
            [Candidate_ProteinsList_Initial,Candidate_ProteinsList_Truncated] = ParseDatabaseBatch(Candidate_ProteinsList_Full,Experimental_Protein_Mass,MW_Tolerance,Fixed_Modifications,Variable_Modifications,Tags_Ladder);
            ArrayOfDbFetch = ArrayOfDbFetch + toc;
        else
            Candidate_ProteinsList_Initial = Candidate_ProteinsList_Full;
            %% Obtain proteins greater then MolW.
            Candidate_ProteinsList_Truncated = Candidate_ProteinsList_Full;
        end
        
        Candidate_ProteinsList_MW=Score_Mol_Weight(Candidate_ProteinsList_Initial,Experimental_Protein_Mass);
        
        tic;
        Candidate_ProteinsList = Updated_ParseDatabase(Experimental_Protein_Mass,Tags_Ladder,Candidate_ProteinsList_MW,PTM_Tolerance,Fixed_Modifications,Variable_Modifications );
        ArrayOfUpdated_ParseDatabase= ArrayOfUpdated_ParseDatabase + toc;
        
        tic;
        Candidate_ProteinsList = Insilico_frags_Generator_modifier(Candidate_ProteinsList,Fragmentation_Type,HandleIon);
        ArrayOfInsilico_frags_Generator_modifier = ArrayOfInsilico_frags_Generator_modifier + toc;
        
        if BlindPTMvar == 1
            
            tic;
            [sizeHopeInfo,Hop_Info_name, Hop_Info_AA, Hop_Info_end, Hop_Info_start] = BlindPTM_Extraction();
            Candidate_ProteinsListModified = BlindPTM(Candidate_ProteinsList,Peptide_Tolerance, 1,PepUnit,sizeHopeInfo,Hop_Info_name, Hop_Info_AA, Hop_Info_end, Hop_Info_start);
            ArrayOfBlindPtm = ArrayOfBlindPtm + toc;
            
        else
            Candidate_ProteinsListModified = [];
        end
        Candidate_ProteinsList = [Candidate_ProteinsList; Candidate_ProteinsListModified];
        
        tic;
        Matches = Insilico_Score(Candidate_ProteinsList,getappdata(0,'Fragments_Masses'), getappdata(0,'Int'),Peptide_Tolerance,PepUnit); %Updated 20210410 %% Use mass diff to estimate blind ptms.
        ArrayOfSpectralComparison = ArrayOfSpectralComparison + toc;
        
        tic;
        Matches = BlindPTM_Localization(Matches,Experimental_Protein_Mass);
        ArrayOfBlindPtm = ArrayOfBlindPtm + toc;
        
        %% Truncation Starts Here
        truncation = getappdata(0,'Truncation');
        if isempty(truncation)
            truncation = 0;
        end
        TruncatedMatches = [];
        tic;
        if truncation == 1
            %% Candidate_ProteinsList_Truncated = ParseDatabaseBatch_Truncation(Candidate_ProteinsList_Full,Experimental_Protein_Mass,MW_Tolerance,Tags_Ladder);
            [Candidate_ProteinsList_Left,Candidate_ProteinsList_Right] = PreTruncation(Candidate_ProteinsList_Truncated,MW_Tolerance);
            
            %% Ordinary Truncation
            [Candidate_ProteinsList_Left, RemainingProteins_Left] = Truncation_Left(Candidate_ProteinsList_Left);
            [Candidate_ProteinsList_Right, RemainingProteins_Right] = Truncation_Right(Candidate_ProteinsList_Right);
            Candidate_ProteinsList_UnModified = [Candidate_ProteinsList_Left; Candidate_ProteinsList_Right];
            
            %% In silico Treatment
            Candidate_ProteinsList_UnModified = Insilico_frags_Generator_modifier(Candidate_ProteinsList_UnModified,Fragmentation_Type,HandleIon);
            if BlindPTMvar == 1
                RemainingProteins_Right = Insilico_frags_Generator_modifier(RemainingProteins_Right,Fragmentation_Type,HandleIon);
                RemainingProteins_Left = Insilico_frags_Generator_modifier(RemainingProteins_Left,Fragmentation_Type,HandleIon);
                
                %% Blind PTM localization
                [RemainingProteins_Right_Modified] = BlindPTM_Truncation_Right(RemainingProteins_Right, Peptide_Tolerance, 1, PepUnit, sizeHopeInfo,Hop_Info_name, Hop_Info_AA, Hop_Info_end, Hop_Info_start);
                [RemainingProteins_Left_Modified] = BlindPTM_Truncation_Left(RemainingProteins_Left, Peptide_Tolerance, 1, PepUnit, sizeHopeInfo,Hop_Info_name, Hop_Info_AA, Hop_Info_end, Hop_Info_start);
                
                %% Modified Truncation
                %20181029 - Adding additional parameters for pepUnits etc
                %[Candidate_ProteinsList_Modified_Right] = Truncation_Right_Modification(RemainingProteins_Right_Modified, Fragmentation_Type);
                [Candidate_ProteinsList_Modified_Right] = Truncation_Right_Modification(RemainingProteins_Right_Modified, Peptide_Tolerance, PepUnit, Fragmentation_Type);
                [Candidate_ProteinsList_Modified_Left] = Truncation_Left_Modification(RemainingProteins_Left_Modified, Peptide_Tolerance, PepUnit, Fragmentation_Type);
            else
                Candidate_ProteinsList_Modified_Right = [];
                Candidate_ProteinsList_Modified_Left = [];
            end
            %% Final Scoring
            Candidate_ProteinsList = [Candidate_ProteinsList_UnModified;Candidate_ProteinsList_Modified_Left;Candidate_ProteinsList_Modified_Right];
            Candidate_ProteinsList = FIlter_Truncated_Proteins(Candidate_ProteinsList, Tags_Ladder);
            TruncatedMatches = Insilico_Score(Candidate_ProteinsList,getappdata(0,'Fragments_Masses'), getappdata(0,'Int'),Peptide_Tolerance,PepUnit); %Updated 20210410 %% Use mass diff to estimate blind ptms.
        end
        ArrayOfTruncation = ArrayOfTruncation + toc;
        
        Matches = [Matches; TruncatedMatches]; %#ok<AGROW>
        setappdata(0,'Matches',Matches);
        tElapsed = num2str(toc(batchModeTimer));
        
        %% Compute Final Score
        final_score;
        
        %% Compute E-Value
        Matches=getappdata(0,'Matches');
        tic;
        if numel(Matches) ~= 0
            Matches =  PrSM_Evalue(Matches);
        end
        ArrayOfEvalue = ArrayOfEvalue + toc;
        
        %% For table
        data = cell(numel(Matches),22);
        %sort result with respect to their scores
        for z=1:numel(Matches)
            % get values from structure in which result are stored
            data{z,1} = Matches{z}.Header;
            data{z,2} = Matches{z}.Name;
            data{z,3} = Matches{z}.MolW;
            data{z,4} = Matches{z}.Final_Score;%
            data{z,5} = Matches{z}.Sequence;
            data{z,6} = Matches{z}.PTM_score;
            data{z,7} = Matches{z}.PTM_name;
            data{z,8} = Matches{z}.EST_Score;
            data{z,9} = Matches{z}.PTM_seq_idx;
            data{z,10} = Matches{z}. PTM_site;
            data{z,11} = Matches{z}. MWScore;
            data{z,12} = Matches{z}.Matches_Score;
            data{z,13} = Matches{z}.LeftIons;
            data{z,14} = Matches{z}.RightIons;
            
            if BlindPTMvar == 1
                Blind = Matches{z}.Blind;
            else
                Blind.Start = -1;
                Blind.End = -1;
                Blind.Mass = -1;
            end
            
            
            data{z,15} = Blind.Start;
            data{z,16} = Blind.End;
            data{z,17} = Blind.Mass;
            data{z,18} = Matches{z}.Match;
            data{z,19} = Matches{z}.Terminal_Modification;
            
            if truncation == 1
                if strcmp(Matches{z}.Truncation,'Left')
                    TruncationMessage = 'Truncation at N-Terminal Side';
                elseif strcmp(Matches{z}.Truncation,'Right')
                    TruncationMessage = 'Truncation at C-Terminal Side';
                else
                    TruncationMessage = 'No Truncation';
                end
                TruncationLocation = Matches{z}.TruncationIndex;
            else
                TruncationMessage = 'No Truncation';
                TruncationLocation = -1;
            end
            data{z,20} = TruncationMessage;
            data{z,21} = TruncationLocation;
            data{z,22} = Matches{z}.Evalue;
        end
        
        % Write File
        if numel(data) ~= 0
            data=sortrows(data,-4);
            menu_File = fopen(Save_Batch_File,'a');
            size_data=size(data);
            for out_put=1:size_data(1)
                %                 header=strcat('>',data{out_put,1},' | Score:',data{out_put,4},' | Molweight:',data{out_put,3},' | # Matched Feagments:',num2str(data{out_put,18}),' | Terminal Modification:',data{out_put,19},' | E-Value:',num2str(data{out_put,22}));
                formatSpec = '> %s | Score: %f | Molweight: %f | # Matched Fragments: %d | Terminal Modification: %s | E-Value: %g';
                fprintf(menu_File,formatSpec,data{out_put,1},data{out_put,4},data{out_put,3},data{out_put,18},data{out_put,19},data{out_put,22});
                fprintf(menu_File,'\n');
                fprintf(menu_File,data{out_put,5});
                fprintf(menu_File,'\n');
                for indi = 1 : numel(data{out_put,7})
                    %                     Modification = strcat('Modification Name: ',data{out_put,7}{indi},' | Modification Site: ',data{out_put,10}{indi},' | Site Index: ', num2str(data{out_put,9}(indi)) );
                    Modification = 'Modification Name: %s | Modification Site: %d | Site Index: %d';
                    fprintf(menu_File,Modification, data{out_put,7}{indi}, data{out_put,10}{indi}, data{out_put,9}(indi));
                    fprintf(menu_File,'\n');
                end
                
                if BlindPTMvar == 1
                    if data{out_put,15} ~= -1
                        %                         Modification = strcat('Modification Name: Unknown | Modification Weight: ', num2str(data{out_put,17}),' | Modification lies between index :',num2str(data{out_put,15}),'-',num2str(data{out_put,16}));
                        Modification = 'Modification Name: Unknown | Modification Weight: %f | Modification lies between index : %d - %d';
                        fprintf(menu_File, Modification', data{out_put,17}, data{out_put,15}, data{out_put,16});
                        fprintf(menu_File,'\n');
                    end
                end
            end
            fclose( menu_File);
            headerRegex =  data{1,1};
            headerRegex(regexp(headerRegex,'[,]'))=[];
            headerRegex = regexprep(headerRegex,'[\n\r]+','');
            csvData = [csvData; {DirectoryContents(i).name}, headerRegex, {data{1,19}}, {data{1,5}}, {data{1,20}}, {data{1,21}}, data{1,4}, {data{1,3}}, numel(data{1,7}), {data{1,18}}, tElapsed, {data{1,22}}]; %#ok<AGROW>
            cd(initial_path);
        else
            cd(initial_path);
            cd(getappdata(0,'Result_Folder'));
            menu_File = fopen(Save_Batch_File,'a');
            fprintf(menu_File,'\n');
            fprintf(menu_File,'No Result Found Please search with another set of parameters');
            fclose( menu_File);
            cd(initial_path)
        end
        isResultAvailable = 1; %Updated 20210427
    catch Error
        menu_File = fopen(Save_Batch_File,'a');
        fprintf(menu_File,'\n');
        fprintf(menu_File,'No Result Found Please search with another set of parameters');
        fclose( menu_File);
        % setappdata(0,'P_condotion',0);  %Updated 20210427
        continue ;
    end
    
end
cd(getappdata(0,'Result_Folder'));
fid = fopen(strcat(Project_Title,'.csv'),'w');
fprintf(fid,'%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s\r\n',csvData{1,:});
for csvIndex = 2:numel(csvData)/12
    fprintf(fid,'%s, %s, %s, %s, %s, %d, %f, %f, %d, %d, %s, %g\r\n',csvData{csvIndex,:});
end
fclose(fid);
cd(initial_path)
progressbar(1/1);
setappdata(0,'isResultAvailable',isResultAvailable); %Updated 20210427