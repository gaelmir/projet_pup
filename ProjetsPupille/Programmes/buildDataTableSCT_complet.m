function Ttotal = buildDataTableSCT(SubjectCode,DataPath)


% EYECOG
% Create a table with all requested information in colums, for each trial
% (in row) 

%------------INPUT-----------------
%SubjectCode = end of matfile name eg '1002'


% variable to include:
% subject
% conditions
% starting position  X
% starting position  Y
% ending position X
% ending position  Y
% amplitude  X
% amplitude  Y
% total amplitude 
% latency 
% duration 
% peak velocity 
% direction of saccades
% validity of saccades
% nb of blinks
% saccade accuracy



ExpeVersion={'SCTv','SCTf'};
ExpeType='SCT';
Ttotal=[];

%load and reshape mat file
for iExpe=1:length(ExpeVersion)
    load(fullfile(DataPath,sprintf('%s%s.mat',ExpeVersion{1,iExpe},SubjectCode)));
[Image,imagenames,posFix,posSaccStart,posSaccEnd,pvelSacc,blinkTime,AllTrialInfos,...
    timeSaccStart,amplitudeSacc,VariablesNames,SaccDir,validSaccStartTime,validSaccPos,...
    validSaccDur, validSaccAmpl,validNoBlink,nbBlinks,PPD_X,PPD_Y,pupCross,...
    pupTarget,sizePupilFixationCross,sizePupilImage,sizePupilBackground,...
    XFixationCross,XImage,XBackground] = ...
    reshapeStruct_LK(eyedata,'SCT');



%create column with Subject name and group
Subject=cellstr(repmat(SubjectCode,[length(posSaccStart),1]));
Group=cellstr(repmat(SubjectCode(1),[length(posSaccStart),1]));
Subject=array2table(Subject,'VariableNames',{'Subjects'});
Group=array2table(Group,'VariableNames',{'Group'});

    
    
%columns with names of condition
Variables=array2table(AllTrialInfos,'VariableNames',VariablesNames(1:end));
   

%extract data for the two first saccades 
 %set names of variables:
 %comment unnecessary lines
     

    % 1st saccade
    nonEmptyIdx = cellfun('size',posSaccStart,1)>0;
    nonEmptyFixIdx = cellfun('size',pupCross,1)>0 & cellfun('size',posSaccStart,1)>0;
    nonEmptyTargetIdx = cellfun('size',pupTarget,1)>0 & cellfun('size',posSaccStart,1)>0;
    [StartPosX1,StartPosY1,EndPosX1,EndPosY1,AmplitudeX1,AmplitudeY1,TotalAmpl1,Latency1,Duration1,PeakVel1,Valid,...
        NBlinks,PupCrossStart1,PupCrossEnd1,PupCrossAverage1,PupTargetStart1,PupTargetEnd1,PupTargetAverage1] = deal(nan(length(posSaccStart),1));
    SaccDir1=repmat({''},length(posSaccStart),1);

    % if there is a trialID message missing, set trials for which there is
    % no trial info to nan
    nonEmptyIdx(cell2mat(strfind(AllTrialInfos(:,1),'nan'))')=0;
  

    
    
    %1st saccade
    Valid(nonEmptyIdx,1)=cellfun(@(v)v(1,1),validSaccStartTime(nonEmptyIdx))';
    Valid(nonEmptyIdx,2)=cellfun(@(v)v(1,1),validSaccPos(nonEmptyIdx))';
    Valid(nonEmptyIdx,3)=cellfun(@(v)v(1,2),validSaccPos(nonEmptyIdx))';
    Valid(nonEmptyIdx,4)=cellfun(@(v)v(1,1),validNoBlink(nonEmptyIdx))';
    Valid(nonEmptyIdx,5)= cellfun(@(v)v(1,1),validSaccDur(nonEmptyIdx))';
    Valid(nonEmptyIdx,6)= cellfun(@(v)v(1,1),validSaccAmpl(nonEmptyIdx))';
    NBlinks(nonEmptyIdx) = cellfun(@(v)v(1,1),nbBlinks(nonEmptyIdx))';
    

    StartPosX1(nonEmptyIdx) = round(cellfun(@(v)v(1,1),posSaccStart(nonEmptyIdx)))';
    StartPosY1(nonEmptyIdx) = round(cellfun(@(v)v(1,2),posSaccStart(nonEmptyIdx)))';
    EndPosX1(nonEmptyIdx) = round(cellfun(@(v)v(1,1),posSaccEnd(nonEmptyIdx)))';
    EndPosY1(nonEmptyIdx) = round(cellfun(@(v)v(1,2),posSaccEnd(nonEmptyIdx)))';
    SaccDir1(nonEmptyIdx) = cellfun(@(v)v(1,1),SaccDir(nonEmptyIdx))';
    AmplitudeX1(nonEmptyIdx) = round(cellfun(@(v)v(1,1),amplitudeSacc(nonEmptyIdx)))';
    AmplitudeY1(nonEmptyIdx) = round(cellfun(@(v)v(1,2),amplitudeSacc(nonEmptyIdx)))';
    TotalAmpl1(nonEmptyIdx) = round(cellfun(@(v)v(1,3),amplitudeSacc(nonEmptyIdx)))';
    Latency1(nonEmptyIdx) = round(cellfun(@(v)v(1,1),timeSaccStart(nonEmptyIdx)))';
    Duration1(nonEmptyIdx) = round(cellfun(@(v)v(1,3),posSaccEnd(nonEmptyIdx)))';
    PeakVel1(nonEmptyIdx) = round(cellfun(@(v)v(1,1),pvelSacc(nonEmptyIdx)))';
    PupCrossStart1(nonEmptyFixIdx) = round(cellfun(@(v)v(1,1),pupCross(nonEmptyFixIdx)))';
    PupCrossEnd1(nonEmptyFixIdx) = round(cellfun(@(v)v(1,2),pupCross(nonEmptyFixIdx)))';
    PupCrossAverage1(nonEmptyFixIdx) = round(cellfun(@(v)v(1,3),pupCross(nonEmptyFixIdx)))';
    PupTargetStart1(nonEmptyTargetIdx) = round(cellfun(@(v)v(1,1),pupTarget(nonEmptyTargetIdx)))';
    PupTargetEnd1(nonEmptyTargetIdx) = round(cellfun(@(v)v(1,2),pupTarget(nonEmptyTargetIdx)))';
    PupTargetAverage1(nonEmptyTargetIdx) = round(cellfun(@(v)v(1,3),pupTarget(nonEmptyTargetIdx)))';

    
    Correct1 = strcmp(SaccDir1,Variables{:,3});
    Error1 = (Correct1==0) & (strcmp(SaccDir1,'')==0);
    
    Valid(:,7)=Latency1>50;
    Valid(:,8)=TotalAmpl1<683;
    Valid=(sum(Valid,2)==size(Valid,2));

    % 2nd saccade
    nonEmptyIdx = cellfun('size',posSaccStart,1)>1;
    nonEmptyFixIdx = cellfun('size',pupCross,1)>1 & cellfun('size',posSaccStart,1)>1;
    nonEmptyTargetIdx = cellfun('size',pupTarget,1)>1 & cellfun('size',posSaccStart,1)>1;

    [StartPosX2,StartPosY2,EndPosX2,EndPosY2,AmplitudeX2,AmplitudeY2,TotalAmpl2,Latency2,Duration2,PeakVel2...
        PupCrossStart2,PupCrossEnd2,PupCrossAverage2,PupTargetStart2,PupTargetEnd2,PupTargetAverage2] = deal(nan(length(posSaccStart),1));
    SaccDir2=repmat({''},length(posSaccStart),1);
    
    nonEmptyIdx(cell2mat(strfind(AllTrialInfos(:,1),'nan'))')=0;
    
    StartPosX2(nonEmptyIdx) = round(cellfun(@(v)v(2,1),posSaccStart(nonEmptyIdx)))';
    StartPosY2(nonEmptyIdx) = round(cellfun(@(v)v(2,2),posSaccStart(nonEmptyIdx)))';
    EndPosX2(nonEmptyIdx) = round(cellfun(@(v)v(2,1),posSaccEnd(nonEmptyIdx)))';
    EndPosY2(nonEmptyIdx)= round(cellfun(@(v)v(2,2),posSaccEnd(nonEmptyIdx)))';
    SaccDir2(nonEmptyIdx)= cellfun(@(v)v(2,1),SaccDir(nonEmptyIdx))';
    AmplitudeX2(nonEmptyIdx) = round(cellfun(@(v)v(2,1),amplitudeSacc(nonEmptyIdx)))';
    AmplitudeY2(nonEmptyIdx) = round(cellfun(@(v)v(2,2),amplitudeSacc(nonEmptyIdx)))';
    TotalAmpl2(nonEmptyIdx) = round(cellfun(@(v)v(2,3),amplitudeSacc(nonEmptyIdx)))';
    Latency2(nonEmptyIdx) = round(cellfun(@(v)v(2,1),timeSaccStart(nonEmptyIdx)))';
    Duration2(nonEmptyIdx) = round(cellfun(@(v)v(2,3),posSaccEnd(nonEmptyIdx)))';
    PeakVel2(nonEmptyIdx) = round(cellfun(@(v)v(2,1),pvelSacc(nonEmptyIdx)))';
    PupCrossStart2(nonEmptyFixIdx) = round(cellfun(@(v)v(2,1),pupCross(nonEmptyFixIdx)))';
    PupCrossEnd2(nonEmptyFixIdx) = round(cellfun(@(v)v(2,2),pupCross(nonEmptyFixIdx)))';
    PupCrossAverage2(nonEmptyFixIdx) = round(cellfun(@(v)v(2,3),pupCross(nonEmptyFixIdx)))';
    PupTargetStart2(nonEmptyTargetIdx) = round(cellfun(@(v)v(2,1),pupTarget(nonEmptyTargetIdx)))';
    PupTargetEnd2(nonEmptyTargetIdx) = round(cellfun(@(v)v(2,2),pupTarget(nonEmptyTargetIdx)))';
    PupTargetAverage2(nonEmptyTargetIdx) = round(cellfun(@(v)v(2,3),pupTarget(nonEmptyTargetIdx)))';

    sizePupilFixationCross=sizePupilFixationCross';
    sizePupilImage=sizePupilImage';
    sizePupilBackground=sizePupilBackground';
    XFixationCross = XFixationCross';
    XImage = XImage';
    XBackground = XBackground';
 
    DataTable=table(...
        Valid,...
        NBlinks,...
        StartPosX1,...
        StartPosY1,...
        EndPosX1,...
        EndPosY1,...
        SaccDir1,...
        AmplitudeX1,...
        AmplitudeY1,...
        TotalAmpl1,...
        Latency1,...
        Duration1,...
        PeakVel1,...
        Correct1,...
        Error1,...
        PupCrossStart1,...
        PupCrossEnd1,...
        PupCrossAverage1,...
        PupTargetStart1,...
        PupTargetEnd1,...
        PupTargetAverage1,...        %second saccade
        StartPosX2,...
        StartPosY2,...
        EndPosX2,...
        EndPosY2,...
        SaccDir2,...
        AmplitudeX2,...
        AmplitudeY2,...
        TotalAmpl2,...
        Latency2,...
        Duration2,...
        PeakVel2,...
        PupCrossStart2,...
        PupCrossEnd2,...
        PupCrossAverage2,...
        PupTargetStart2,...
        PupTargetEnd2,...
        PupTargetAverage2,...
        sizePupilFixationCross,...
        sizePupilImage,...
        sizePupilBackground,...
        XFixationCross,...
        XImage,...
        XBackground...
    );


%put everything into a bigger table:
T=[Subject,Group,Variables,DataTable];
Ttotal=[Ttotal;T];
%TTotal
end

end


