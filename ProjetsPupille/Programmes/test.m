clear all
close all
%%
Matrice=buildDataTableSCT('02','Exemple_Data',1);
Matrice_face=buildDataTableSCT('02','Exemple_Data',1);% matrice pour visage 
Matrice_taille=Matrice{:,[34:36]};
Vect_correct=Matrice{:,21};
Vect_erreur=Matrice{:,22};

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
a = 1;
b = [1/4 1/4 1/4 1/4];
for i=8:18%size(Matrice_taille_erreur)
    sizepupilimage=cell2mat(Matrice_taille_erreur(i,2));
    x=size(sizepupilimage);
    x=x(1)
    if x==399
        y = filter(b,a,sizepupilimage);

        t = 1:length(sizepupilimage);
        %plot(t,sizepupilimage,'--',t,y,'-')
        %legend('Original Data','Filtered Data')
        plot(y(i:399))
        hold on
    end
end
hold off
%figure()

for i=4:8%size(Matrice_taille_erreur)
    sizepupilbackground=cell2mat(Matrice_taille_erreur(i,3));
    x=size(sizepupilbackground);
    x=x(1)
    if x==999
        %plot(sizepupilbackground)
        %hold on
    end
end
hold off

%Affichage de l'évolution en cas de correct pour sizePupilimage et
%sizePupilbackground
figure()

for i=8:18%size(Matrice_taille_erreur)
    sizepupilimage=cell2mat(Matrice_taille_correct(i,2));
    x=size(sizepupilimage);
    x=x(1)
    if x==399
        plot(sizepupilimage)
        hold on
    end
end
hold off
%figure()

for i=4:8%size(Matrice_taille_erreur)
    sizepupilbackground=cell2mat(Matrice_taille_correct(i,3));
    x=size(sizepupilbackground);
    x=x(1)
    if x==999
        %plot(sizepupilbackground)
        %hold on
    end
end
hold off



