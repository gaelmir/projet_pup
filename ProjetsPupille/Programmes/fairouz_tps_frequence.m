clear all;
close all;
clc;
Matrice=buildDataTableSCT('02','J:\ProjetsPupille\version Faustine\projet_pup-master\projet_pup-master\ProjetsPupille\Programmes\Exemple_Data');
Matrice_taille=Matrice{:,[34:36]};
Vect_correct=Matrice{:,21};
Vect_erreur=Matrice{:,22};

%Valeur_ecran_gris=Matrice_taille(:,3);


Matrice_taille_correct=[];
Matrice_taille_erreur=[];
for i=1:size(Vect_correct)

    if Vect_correct(i)==1

        Matrice_taille_correct=[Matrice_taille_correct;Matrice_taille(i,:)];

    end

    if Vect_erreur(i)==1

        Matrice_taille_erreur=[Matrice_taille_erreur;Matrice_taille(i,:)];

    end
end


%Cas où l'experience est prise en compte(cas correcte)
Matrice_correct_sur_image=Matrice_taille_correct(:,2);
Matrice_correct_ecran_gris=Matrice_taille_correct(:,3);



%--------------------------------------------------------------------------------------%
%Partie 1:transformée de Fourrier à fenètre et spectrogramme
%--------------------------------------------------------------------------------------%


%Representation du spectrogramme du signal :
x=Matrice_correct_sur_image{1, 1};
Fe=1000;%fréquence d'echantillionnage
Te=1/Fe;
N=length (x)%nombre d'echantillions
t=(1:N)/Fe;
t=t/N*Fe%Pour normaliser
figure()
plot(t,x)
title('representation temporelle du signal x')
xlabel('t(s)')
ylabel('frequence(Hz)')


axe_freq = (0:N-1)*Fe/N;
axe_freq=axe_freq/Fe;
y=fft(x);
figure()
stem(axe_freq,abs(y))

fp=[];
for i=1:4
[fp_max,fp_min]=spectrogramme(x,8*i,1024,Fe);
[fp]=[fp;fp_max,fp_min];
end

% % f1=F(200:400);
% % t1=1/f1
% % xlim1=x(200)
% % xlim2=x(400)
% % x1=x(xlim1:xlim2)
% % [S1,F1,T1,Ps1]=spectrogram(x1,hanning(64),32,1024,f1);
% % %x2=x(xlim2:xlim1))
% % % figure(3)
% % %  plot(t1,x)
% 
% 
