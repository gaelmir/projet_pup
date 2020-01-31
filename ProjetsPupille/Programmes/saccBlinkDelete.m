function [timeSaccStartAll,timeSaccEndAll,posSaccStartAll,posSaccEndAll,pvelSacccAll] = saccBlinkDelete(blinkTimeStart,blinkTimeEnd,timeSaccStartAll,timeSaccEndAll,posSaccStartAll,posSaccEndAll,pvelSacccAll)
% [timeSaccStartAll,timeSaccEndAll] = saccBlink(blinkTimeStart,blinkTimeEnd,,timeSaccStartAll,timeSaccEndAll)
% delete the saccades in which a blink occured
% --- INPUT ---
% blinkTimeStart : the start time of all blinks in one subject
% blinkTimeEnd : the end time of all blinks in one subject
% timeSaccStartAll : the start time of all saccades in one subject
% timeSaccEndAll :the end time of all saccades in one subject 
% --- OUTPUT ---  
% timeSaccStartAll : the start time of saccades (excluding during the
%                    blink) in one subject
% timeSaccEndAll : the end time of saccades (excluding during the blink) in one subject
% saccblinkstart = [];
% saccblinkend = [];
% blinkStart =[];
% blinkEnd = [];

for i = 1:size(blinkTimeEnd,1)
    for j = 1: size(timeSaccStartAll,2)
        if((blinkTimeEnd(i) <= timeSaccEndAll(j)) && (blinkTimeStart(i) >= timeSaccStartAll(j))) %if end of blink is before end of saccade and if blink start is after start of saccade --> remove saccade
%             blinkStart = cat(1,blinkStart,blinkTimeStart(i));
%             blinkEnd = cat(1,blinkEnd,blinkTimeEnd(i));
%             saccblinkstart = cat(1,saccblinkstart,timeSaccStartAll(j));
%             saccblinkend = cat(1,saccblinkend,timeSaccEndAll(j));
             idxBlinkSacc(j)=1;
         else
             idxBlinkSacc(j)=0;
             
%             timeSaccEndAll(j) = 0;
%             timeSaccStartAll(j) = 0;
%             posSaccStartAll(:,j) = 0;
%             posSaccEndAll(:,j) = 0;
%             pvelSacccAll(j) = 0;
        end
    end
end

timeSaccEndAll(idxBlinkSacc==1) = [];
timeSaccStartAll(idxBlinkSacc==1) = [];
posSaccStartAll(:,(idxBlinkSacc==1)) = [];
posSaccEndAll(:,(idxBlinkSacc==1)) = [];
pvelSacccAll(idxBlinkSacc==1) = [];

% timeSaccEndAll(all((timeSaccEndAll)==0,1)) = [];
% timeSaccStartAll(all((timeSaccStartAll)==0,1)) = [];
% posSaccStartAll(:,~any(posSaccStartAll,1)) = [];
% posSaccEndAll(:,~any(posSaccEndAll,1)) = [];
% pvelSacccAll(all((pvelSacccAll)==0,1)) = [];