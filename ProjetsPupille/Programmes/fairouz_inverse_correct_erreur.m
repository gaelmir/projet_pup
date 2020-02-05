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
Vect_condition=Matrice{:,5};


%Valeur_ecran_gris=Matrice_taille(:,3);

Matrice_taille_upright_correct=[];
Matrice_taille_inverted_correct=[];
Matrice_taille_upright_erreur=[];
Matrice_taille_inverted_erreur=[];
Matrice_taille_inverted=[];
Matrice_taille_upright=[];



for i=1:size(Vect_condition)

    if strcmp( Vect_condition(i),{'inverted'})==1

        Matrice_taille_inverted=[Matrice_taille_inverted;Matrice_taille(i,:)];
        
            if Vect_correct(i)==1
        
                Matrice_taille_inverted_correct=[Matrice_taille_inverted_correct;Matrice_taille(i,:)];
        
            end
        
            if Vect_erreur(i)==1
        
                Matrice_taille_inverted_erreur=[Matrice_taille_inverted_erreur;Matrice_taille(i,:)];
        
            end



    else if strcmp( Vect_condition(i),{'upright'})==1

        Matrice_taille_upright=[Matrice_taille_upright;Matrice_taille(i,:)];
                   
        
            if Vect_correct(i)==1
        
                Matrice_taille_upright_correct=[Matrice_taille_upright_correct;Matrice_taille(i,:)];
        
            end
        
            if Vect_erreur(i)==1
        
                Matrice_taille_upright_erreur=[Matrice_taille_upright_erreur;Matrice_taille(i,:)];
        
            end


        end
    end
    
end

%Cas où l'experience est prise en compte(cas correcte)
Matrice_inverted_correct_sur_image=Matrice_taille_inverted_correct(:,2);
Matrice_upright_correct_sur_image=Matrice_taille_upright_correct(:,2);

Matrice_inverted_erreur_sur_image=Matrice_taille_inverted_erreur(:,2);
Matrice_upright_erreur_sur_image=Matrice_taille_upright_erreur(:,2);



close all;
 % -----------------------------------------------------------------------
  %---------------------------------------------------------------------
  % %Evolution de la taille de la pupille sur l'image
  %--------------------------------------------------------------------
  %----------------------------------------------------------------------
  
  


%%Evolution de la taille de la pupille pour les images

%Correcte
figure()
for i=1:size(Matrice_inverted_correct_sur_image)
    moyenne_inverted_correcte(i)=mean((Matrice_inverted_correct_sur_image{i,1}));
    ecart_type_inverted_correcte(i)=std((Matrice_inverted_correct_sur_image{i,1}));
    plot(Matrice_inverted_correct_sur_image{i,1})   ;
    hold on

end
title('differentes tailles de la pupille sur l image inversee cas correct');
 moyenne_generale_inverted_correcte=mean( moyenne_inverted_correcte);
 moyenne_ecart_type_inverted_correcte=mean( ecart_type_inverted_correcte);

 figure()
for i=1:size(Matrice_upright_correct_sur_image);
    moyenne_upright_correcte(i)=mean((Matrice_upright_correct_sur_image{i,1}));
    ecart_type_upright_correcte(i)=std((Matrice_upright_correct_sur_image{i,1}));
    plot(Matrice_upright_correct_sur_image{i,1})   ;
    hold on

end
title('differentes tailles de la pupille sur l image droite cas correct');
 moyenne_generale_upright_correcte=mean( moyenne_upright_correcte);
 moyenne_ecart_type_upright_correcte=mean( ecart_type_upright_correcte);


%Erreur
 
 figure()
for i=1:size(Matrice_inverted_erreur_sur_image);
    moyenne_inverted_erreur(i)=mean((Matrice_inverted_erreur_sur_image{i,1}));
    ecart_type_inverted_erreur(i)=std((Matrice_inverted_erreur_sur_image{i,1}));
    plot(Matrice_inverted_erreur_sur_image{i,1})   ;
    hold on

end
title('differentes tailles de la pupille sur l image inversee cas erreur');
 moyenne_generale_inverted_erreur=mean( moyenne_inverted_erreur);
 moyenne_ecart_type_inverted_erreur=mean( ecart_type_inverted_erreur);

 figure()
for i=1:size(Matrice_upright_erreur_sur_image);
    moyenne_upright_erreur(i)=mean((Matrice_upright_erreur_sur_image{i,1}));
    ecart_type_upright_erreur(i)=std((Matrice_upright_erreur_sur_image{i,1}));
    plot(Matrice_upright_erreur_sur_image{i,1})   ;
    hold on

end
title('differentes tailles de la pupille sur l image droite cas erreur');
 moyenne_generale_upright_erreur=mean( moyenne_upright_erreur);
 moyenne_ecart_type_upright_erreur=mean( ecart_type_upright_erreur);
 
