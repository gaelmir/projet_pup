function Flags = Configflags(ExpeType)
% Function to create variables containing the flags, data to remove etc
% which are specific to a given experiment and eyedata.mat file. This
% function is passed as an argument in the main "reshapeStruct" function
% ----Inputs----
% ExpeType: 'SCT', 'NatEx', or 'SPAN' according to the experiment
% ----Ouput----
% Flag:  structure containing the relevant flags to look for in the
% .mat structure

%% Flags definition
switch ExpeType
    case 'SCT'        
        Flags.TrialID = 'TRIALID';               %flag to get info on trial
        Flags.TargetStart = 'TARGET_DISPLAY';    %flag to get start of target
        Flags.TargetEnd = 'TARGET_END';          %flag to get end of target
        Flags.FixationStart = 'FIXATION_DISPLAY';%flag to get fixation start
        Flags.GapStart = 'GAP_DISPLAY';          %flag to get gap start
        Flags.ISIStart = 'ISI_DISPLAY';          %flag to get ISI start
        Flags.FixationEnd = Flags.GapStart;
        Flags.ISIEnd=Flags.FixationStart;
        Flags.VariableNames={'TRIALID','Target','Target_Location','Condition','LeftImage','RightImage'};
        Flags.KeepVariables=[2 4 8 10 13 16 ];%real: [2 4 8 10 13 16 21]
        Flags.ViewDist = 57;                     % viewing distance
        Flags.winWidth = 52.9;                   %screen width in cm
        Flags.winHeight = 29.7;                  %screen height in cm   
   
    case 'NAT'        
        Flags.TrialID = 'TRIALID';               %flag to get info on trial
        Flags.TargetStart = 'TARGET_DISPLAY';    %flag to get start of target
        Flags.TargetEnd = 'TARGET_END';          %flag to get end of target
        Flags.FixationStart = 'FIXATION_DISPLAY';%flag to get fixation start
        Flags.ISIStart = 'ISI_DISPLAY';          %flag to get ISI start
        Flags.FixationEnd = Flags.TargetStart;
        Flags.ISIEnd=Flags.FixationStart;
        Flags.VariableNames={'TRIALID','Image','Category'};
        Flags.KeepVariables=[2 4 6];
        Flags.ViewDist = 57;                     % viewing distance
        Flags.winWidth = 52.9;                   %screen width in cm
        Flags.winHeight = 29.7;                  %screen height in cm   
        
    case 'SPAN'        
        Flags.TrialID = 'TRIALID';               %flag to get info on trial
        Flags.TargetStart = 'TARGET_DISPLAY';    %flag to get start of target
        Flags.TargetEnd = 'TARGET_END';          %flag to get end of target
        Flags.FixationStart = 'FIXATION_DISPLAY';%flag to get fixation start
        Flags.GapStart = 'GAP_DISPLAY';          %flag to get gap start
        Flags.ISIStart = 'ISI_DISPLAY';          %flag to get ISI start
        Flags.FixationEnd = Flags.GapStart;
        Flags.ISIEnd=Flags.FixationStart;
        Flags.VariableNames={'TRIALID','Task','Target_Location','Correct','block'};
        Flags.KeepVariables=[2 4 6 8 ];
        Flags.ViewDist = 57;                     %viewing distance
        Flags.winWidth = 52.9;                   %screen width in cm
        Flags.winHeight = 29.7;                  %screen height in cm           
end
end