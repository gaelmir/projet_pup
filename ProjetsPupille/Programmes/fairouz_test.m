clear all ;
close all;

%Chargement des donn?es F (vers le visage)
F=load("SCTf02.mat")

%Chargement des donn?es V (vers le vehicule)
V=load("SCTv02.mat")

TimeF=F.eyedata.FSAMPLE.time;

TimeV=V.eyedata.FSAMPLE.time;

TimeF=TimeF-min(TimeF);
TimeV=TimeV-min(TimeV);

% figure()
% plot(TimeF)
% title("Evolution du temps pour la 1er partie de l'experience (regarder les visages)")
% 
% figure()
% plot(TimeV)
% title("Evolution du temps pour la 2?me partie de l'experience (regarder les vehicules)")

%On r?cup?re la deuxi?me colonne de pa (diametre de la pupille) ? quoi sert
%la deuxieme colonne ?
diametre_pupille_F=F.eyedata.FSAMPLE.pa(:,2);
diametre_pupille_V=V.eyedata.FSAMPLE.pa(:,2);

figure()
stem(TimeF,diametre_pupille_F)

figure()
stem(TimeV,diametre_pupille_V)


% Premiere_serie_F=[];
% i=1;
% while diametre_pupille_F(i) > 5000
%     Premiere_serie_F=[Premiere_serie_F;diametre_pupille_F(i)];
%     i=i+1;
%     
% end
% %Premiere_serie_F=Premiere_serie_F'
% Premiere_serie_TimeF=[];
% for j = 1:i-1
%     Premiere_serie_TimeF=[Premiere_serie_TimeF;TimeF(j)];
% end
% 
% figure()
% stem(Premiere_serie_TimeF,Premiere_serie_F)
Indice_saut=[];
%Indice_saut=[Indice_saut;0];
for i=2:size(TimeF)
    if (TimeF(i-1)+ 1)< TimeF(i)
        Indice_saut=[Indice_saut;i];
    end
end
Premiere_serie_F=zeros([3350 123]);
Premiere_serie_TimeF=zeros([3350 123]);
Premiere_serie_F([1:Indice_saut(1)],1)=diametre_pupille_F([1:Indice_saut(1)]);
Premiere_serie_TimeF([1:Indice_saut(1)],1)=TimeF([1:Indice_saut(1)]);


for j=2:size(Indice_saut)
      Premiere_serie_F([1:(Indice_saut(j)-Indice_saut(j-1)+1)],j)=diametre_pupille_F([Indice_saut(j-1):Indice_saut(j)]);
      Premiere_serie_TimeF([1:(Indice_saut(j)-Indice_saut(j-1)+1)],j)=TimeF([Indice_saut(j-1):Indice_saut(j)]);
  
end
figure()
plot(Premiere_serie_TimeF([1:Indice_saut(1)],1),Premiere_serie_F([1:Indice_saut(1)],1))
Matrice=buildDataTableSCT('02','D:\ProjetsPupille\version Faustine\projet_pup-master\projet_pup-master\ProjetsPupille\Programmes\Exemple_Data');
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



 % -----------------------------------------------------------------------
  %---------------------------------------------------------------------
  % %Evolution de la taille de la pupille sur l'image
  %--------------------------------------------------------------------
  %----------------------------------------------------------------------
  
  


%%Evolution de la taille de la pupille pour les images
figure()
for i=1:size(Matrice_correct_sur_image)
    moyenne_correcte(i)=mean((Matrice_correct_sur_image{i,1}))
    plot(Matrice_correct_sur_image{i,1})   
    hold on

end
title('differentes tailles de la pupille cas correct')
 moyenne_generale_correcte=mean(moyenne_correcte)

 


%Cas où l'experience n'est pas prise en compte(cas erreur)
Matrice_erreur_sur_image=Matrice_taille_erreur(:,2);
figure()
for i=1:size(Matrice_erreur_sur_image)
     moyenne_erreur(i)=mean((Matrice_erreur_sur_image{i,1}))
    plot(Matrice_erreur_sur_image{i,1})
    hold on
end
title('differentes tailles de la pupille cas d erreur')
 moyenne_generale_erreur=mean(moyenne_erreur')
 % Analyses univariées : fonction anova1
 % anova1( moyenne_erreur)
  %title('Anova1 pour le cas d erreur')
  
  
  % Analyses univariées : fonction anova1
  p_sur_image=anova1 ([moyenne_correcte(1:length(moyenne_erreur))',moyenne_erreur'])
    title('Anova1 pour les cas correct/erreur')
    
 % -----------------------------------------------------------------------
  %---------------------------------------------------------------------
  % %Evolution de la taille de la pupille pour l'ecran gris
  %--------------------------------------------------------------------
  %----------------------------------------------------------------------
  
  
figure()
for i=1:size(Matrice_correct_ecran_gris)
    moyenne_correcte_ecran_gris(i)=mean((Matrice_correct_ecran_gris{i,1}))
    mediane_correcte_ecran_gris(i)=median((Matrice_correct_ecran_gris{i,1}))
    if((Matrice_correct_ecran_gris{i,1}>4000) & (Matrice_correct_ecran_gris{i,1}< 8000))
    plot(Matrice_correct_ecran_gris{i,1})   
    hold on
    end

end
title('differentes tailles de la pupille pour écran gris cas correct après traitement')
 moyenne_generale_correcte_ecran_gris=mean(moyenne_correcte_ecran_gris)
 mediane_generale_correcte_ecran_gris=median(mediane_correcte_ecran_gris)

 


%Cas où l'experience n'est pas prise en compte(cas erreur)
Matrice_erreur_ecran_gris=Matrice_taille_erreur(:,3);
figure()
for i=1:size(Matrice_erreur_ecran_gris)
     moyenne_erreur_ecran_gris(i)=mean((Matrice_erreur_ecran_gris{i,1}))
     mediane_erreur_ecran_gris(i)=median((Matrice_erreur_ecran_gris{i,1}))
    if((Matrice_erreur_ecran_gris{i,1}>4000) & (Matrice_erreur_ecran_gris{i,1}< 8000))
    plot(Matrice_erreur_ecran_gris{i,1})
    hold on
    end
end
title('differentes tailles de la pupille pour ecran gris cas d erreur après traitement')
 moyenne_generale_erreur_ecran_gris=mean(moyenne_erreur_ecran_gris')
 mediane_generale_erreur_ecran_gris=median(mediane_erreur_ecran_gris')
 % Analyses univariées : fonction anova1
%  anova1( moyenne_erreur_ecran_gris)
 % title('Anova1 pour le cas d erreur ecran gris')
  
  
  % Analyses univariées : fonction anova1
  p_moyenne_ecran_gris=anova1 ([moyenne_correcte_ecran_gris(1:length(moyenne_erreur_ecran_gris))',moyenne_erreur_ecran_gris'])
    title('Anova1 moyenne pour cas correct/erreur pour ecran gris')
    
  p_mediane_ecran_gris=anova1 ([mediane_correcte_ecran_gris(1:length(mediane_erreur_ecran_gris))',mediane_erreur_ecran_gris'])
  title('Anova1 mediane pour cas correct/erreur pour ecran gris')
    
    