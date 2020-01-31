% parcours des données
clear all;
close all;

F=load('SCTf02.mat'); % chargement des données ( face en premier )
V=load('SCTv02.mat'); % chargement des données ( vehicule en premier )

echantillonsF = F.eyedata.FSAMPLE; % Récupération des échantillons 
echantillonsV = V.eyedata.FSAMPLE;

TempsF=echantillonsF.time; % Récupération du temps
TempsV=echantillonsV.time;

TempsF=TempsF-min(TempsF);%Nouvelle echelle du temps, on part de 0 
TempsV=TempsV-min(TempsV);

figure(1)
plot(TempsF) % Il y a surement des poses car la courbe n'est pas continue
title("évolution du temps")
grid on
%plot(TempsV);

figure(2)
paF=echantillonsF.pa;
stem(TempsF,paF(:,2))
grid on

hold off

%%
% Création de vecteurs temps entre chaque recalibration
aire_pupille=paF(:,2);
taille=size(TempsF);
taille=taille(1);

tab_index_saut_temps_deb=[1];
tab_index_saut_temps_fin=[];
j=1;
debut=true;

for i= 2:taille
    if TempsF(i)~=(TempsF(j)+1)
        if debut==false 
            tab_index_saut_temps_deb=[tab_index_saut_temps_deb;i];
        else 
            tab_index_saut_temps_fin=[tab_index_saut_temps_fin;i];
        end
        if debut==false 
            debut=true;
        else
            debut=false; 
        end
    end
    j=j+1;
end


%%
close all
duree_max_session=max(tab_index_saut_temps_fin-tab_index_saut_temps_deb)% Cela nous permettra de normaliser les vecteurs
nbre_saut=size(tab_index_saut_temps_deb);
nbre_saut=nbre_saut(1);
toutesval=zeros(duree_max_session,nbre_saut)
for i=1:nbre_saut
    test_0=aire_pupille(tab_index_saut_temps_deb(i):tab_index_saut_temps_fin(i))==0;
    if sum(test_0==0)
        taille_vec=tab_index_saut_temps_fin(i)-tab_index_saut_temps_deb(i)
        toutesval(1:taille_vec+1,i)=aire_pupille(tab_index_saut_temps_deb(i):tab_index_saut_temps_fin(i));
    end
end

for i=1:nbre_saut
    plot(toutesval(:,i))
    hold on
end