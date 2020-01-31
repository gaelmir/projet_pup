%Convert edf to mat
function Convert_edf2mat(DataPath,edffile)
% cd ('G:\GIPSA\EYECOG\Expes\Process_Data\edfmex_Nouveau\DATA');
% edfFiles=dir('*.edf');

    eyedata=edfmex(fullfile(DataPath,edffile),'LegacyStruct','False');
    %Eyedata = edfmex('nomedf','LegacyStruct','False')
    save(sprintf('%s.mat',fullfile(DataPath,edffile(1:end-4))),'eyedata');

end