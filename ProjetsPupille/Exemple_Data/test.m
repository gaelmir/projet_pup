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


%%
%---------------------------------PARTIE VEHICULE --------------------
Matrice_vehicule=buildDataTableSCT('02','C:\Users\ASUS\Desktop\gitou\projet_pup\ProjetsPupille\Exemple_Data',{'SCTv'});

Matrice_taille=Matrice_vehicule{:,[34:36]};
Vect_correct=Matrice_vehicule{:,21};
Vect_erreur=Matrice_vehicule{:,22};

%On crée une table composée de l'évolution de la taille dans la pupille
%lorsque qu'il y a erreur et une table composée de l'évolution de la taille dans la pupille
%lorsque qu'il n'y a pas erreur
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

%Affichage de l'évolution en cas d'erreur pour sizePupilimage et
%sizePupilbackground
figure()

for i=8:18%size(Matrice_taille_erreur)
    sizepupilimage=cell2mat(Matrice_taille_erreur(i,2));
    x=size(sizepupilimage);
    x=x(1)
    if x==399
%       y = filter(b,a,sizepupilimage);
%         
        %t = 1:length(sizepupilimage);
%         gscatter(sizepupilimage,t
        y=smooth(sizepupilimage,10);
        %plot(t,sizepupilimage,'--',t,y,'-')
        %legend('Original Data','Filtered Data')
        plot(y)
        title("Evolution de la taille de la pupille (erreur + vehicule + image)")
        hold on
    end
end
hold off
figure()

for i=8:18%size(Matrice_taille_erreur)
    sizepupilbackground=cell2mat(Matrice_taille_erreur(i,3));
    x=size(sizepupilbackground);
    x=x(1)
    if x==999
        y=smooth(sizepupilbackground,10);
        plot(y)
        title("Evolution de la taille de la pupille (erreur + vehicule + écran gris)")
        hold on
    end
end
hold off

%Affichage de l'évolution en cas de correct pour sizePupilimage et
%sizePupilbackground
figure()

for i=8:18%size(Matrice_taille_correct)
    sizepupilimage=cell2mat(Matrice_taille_correct(i,2));
    x=size(sizepupilimage);
    x=x(1)
    if x==399
        y=smooth(sizepupilimage,10);
        plot(y)
        title("Evolution de la taille de la pupille (correct + vehicule + image)")
        hold on
    end
end
hold off
figure()

for i=8:18%size(Matrice_taille_correct)
    sizepupilbackground=cell2mat(Matrice_taille_correct(i,3));
    x=size(sizepupilbackground);
    x=x(1)
    if x==999
        y=smooth(sizepupilbackground,10);
        plot(y)
        title("Evolution de la taille de la pupille (correct + vehicule + écran gris)")
        hold on
    end
end
hold off

%%
%%
clear all
%---------------------------------PARTIE FACE --------------------
Matrice_face=buildDataTableSCT('02','C:\Users\ASUS\Desktop\gitou\projet_pup\ProjetsPupille\Exemple_Data',{'SCTf'});
Matrice_taille=Matrice_face{:,[34:36]};
Vect_correct=Matrice_face{:,21};
Vect_erreur=Matrice_face{:,22};

%On crée une table composée de l'évolution de la taille dans la pupille
%lorsque qu'il y a erreur et une table composée de l'évolution de la taille dans la pupille
%lorsque qu'il n'y a pas erreur
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

%Affichage de l'évolution en cas d'erreur pour sizePupilimage et
%sizePupilbackground
figure()

for i=8:18%size(Matrice_taille_erreur)
    sizepupilimage=cell2mat(Matrice_taille_erreur(i,2));
    x=size(sizepupilimage);
    x=x(1)
    if x==399

        y=smooth(sizepupilimage,10);

        plot(y)
        title("Evolution de la taille de la pupille (erreur + visage + image)")
        hold on
    end
end
hold off
figure()

for i=8:18%size(Matrice_taille_erreur)
    sizepupilbackground=cell2mat(Matrice_taille_erreur(i,3));
    x=size(sizepupilbackground);
    x=x(1)
    if x==999
        y=smooth(sizepupilbackground,10);
        plot(y)
        title("Evolution de la taille de la pupille (erreur + visage + écran gris)")
        hold on
    end
end
hold off

%Affichage de l'évolution en cas de correct pour sizePupilimage et
%sizePupilbackground
figure()

for i=8:18%size(Matrice_taille_correct)
    sizepupilimage=cell2mat(Matrice_taille_correct(i,2));
    x=size(sizepupilimage);
    x=x(1)
    if x==399
        y=smooth(sizepupilimage,10);
        plot(y)
        title("Evolution de la taille de la pupille (correct + visage + image)")
        hold on
    end
end
hold off
figure()

for i=8:18%size(Matrice_taille_correct)
    sizepupilbackground=cell2mat(Matrice_taille_correct(i,3));
    x=size(sizepupilbackground);
    x=x(1)
    if x==999
        y=smooth(sizepupilbackground,10);
        plot(y)
        title("Evolution de la taille de la pupille (correct + visage + écran gris)")
        hold on
    end
end
hold off



