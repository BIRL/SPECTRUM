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
function [sizeHopeInfo,Hop_Info_name, Hop_Info_AA, Hop_Info_end, Hop_Info_start] = BlindPTM_Extraction( )

% Experimental peak extraction and peak fliping.
%%% Updated 20210409   %% BELOW
%ExperimentalSpectrum = sortrows(getappdata(0,'Peaklist_Data'));
PeakListMW = getappdata(0,'Fragments_Masses');
Intensity = getappdata(0,'Int');
ExperimentalSpectrum = [PeakListMW, Intensity];%sortrows(getappdata(0,'Peaklist_Data'));
%%% Updated 20210409   %% ABOVE

MolW = ExperimentalSpectrum(size(ExperimentalSpectrum,1));

User_Hop_Threshold = 1;

peaks = [0 ExperimentalSpectrum(1:size(ExperimentalSpectrum,1)-1) MolW - ExperimentalSpectrum(1:size(ExperimentalSpectrum,1)-1)    MolW];
peaks = peaks';
peaks = sortrows(peaks);

[InfoModMass,InfoModAminoAcids,InfoModName] = InfoTable();

% Initializations.
Hop_Info_name = [];
Hop_Info_AA = [];
Hop_Info_end = [];
Hop_Info_start = [];
Ladder_Index = 0;
%% Extraction of Modified and Unmodified tags
for ExpI = 2 : size(peaks,1)-1
    for ExpJ = ExpI+1 : size(peaks,1)
        PeakDiff = peaks(ExpJ) - peaks(ExpI);
        for AAIndex = 1 : numel(InfoModMass) % number itration increase from 20 to 39 :20 unmodif  ied and 33 for PTM and 39 if other modification are selected
            Error = PeakDiff - InfoModMass(AAIndex);
            abs_Error = abs(Error);
            if  abs_Error <= User_Hop_Threshold
                Ladder_Index = Ladder_Index + 1;
                Hop_Info_name = [Hop_Info_name;InfoModName(AAIndex)]; %#ok<*CCAT1,*AGROW>
                Hop_Info_AA =[Hop_Info_AA;InfoModAminoAcids(AAIndex)];
                Hop_Info_end = [Hop_Info_end;peaks(ExpJ)];
                Hop_Info_start = [Hop_Info_start;peaks(ExpI)];
            else
                if Error < -User_Hop_Threshold
                    break;
                end
            end
        end
    end
end
sizeHopeInfo = numel(Hop_Info_AA);

end

function [InfoModMass,InfoModAminoAcids,InfoModName] = InfoTable()
InfoModMass = [70.0055000000000;99.0321000000000;111.032100000000;113.047700000000;113.047700000000;117.024800000000;129.042600000000;129.042600000000;131.999400000000;139.063400000000;142.074200000000;142.110600000000;143.058300000000;144.089900000000;147.035400000000;156.126300000000;159.035400000000;160.084800000000;163.030300000000;166.998300000000;170.105600000000;170.116700000000;173.014700000000;173.032400000000;173.051100000000;181.014000000000;184.132400000000;194.993200000000;198.111700000000;208.048400000000;217.025200000000;243.029600000000;290.111400000000;304.127100000000;341.239200000000;408.077200000000;431.164900000000];
InfoModAminoAcids = ['S';'G';'Q';'A';'P';'C';'S';'P';'C';'P';'G';'K';'T';'K';'M';'K';'M';'K';'M';'S';'K';'R';'C';'E';'M';'T';'R';'D';'R';'Y';'H';'Y';'S';'T';'C';'C';'N'];
InfoModName = {'Pyruvate-S';'Acetylation';'Pyrrolidone-Aarboxylic-Acid';'Acetylation';'Hydroxylation';'Methylation';'Acetylation';'DiHydroxylation';'S-Nitrosylation';'Acetylation';'Methylation';'Methylation';'Acetylation';'Hydroxylation';'Sulfoxide';'DiMethylation';'Formylation';'DiHydroxylation';'Sulfone';'Phosphorylation';'Acetylation';'Methylation';'Pyruvate-C';'Gamma-Carboxyglutamic-Acid';'Acetylation';'Phosphorylation';'DiMethylation';'Phosphorylation';'Acetylation';'Nitration';'Phosphorylation';'Phosphorylation';'O-linked-Glycosylation';'O-linked-Glycosylation';'Palmitoylation';'Glutathionylation';'N-linked-Glycosylation'};
end


