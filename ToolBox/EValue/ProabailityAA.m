function probAminoAcid = ProabailityAA(Sequence)
%% Uniprot Probability
% probAA = [
%     0.0825938682640556;     %A
%     1.42515431570931e-06;   %B
%     0.0138024695314009;     %C
%     0.0546243697267540;     %D
%     0.0673751203780345;     %E
%     0.0386516702028496;     %F
%     0.0708001312382105;     %G
%     0.0227491382766926;     %H
%     0.0592831591804761;     %I
%     0;                      %J
%     0.0582039523239576;     %K
%     0.0965668762613616;     %L
%     0.0241605761071809;     %M
%     0.0406028714789237;     %N
%     1.45015702300245e-07;   %O
%     0.0472903906034946;     %P
%     0.0393235679559383;     %Q
%     0.0553650649292305;     %R
%     0.0661992680567452;     %S
%     0.0535236605419635;     %T
%     1.64517813988899e-06;   %U
%     0.0686698305692540;     %V
%     0.0109673375433092;     %W
%     3.98993202984019e-05;   %X
%     0.0292023070258048;     %Y
%     1.25513590611591e-06;   %Z
%     ];

%% Sequence Probs
probAA = getSequenceProb(Sequence);

probAminoAcid = 1;

for index_AA = 1:numel(Sequence)
    probAminoAcid = (probAminoAcid * probAA(double(Sequence(index_AA))-64));
end

probAminoAcid = probAminoAcid/numel(Sequence);

if probAminoAcid == 0
    probAminoAcid = 4.94065645841247E-324; % Obtained from MSPathFinder - Handle UnderFlow
end

end