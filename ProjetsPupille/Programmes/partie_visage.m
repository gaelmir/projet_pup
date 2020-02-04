%%
close all
clear all
%---------------------------------PARTIE FACE ---------------------%
Matrice_face=buildDataTableSCT('02','C:\Users\ASUS\Desktop\gitou\projet_pup\ProjetsPupille\Exemple_Data',1);
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
%figure()

for i=8:18%size(Matrice_taille_erreur)
    sizepupilimage=cell2mat(Matrice_taille_erreur(i,2));
    x=size(sizepupilimage);
    x=x(1);
    if x==399

        y=smooth(sizepupilimage,10);

        %plot(y)
        %title("Evolution de la taille de la pupille (erreur + visage + image)")
        %hold on
    end
end
%hold off
%figure()

for i=8:18%size(Matrice_taille_erreur)
    sizepupilbackground=cell2mat(Matrice_taille_erreur(i,3));
    x=size(sizepupilbackground);
    x=x(1);
    if x==999
        y=smooth(sizepupilbackground,10);
        %plot(y)
        %title("Evolution de la taille de la pupille (erreur + visage + écran gris)")
        %hold on
    end
end
%hold off

%Affichage de l'évolution en cas de correct pour sizePupilimage et
%sizePupilbackground
%figure()

for i=8:18%size(Matrice_taille_correct)
    sizepupilimage=cell2mat(Matrice_taille_correct(i,2));
    x=size(sizepupilimage);
    x=x(1);
    if x==399
        y=smooth(sizepupilimage,10);
        %plot(y)
        %title("Evolution de la taille de la pupille (correct + visage + image)")
        %hold on
    end
end
%hold off
%figure()

for i=8:18%size(Matrice_taille_correct)
    sizepupilbackground=cell2mat(Matrice_taille_correct(i,3));
    x=size(sizepupilbackground);
    x=x(1);
    if x==999
        y=smooth(sizepupilbackground,10);
        %plot(y)
        %title("Evolution de la taille de la pupille (correct + visage + écran gris)")
        %hold on
    end
end
%hold off

