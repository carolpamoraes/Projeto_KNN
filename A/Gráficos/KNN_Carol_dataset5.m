clc
clear all
close all

%Teste KNN
%Inicialização
k=3;
n=0;
m=0;
p=0;
Classe_1=zeros(2,3);
Classe_2=zeros(2,4);
Classe_3=zeros(2,4);

load('dataset5_mesclado.mat');
data=dataset5Copy;

%Quantidade de dados
quant_training=110;
quant_teste=40;

%Dados Treinamento em MATRIZ
d_training=data(1:110,:);

%Dados Treinamento
y=d_training(:,1);
x=d_training(:,2);
Teta_training= d_training(:,3);



for it=1:quant_training
    
    if Teta_training(it,1)==1
        
        n=n+1;

        Classe_1(:,n)=[x(it,1),y(it,1)];      
        
    elseif  Teta_training(it,1)==2    
        
        m=m+1;

        Classe_2(:,m)=[x(it,1),y(it,1)]; 

    else
        
        p=p+1;

        Classe_3(:,p)=[x(it,1),y(it,1)]; 

    end
    
end

%Grafico Treinamento
figure(1)
scatter(Classe_1(1,:),Classe_1(2,:),'^','red');
hold on
scatter(Classe_2(1,:),Classe_2(2,:),'o','blue');
hold on
scatter(Classe_3(1,:),Classe_3(2,:),'d','green');
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
    
     cont_1=0;
     cont_2=0;
     cont_3=0;

[l,c]=sort(d);

    for ik=1:k

        a = Teta_training(c(1,ik),1);

        if a==1

            cont_1=cont_1+1;

        elseif a==2

            cont_2=cont_2+1;

        else

            cont_3=cont_3+1;

        end


    end
    
    
        %Quantidade de acertos
        if a==Teta_t(iy,1)

            acerto=acerto+1;

        else 

            erro=erro+1;        

        end
    
    
        %Grafico Teste
        figure(2)
        scatter(Classe_1(1,:),Classe_1(2,:),'*','red');    
        hold on
        scatter(Classe_2(1,:),Classe_2(2,:),'.','blue');
        hold on
        scatter(Classe_3(1,:),Classe_3(2,:),'+','green');
        hold on

        if cont_1 > cont_2 && cont_1 > cont_3

        disp('Classificação: 1');
        scatter(d_test(iy,2),d_test(iy,1),'^','red');
        hold on

        elseif  cont_2 > cont_1 && cont_2 > cont_3

        disp('Classificação: 2');
        scatter(d_test(iy,2),d_test(iy,1),'o','blue');
        hold on

        else

        disp('Classificação: 3');
        scatter(d_test(iy,2),d_test(iy,1),'d','green');
        hold on   

        end
    
end


%Acurácia
Ac=(acerto/quant_teste)*100;
X = ['Acurácia: ',num2str(Ac),'%'];
disp(X);    
    

    
    
    
 