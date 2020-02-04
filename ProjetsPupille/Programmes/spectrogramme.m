 function [fp_max,fp_min]=spectrogramme(x,L,m,Fe)
 
 
 %%%les variables d'entrees
 %x est le  signal à traiter
 %L est la longueur de la fenètre glissante
 %Fe est la fréquence d'echantillionnage
 
 %%les variables de sorties
 %fp :la fréquence de la porteuse

[S,F,T,Ps]=spectrogram(x,hanning(L),L/2,m,Fe);
figure()
imagesc(T,F,Ps);
%colormap(gray);
title(sprintf('le spectrogram du signal x avec hanning %d',L))
xlabel('t(s)')
ylabel('frequence(Hz)')
axis xy
[q,nd]=max(Ps);%recherche de maxima;
hold on
plot3(T,F(nd),q,'k','linewidth',2)
fp_max=max(nd);
fp_min=min(nd);