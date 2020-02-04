 %%
  close all
  clear all
  %%
   % -----------------------------------------------------------------------
  %---------------------------------------------------------------------
  % %Evolution de la taille de la pupille sur l'image pour 4 intervals
  %calculs des ecarts-types
  %--------------------------------------------------------------------
  %----------------------------------------------------------------------
%Chargement des donn?es F (vers le visage)
F=load('Exemple_Data\SCTf02.mat')

%Chargement des donn?es V (vers le vehicule)
V=load('Exemple_Data\SCTv02.mat')

TimeF=F.eyedata.FSAMPLE.time;

TimeV=V.eyedata.FSAMPLE.time;

TimeF=TimeF-min(TimeF);
TimeV=TimeV-min(TimeV);
  
Matrice=buildDataTableSCT('02','Exemple_Data',0);
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
  
Matrice_correct_sur_image=Matrice_taille_correct(:,2);
Matrice_correct_ecran_gris=Matrice_taille_correct(:,3);  
Matrice_erreur_sur_image=Matrice_taille_erreur(:,2);
    
%Evolution de la taille de la pupille pour les images

k=1;
i=100;
l=1;



for l=1:4
    figure()
    
 %for j=k:(i*l)-1
        for m=1:size(Matrice_correct_sur_image)
   % for j=k:i*(size (Matrice_correct_sur_image)/4)
    
            ecart_type_correcte_interval(l,m)=std((Matrice_correct_sur_image{m,1}([k:(i*l)-1],1)));
            plot(Matrice_correct_sur_image{m,1}([k:(i*l)-1],1))  
            hold on
        end

        k=(i*l);
        title(sprintf('differentes tailles de la pupille sur limage sur %d ème interval cas correct',l))
        ecart_type_generale_correcte_interval(l)=mean(ecart_type_correcte_interval(l,m));
     
 end

ecart_t_corr_int=[]
for i=1:4
    ecart_t_corr_int(i)=mean(ecart_type_correcte_interval(i,:))
end

%(cas erreur)
k=1;
i=100;
l=1;



for l=1:4
    figure()

         for m=1:size(Matrice_erreur_sur_image)
        ecart_type_erreur_interval(l,m)=std((Matrice_erreur_sur_image{m,1}([k:(i*l)-1],1)));
        plot(Matrice_erreur_sur_image{m,1}([k:(i*l)-1],1))  
        hold on
        end

    k=(i*l);
    title(sprintf('differentes tailles de la pupille sur limage sur %d ème interval cas erreur',l))
     ecart_type_generale_erreur_interval(l)=mean(ecart_type_erreur_interval(l,m));
end
ecart_t_err_int=[]
for i=1:4
    ecart_t_err_int(i)=mean(ecart_type_erreur_interval(i,:))
end
 

figure(1)
boxplot([ecart_type_correcte_interval(4,1:50)',ecart_type_erreur_interval(4,:)'])
  
%   % Analyses univariées : fonction anova1
%  p_sur_image_interval=anova1 ( moyenne_generale_erreur_interval, moyenne_generale_correcte_interval)
%     title('Anova1 pour les cas correct/erreur')