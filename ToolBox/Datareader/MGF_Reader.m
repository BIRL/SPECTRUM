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

function Files = MGF_Reader(directory, fileName) %#ok<STOUT>
progressbar_heading = getappdata(0, 'progressbar_heading');
if progressbar_heading == 1
    progressbar('Please wait while mgf file is processing...');
elseif progressbar_heading == 2
    progressbar('Please wait while mzXML file is processing...');
elseif progressbar_heading == 3
    progressbar('Please wait while mzML file is processing...');
end

scanReadComplete = 0; % For progressbar
countofScansTotal = 6000; % progressbar for 6000 scans

f = filesep;
inputfile = fopen(strcat(directory, f, fileName));
FileNameIndex = 0;
while ~feof(inputfile)
    data=fgetl(inputfile);
    if(length(data)>2)
        FileNameIndex=FileNameIndex+1;
        if(data == -1)
            break
        end
        
        data1='BEGIN IONS';

        
        while(~(strcmp(data,data1)))
            data=fgetl(inputfile);
        end
        
        dlmwrite(strcat(directory,f, fileName(1:numel(fileName)-4),'_',num2str(FileNameIndex),'.txt'),'','delimiter','');
        data3='PEPMASS=';
        while(isempty(findstr(data,data3))) %#ok<FSTR>
            data=fgetl(inputfile);
        end
        data1=data(9:end);
        data1 = strcat(data1,{' '},'1');
        str = data;
        str(str==' ') = '';
        str(str=='.') = '';
%         A = isstrprop(str, 'digit');
%         check = all(A(:));
        
        MS1 = strsplit(data1{1,1});
        MS1 = str2double(MS1);
        dlmwrite(strcat(directory,f, fileName(1:numel(fileName)-4),'_',num2str(FileNameIndex),'.txt'),MS1,'delimiter','\t','newline', 'pc','precision',16);  %Updated 20200108
        data1='END IONS';
        while(~strcmp(data,data1))
            ContainEqual = strfind(data, '=');
            if isempty(ContainEqual)
                MS2 = strsplit(data);
                MS2 = str2double(MS2);
                dlmwrite(strcat(directory,f, fileName(1:numel(fileName)-4),'_',num2str(FileNameIndex),'.txt'),MS2,'-append','delimiter','\t','newline', 'pc','precision','%.13f');  %Updated 20200108
                data=fgetl(inputfile);
            else
                data=fgetl(inputfile);
            end
        end
    end
    scanReadComplete = scanReadComplete + 1; % For progressbar
    if rem(scanReadComplete , 100) == 0
        progressbar(scanReadComplete/countofScansTotal);
    end
end