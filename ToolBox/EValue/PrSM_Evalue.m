function [Candidate_ProteinsList]  =  PrSM_Evalue(Candidate_ProteinsList)
ProbOfSequence = [];
SpectralMatches = [];
Evalue = [];

%% Get Protein Data i.e. Spectral Matches and Probability of Sequence
for ProteinListIndex= 1: numel(Candidate_ProteinsList)
    protein = Candidate_ProteinsList{ProteinListIndex,1};
    ProbOfSequence = [ProbOfSequence; ProabailityAA(protein.Sequence)];
    SpectralMatches = [SpectralMatches; protein.Match];
end
%% Get Unique Spectral Matches in Order
USpectralMatches = unique(SpectralMatches);
USpectralMatches = sortrows(USpectralMatches, -1);

for i = 1:numel(USpectralMatches)
    %% Get Indices corresponding to each unique Spectral Match Number
    Matches = USpectralMatches(i);
    ind = SpectralMatches == Matches;
    setInd = ind; %% Will be used for setting E-Value
    if i > 1
        for k = i-1:-1:1
            % For Accomoddating greater than equal to condition of score threshold
            temp_ind = SpectralMatches == USpectralMatches(k);
            ind = ind + temp_ind;
        end
    end
    
    eval = 0;
    counter = 0;
    
    %% Computing E-Value
    for j = 1:numel(SpectralMatches)
        if ind(j) == 1
            eval = eval + ProbOfSequence(j);
            counter = counter + 1;
        end
    end
    eval = counter*eval;
    
    %% Saving E-Value for each Candidate Protein
    for ProteinListIndex = 1:numel(SpectralMatches)
        if setInd(ProteinListIndex) == 1
            if strcmp(Candidate_ProteinsList{ProteinListIndex, 1}.Truncation,'None')
                Candidate_ProteinsList{ProteinListIndex,1}.Evalue = eval;
            else
                % Multiplied by 0.693 (Cs and Cp from the paper to accomodate Truncations)
                Candidate_ProteinsList{ProteinListIndex,1}.Evalue = eval * 0.693;
            end
        end
    end
    
    Evalue = [Evalue; eval];
end
end