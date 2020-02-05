function [Image,imagenames,posFix,posSaccStart,posSaccEnd,pvelSacc,blinkTime,AllTrialInfos,timeSaccStart,amplitudeSacc,VariablesNames,SaccDir,validSaccStartTime,validSaccPos,  validSaccDur, validSaccAmpl,validNoBlink,nbBlinks,PPD_X,PPD_Y,pupCross,pupTarget,sizePupilFixationCross,sizePupilImage,sizePupilBackground,XFixationCross,XImage,XBackground] = reshapeStruct_LK(structure,ExpeType)
%function  reshapeStruct_LK(structure,ExpeType)


%structure = eyedata;
% Reshape structure given by MatBuilder
% --- INPUT ---
% structure : EyetrackerAcq built by MatBuilder: data for one subject
% ExpeType: 'SCT', 'SPAN' or 'NatEx'
%
% --- OUTPUT ---
% Image : cell array of images presented to the subject
% imagenames : cell array of pictures name
% posFix : [Xpos,Ypos,duration]
% posSaccStart : start positon of saccades
% posSaccEnd : end positon of saccades
% blinkTime : the times of blinks
% sizePupil : the sizes of pupil in 3 different cas
%              [fixationcrossSIZE imageSIZE backgroundSIZE]

%run Config file to get flag names according to the type of experiment
Flags=Configflags(ExpeType);

%extract display resolution
displayCoord=strsplit(structure.MESSAGES.message{1,1});
screenSize(1)=str2num(displayCoord{1,4});
screenSize(2)=str2num(displayCoord{1,5});
screenCenter(1)=screenSize(1)/2;
screenCenter(2)=screenSize(2)/2;

%calculate pixels per degree in X and Z
PPD_X = ang2pix(Flags.ViewDist,Flags.winWidth+1,screenSize(1)+1,1);
PPD_Y = ang2pix(Flags.ViewDist,Flags.winHeight+1,screenSize(2)+1,1);


%% extract data from all events
% list of picture names of one subject
imagenames = {};
AllTrialInfos = {};
% start time and end time of all events
timeStartAll = (structure.FEVENT.sttime)';
timeEndAll = (structure.FEVENT.entime)';
% x y start position of all events
posStartAll(1,:) = (structure.FEVENT.gstx)';
posStartAll(2,:) = (structure.FEVENT.gsty)';
% x y end position of all events
posEndAll(1,:) = (structure.FEVENT.genx)';
posEndAll(2,:) = (structure.FEVENT.geny)';
% LK: peak velocity of all events
pvelAll=(structure.FEVENT.pvel)';
% LK: pupil size of all events
pupilSizeAll(1,:) = (structure.FEVENT.sta)';% pupil size start
pupilSizeAll(2,:) = (structure.FEVENT.ena)';% pupil size end
pupilSizeAll(3,:) = (structure.FEVENT.ava)';% average pupil size



%% Extract data corresponding to specific events (eg TRIAL ID, Target display) based on the message structure
TrialID = strncmp(structure.MESSAGES.message,Flags.TrialID,length(Flags.TrialID));
% find the target start and end from the message struct
idxtargetStart = strncmp(structure.MESSAGES.message,Flags.TargetStart,length(Flags.TargetStart));
idxtargetEnd = strncmp(structure.MESSAGES.message,Flags.TargetEnd,length(Flags.TargetEnd));
idxfixStart = strncmp(structure.MESSAGES.message,Flags.FixationStart,length(Flags.FixationStart));
idxfixEnd = strncmp(structure.MESSAGES.message,Flags.FixationEnd,length(Flags.FixationEnd));

for i = 1:size(idxtargetStart,1)
    if TrialID(i)
        % extract the image name or info about the trial
        TrialInfo = strsplit(structure.MESSAGES.message{i,1});
        if strcmp(ExpeType,'SPAN')
            TrialInfo = TrialInfo([Flags.KeepVariables length(TrialInfo)]);
        else
         TrialInfo = TrialInfo(Flags.KeepVariables);
        end
         VariablesNames = Flags.VariableNames;
         AllTrialInfos=cat(1,AllTrialInfos,TrialInfo);
    end
end

%delete ";" or "," from conditions names
AllTrialInfos=regexprep(AllTrialInfos,';','');
AllTrialInfos=regexprep(AllTrialInfos,',','');
if strcmp(ExpeType,'NAT')
    AllTrialInfos=regexprep(AllTrialInfos,'/60','');
else
    AllTrialInfos=regexprep(AllTrialInfos,'/',' of ');
end

%% find indices of specific types of events
% index of fixation
idxFixAll = strcmp(structure.FEVENT.codestring,'ENDFIX');
% index of saccade
idxSaccAll = strcmp(structure.FEVENT.codestring,'ENDSACC');
% index of blink
idxBlinkAll = strcmp(structure.FEVENT.codestring,'ENDBLINK');

% timeImage : the start and end times of images/target appearance
timeImage(1,:) = structure.MESSAGES.time(idxtargetStart);
timeImage(2,:) = structure.MESSAGES.time(idxtargetEnd);
% timeCoross : the start and end times of fixation cross appearance
timeCross(1,:)= structure.MESSAGES.time(idxfixStart);
timeCross(2,:)= structure.MESSAGES.time(idxfixEnd);

% index of the fixation cross
idxFixationCrossStart = strncmp(structure.MESSAGES.message,Flags.FixationStart,length(Flags.FixationStart));

idxFixationCrossEnd = strncmp(structure.MESSAGES.message,Flags.FixationEnd,length(Flags.FixationEnd));
% index of the background(gray)
idxBackgroundStart = strncmp(structure.MESSAGES.message,Flags.ISIStart,length(Flags.ISIStart));
idxBackgroundEnd = strncmp(structure.MESSAGES.message,Flags.ISIEnd,length(Flags.ISIEnd));

% starting and ending time of the fixation cross
timeFixationCross(1,:) = structure.MESSAGES.time(idxFixationCrossStart);
timeFixationCross(2,:) = structure.MESSAGES.time(idxFixationCrossEnd);
% starting and ending time of the background/ISI
timeBackground(1,:) = structure.MESSAGES.time(idxBackgroundStart);
timeBackground(2,:) = structure.MESSAGES.time(idxBackgroundEnd);



% all fixation times
timeFixAll(1,:) = timeStartAll(idxFixAll');
timeFixAll(2,:) = timeEndAll(idxFixAll');

% all fixation positions
posFixAll(1,:) = posStartAll(1,idxFixAll');
posFixAll(2,:) = posStartAll(2,idxFixAll');

% all saccades starting and ending times
timeSaccStartAll = timeStartAll(idxSaccAll');
timeSaccEndAll = timeEndAll(idxSaccAll');

% all saccades starting positions
posSaccStartAll(1,:) = posStartAll(1,idxSaccAll');
posSaccStartAll(2,:) = posStartAll(2,idxSaccAll');

% all saccades ending positions
posSaccEndAll(1,:) = posEndAll(1,idxSaccAll');
posSaccEndAll(2,:) = posEndAll(2,idxSaccAll');

%LK; all saccades peak velocity
pvelSaccAll(1,:)=pvelAll(1,idxSaccAll');

%LK: All pupil sizes (fEVENT)
pupilSizeFixAll(1,:) = pupilSizeAll(1,idxFixAll');
pupilSizeFixAll(2,:) = pupilSizeAll(2,idxFixAll');
pupilSizeFixAll(3,:) = pupilSizeAll(3,idxFixAll');


% all blink times
blinkTimeStart = timeStartAll(idxBlinkAll)';
blinkTimeEnd = timeEndAll(idxBlinkAll)';
blinkTime(1,:) = blinkTimeStart;
blinkTime(2,:) = blinkTimeEnd;

% Number of images/target displays
sz = size(timeImage,2);


%% deletion of saccade events where a blink occured
[timeSaccStartAll,timeSaccEndAll,posSaccStartAll,...
    posSaccEndAll,pvelSaccAll] = saccBlinkDelete(blinkTimeStart,...
    blinkTimeEnd,timeSaccStartAll,timeSaccEndAll,posSaccStartAll,...
    posSaccEndAll,pvelSaccAll);

%% extraction of events corresponding to target/image display and for good trials
for i = 1:sz
    %     % RGB Image
    Image={};
    
    %LK: Fixation index of fixation cross
    idxFixCross{i}(:,1) = find((timeFixAll(1,:) > timeFixationCross(1,i))&...
        (timeFixAll(1,:) < timeFixationCross(2,i)));
    
    if isempty(idxFixCross{i}(:,1))
        pupCross{i} = [];
    else
        % Position of fixation (full screen)
        pupCross{i} = pupilSizeFixAll(:,idxFixCross{i})';
        % Position of fixations (image)(origin is the top corner of images)
        %        posFix{i} = posFix{i}-repmat(corner,size(posFix{i},1),1);
        % Duration of fixation
    end
    
    % Fixation index of current image/target
    idxFix{i}(:,1) = find((timeFixAll(1,:) > timeImage(1,i))&...
        (timeFixAll(1,:) < timeImage(2,i)));
    if isempty(idxFix{i}(:,1))
        posFix{i} = [];
        pupTarget{i} = [];
    else
        % Position of fixation (full screen)
        posFix{i} = posFixAll(:,idxFix{i})';
        pupTarget{i} = pupilSizeFixAll(:,idxFix{i})';
        % Position of fixations (image)(origin is the top corner of images)
        %        posFix{i} = posFix{i}-repmat(corner,size(posFix{i},1),1);
        % Duration of fixation
        posFix{i}(:,3) = timeFixAll(2,idxFix{i}) - ...
            timeFixAll(1,idxFix{i});
    end
    
    % Saccade index of curent image/target
    idxSacc{i}(:,1) = find((timeSaccStartAll > timeImage(1,i))&...
        (timeSaccStartAll < timeImage(2,i)));
    if isempty(idxSacc{i}(:,1)) 
        posSaccStart{i} = [];
        posSaccEnd{i} = [];
        timeSaccStart{i} = [];
        amplitudeSacc{i}= [];
        pvelSacc{i} = [];
        validSaccStartTime{i} = [];     
        validSaccPos{i} = [];
        validSaccDur{i}=[];
        validSaccAmpl{i}=[];
        validNoBlink{i} = [];
        nbBlinks{i}= [];
        SaccDir{i}=[];
    else
        % start position of saccade (full screen)
        posSaccStart{i} = posSaccStartAll(:,idxSacc{i})';
        % start position of saccade (image)
        %        posSaccStart{i} = posSaccStart{i}-repmat(corner,size(posSaccStart{i},1),1);
        
        % end positon of saccade
        posSaccEnd{i} = posSaccEndAll(:,idxSacc{i})';
        % end position of saccade (image)
        %        posSaccEnd{i} = posSaccEnd{i}-repmat(corner,size(posSaccEnd{i},1),1);
        
        % Duration of saccade
        posSaccStart{i}(:,3) = timeSaccEndAll(1,idxSacc{i}) - ...
            timeSaccStartAll(1,idxSacc{i});
        
       % Duration of saccade
        posSaccEnd{i}(:,3) = timeSaccEndAll(1,idxSacc{i}) - ...
            timeSaccStartAll(1,idxSacc{i});
        
        %LK: start time of saccades (latency) relative to target appearance
        timeSaccStart{i}(:,1)=timeSaccStartAll(1,idxSacc{i})-timeImage(1,i);
        
        %LK: amplitude of saccades
        amplitudeSacc{i}(:,1) = abs(posSaccEnd{i}(:,1)-posSaccStart{i}(:,1));%amplitude X
        amplitudeSacc{i}(:,2) = abs(posSaccEnd{i}(:,2)-posSaccStart{i}(:,2));% amplitude Y
        
        if ~isempty(amplitudeSacc{i})
            amplitudeSacc{i}(:,3) = sqrt(amplitudeSacc{i}(:,1).^2+amplitudeSacc{i}(:,2).^2);% total amplitude
        end
        
        %LK: peak velocity of saccades
        pvelSacc{i}(:,1)= pvelSaccAll(1,idxSacc{i});
        
        
        %LK: direction of saccade
        for nsacc=1:size(posSaccStart{i},1)
            
            if (posSaccEnd{i}(nsacc,1) > posSaccStart{i}(nsacc,1))
                SaccDir{i}{nsacc,1}='right';
            elseif (posSaccEnd{i}(nsacc,1) < posSaccStart{i}(nsacc,1))
                SaccDir{i}{nsacc,1}='left';
            else
                SaccDir{i}{nsacc,1}='';
            end         

        end
       
      %LK: coding of saccades validity
        
      %1st saccade started after stimulus onset
        validSaccStartTime{i} = timeSaccStart{i}(1,1) > 1;
        
        %1st staccade started within 1degrees of the fixation point        
        validSaccPos{i}(1,1) = posSaccStart{i}(1,1)<= screenCenter(1)+...
            2*PPD_X && posSaccStart{i}(1,1)>= screenCenter(1)-2*PPD_X;
        validSaccPos{i}(1,2) = posSaccStart{i}(1,2)<= screenCenter(2)+...
            2*PPD_Y && posSaccStart{i}(1,2)>= screenCenter(2)-2*PPD_Y;

        %1st staccade has a duration < 100 ms        
        validSaccDur{i}= posSaccStart{i}(:,3) < 100;
        
         %1st staccade has a total amplitude > 1degree    
        validSaccAmpl{i}=amplitudeSacc{i}(:,3)>1*PPD_X;
        
        %no blink during stimulus presentation
        
        for iBlink=1:length(blinkTime)
            if blinkTime(1,iBlink)>timeImage(1,i) && blinkTime(1,iBlink)<timeImage(2,i)
                validNoBlink{i} = 0;
            elseif blinkTime(2,iBlink)<timeImage(2,i) && blinkTime(2,iBlink)>timeImage(1,i)
                 validNoBlink{i} = 0;
            else
                validNoBlink{i} = 1;                             
            end           
        end
        
        %number of blinks during the trial (between onset of fixation point to
        %offset of target)
        nbBlinks{i}=numel(find((blinkTime(1,:)>timeCross(1,i)) & (blinkTime(1,:)<timeImage(2,i))));
       
        
             
        
    end
    
end

% check in case there is a trialID message missing, then set corresponding Variables to 'nan'
    if length(AllTrialInfos)<length(posSaccStart)
        GoodTrials = str2double(AllTrialInfos(:,1));
        MissingTrials = ones(length(posSaccStart),1);
        MissingTrials(GoodTrials) = 0;
        TrialtoInsert = find(MissingTrials);
        InsertValue = repmat({'nan'},1,(size(AllTrialInfos,2)));
        AllTrialInfos = [AllTrialInfos(1:TrialtoInsert-1,:);  InsertValue; AllTrialInfos(TrialtoInsert:end,:)];
    end


%% get pupil info
sizePupilFixationCross = [];
sizePupilImage = [];
sizePupilBackground = [];
timeFixationCrossSample = [];
timeBackgroundSample = [];
timeImageSample = [];
XFixationCross = [];
XImage = [];
XBackground = [];


% all the sample time
timeSampleAll = structure.FSAMPLE.time;
% find the right eye or left
if structure.FSAMPLE.pa(1,1) > 0
    % the first colone is positive, the left eye was detected
    sizePupilAll = structure.FSAMPLE.pa(:,1);
else
    % the second colone is positive, the right eye was detected
    sizePupilAll = structure.FSAMPLE.pa(:,2);
end

if structure.FSAMPLE.gx(1,1) > 0
    % the first colone is positive, the left eye was detected
    abscisse_x = structure.FSAMPLE.gx(:,1);
else
    % the second colone is positive, the right eye was detected
    abscisse_x = structure.FSAMPLE.gx(:,2);
end

if structure.FSAMPLE.gy(1,1) > 0
    % the first colone is positive, the left eye was detected
    ordonne_y = structure.FSAMPLE.gy(:,1);
else
    % the second colone is positive, the right eye was detected
    ordonne_y = structure.FSAMPLE.gy(:,2);
end

% index of the fixation cross
idxFixationCrossStart = strncmp(structure.MESSAGES.message,Flags.FixationStart,length(Flags.FixationStart));

idxFixationCrossEnd = strncmp(structure.MESSAGES.message,Flags.FixationEnd,length(Flags.FixationEnd));
% index of the background(gray)
idxBackgroundStart = strncmp(structure.MESSAGES.message,Flags.ISIStart,length(Flags.ISIStart));
idxBackgroundEnd = strncmp(structure.MESSAGES.message,Flags.ISIEnd,length(Flags.ISIEnd));

% starting and ending time of the fixation cross
timeFixationCross(1,:) = structure.MESSAGES.time(idxFixationCrossStart);
timeFixationCross(2,:) = structure.MESSAGES.time(idxFixationCrossEnd);
% starting and ending time of the background/ISI
timeBackground(1,:) = structure.MESSAGES.time(idxBackgroundStart);
timeBackground(2,:) = structure.MESSAGES.time(idxBackgroundEnd);

for i= 1: size(timeFixationCross,2)
    % index of fixation cross (sample time)
    idxFixationCross{i} = find((timeSampleAll > timeFixationCross(1,i))&...
        (timeSampleAll < timeFixationCross(2,i)));
    % index of fixation cross (sample time)
    idxBackground{i} = find((timeSampleAll > timeBackground(1,i))&...
        (timeSampleAll < timeBackground(2,i)));
    % index of fixation cross (sample time)
    idxImage{i} = find((timeSampleAll > timeImage(1,i))&...
        (timeSampleAll < timeImage(2,i)));
    
    % size of pupil in the different sample time during the fixation cross
    vecteurFixationCross = sizePupilAll(idxFixationCross{i});
    sizePupilFixationCross = [sizePupilFixationCross,{vecteurFixationCross}];
    %sizePupilFixationCross = cat(1,sizePupilFixationCross,sizePupilAll(idxFixationCross{i}));
    % size of pupil in the different sample time during the image
    vecteurImage = sizePupilAll(idxImage{i});
    sizePupilImage = [sizePupilImage,{vecteurImage}];
    %sizePupilImage = cat(1,sizePupilImage,sizePupilAll(idxImage{i}));
    % size of pupil in the different sample time during the background
    vecteurBackground = sizePupilAll(idxBackground{i});
    sizePupilBackground = [sizePupilBackground,{vecteurBackground}];
    %sizePupilBackground = cat(1,sizePupilBackground,sizePupilAll(idxBackground{i}));
    
    vecteurBackground = abscisse_x(idxBackground{i});
    vecteurImage = abscisse_x(idxImage{i});
    vecteurFixationCross = abscisse_x(idxFixationCross{i});
    
    XFixationCross = [XFixationCross,{vecteurFixationCross}];
    XImage = [XImage,{vecteurImage}];
    XBackground = [XBackground,{vecteurBackground}];
    
end
% timePupil = {timeFixationCrossSample timeImageSample timeBackgroundSample};
sizePupil = {sizePupilFixationCross sizePupilImage sizePupilBackground};




