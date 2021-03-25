function Final_Ladder_raw = MultipleTags(Ladder_raw, User_max_TagLength_Threshold,User_Taglength_min_threshold,User_Hop_Threshold,User_tagError_threshold, HopInfo)
index =size(Ladder_raw,1)+1;
LoopRun  = true;
upperlimit = size(Ladder_raw,1);
StartIndex = 1;
EndIndex = size(Ladder_raw,1);

while LoopRun
    for HopPeakIndex = StartIndex: EndIndex
        TagLength =  size( Ladder_raw{HopPeakIndex,1},1);
        DoubleTagEndIndex = Ladder_raw{HopPeakIndex,1}{end,2};
        
        for SinglePstHomePeakIndex = 1:size(HopInfo,2)
            if (DoubleTagEndIndex == HopInfo{1, SinglePstHomePeakIndex}{1})
                if (User_max_TagLength_Threshold > TagLength)
                    Ladder_raw{index, 1} =  [Ladder_raw{HopPeakIndex,1}; HopInfo{1,SinglePstHomePeakIndex}];
                    index = index + 1;
                else
                    break;
                end 
            end
        end
    end
    StartIndex = EndIndex + 1;
    EndIndex = size(Ladder_raw,1);
    
    if (StartIndex > EndIndex)
        LoopRun = false;
    end
end
index = 1;
for iter = 1: size(Ladder_raw,1)
    if (User_Taglength_min_threshold <= size(Ladder_raw{iter,1},1))
        Final_Ladder_raw{index, 1}  = Ladder_raw{iter, 1};
        index = index + 1;
    end
    
end
end

