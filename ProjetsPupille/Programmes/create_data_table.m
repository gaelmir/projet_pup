function TableAll = create_data_table(ExpeType,DataPath,writeExcelfile)

% Analysis of eye movement data of multiple subjects
% 
% INPUTS: 
% ExpeType    'SCT' 'NAT' or 'SPAN'
% DataPath    path where edf files are stored
% 


%% 1. find mat files or create them if they don't exist
Convert = 0;
DataFiles = dir([DataPath filesep ExpeType '*.mat']);

if isempty(DataFiles)
    DataFiles = dir([DataPath filesep ExpeType '*.edf']);
    Convert = 1;
end

%% 2. convert edf to mat if needed and get subjects codes
for ifile = 1:length(DataFiles)
    if Convert
        Convert_edf2mat(DataPath,DataFiles(ifile).name);
    end
    Subjects{ifile}=DataFiles(ifile).name(end-5:end-4);
end

Subjects=unique(Subjects);

TableAll=[];
%% 3. build datatable

for iSubject = 1:length(Subjects)
    fprintf('\n building data table for Subject %s ... \n',Subjects{iSubject});
    SubjectCode=Subjects{1,iSubject};
    if strcmp(ExpeType,'SCT')
        TSubject = buildDataTableSCT(SubjectCode,DataPath);
    elseif strcmp(ExpeType,'SPAN')
            TSubject = buildDataTableSPAN(SubjectCode,DataPath);
    elseif strcmp(ExpeType,'NAT')
            TSubject = buildDataTableNAT(SubjectCode,DataPath);
    end
    fprintf('\n ... Done! \n'); 
    
    TableAll = [TableAll;TSubject];
end

%% 4. write table into excel file
if writeExcelfile
writetable(TableAll,sprintf('%sData_Allnew_%s.xlsx',[DataPath filesep],ExpeType));
end
end
