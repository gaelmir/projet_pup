clear all
close all
%%
%vehicule
Matrice=buildDataTableSCT('02','Exemple_Data',0)
%Matrice_face=buildDataTableSCT('02','Exemple_Data',1);% matrice pour visage 
Matrice_taille=Matrice{:,34};

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
%sizePupilfixationcross
figure()
a = 1;
b = [1/4 1/4 1/4 1/4];
tab_sizepupilimage_err_cross=[]
for i=1:size(Matrice_taille_erreur)
    sizepupilimage=cell2mat(Matrice_taille_erreur(i));
    sizepupilimage=sizepupilimage(end-399:end);
    if sum(sizepupilimage==0)==0 && sum(sizepupilimage>=8000)==0
        tab_sizepupilimage_err_cross=[tab_sizepupilimage_err_cross;sizepupilimage];
        x=size(sizepupilimage);
    
        %y = filter(b,a,sizepupilimage);
        %t = 1:length(sizepupilimage);
        %plot(t,sizepupilimage,'--',t,y,'-')
        %legend('Original Data','Filtered Data')
        plot(sizepupilimage)
        hold on
    end
end
title("taille de la pupille lors de la croix de fixation avant erreur vehicule")
hold off
%figure()

%Affichage de l'évolution en cas d'erreur pour sizePupilimage et
%sizePupilfixationcross
figure()
a = 1;
b = [1/4 1/4 1/4 1/4];
tab_sizepupilimage_corr_cross=[]
for i=1:size(Matrice_taille_correct)
    sizepupilimage=cell2mat(Matrice_taille_correct(i));
    sizepupilimage=sizepupilimage(end-399:end);
    if sum(sizepupilimage==0)==0 && sum(sizepupilimage>=8000)==0
        tab_sizepupilimage_corr_cross=[tab_sizepupilimage_corr_cross;sizepupilimage];
        x=size(sizepupilimage);
    
        %y = filter(b,a,sizepupilimage);
        %t = 1:length(sizepupilimage);
        %plot(t,sizepupilimage,'--',t,y,'-')
        %legend('Original Data','Filtered Data')
        plot(sizepupilimage)
        hold on
    end
end
title("taille de la pupille lors de la croix de fixation sans erreur vehicule")
hold off
%%
% face 

Matrice=buildDataTableSCT('02','Exemple_Data',1)
%Matrice_face=buildDataTableSCT('02','Exemple_Data',1);% matrice pour visage 
Matrice_taille=Matrice{:,34};

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
%sizePupilfixationcross
figure()
a = 1;
b = [1/4 1/4 1/4 1/4];
tab_sizepupilimage_err_cross=[]
for i=1:size(Matrice_taille_erreur)
    sizepupilimage=cell2mat(Matrice_taille_erreur(i));
    sizepupilimage=sizepupilimage(end-399:end);
    if sum(sizepupilimage==0)==0 && sum(sizepupilimage>=8000)==0
        tab_sizepupilimage_err_cross=[tab_sizepupilimage_err_cross;sizepupilimage];
        x=size(sizepupilimage);
    
        %y = filter(b,a,sizepupilimage);
        %t = 1:length(sizepupilimage);
        %plot(t,sizepupilimage,'--',t,y,'-')
        %legend('Original Data','Filtered Data')
        plot(sizepupilimage)
        hold on
    end
end
title("taille de la pupille lors de la croix de fixation avant erreur face")
hold off
%figure()

%Affichage de l'évolution en cas d'erreur pour sizePupilimage et
%sizePupilfixationcross
figure()
a = 1;
b = [1/4 1/4 1/4 1/4];
tab_sizepupilimage_corr_cross=[]
for i=1:size(Matrice_taille_correct)
    sizepupilimage=cell2mat(Matrice_taille_correct(i));
    sizepupilimage=sizepupilimage(end-399:end);
    if sum(sizepupilimage==0)==0 && sum(sizepupilimage>=8000)==0
        tab_sizepupilimage_corr_cross=[tab_sizepupilimage_corr_cross;sizepupilimage];
        x=size(sizepupilimage);
    
        %y = filter(b,a,sizepupilimage);
        %t = 1:length(sizepupilimage);
        %plot(t,sizepupilimage,'--',t,y,'-')
        %legend('Original Data','Filtered Data')
        plot(sizepupilimage)
        hold on
    end
end
title("taille de la pupille lors de la croix de fixation sans erreur face")
hold off