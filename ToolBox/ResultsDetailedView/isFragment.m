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

function Res = isFragment(Index, Match, IonssMW_threshold)
ExperimentalPeakList = getappdata(0,'Peaklist_Data');
for PeakListIndex = 1:numel(ExperimentalPeakList)
   % Left
    diff = abs(ExperimentalPeakList(PeakListIndex) - Match.LeftIons(Index));
    if strcmp(PepUnit,'Da')|| strcmp(PepUnit,'mmu')
        if diff <= IonssMW_threshold
            %Res.
            Match.Matches_Score = Match.Matches_Score + 1; % only update score
        end
    else
        if strcmp(PepUnit,'ppm')
            ppm = (diff/ExperimentalPeakList(PeakListIndex))*1000000;
            if (ppm <= IonssMW_threshold)
               Match.Matches_Score = Match.Matches_Score + 1;
            end
        else
            percent = (diff/ExperimentalPeakList(PeakListIndex))*100;
            if (percent <= IonssMW_threshold)
               Match.Matches_Score = Match.Matches_Score + 1;
            end
        end
    end
    
    % Right
    diff = abs(ExperimentalPeakList(PeakListIndex) - Match.RightIons(Index));
    if strcmp(PepUnit,'Da')|| strcmp(PepUnit,'mmu')
        if diff <= IonssMW_threshold
            Match.Matches_Score = Match.Matches_Score + 1; % only update score
        end
    else
        if strcmp(PepUnit,'ppm')
            ppm = (diff/ExperimentalPeakList(PeakListIndex))*1000000;
            if (ppm <= IonssMW_threshold)
                Match.Matches_Score = Match.Matches_Score + 1;
                P = [P; ppm];
                D = [D; diff];
            end
        else
            percent = (diff/ExperimentalPeakList(PeakListIndex))*100;
            if (percent <= IonssMW_threshold)
                Match.Matches_Score = Match.Matches_Score + 1;
            end
        end
    end
    
    %% ao 1
    if(numel(Match.LeftIons_ao)>0)
        diff = abs(ExperimentalPeakList(PeakListIndex) - Match.LeftIons_ao(Index));
        if strcmp(PepUnit,'Da')|| strcmp(PepUnit,'mmu')
            if diff <= IonssMW_threshold
                Match.Matches_Score = Match.Matches_Score + 1;
            end
        else
            if strcmp(PepUnit,'ppm')
                ppm = (diff/ExperimentalPeakList(PeakListIndex))*1000000;
                if (ppm <= IonssMW_threshold)
                    Match.Matches_Score = Match.Matches_Score + 1;
                end
            else
                percent = (diff/ExperimentalPeakList(PeakListIndex))*100;
                if (percent <= IonssMW_threshold)
                    Match.Matches_Score = Match.Matches_Score + 1;
                end
            end
        end
    end
    
    %% bo 2
    if(numel(Match.LeftIons_bo)>0)
        diff = abs(ExperimentalPeakList(PeakListIndex) - Match.LeftIons_bo(Index));
        if strcmp(PepUnit,'Da')|| strcmp(PepUnit,'mmu')
            if diff <= IonssMW_threshold
                Match.Matches_Score = Match.Matches_Score + 1;
                
            end
        else
            if strcmp(PepUnit,'ppm')
                ppm = (diff/ExperimentalPeakList(PeakListIndex))*1000000;
                if (ppm <= IonssMW_threshold)
                    Match.Matches_Score = Match.Matches_Score + 1;
                end
            else
                percent = (diff/ExperimentalPeakList(PeakListIndex))*100;
                if (percent <= IonssMW_threshold)
                    Match.Matches_Score = Match.Matches_Score + 1;
                end
            end
        end
    end
    
    %% yo 3
    if(numel(Match.RightIons_yo)>0)
        diff = abs(ExperimentalPeakList(PeakListIndex) - Match.RightIons_yo(Index));
        if strcmp(PepUnit,'Da')|| strcmp(PepUnit,'mmu')
            if diff <= IonssMW_threshold
                Match.Matches_Score = Match.Matches_Score + 1;
                
            end
        else
            if strcmp(PepUnit,'ppm')
                ppm = (diff/ExperimentalPeakList(PeakListIndex))*1000000;
                if (ppm <= IonssMW_threshold)
                    Match.Matches_Score = Match.Matches_Score + 1;
                end
            else
                percent = (diff/ExperimentalPeakList(PeakListIndex))*100;
                if (percent <= IonssMW_threshold)
                    Match.Matches_Score = Match.Matches_Score + 1;
                end
            end
        end
    end
    
    %% zo 4
    if(numel(Match.RightIons_zo)>0)
        abs(ExperimentalPeakList(PeakListIndex) - Match.RightIons_zo(Index));
        if strcmp(PepUnit,'Da')|| strcmp(PepUnit,'mmu')
            if diff <= IonssMW_threshold
                Match.Matches_Score = Match.Matches_Score + 1;
                
            end
        else
            if strcmp(PepUnit,'ppm')
                ppm = (diff/ExperimentalPeakList(PeakListIndex))*1000000;
                if (ppm <= IonssMW_threshold)
                    Match.Matches_Score = Match.Matches_Score + 1;
                end
            else
                percent = (diff/ExperimentalPeakList(PeakListIndex))*100;
                if (percent <= IonssMW_threshold)
                    Match.Matches_Score = Match.Matches_Score + 1;
                end
            end
        end
    end
     %% zoo 5
            if(numel(Match.RightIons_zoo)>0)
                diff = abs(ExperimentalPeakList(PeakListIndex) - Match.RightIons_zoo(Index));
                if strcmp(PepUnit,'Da')|| strcmp(PepUnit,'mmu')
                    if diff <= IonssMW_threshold
                        Match.Matches_Score = Match.Matches_Score + 1;
                        
                    end
                else
                    if strcmp(PepUnit,'ppm')
                        ppm = (diff/ExperimentalPeakList(PeakListIndex))*1000000;
                        if (ppm <= IonssMW_threshold)
                            Match.Matches_Score = Match.Matches_Score + 1;
                        end
                    else
                       percent = (diff/ExperimentalPeakList(PeakListIndex))*100;
                        if (percent <= IonssMW_threshold)
                            Match.Matches_Score = Match.Matches_Score + 1;
                        end
                    end
                end
            end
            
            %% a* 6
            if(numel(Match.LeftIons_astar)>0)
                diff = abs(ExperimentalPeakList(PeakListIndex) - Match.LeftIons_astar(Index));
                if strcmp(PepUnit,'Da')|| strcmp(PepUnit,'mmu')
                    if diff <= IonssMW_threshold
                        Match.Matches_Score = Match.Matches_Score + 1;
                        
                    end
                else
                    if strcmp(PepUnit,'ppm')
                        ppm = (diff/ExperimentalPeakList(PeakListIndex))*1000000;
                        if (ppm <= IonssMW_threshold)
                            Match.Matches_Score = Match.Matches_Score + 1;
                        end
                    else
                       percent = (diff/ExperimentalPeakList(PeakListIndex))*100;
                        if (percent <= IonssMW_threshold)
                            Match.Matches_Score = Match.Matches_Score + 1;
                        end
                    end
                end
            end
            
            %% b* 7
            if(numel(Match.LeftIons_bstar)>0)
                diff = abs(ExperimentalPeakList(PeakListIndex) - Match.LeftIons_bstar(Index));
                if strcmp(PepUnit,'Da')|| strcmp(PepUnit,'mmu')
                    if diff <= IonssMW_threshold
                        Match.Matches_Score = Match.Matches_Score + 1;
                        
                    end
                else
                    if strcmp(PepUnit,'ppm')
                        ppm = (diff/ExperimentalPeakList(PeakListIndex))*1000000;
                        if (ppm <= IonssMW_threshold)
                            Match.Matches_Score = Match.Matches_Score + 1;
                        end
                    else
                       percent = (diff/ExperimentalPeakList(PeakListIndex))*100;
                        if (percent <= IonssMW_threshold)
                            Match.Matches_Score = Match.Matches_Score + 1;
                        end
                    end
                end
            end
            
            %% y* 8
            if(numel(Match.RightIons_ystar)>0)
                diff = abs(ExperimentalPeakList(PeakListIndex) - Match.RightIons_ystar(Index));
                if strcmp(PepUnit,'Da')|| strcmp(PepUnit,'mmu')
                    if diff <= IonssMW_threshold
                        Match.Matches_Score = Match.Matches_Score + 1; % only update score
                    end
                else
                    if strcmp(PepUnit,'ppm')
                        ppm = (diff/ExperimentalPeakList(PeakListIndex))*1000000;
                        if (ppm <= IonssMW_threshold)
                            Match.Matches_Score = Match.Matches_Score + 1;
                        end
                    else
                        percent = (diff/ExperimentalPeakList(PeakListIndex))*100;
                        if (percent <= IonssMW_threshold)
                            Match.Matches_Score = Match.Matches_Score + 1;
                        end
                    end
                end
            end
end
end