clear all
close all

SubjectCode='02';
path='Exemple_Data'
Matrice=buildDataTableSCT(SubjectCode,path,0);
Matrice_taille=Matrice{:,35};

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
tab_sizepupilimage_err=[];
figure()
grid on
for i=1:size(Matrice_taille_erreur)
sizepupilimage=cell2mat(Matrice_taille_erreur(i));
sizepupilimage=sizepupilimage(1:398);
    if sum(sizepupilimage==0)==0 && sum(sizepupilimage>=8000)==0
        garde_err=[garde_err;i];
        tab_sizepupilimage_err=[tab_sizepupilimage_err,sizepupilimage];
        moy_err=[moy_err;mean(sizepupilimage)];
        ecart_err=[ecart_err;std(sizepupilimage)];
        x=size(sizepupilimage);
        plot(sizepupilimage)
        hold on

    end
end
title("taille erreur")


    %Affichage de l'évolution en cas d'erreur pour sizePupilimage et
    %sizePupilfixationcross
moy_corr=[];
ecart_corr=[];
garde_corr=[];
tab_sizepupilimage_corr=[];
figure()
grid on
for i=1:size(Matrice_taille_correct)
    sizepupilimage=cell2mat(Matrice_taille_correct(i));
    sizepupilimage=sizepupilimage(1:398);
    if sum(sizepupilimage==0)==0 && sum(sizepupilimage>=8000)==0
        garde_corr=[garde_corr;i];
        tab_sizepupilimage_corr=[tab_sizepupilimage_corr,sizepupilimage];
        moy_corr=[moy_corr;mean(sizepupilimage)];
        ecart_corr=[ecart_corr;std(sizepupilimage)];

        x=size(sizepupilimage);
        plot(sizepupilimage)
        hold on
    end
end
title("taille correct")



%%
close all
vect_test_err=tab_sizepupilimage_err(:,17);
vect_test_corr=tab_sizepupilimage_corr(:,17);

Fe=1000;
axe_freq=[0:397]/397
Ts=1/Fs;
t=1:1:398;
y_corr=fft(vect_test_corr)
figure()
y_corr(1)=0
stem(axe_freq,abs(y_corr))
y_err=fft(vect_test_err)
y_err(1)=0
hold on 
stem(axe_freq,abs(y_err))
grid on