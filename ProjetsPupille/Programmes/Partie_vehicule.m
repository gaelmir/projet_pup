clear all
close all
% %Chargement des données F (vers le visage)
% F=load("SCTf02.mat")
% 
% %Chargement des données V (vers le vehicule)
% V=load("SCTv02.mat")
% 
% TimeF=F.eyedata.FSAMPLE.time;
% 
% TimeV=V.eyedata.FSAMPLE.time;
% 
% TimeF=TimeF-min(TimeF);
% TimeV=TimeV-min(TimeV);
% 
% % figure()
% % plot(TimeF)
% % title("Evolution du temps pour la 1er partie de l'experience (regarder les visages)")
% % 
% % figure()
% % plot(TimeV)
% % title("Evolution du temps pour la 2ème partie de l'experience (regarder les vehicules)")
% 
% %On récupère la deuxième colonne de pa (diametre de la pupille) à quoi sert
% %la deuxieme colonne ?
% diametre_pupille_F=F.eyedata.FSAMPLE.pa(:,2);
% diametre_pupille_V=V.eyedata.FSAMPLE.pa(:,2);
% 
% figure()
% stem(TimeF,diametre_pupille_F)
% 
% figure()
% stem(TimeV,diametre_pupille_V)
% 
% 
% % Premiere_serie_F=[];
% % i=1;
% % while diametre_pupille_F(i) > 5000
% %     Premiere_serie_F=[Premiere_serie_F;diametre_pupille_F(i)];
% %     i=i+1;
% %     
% % end
% % %Premiere_serie_F=Premiere_serie_F'
% % Premiere_serie_TimeF=[];
% % for j = 1:i-1
% %     Premiere_serie_TimeF=[Premiere_serie_TimeF;TimeF(j)];
% % end
% % 
% % figure()
% % stem(Premiere_serie_TimeF,Premiere_serie_F)
% Indice_saut=[];
% %Indice_saut=[Indice_saut;0];
% for i=2:size(TimeF)
%     if (TimeF(i-1)+ 1)< TimeF(i)
%         Indice_saut=[Indice_saut;i];
%     end
% end
% Premiere_serie_F=zeros([3350 123]);
% Premiere_serie_TimeF=zeros([3350 123]);
% Premiere_serie_F([1:Indice_saut(1)],1)=diametre_pupille_F([1:Indice_saut(1)]);
% Premiere_serie_TimeF([1:Indice_saut(1)],1)=TimeF([1:Indice_saut(1)]);
% 
% 
% for j=2:size(Indice_saut)
%       Premiere_serie_F([1:(Indice_saut(j)-Indice_saut(j-1)+1)],j)=diametre_pupille_F([Indice_saut(j-1):Indice_saut(j)]);
%       Premiere_serie_TimeF([1:(Indice_saut(j)-Indice_saut(j-1)+1)],j)=TimeF([Indice_saut(j-1):Indice_saut(j)]);
%   
% end
% figure()
% plot(Premiere_serie_TimeF([1:Indice_saut(1)],1),Premiere_serie_F([1:Indice_saut(1)],1))



%---------------------------------PARTIE VEHICULE --------------------
Matrice_vehicule=buildDataTableSCT('02','C:\Users\ASUS\Desktop\gitou\projet_pup\ProjetsPupille\Exemple_Data',0);

Matrice_taille=Matrice_vehicule{:,[34:36]};
Vect_correct=Matrice_vehicule{:,21};
Vect_erreur=Matrice_vehicule{:,22};
Matrice_position_XY=Matrice_vehicule{:,[37:38]};

% %Chargement des données F (vers le visage)
% F=load('C:\Users\ASUS\Desktop\gitou\projet_pup\ProjetsPupille\Exemple_Data\SCTf02.mat');
% %Chargement des données V (vers le vehicule)
% V=load('C:\Users\ASUS\Desktop\gitou\projet_pup\ProjetsPupille\Exemple_Data\SCTv02.mat');
% 
% %On récupère la position en x et en y
% pos_X_visage=F.eyedata.FSAMPLE.gx;
% pos_Y_visage=F.eyedata.FSAMPLE.gy;
% pos_X_vehicule=V.eyedata.FSAMPLE.gx;
% pos_Y_vehicule=V.eyedata.FSAMPLE.gy;

%Pos_saccade_1=Matrice_vehicule{:,10:13};
%Pos_saccade_2=Matrice_vehicule{:,23:26};

%On crée une table composée de l'évolution de la taille dans la pupille
%lorsque qu'il y a erreur et une table composée de l'évolution de la taille dans la pupille
%lorsque qu'il n'y a pas erreur
Matrice_taille_correct=[];
Matrice_taille_erreur=[];
Matrice_position_XY_correct=[];
Matrice_position_XY_erreur=[];
%Matrice_saccade_1_correct=[];
%Matrice_saccade_2_correct=[];
%Matrice_saccade_1_erreur=[];
%Matrice_saccade_2_erreur=[];


for i=1:size(Vect_correct)
    
    if Vect_correct(i)==1
  
        Matrice_taille_correct=[Matrice_taille_correct;Matrice_taille(i,:)];
        Matrice_position_XY_correct=[Matrice_position_XY_correct;Matrice_position_XY(i,:)];
       
    end
    
    if Vect_erreur(i)==1
  
        Matrice_taille_erreur=[Matrice_taille_erreur;Matrice_taille(i,:)];
        Matrice_position_XY_erreur=[Matrice_position_XY_erreur;Matrice_position_XY(i,:)];
       
    end
end

%Affichage de l'évolution en cas d'erreur pour sizePupilimage et
%sizePupilbackground
%figure()
%erreur_sizepupilimage=[];
for i=8:8%size(Matrice_taille_erreur)
    sizepupilimage=cell2mat(Matrice_taille_erreur(i,2));
    position_X=cell2mat(Matrice_position_XY_erreur(i,1))+6000;
    position_Y=cell2mat(Matrice_position_XY_erreur(i,2))+6000;
    x=size(sizepupilimage);
    x=x(1);
    if x==399

        y=smooth(sizepupilimage,10);
        
   
%         plot(y)
%         title("Evolution de la taille de la pupille (erreur + vehicule + image)")
%         hold on
%         plot(position_X)
%         hold on
%         plot(position_Y)
%         legend('taille','position x','position y')
        
    end
end
hold off
%figure()

for i=8:8%size(Matrice_taille_erreur)
    sizepupilbackground=cell2mat(Matrice_taille_erreur(i,3));
    x=size(sizepupilbackground);
    x=x(1);
    if x==999
        y=smooth(sizepupilbackground,10);
        %plot(y)
        %title("Evolution de la taille de la pupille (erreur + vehicule + écran gris)")
        %hold on
    end
end
%hold off

%Affichage de l'évolution en cas de correct pour sizePupilimage et
%sizePupilbackground
%figure()

for i=8:8%size(Matrice_taille_correct)
    sizepupilimage=cell2mat(Matrice_taille_correct(i,2));
    position_X=cell2mat(Matrice_position_XY_correct(i,1))+6000;
    position_Y=cell2mat(Matrice_position_XY_correct(i,2))+6000;
    x=size(sizepupilimage);
    x=x(1);
    if x==399
        y=smooth(sizepupilimage,10);
%         plot(y)
%         title("Evolution de la taille de la pupille (correct + vehicule + image)")
%         hold on
%         plot(position_X)
%         hold on
%         plot(position_Y)
%         
%         legend('taille','position x','position y')
    end
end
hold off
%figure()

for i=8:18%size(Matrice_taille_correct)
    sizepupilbackground=cell2mat(Matrice_taille_correct(i,3));
    x=size(sizepupilbackground);
    x=x(1);
    if x==999
        y=smooth(sizepupilbackground,10);
        %plot(y)
        %title("Evolution de la taille de la pupille (correct + vehicule + écran gris)")
        %hold on
    end
end
%hold off

%%
close all
%-------------------------------------ANALYSE DES DONNEES---------------%
%On s'interesse d'abord aux véhicules
[garde_corr,moy_corr,ecart_corr,garde_err,moy_err,ecart_err]=croix_moy_ecart('02','C:\Users\ASUS\Desktop\gitou\projet_pup\ProjetsPupille\Exemple_Data',0);

%On normalise les données
sizepupilimage_normalisee_correct=[];
sizepupilimage_normalisee_erreur=[];
figure()
for j=1:size(Matrice_taille_erreur)
    sizepupilimage=cell2mat(Matrice_taille_erreur(j,2));
    %On regarde si on a conserver la valeur
    Valider=sum(j==garde_err);
    position=find(garde_err==j);
    if Valider==1
        sizepupilimage=sizepupilimage-moy_err(position);
        sizepupilimage=sizepupilimage/ecart_err(position);
        y=smooth(sizepupilimage,15);
        plot(y)
        hold on
        title("evolution de la taille de la pupille normalisée (image + vehicule + erreur)")
        sizepupilimage_normalisee_erreur=[sizepupilimage_normalisee_erreur;{sizepupilimage}];
    end
        
end
hold off
figure
for j=1:size(Matrice_taille_correct)
    sizepupilimage=cell2mat(Matrice_taille_correct(j,2));
    %On regarde si on a conserver la valeur
    Valider=sum(j==garde_corr);
    position=find(garde_corr==j);
    if Valider==1
        sizepupilimage=sizepupilimage-moy_corr(position);
        sizepupilimage=sizepupilimage/ecart_corr(position);
        y=smooth(sizepupilimage,15);
        plot(y)
        hold on
        title("evolution de la taille de la pupille normalisée (image + vehicule + correct)")
        sizepupilimage_normalisee_correct=[sizepupilimage_normalisee_correct;{sizepupilimage}];
    end
        
end
    
hold off
    





