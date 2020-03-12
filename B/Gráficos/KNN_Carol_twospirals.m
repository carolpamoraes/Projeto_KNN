clc
clear all
close all

%Teste KNN
%Inicialização
k=5;
n=0;
m=0;
Classe_0=zeros(2,3);
Classe_1=zeros(2,4);

%Quantidade de dados
quant_training=1300;
quant_teste=700;

load('dataset_twospirals.mat')


%Dados Treinamento em MATRIZ
d_training=[data(1:200,:);data(1001:1200,:);data(201:250,:);data(1201:1250,:);data(251:350,:);data(1251:1450,:);data(351:550,:);data(1451:1500,:);data(551:650,:);data(1501:1650,:)];

%Dados Treinamento
y=d_training(:,1);
x=d_training(:,2);
Teta= d_training(:,3);



for it=1:quant_training
    
    if Teta(it,1)==0
        
        n=n+1;

        Classe_0(:,n)=[x(it,1),y(it,1)];       

    else
        
        m=m+1;

        Classe_1(:,m)=[x(it,1),y(it,1)]; 

    end
    
end

%Grafico Treinamento
figure(1)
scatter(Classe_0(1,:),Classe_0(2,:),'o','blue');
hold on
scatter(Classe_1(1,:),Classe_1(2,:),'^','green');
hold off


%Dados teste em MATRIZ
d_test=[data(651:700,:);data(1651:1750,:);data(701:800,:);data(1751:1850,:);data(801:900,:);data(1851:1950,:);data(901:1000,:);data(1951:2000,:)];


%Dados teste
y_t=d_test(:,1);
x_t=d_test(:,2);
Teta_t=d_test(:,3);


%Contadores de acerto e erro
acerto=0;
erro=0;

for iy=1:quant_teste
    
    for ix=1:quant_training
        
        d(:,ix)=norm(d_test(iy,:)-d_training(ix,:));
        
    end
    
 cont_classe_0=0;
 cont_classe_1=0;

 [l,c]=sort(d);

for ik=1:k

    a = Teta(c(1,ik),1);
    
    if a==0
        
        cont_classe_0=cont_classe_0+1;
        
    else
        
        cont_classe_1=cont_classe_1+1;
        
    end
    
    
end

    cont=[cont_classe_0 cont_classe_1];

    %Quantidade de acertos
    [~,b]=max(cont);

    if (b-1)==Teta_t(iy,1)
        
        acerto=acerto+1;
        
    else 
        
        erro=erro+1;        
        
    end
    
    
%     %Grafico Teste
%     figure(2)
%     scatter(Classe_0(1,:),Classe_0(2,:),'.','red');        
%     hold on
%     scatter(Classe_1(1,:),Classe_1(2,:),'.','blue');
%     hold on
% 
%     if cont_classe_0 > cont_classe_1
% 
%     disp('Classificação: 0');
%     scatter(d_test(iy,2),d_test(iy,1),'^','red');
%     hold on
% 
%     else 
% 
%     disp('Classificação: 1');
%     scatter(d_test(iy,2),d_test(iy,1),'o','blue');
%     hold on
% 
%     end
    
end


    
%Acurácia
Ac=(acerto/quant_teste)*100;
X = ['Acurácia: ',num2str(Ac),'%'];
disp(X);
    


    
    
 