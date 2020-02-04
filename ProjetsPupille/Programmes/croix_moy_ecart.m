function [garde_corr,moy_corr,ecart_corr,garde_err,moy_err,ecart_err]=croix_moy_ecart(SubjectCode,path,face)

%input 
%subject code : '02' entre ''
%path : 'c\.......\Exemple_Data' entre ''
%face : 1 face ou 0 vehicule . Scalaire 0 ou 1 

%output 
%les statistiques sur les 400 dernières ms 
%garde : numero des essais coservés

if face ~= 0 && face ~=1
   "erreur"
end
if face==0
    %vehicule
    Matrice=buildDataTableSCT(SubjectCode,path,0);
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
    
    tab_sizepupilimage_err_cross=[];
    moy_err=[];
    ecart_err=[];
    garde_err=[];
    for i=1:size(Matrice_taille_erreur)
        sizepupilimage=cell2mat(Matrice_taille_erreur(i));
        sizepupilimage=sizepupilimage(end-399:end);
        if sum(sizepupilimage==0)==0 && sum(sizepupilimage>=8000)==0
            garde_err=[garde_err;i];
            tab_sizepupilimage_err_cross=[tab_sizepupilimage_err_cross;sizepupilimage];
            moy_err=[moy_err;mean(sizepupilimage)];
            ecart_err=[ecart_err;std(sizepupilimage)];
            x=size(sizepupilimage);
        end
    end


    %Affichage de l'évolution en cas d'erreur pour sizePupilimage et
    %sizePupilfixationcross
    moy_corr=[];
    ecart_corr=[];
    garde_corr=[];
    tab_sizepupilimage_corr_cross=[];
    for i=1:size(Matrice_taille_correct)
        sizepupilimage=cell2mat(Matrice_taille_correct(i));
        sizepupilimage=sizepupilimage(end-399:end);
        if sum(sizepupilimage==0)==0 && sum(sizepupilimage>=8000)==0
            garde_corr=[garde_corr;i];
            tab_sizepupilimage_corr_cross=[tab_sizepupilimage_corr_cross;sizepupilimage];
            moy_corr=[moy_corr;mean(sizepupilimage)];
            ecart_corr=[ecart_corr;std(sizepupilimage)];
            x=size(sizepupilimage);
        end
    end
end







if face==1
    % face 

    Matrice=buildDataTableSCT(SubjectCode,path,1);
    
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
    
    moy_err=[];
    ecart_err=[];
    garde_err=[];
    tab_sizepupilimage_err_cross=[];
    for i=1:size(Matrice_taille_erreur)
        sizepupilimage=cell2mat(Matrice_taille_erreur(i));
        sizepupilimage=sizepupilimage(end-399:end);
        if sum(sizepupilimage==0)==0 && sum(sizepupilimage>=8000)==0
            garde_err=[garde_err;i];
            tab_sizepupilimage_err_cross=[tab_sizepupilimage_err_cross;sizepupilimage];
            moy_err=[moy_err;mean(sizepupilimage)];
            ecart_err=[ecart_err;std(sizepupilimage)];
            x=size(sizepupilimage);

        end
    end



    %Affichage de l'évolution en cas d'erreur pour sizePupilimage et
    %sizePupilfixationcross
    moy_corr=[];
    ecart_corr=[];
    garde_corr=[];
    tab_sizepupilimage_corr_cross=[];
    for i=1:size(Matrice_taille_correct)
        sizepupilimage=cell2mat(Matrice_taille_correct(i));
        sizepupilimage=sizepupilimage(end-399:end);
        if sum(sizepupilimage==0)==0 && sum(sizepupilimage>=8000)==0
            garde_corr=[garde_corr;i];
            tab_sizepupilimage_corr_cross=[tab_sizepupilimage_corr_cross;sizepupilimage];
            moy_corr=[moy_corr;mean(sizepupilimage)];
            ecart_corr=[ecart_corr;std(sizepupilimage)];
            
            x=size(sizepupilimage);
        end
    end
end

end