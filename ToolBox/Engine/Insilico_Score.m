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

function Matches = Insilico_Score(Candidate_ProteinsList,ExperimentalMWs, ExperimentalIntensities,IonssMW_threshold,PepUnit)

ExperimentalPeakList = [ExperimentalMWs, ExperimentalIntensities];

Matches = cell(numel(Candidate_ProteinsList),1);
Idx = 0;
peakCount = numel(ExperimentalPeakList)/2;

for PeakListIndex = 1:peakCount
    if ExperimentalPeakList(PeakListIndex,2) < 0.000092
        ExperimentalPeakList(PeakListIndex,2) = 0.001;
    else
        ExperimentalPeakList(PeakListIndex,2) = 1;
    end
end

if peakCount > 16
    
    StartIndex = 1;   %Upadted 20210410
    EndIndex = peakCount - 1;   %Upadted 20210410
    
    % ExperimentalPeakList(:,2) =  log10(2.162.*ExperimentalPeakList(:,2)+1)+0.50003813;
    % set matched attribute false - will be used to prevent duplicate proteins entries in final array
    for ProteinListIndex= 1: numel(Candidate_ProteinsList)
        
        numofLInsilicos = numel(Candidate_ProteinsList{ProteinListIndex,1}.LeftIons);
        numofRInsilicos = numel(Candidate_ProteinsList{ProteinListIndex,1}.RightIons);
        
        numofAo = numel(Candidate_ProteinsList{ProteinListIndex,1}.LeftIons_ao);
        if(numofAo > 0)
            LeftIons_ao = Candidate_ProteinsList{ProteinListIndex,1}.LeftIons_ao;
        end
        
        numofBo = numel(Candidate_ProteinsList{ProteinListIndex,1}.LeftIons_bo);
        if(numofBo > 0)
            LeftIons_bo = Candidate_ProteinsList{ProteinListIndex,1}.LeftIons_bo;
        end
        
        numofAstar = numel(Candidate_ProteinsList{ProteinListIndex,1}.LeftIons_astar);
        if(numofAstar > 0)
            LeftIons_astar = Candidate_ProteinsList{ProteinListIndex,1}.LeftIons_astar;
        end
        
        numofBstar = numel(Candidate_ProteinsList{ProteinListIndex,1}.LeftIons_bstar);
        if(numofBstar > 0)
            LeftIons_bstar = Candidate_ProteinsList{ProteinListIndex,1}.LeftIons_bstar;
        end
        
        numofYo = numel(Candidate_ProteinsList{ProteinListIndex,1}.RightIons_yo);
        if(numofYo > 0)
            RightIons_yo = Candidate_ProteinsList{ProteinListIndex,1}.RightIons_yo;
        end
        
        numofZo = numel(Candidate_ProteinsList{ProteinListIndex,1}.RightIons_zo);
        if(numofZo > 0)
            RightIons_zo = Candidate_ProteinsList{ProteinListIndex,1}.RightIons_zo;
        end
        
        numofZoo = numel(Candidate_ProteinsList{ProteinListIndex,1}.RightIons_zoo);
        if(numofZoo > 0)
            RightIons_zoo = Candidate_ProteinsList{ProteinListIndex,1}.RightIons_zoo;
        end
        
        numofYstar = numel(Candidate_ProteinsList{ProteinListIndex,1}.RightIons_ystar);
        if(numofYstar > 0)
            RightIons_ystar = Candidate_ProteinsList{ProteinListIndex,1}.RightIons_ystar;
        end
        
        LeftIons = Candidate_ProteinsList{ProteinListIndex,1}.LeftIons;
        RightIons = Candidate_ProteinsList{ProteinListIndex,1}.RightIons;
        
        
        Matches_Score = 0;
        MatchCounter = 0;
        LeftMatched_Index = [];
        RightMatched_Index = [];
        LeftPeak_Index = [];
        RightPeak_Index = [];
        LeftType = [];
        RightType = [];
        
        IdxL = 1;
        IdxR = 1;
        
        specialLeft = numofAo + numofBo + numofAstar + numofBstar;
        specialRight =  numofYo + numofZo + numofZoo + numofYstar;
        % For Finding consecutive region
        Counter = 0;
        OldConsec = 0;
        OldConsec2 = 0;
        ConsecutiveRegion = 0;
        
        if strcmp(PepUnit,'Da')|| strcmp(PepUnit,'mmu')
            tol = IonssMW_threshold;
            for PeakListIndex = StartIndex:EndIndex   %Upadted 20210410
                Consecutive = PeakListIndex;
                %check in Left Ions
                for left_Idx = IdxL:numofLInsilicos
                    
                    % Left
                    diff = ExperimentalPeakList(PeakListIndex) - LeftIons(left_Idx);
                    abs_diff = abs(diff);
                    if abs_diff <= tol
                        if Consecutive == OldConsec + 1 && OldConsec == OldConsec2 + 1
                            if Counter == 0
                                ConsecutiveRegion = ConsecutiveRegion + 1;
                            end
                            Counter = Counter + 1;
                            Matches_Score = Matches_Score + 1.5;
                            OldConsec2 = OldConsec;
                            OldConsec = Consecutive;
                        elseif Consecutive == OldConsec && OldConsec == OldConsec2 + 1
                            Counter = Counter + 1;
                            Matches_Score = Matches_Score + 1.5;
                        else
                            Counter = 0;
                            Matches_Score = Matches_Score + ExperimentalPeakList(PeakListIndex,2);                     %Matches_Score = Matches_Score + 1.5;
                            OldConsec2 = OldConsec;
                            OldConsec = Consecutive;
                        end % only update score
                        LeftMatched_Index = [LeftMatched_Index; left_Idx];
                        LeftPeak_Index = [LeftPeak_Index; PeakListIndex];
                        LeftType = [LeftType; {'Left'} ];
                        MatchCounter = MatchCounter + 1;
                    end
                    
                    if specialLeft == 0
                    else
                        %% ao 1
                        if(numofAo > 0)
                            diff = ExperimentalPeakList(PeakListIndex) - LeftIons_ao(left_Idx);
                            abs_diff = abs(diff);
                            
                            if abs_diff <= tol
                                if Consecutive == OldConsec + 1 && OldConsec == OldConsec2 + 1
                                    if Counter == 0
                                        ConsecutiveRegion = ConsecutiveRegion + 1;
                                    end
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                elseif Consecutive == OldConsec && OldConsec == OldConsec2 + 1
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                else
                                    Counter = 0;
                                    Matches_Score = Matches_Score + ExperimentalPeakList(PeakListIndex,2);                     %Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                end % only update score
                                LeftMatched_Index = [LeftMatched_Index; left_Idx];
                                LeftPeak_Index = [LeftPeak_Index; PeakListIndex];
                                LeftType = [LeftType; {'A'''} ];
                                MatchCounter = MatchCounter + 1;
                            end
                        end
                        
                        %% bo 2
                        if(numofBo > 0)
                            diff = ExperimentalPeakList(PeakListIndex) - LeftIons_bo(left_Idx);
                            abs_diff = abs(diff);
                            
                            if abs_diff <= tol
                                if Consecutive == OldConsec + 1 && OldConsec == OldConsec2 + 1
                                    if Counter == 0
                                        ConsecutiveRegion = ConsecutiveRegion + 1;
                                    end
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                elseif Consecutive == OldConsec && OldConsec == OldConsec2 + 1
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                else
                                    Counter = 0;
                                    Matches_Score = Matches_Score + ExperimentalPeakList(PeakListIndex,2);                     %Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                end % only update score
                                LeftMatched_Index = [LeftMatched_Index; left_Idx];
                                LeftPeak_Index = [LeftPeak_Index; PeakListIndex];
                                LeftType = [LeftType; {'B'''} ];
                                MatchCounter = MatchCounter + 1;
                            end
                        end
                        
                        %% a* 6
                        if(numofAstar > 0)
                            diff = ExperimentalPeakList(PeakListIndex) - LeftIons_astar(left_Idx);
                            abs_diff = abs(diff);
                            
                            if abs_diff <= tol
                                if Consecutive == OldConsec + 1 && OldConsec == OldConsec2 + 1
                                    if Counter == 0
                                        ConsecutiveRegion = ConsecutiveRegion + 1;
                                    end
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                elseif Consecutive == OldConsec && OldConsec == OldConsec2 + 1
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                else
                                    Counter = 0;
                                    Matches_Score = Matches_Score + ExperimentalPeakList(PeakListIndex,2);                     %Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                end % only update score
                                LeftMatched_Index = [LeftMatched_Index; left_Idx];
                                LeftPeak_Index = [LeftPeak_Index; PeakListIndex];
                                LeftType = [LeftType; {'A*'} ];
                                MatchCounter = MatchCounter + 1;
                            end
                        end
                        
                        %% b* 7
                        if(numofBstar > 0)
                            diff = ExperimentalPeakList(PeakListIndex) - LeftIons_bstar(left_Idx);
                            abs_diff = abs(diff);
                            if abs_diff <= tol
                                if Consecutive == OldConsec + 1 && OldConsec == OldConsec2 + 1
                                    if Counter == 0
                                        ConsecutiveRegion = ConsecutiveRegion + 1;
                                    end
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                elseif Consecutive == OldConsec && OldConsec == OldConsec2 + 1
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                else
                                    Counter = 0;
                                    Matches_Score = Matches_Score + ExperimentalPeakList(PeakListIndex,2);                     %Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                end % only update score
                                LeftMatched_Index = [LeftMatched_Index; left_Idx];
                                LeftPeak_Index = [LeftPeak_Index; PeakListIndex];
                                LeftType = [LeftType; {'B*'} ];
                                MatchCounter = MatchCounter + 1;
                            end
                        end
                    end
                    
                    if diff < -tol && left_Idx > 1
                        IdxL = left_Idx - 1;
                        break;
                    end
                end
                
                %check in RIght Ions
                for right_Idx = IdxR:numofRInsilicos
                    % Right
                    diff = ExperimentalPeakList(PeakListIndex) - RightIons(right_Idx);
                    abs_diff = abs(diff);
                    if abs_diff <= tol
                        if Consecutive == OldConsec + 1 && OldConsec == OldConsec2 + 1
                            if Counter == 0
                                ConsecutiveRegion = ConsecutiveRegion + 1;
                            end
                            Counter = Counter + 1;
                            Matches_Score = Matches_Score + 1.5;
                            OldConsec2 = OldConsec;
                            OldConsec = Consecutive;
                        elseif Consecutive == OldConsec && OldConsec == OldConsec2 + 1
                            Counter = Counter + 1;
                            Matches_Score = Matches_Score + 1.5;
                        else
                            Counter = 0;
                            Matches_Score = Matches_Score + ExperimentalPeakList(PeakListIndex,2);                     %Matches_Score = Matches_Score + 1.5;
                            OldConsec2 = OldConsec;
                            OldConsec = Consecutive;
                        end % only update score
                        RightMatched_Index = [RightMatched_Index; right_Idx];
                        RightPeak_Index = [RightPeak_Index; PeakListIndex];
                        RightType = [RightType; {'Right'}];
                        MatchCounter = MatchCounter + 1;
                    end
                    
                    if specialRight == 0
                    else
                        %% yo 3
                        if(numofYo > 0)
                            diff = ExperimentalPeakList(PeakListIndex) - RightIons_yo(right_Idx);
                            abs_diff = abs(diff);
                            if abs_diff <= tol
                                if Consecutive == OldConsec + 1 && OldConsec == OldConsec2 + 1
                                    if Counter == 0
                                        ConsecutiveRegion = ConsecutiveRegion + 1;
                                    end
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                elseif Consecutive == OldConsec && OldConsec == OldConsec2 + 1
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                else
                                    Counter = 0;
                                    Matches_Score = Matches_Score + ExperimentalPeakList(PeakListIndex,2);                     %Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                end % only update score
                                RightMatched_Index = [RightMatched_Index; right_Idx];
                                RightPeak_Index = [RightPeak_Index; PeakListIndex];
                                RightType = [RightType; {'Y'''}];
                                MatchCounter = MatchCounter + 1;
                            end
                        end
                        
                        %% zo 4
                        if(numofZo > 0)
                            diff = ExperimentalPeakList(PeakListIndex) - RightIons_zo(right_Idx);
                            abs_diff = abs(diff);
                            if abs_diff <= tol
                                if Consecutive == OldConsec + 1 && OldConsec == OldConsec2 + 1
                                    if Counter == 0
                                        ConsecutiveRegion = ConsecutiveRegion + 1;
                                    end
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                elseif Consecutive == OldConsec && OldConsec == OldConsec2 + 1
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                else
                                    Counter = 0;
                                    Matches_Score = Matches_Score + ExperimentalPeakList(PeakListIndex,2);                     %Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                end % only update score
                                RightMatched_Index = [RightMatched_Index; right_Idx];
                                RightPeak_Index = [RightPeak_Index; PeakListIndex];
                                RightType = [RightType; {'Z'''}];
                                MatchCounter = MatchCounter + 1;
                            end
                        end
                        
                        %% zoo 5
                        if(numofZoo > 0)
                            diff = ExperimentalPeakList(PeakListIndex) - RightIons_zoo(right_Idx);
                            abs_diff = abs(diff);
                            if abs_diff <= tol
                                if Consecutive == OldConsec + 1 && OldConsec == OldConsec2 + 1
                                    if Counter == 0
                                        ConsecutiveRegion = ConsecutiveRegion + 1;
                                    end
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                elseif Consecutive == OldConsec && OldConsec == OldConsec2 + 1
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                else
                                    Counter = 0;
                                    Matches_Score = Matches_Score + ExperimentalPeakList(PeakListIndex,2);                     %Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                end % only update score
                                RightMatched_Index = [RightMatched_Index; right_Idx];
                                RightPeak_Index = [RightPeak_Index; PeakListIndex];
                                RightType = [RightType; {'Z'''''}];
                                MatchCounter = MatchCounter + 1;
                            end
                        end
                        
                        
                        %% y* 8
                        if(numofYstar > 0)
                            diff = ExperimentalPeakList(PeakListIndex) - RightIons_ystar(right_Idx);
                            abs_diff = abs(diff);
                            if abs_diff <= tol
                                if Consecutive == OldConsec + 1 && OldConsec == OldConsec2 + 1
                                    if Counter == 0
                                        ConsecutiveRegion = ConsecutiveRegion + 1;
                                    end
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                elseif Consecutive == OldConsec && OldConsec == OldConsec2 + 1
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                else
                                    Counter = 0;
                                    Matches_Score = Matches_Score + ExperimentalPeakList(PeakListIndex,2);                     %Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                end % only update score
                                RightMatched_Index = [RightMatched_Index; right_Idx];
                                RightPeak_Index = [RightPeak_Index; PeakListIndex];
                                RightType = [RightType; {'Y*'}];
                                MatchCounter = MatchCounter + 1;
                            end
                        end
                    end
                    if diff < -tol && right_Idx > 1
                        IdxR = right_Idx - 1;
                        break;
                    end
                    
                end
            end
        elseif strcmp(PepUnit,'ppm')
            for PeakListIndex = StartIndex:EndIndex     %Upadted 20210410
                tol = (IonssMW_threshold * ExperimentalPeakList(PeakListIndex)) / 1000000;
                Consecutive = PeakListIndex;
                %check in Left Ions
                for left_Idx = IdxL:numofLInsilicos
                    
                    % Left
                    diff = ExperimentalPeakList(PeakListIndex) - LeftIons(left_Idx);
                    abs_diff = abs(diff);
                    if abs_diff <= tol
                        if Consecutive == OldConsec + 1 && OldConsec == OldConsec2 + 1
                            if Counter == 0
                                ConsecutiveRegion = ConsecutiveRegion + 1;
                            end
                            Counter = Counter + 1;
                            Matches_Score = Matches_Score + 1.5;
                            OldConsec2 = OldConsec;
                            OldConsec = Consecutive;
                        elseif Consecutive == OldConsec && OldConsec == OldConsec2 + 1
                            Counter = Counter + 1;
                            Matches_Score = Matches_Score + 1.5;
                        else
                            Counter = 0;
                            Matches_Score = Matches_Score + ExperimentalPeakList(PeakListIndex,2);                     %Matches_Score = Matches_Score + 1.5;
                            OldConsec2 = OldConsec;
                            OldConsec = Consecutive;
                        end % only update score
                        LeftMatched_Index = [LeftMatched_Index; left_Idx];
                        LeftPeak_Index = [LeftPeak_Index; PeakListIndex];
                        LeftType = [LeftType; {'Left'} ];
                        MatchCounter = MatchCounter + 1;
                    end
                    
                    if specialLeft == 0
                    else
                        %% ao 1
                        if(numofAo > 0)
                            diff = ExperimentalPeakList(PeakListIndex) - LeftIons_ao(left_Idx);
                            abs_diff = abs(diff);
                            
                            if abs_diff <= tol
                                if Consecutive == OldConsec + 1 && OldConsec == OldConsec2 + 1
                                    if Counter == 0
                                        ConsecutiveRegion = ConsecutiveRegion + 1;
                                    end
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                elseif Consecutive == OldConsec && OldConsec == OldConsec2 + 1
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                else
                                    Counter = 0;
                                    Matches_Score = Matches_Score + ExperimentalPeakList(PeakListIndex,2);                     %Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                end % only update score
                                LeftMatched_Index = [LeftMatched_Index; left_Idx];
                                LeftPeak_Index = [LeftPeak_Index; PeakListIndex];
                                LeftType = [LeftType; {'A'''} ];
                                MatchCounter = MatchCounter + 1;
                            end
                        end
                        
                        %% bo 2
                        if(numofBo > 0)
                            diff = ExperimentalPeakList(PeakListIndex) - LeftIons_bo(left_Idx);
                            abs_diff = abs(diff);
                            if abs_diff <= tol
                                if Consecutive == OldConsec + 1 && OldConsec == OldConsec2 + 1
                                    if Counter == 0
                                        ConsecutiveRegion = ConsecutiveRegion + 1;
                                    end
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                elseif Consecutive == OldConsec && OldConsec == OldConsec2 + 1
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                else
                                    Counter = 0;
                                    Matches_Score = Matches_Score + ExperimentalPeakList(PeakListIndex,2);                     %Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                end % only update score
                                LeftMatched_Index = [LeftMatched_Index; left_Idx];
                                LeftPeak_Index = [LeftPeak_Index; PeakListIndex];
                                LeftType = [LeftType; {'B'''} ];
                                MatchCounter = MatchCounter + 1;
                            end
                        end
                        
                        %% a* 6
                        if(numofAstar > 0)
                            diff = ExperimentalPeakList(PeakListIndex) - LeftIons_astar(left_Idx);
                            abs_diff = abs(diff);
                            
                            if abs_diff <= tol
                                if Consecutive == OldConsec + 1 && OldConsec == OldConsec2 + 1
                                    if Counter == 0
                                        ConsecutiveRegion = ConsecutiveRegion + 1;
                                    end
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                elseif Consecutive == OldConsec && OldConsec == OldConsec2 + 1
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                else
                                    Counter = 0;
                                    Matches_Score = Matches_Score + ExperimentalPeakList(PeakListIndex,2);                     %Matches_Score = Matches_Score + 1.5;
                                    MatchCounter = MatchCounter + 1;
                                end % only update score
                                LeftMatched_Index = [LeftMatched_Index; left_Idx];
                                LeftPeak_Index = [LeftPeak_Index; PeakListIndex];
                                LeftType = [LeftType; {'A*'} ];
                                MatchCounter = MatchCounter + 1;
                            end
                        end
                        
                        %% b* 7
                        if(numofBstar > 0)
                            diff = ExperimentalPeakList(PeakListIndex) - LeftIons_bstar(left_Idx);
                            abs_diff = abs(diff);
                            if abs_diff <= tol
                                if Consecutive == OldConsec + 1 && OldConsec == OldConsec2 + 1
                                    if Counter == 0
                                        ConsecutiveRegion = ConsecutiveRegion + 1;
                                    end
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                elseif Consecutive == OldConsec && OldConsec == OldConsec2 + 1
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                else
                                    Counter = 0;
                                    Matches_Score = Matches_Score + ExperimentalPeakList(PeakListIndex,2);                     %Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                end % only update score
                                LeftMatched_Index = [LeftMatched_Index; left_Idx];
                                LeftPeak_Index = [LeftPeak_Index; PeakListIndex];
                                LeftType = [LeftType; {'B*'} ];
                                MatchCounter = MatchCounter + 1;
                            end
                        end
                    end
                    if diff < -tol && left_Idx > 1
                        IdxL = left_Idx - 1;
                        break;
                    end
                end
                
                %check in RIght Ions
                for right_Idx = IdxR:numofRInsilicos
                    % Right
                    diff = ExperimentalPeakList(PeakListIndex) - RightIons(right_Idx);
                    abs_diff = abs(diff);
                    if abs_diff <= tol
                        if Consecutive == OldConsec + 1 && OldConsec == OldConsec2 + 1
                            if Counter == 0
                                ConsecutiveRegion = ConsecutiveRegion + 1;
                            end
                            Counter = Counter + 1;
                            Matches_Score = Matches_Score + 1.5;
                            OldConsec2 = OldConsec;
                            OldConsec = Consecutive;
                        elseif Consecutive == OldConsec && OldConsec == OldConsec2 + 1
                            Counter = Counter + 1;
                            Matches_Score = Matches_Score + 1.5;
                        else
                            Counter = 0;
                            Matches_Score = Matches_Score + ExperimentalPeakList(PeakListIndex,2);                     %Matches_Score = Matches_Score + 1.5;
                            OldConsec2 = OldConsec;
                            OldConsec = Consecutive;
                        end % only update score
                        RightMatched_Index = [RightMatched_Index; right_Idx];
                        RightPeak_Index = [RightPeak_Index; PeakListIndex];
                        RightType = [RightType; {'Right'}];
                        MatchCounter = MatchCounter + 1;
                        
                    end
                    
                    if specialRight == 0
                    else
                        %% yo 3
                        if(numofYo > 0)
                            diff = ExperimentalPeakList(PeakListIndex) - RightIons_yo(right_Idx);
                            abs_diff = abs(diff);
                            if abs_diff <= tol
                                if Consecutive == OldConsec + 1 && OldConsec == OldConsec2 + 1
                                    if Counter == 0
                                        ConsecutiveRegion = ConsecutiveRegion + 1;
                                    end
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                elseif Consecutive == OldConsec && OldConsec == OldConsec2 + 1
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                else
                                    Counter = 0;
                                    Matches_Score = Matches_Score + ExperimentalPeakList(PeakListIndex,2);                     %Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                end % only update score
                                RightMatched_Index = [RightMatched_Index; right_Idx];
                                RightPeak_Index = [RightPeak_Index; PeakListIndex];
                                RightType = [RightType; {'Y'''}];
                                MatchCounter = MatchCounter + 1;
                            end
                        end
                        
                        %% zo 4
                        if(numofZo > 0)
                            diff = ExperimentalPeakList(PeakListIndex) - RightIons_zo(right_Idx);
                            abs_diff = abs(diff);
                            if abs_diff <= tol
                                if Consecutive == OldConsec + 1 && OldConsec == OldConsec2 + 1
                                    if Counter == 0
                                        ConsecutiveRegion = ConsecutiveRegion + 1;
                                    end
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                elseif Consecutive == OldConsec && OldConsec == OldConsec2 + 1
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                else
                                    Counter = 0;
                                    Matches_Score = Matches_Score + ExperimentalPeakList(PeakListIndex,2);                     %Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                end % only update score
                                RightMatched_Index = [RightMatched_Index; right_Idx];
                                RightPeak_Index = [RightPeak_Index; PeakListIndex];
                                RightType = [RightType; {'Z'''}];
                                MatchCounter = MatchCounter + 1;
                            end
                        end
                        
                        %% zoo 5
                        if(numofZoo > 0)
                            diff = ExperimentalPeakList(PeakListIndex) - RightIons_zoo(right_Idx);
                            abs_diff = abs(diff);
                            if abs_diff <= tol
                                if Consecutive == OldConsec + 1 && OldConsec == OldConsec2 + 1
                                    if Counter == 0
                                        ConsecutiveRegion = ConsecutiveRegion + 1;
                                    end
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                elseif Consecutive == OldConsec && OldConsec == OldConsec2 + 1
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                else
                                    Counter = 0;
                                    Matches_Score = Matches_Score + ExperimentalPeakList(PeakListIndex,2);                     %Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                end % only update score
                                RightMatched_Index = [RightMatched_Index; right_Idx];
                                RightPeak_Index = [RightPeak_Index; PeakListIndex];
                                RightType = [RightType; {'Z'''''}];
                                MatchCounter = MatchCounter + 1;
                            end
                        end
                        
                        
                        %% y* 8
                        if(numofYstar > 0)
                            diff = ExperimentalPeakList(PeakListIndex) - RightIons_ystar(right_Idx);
                            abs_diff = abs(diff);
                            if abs_diff <= tol
                                if Consecutive == OldConsec + 1 && OldConsec == OldConsec2 + 1
                                    if Counter == 0
                                        ConsecutiveRegion = ConsecutiveRegion + 1;
                                    end
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                elseif Consecutive == OldConsec && OldConsec == OldConsec2 + 1
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                else
                                    Counter = 0;
                                    Matches_Score = Matches_Score + ExperimentalPeakList(PeakListIndex,2);                     %Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                end % only update score
                                RightMatched_Index = [RightMatched_Index; right_Idx];
                                RightPeak_Index = [RightPeak_Index; PeakListIndex];
                                RightType = [RightType; {'Y*'}];
                                MatchCounter = MatchCounter + 1;
                            end
                        end
                    end
                    if diff < -tol && right_Idx > 1
                        IdxR = right_Idx - 1;
                        break;
                    end
                    
                end
            end
        else
            for PeakListIndex = StartIndex:EndIndex   %Upadted 20210410
                tol = (IonssMW_threshold * ExperimentalPeakList(PeakListIndex)) / 100;
                Consecutive = PeakListIndex;
                %check in Left Ions
                for left_Idx = IdxL:numofLInsilicos
                    
                    % Left
                    diff = ExperimentalPeakList(PeakListIndex) - LeftIons(left_Idx);
                    abs_diff = abs(diff);
                    if abs_diff <= tol
                        if Consecutive == OldConsec + 1 && OldConsec == OldConsec2 + 1
                            if Counter == 0
                                ConsecutiveRegion = ConsecutiveRegion + 1;
                            end
                            Counter = Counter + 1;
                            Matches_Score = Matches_Score + 1.5;
                            OldConsec2 = OldConsec;
                            OldConsec = Consecutive;
                        elseif Consecutive == OldConsec && OldConsec == OldConsec2 + 1
                            Counter = Counter + 1;
                            Matches_Score = Matches_Score + 1.5;
                        else
                            Counter = 0;
                            Matches_Score = Matches_Score + ExperimentalPeakList(PeakListIndex,2);                     %Matches_Score = Matches_Score + 1.5;
                            OldConsec2 = OldConsec;
                            OldConsec = Consecutive;
                        end % only update score
                        LeftMatched_Index = [LeftMatched_Index; left_Idx];
                        LeftPeak_Index = [LeftPeak_Index; PeakListIndex];
                        LeftType = [LeftType; {'Left'} ];
                        MatchCounter = MatchCounter + 1;
                    end
                    
                    if specialLeft == 0
                    else
                        %% ao 1
                        if(numofAo > 0)
                            diff = ExperimentalPeakList(PeakListIndex) - LeftIons_ao(left_Idx);
                            abs_diff = abs(diff);
                            
                            if abs_diff <= tol
                                if Consecutive == OldConsec + 1 && OldConsec == OldConsec2 + 1
                                    if Counter == 0
                                        ConsecutiveRegion = ConsecutiveRegion + 1;
                                    end
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                elseif Consecutive == OldConsec && OldConsec == OldConsec2 + 1
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                else
                                    Counter = 0;
                                    Matches_Score = Matches_Score + ExperimentalPeakList(PeakListIndex,2);                     %Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                end % only update score
                                LeftMatched_Index = [LeftMatched_Index; left_Idx];
                                LeftPeak_Index = [LeftPeak_Index; PeakListIndex];
                                LeftType = [LeftType; {'A'''} ];
                                MatchCounter = MatchCounter + 1;
                            end
                        end
                        
                        %% bo 2
                        if(numofBo > 0)
                            diff = ExperimentalPeakList(PeakListIndex) - LeftIons_bo(left_Idx);
                            abs_diff = abs(diff);
                            if abs_diff <= tol
                                if Consecutive == OldConsec + 1 && OldConsec == OldConsec2 + 1
                                    if Counter == 0
                                        ConsecutiveRegion = ConsecutiveRegion + 1;
                                    end
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                elseif Consecutive == OldConsec && OldConsec == OldConsec2 + 1
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                else
                                    Counter = 0;
                                    Matches_Score = Matches_Score + ExperimentalPeakList(PeakListIndex,2);                     %Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                end % only update score
                                LeftMatched_Index = [LeftMatched_Index; left_Idx];
                                LeftPeak_Index = [LeftPeak_Index; PeakListIndex];
                                LeftType = [LeftType; {'B'''} ];
                                MatchCounter = MatchCounter + 1;
                            end
                        end
                        
                        %% a* 6
                        if(numofAstar > 0)
                            diff = ExperimentalPeakList(PeakListIndex) - LeftIons_astar(left_Idx);
                            abs_diff = abs(diff);
                            
                            if abs_diff <= tol
                                if Consecutive == OldConsec + 1 && OldConsec == OldConsec2 + 1
                                    if Counter == 0
                                        ConsecutiveRegion = ConsecutiveRegion + 1;
                                    end
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                elseif Consecutive == OldConsec && OldConsec == OldConsec2 + 1
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                else
                                    Counter = 0;
                                    Matches_Score = Matches_Score + ExperimentalPeakList(PeakListIndex,2);                     %Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                end % only update score
                                LeftMatched_Index = [LeftMatched_Index; left_Idx];
                                LeftPeak_Index = [LeftPeak_Index; PeakListIndex];
                                LeftType = [LeftType; {'A*'} ];
                                MatchCounter = MatchCounter + 1;
                            end
                        end
                        
                        %% b* 7
                        if(numofBstar > 0)
                            diff = ExperimentalPeakList(PeakListIndex) - LeftIons_bstar(left_Idx);
                            abs_diff = abs(diff);
                            if abs_diff <= tol
                                if Consecutive == OldConsec + 1 && OldConsec == OldConsec2 + 1
                                    if Counter == 0
                                        ConsecutiveRegion = ConsecutiveRegion + 1;
                                    end
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                elseif Consecutive == OldConsec && OldConsec == OldConsec2 + 1
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                else
                                    Counter = 0;
                                    Matches_Score = Matches_Score + ExperimentalPeakList(PeakListIndex,2);                     %Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                end % only update score
                                LeftMatched_Index = [LeftMatched_Index; left_Idx];
                                LeftPeak_Index = [LeftPeak_Index; PeakListIndex];
                                LeftType = [LeftType; {'B*'} ];
                                MatchCounter = MatchCounter + 1;
                            end
                        end
                    end
                    if diff < -tol && left_Idx > 1
                        IdxL = left_Idx - 1;
                        break;
                    end
                end
                
                %check in RIght Ions
                for right_Idx = IdxR:numofRInsilicos
                    % Right
                    diff = ExperimentalPeakList(PeakListIndex) - RightIons(right_Idx);
                    abs_diff = abs(diff);
                    if abs_diff <= tol
                        if Consecutive == OldConsec + 1 && OldConsec == OldConsec2 + 1
                            if Counter == 0
                                ConsecutiveRegion = ConsecutiveRegion + 1;
                            end
                            Counter = Counter + 1;
                            Matches_Score = Matches_Score + 1.5;
                            OldConsec2 = OldConsec;
                            OldConsec = Consecutive;
                        elseif Consecutive == OldConsec && OldConsec == OldConsec2 + 1
                            Counter = Counter + 1;
                            Matches_Score = Matches_Score + 1.5;
                        else
                            Counter = 0;
                            Matches_Score = Matches_Score + ExperimentalPeakList(PeakListIndex,2);                     %Matches_Score = Matches_Score + 1.5;
                            OldConsec2 = OldConsec;
                            OldConsec = Consecutive;
                        end % only update score
                        RightMatched_Index = [RightMatched_Index; right_Idx];
                        RightPeak_Index = [RightPeak_Index; PeakListIndex];
                        RightType = [RightType; {'Right'}];
                        MatchCounter = MatchCounter + 1;
                    end
                    
                    if specialRight == 0
                    else
                        %% yo 3
                        if(numofYo > 0)
                            diff = ExperimentalPeakList(PeakListIndex) - RightIons_yo(right_Idx);
                            abs_diff = abs(diff);
                            if abs_diff <= tol
                                if Consecutive == OldConsec + 1 && OldConsec == OldConsec2 + 1
                                    if Counter == 0
                                        ConsecutiveRegion = ConsecutiveRegion + 1;
                                    end
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                elseif Consecutive == OldConsec && OldConsec == OldConsec2 + 1
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                else
                                    Counter = 0;
                                    Matches_Score = Matches_Score + ExperimentalPeakList(PeakListIndex,2);                     %Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                end % only update score
                                RightMatched_Index = [RightMatched_Index; right_Idx];
                                RightPeak_Index = [RightPeak_Index; PeakListIndex];
                                RightType = [RightType; {'Y'''}];
                                MatchCounter = MatchCounter + 1;
                            end
                        end
                        
                        %% zo 4
                        if(numofZo > 0)
                            diff = ExperimentalPeakList(PeakListIndex) - RightIons_zo(right_Idx);
                            abs_diff = abs(diff);
                            if abs_diff <= tol
                                if Consecutive == OldConsec + 1 && OldConsec == OldConsec2 + 1
                                    if Counter == 0
                                        ConsecutiveRegion = ConsecutiveRegion + 1;
                                    end
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                elseif Consecutive == OldConsec && OldConsec == OldConsec2 + 1
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                else
                                    Counter = 0;
                                    Matches_Score = Matches_Score + ExperimentalPeakList(PeakListIndex,2);                     %Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                end % only update score
                                RightMatched_Index = [RightMatched_Index; right_Idx];
                                RightPeak_Index = [RightPeak_Index; PeakListIndex];
                                RightType = [RightType; {'Z'''}];
                                MatchCounter = MatchCounter + 1;
                            end
                        end
                        
                        %% zoo 5
                        if(numofZoo > 0)
                            diff = ExperimentalPeakList(PeakListIndex) - RightIons_zoo(right_Idx);
                            abs_diff = abs(diff);
                            if abs_diff <= tol
                                if Consecutive == OldConsec + 1 && OldConsec == OldConsec2 + 1
                                    if Counter == 0
                                        ConsecutiveRegion = ConsecutiveRegion + 1;
                                    end
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                elseif Consecutive == OldConsec && OldConsec == OldConsec2 + 1
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                else
                                    Counter = 0;
                                    Matches_Score = Matches_Score + ExperimentalPeakList(PeakListIndex,2);                     %Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                end % only update scoreatched_Index; right_Idx];
                                RightMatched_Index = [RightMatched_Index; right_Idx];
                                RightPeak_Index = [RightPeak_Index; PeakListIndex];
                                RightType = [RightType; {'Z'''''}];
                                MatchCounter = MatchCounter + 1;
                            end
                        end
                        
                        
                        %% y* 8
                        if(numofYstar > 0)
                            diff = ExperimentalPeakList(PeakListIndex) - RightIons_ystar(right_Idx);
                            abs_diff = abs(diff);
                            if abs_diff <= tol
                                if Consecutive == OldConsec + 1 && OldConsec == OldConsec2 + 1
                                    if Counter == 0
                                        ConsecutiveRegion = ConsecutiveRegion + 1;
                                    end
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                elseif Consecutive == OldConsec && OldConsec == OldConsec2 + 1
                                    Counter = Counter + 1;
                                    Matches_Score = Matches_Score + 1.5;
                                else
                                    Counter = 0;
                                    Matches_Score = Matches_Score + ExperimentalPeakList(PeakListIndex,2);                     %Matches_Score = Matches_Score + 1.5;
                                    OldConsec2 = OldConsec;
                                    OldConsec = Consecutive;
                                end % only update score
                                RightMatched_Index = [RightMatched_Index; right_Idx];
                                RightPeak_Index = [RightPeak_Index; PeakListIndex];
                                RightType = [RightType; {'Y*'}];
                                MatchCounter = MatchCounter + 1;
                            end
                        end
                    end
                    if diff < -tol && right_Idx > 1
                        IdxR = right_Idx - 1;
                        break;
                    end
                    
                end
            end
        end
        
        Candidate_ProteinsList{ProteinListIndex,1}.LeftMatched_Index = LeftMatched_Index;
        Candidate_ProteinsList{ProteinListIndex,1}.RightMatched_Index = RightMatched_Index;
        
        Candidate_ProteinsList{ProteinListIndex,1}.LeftPeak_Index = LeftPeak_Index;
        Candidate_ProteinsList{ProteinListIndex,1}.RightPeak_Index = RightPeak_Index;
        
        Candidate_ProteinsList{ProteinListIndex,1}.LeftType = LeftType;
        Candidate_ProteinsList{ProteinListIndex,1}.RightType = RightType;
        
        Candidate_ProteinsList{ProteinListIndex,1}.Match = Matches_Score;
        temp_score1 = Candidate_ProteinsList{ProteinListIndex,1}.Match / peakCount;
        Candidate_ProteinsList{ProteinListIndex,1}.Match  = MatchCounter;
        Candidate_ProteinsList{ProteinListIndex,1}.Matches_Score = temp_score1;
        
        if (Candidate_ProteinsList{ProteinListIndex,1}.Match > 0)
            Idx = Idx + 1;
            Matches(Idx) = Candidate_ProteinsList(ProteinListIndex,1);
        end
    end
end
Matches = Matches(~cellfun('isempty', Matches));
end