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

function [Tuned_MolWt, Fragments_SumofMolWt,Fragments_MaxIntensity ,Histc_Unique_Fragments_MolWt,Unique_Fragments_Occurrences] =  MassTuner(SliderValue,Intact_Protein_Mass,MW_Tolerance)
clc;
PeaksData.Peaks_List_MolWt = getappdata(0,'Fragments_Masses');
NeutralMass = getappdata(0,'neutral');
PeaksData.Peaks_List_Intensity = getappdata(0,'Int');
Peak = {};
Peak.Sums = [];
Peak.Ints = [];
% Sums = [];
WeightedMassSum = 0;
IntSum = 0;

if isstr(Intact_Protein_Mass) %#ok<*DISSTR>
    Intact_Protein_Mass = str2num(Intact_Protein_Mass); %#ok<*ST2NM>
end

SliderValue = (SliderValue * Intact_Protein_Mass)/ (10^6);

% Calculate Peak Sums and shortlist those falling within user specified tol.
for i = 1 : size(PeaksData.Peaks_List_MolWt,1)-1 %20190902 Minor Bug Fix (n-1)
    for j = i+1 : size(PeaksData.Peaks_List_MolWt,1) %20190902 Minor Bug Fix (n)
        %%%% Neutral Mass Added in the fragment sums to accomodate missing mass
        PeaksData.Sum_of_MolWt = PeaksData.Peaks_List_MolWt(i,1) + PeaksData.Peaks_List_MolWt(j,1) + str2num(NeutralMass);         %sum up one MW fragment with all the fragments present after it
        PeaksData.Fragment_Max_Intensity = (PeaksData.Peaks_List_Intensity (i) + PeaksData.Peaks_List_Intensity (j)) / 2;
%         Sums = [Sums; PeaksData.Sum_of_MolWt];
        if PeaksData.Sum_of_MolWt > Intact_Protein_Mass - MW_Tolerance && PeaksData.Sum_of_MolWt <= Intact_Protein_Mass + MW_Tolerance
            Peak.Sums = [Peak.Sums; PeaksData.Sum_of_MolWt];
            Peak.Ints = [Peak.Ints; PeaksData.Fragment_Max_Intensity];
            
        end
    end
end

% Sort Structure
[~, ix] = sort(Peak.Sums);
Peak = struct('Sums',{Peak.Sums(ix)}, 'Ints',{Peak.Ints(ix)});
if numel(Peak.Sums) == 0
    Tuned_MolWt = 0;
    Fragments_SumofMolWt = 0;
    Fragments_MaxIntensity = 0;
    Histc_Unique_Fragments_MolWt = 0;
    Unique_Fragments_Occurrences = 0;
    return;
end

window = Peak.Sums(1);
window_elements_old = [];
oldIndex = [];

H = 1.00727647;
count = [];
while window < Peak.Sums(numel(Peak.Sums))
    newIndex = [];
    window_elements_new = [];
    for i = 1 : numel(Peak.Sums)
        if Peak.Sums(i) >= window && Peak.Sums(i) < window + H
            window_elements_new = [window_elements_new; Peak.Sums(i)]; %#ok<AGROW>
            newIndex = [newIndex; i]; %#ok<AGROW>
        elseif Peak.Sums(i) >= window + H
            break;
        end
    end
     count = [count; numel(window_elements_new)];
    if numel(window_elements_new) >  numel(window_elements_old)
        window_elements_old = window_elements_new;
        oldIndex = newIndex;
    elseif numel(window_elements_new) == numel(window_elements_old)
        oldDiff = abs(window_elements_old(numel(window_elements_old)) - Intact_Protein_Mass);
        newDiff = abs(window_elements_new(numel(window_elements_new)) - Intact_Protein_Mass);
        if numel(window_elements_old) == 5
            disp('diff')
            disp(oldDiff)
            disp(newDiff)
        end
        if oldDiff >= newDiff
            window_elements_old = window_elements_new;
            oldIndex = newIndex;
        end
    end
    window = window + SliderValue;
end

for i = 1 : numel(window_elements_old)
    WeightedMassSum = WeightedMassSum + (Peak.Sums(oldIndex(i)) * Peak.Ints(oldIndex(i)));
    IntSum = IntSum + Peak.Ints(oldIndex(i));
end
Fragments_SumofMolWt = window_elements_old;
Fragments_MaxIntensity = cat(2, window_elements_old, Peak.Ints(oldIndex)); 

%%% Start - From old code
Fragments_Selected_SumofMolWt_Rounded = round(Fragments_SumofMolWt*100000)/100000;                                      %round off the molcular weight fragments to 5 decimal places
Fragments_Selected_SumofMolWt_Rounded = sort(Fragments_Selected_SumofMolWt_Rounded); % sort the MWs in an ascending order
[Unique_Selected_Fragments, ~ ] = unique(Fragments_Selected_SumofMolWt_Rounded);   %select only the unique weights and get their indexes
Histc_Unique_Fragments_Selected = [Unique_Selected_Fragments,histc(Fragments_Selected_SumofMolWt_Rounded(:),Unique_Selected_Fragments)];
Histc_Unique_Fragments_Selected_Size = size(Histc_Unique_Fragments_Selected,1);
Histc_Unique_Fragments_MolWt = zeros(Histc_Unique_Fragments_Selected_Size,1);
Unique_Fragments_Occurrences = zeros(Histc_Unique_Fragments_Selected_Size,1);
for d=1:Histc_Unique_Fragments_Selected_Size
    Histc_Unique_Fragments_MolWt(d) = Histc_Unique_Fragments_Selected(d,1);
    Unique_Fragments_Occurrences(d) = Histc_Unique_Fragments_Selected(d,2);
end
Unique_Fragments_Occurrences = Unique_Fragments_Occurrences/100  ;                                             %divide the number of occurance by 100
%%% END

Tuned_MolWt = WeightedMassSum/IntSum;