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

function Candidate_ProteinsList = Insilico_frags_Generator_modifier(Candidate_ProteinsList,Frag_technique,HandleIon)
for ProteinListIndex= 1:numel(Candidate_ProteinsList)
    similar_fragments = {'CID','IMD','BIRD','SID','HCD'};
    similar_fragments2 = {'ECD','ETD'};
    similar_fragments3 = {'EDD','NETD'};
    match = strcmpi(Frag_technique,similar_fragments); % compares the selected fragmentation technique with the set of similar techniques (ions wise)
    match2 = strcmpi(Frag_technique,similar_fragments2); % compares the selected fragmentation technique with the set of similar techniques (ions wise)
    match3 = strcmpi(Frag_technique,similar_fragments3); % compares the selected fragmentation technique with the set of similar techniques (ions wise)
    
    Proton = 1.00727647;
    H = 1.007825035;
    C = 12.0000;
    O = 15.99491463;
    N = 14.003074;
    Electron = 0.000549; %#ok<NASGU>
    OH = O + H;
    CO = C + O;
    NH = N + H;
    NH3 = N+H+H+H;
    H2O = H+H+O;
    
    if any(match) % checks if any value in match array is non-zero
        Candidate_ProteinsList{ProteinListIndex,1}.LeftIons= Candidate_ProteinsList{ProteinListIndex,1}.LeftIons + Proton; % adding the molecular weight of a hydrogen from left fragment to produce b-ion
        Candidate_ProteinsList{ProteinListIndex,1}.RightIons= Candidate_ProteinsList{ProteinListIndex,1}.RightIons + OH + (2*H); % subtracting the molecular weight of a hydrogen from right fragment to produce y-ion
        if(isempty(HandleIon))
            Candidate_ProteinsList{ProteinListIndex,1}.LeftIons_bo = [];
            Candidate_ProteinsList{ProteinListIndex,1}.LeftIons_bstar = [];
            Candidate_ProteinsList{ProteinListIndex,1}.RightIons_ystar = [];
            Candidate_ProteinsList{ProteinListIndex,1}.RightIons_yo = [];
        else
            if(HandleIon{2,1} == 1)
                Candidate_ProteinsList{ProteinListIndex,1}.LeftIons_bo = Candidate_ProteinsList{ProteinListIndex,1}.LeftIons - H2O;
            else
                Candidate_ProteinsList{ProteinListIndex,1}.LeftIons_bo = [];
            end
            if(HandleIon{7,1} == 1)
                Candidate_ProteinsList{ProteinListIndex,1}.LeftIons_bstar = Candidate_ProteinsList{ProteinListIndex,1}.LeftIons-NH3;
            else
                Candidate_ProteinsList{ProteinListIndex,1}.LeftIons_bstar = [];
            end
            if(HandleIon{8,1} == 1)
                Candidate_ProteinsList{ProteinListIndex,1}.RightIons_ystar = Candidate_ProteinsList{ProteinListIndex,1}.RightIons-NH3;
            else
                Candidate_ProteinsList{ProteinListIndex,1}.RightIons_ystar = [];
            end
            if(HandleIon{3,1} == 1)
                Candidate_ProteinsList{ProteinListIndex,1}.RightIons_yo = Candidate_ProteinsList{ProteinListIndex,1}.RightIons - H2O;
            else
                Candidate_ProteinsList{ProteinListIndex,1}.RightIons_yo = [];
            end
            
        end
    else
        Candidate_ProteinsList{ProteinListIndex,1}.LeftIons_bo = [];
        Candidate_ProteinsList{ProteinListIndex,1}.LeftIons_bstar = [];
        Candidate_ProteinsList{ProteinListIndex,1}.RightIons_ystar = [];
        Candidate_ProteinsList{ProteinListIndex,1}.RightIons_yo = [];
        
    end
    
    if any(match2)
        Candidate_ProteinsList{ProteinListIndex,1}.LeftIons = Candidate_ProteinsList{ProteinListIndex,1}.LeftIons + Proton + N + (3*H); % adding NH2 to left fragment to produce c-ion
        Candidate_ProteinsList{ProteinListIndex,1}.RightIons = Candidate_ProteinsList{ProteinListIndex,1}.RightIons + OH - NH;% subtracting NH2 from right fragment to produce z-ion
        HandleIon{4,1} = 1; %% ECD and ETD always contain Z' ions
        if (isempty(HandleIon))
            Candidate_ProteinsList{ProteinListIndex,1}.RightIons_zo = [];
            Candidate_ProteinsList{ProteinListIndex,1}.RightIons_zoo = [];
        else
            if(HandleIon{4,1} == 1)
                Candidate_ProteinsList{ProteinListIndex,1}.RightIons_zo = Candidate_ProteinsList{ProteinListIndex,1}.RightIons+Proton;
            else
                Candidate_ProteinsList{ProteinListIndex,1}.RightIons_zo = [];
            end
            if(HandleIon{5,1} == 1)
                Candidate_ProteinsList{ProteinListIndex,1}.RightIons_zoo = Candidate_ProteinsList{ProteinListIndex,1}.RightIons+Proton+Proton;
            else
                Candidate_ProteinsList{ProteinListIndex,1}.RightIons_zoo = [];
            end
        end
    else
        Candidate_ProteinsList{ProteinListIndex,1}.RightIons_zo = [];
        Candidate_ProteinsList{ProteinListIndex,1}.RightIons_zoo = [];
    end
    
    if any(match3)
        Candidate_ProteinsList{ProteinListIndex,1}.LeftIons  = Candidate_ProteinsList{ProteinListIndex,1}.LeftIons + Proton - CO; % subtracting the molecular weight of CHO from left fragment to produce a-ion
        Candidate_ProteinsList{ProteinListIndex,1}.RightIons = Candidate_ProteinsList{ProteinListIndex,1}.RightIons + OH + CO; % adding the molecular weight of CO and subtracting H from right fragment to produce x-ion
        if (isempty(HandleIon))
            Candidate_ProteinsList{ProteinListIndex,1}.LeftIons_ao = [];
            Candidate_ProteinsList{ProteinListIndex,1}.LeftIons_astar = [];
        else
            if(HandleIon{1,1} == 1)
                Candidate_ProteinsList{ProteinListIndex,1}.LeftIons_ao = Candidate_ProteinsList{ProteinListIndex,1}.LeftIons-H2O;
            else
                Candidate_ProteinsList{ProteinListIndex,1}.LeftIons_ao = [];
            end
            if(HandleIon{6,1} == 1)
                Candidate_ProteinsList{ProteinListIndex,1}.LeftIons_astar = Candidate_ProteinsList{ProteinListIndex,1}.LeftIons-NH3;
            else
                Candidate_ProteinsList{ProteinListIndex,1}.LeftIons_astar = [];
            end
        end
    else
        Candidate_ProteinsList{ProteinListIndex,1}.LeftIons_ao = [];
        Candidate_ProteinsList{ProteinListIndex,1}.LeftIons_astar = [];
    end
end
end