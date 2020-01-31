     function pix = ang2pix(dist,width,res,ang)
         %converts visual angles in degrees to pixels.
%     %
%     %Inputs:
%     dist (distance from screen (cm))
%     width (width of screen (cm))
%     res (number of pixels of display in horizontal direction)
%     
%     %ang (visual angle)

    %Calculate pixel size
    pixSize = width/res;   %cm/pix
    sz = 2*dist*tan(pi*ang/(2*180));  %cm
    pix = round(sz/pixSize);   %pix 
     end