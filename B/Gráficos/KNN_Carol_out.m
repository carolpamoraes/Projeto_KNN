clc
clear all
close all

%Teste KNN
%Inicialização
k=3;
n=0;
m=0;
p=0;
q=0;

Classe_1=zeros(2,3);
Classe_2=zeros(2,4);
Classe_3=zeros(2,4);
Classe_4=zeros(2,4);

%Quantidade de dados
quant_training=350;
quant_teste=250;
total=600;

load('dataset_out.mat')

sorteio=randperm(total);

for passo_tr=1:quant_training

    %Dados Treinamento em MATRIZ
    d_training(passo_tr,:)=data(sorteio(1,passo_tr),:);

end

%Dados Treinamento
y=d_training(:,1);
x=d_training(:,2);
Teta_training= d_training(:,3);



for it=1:quant_training
    
    if Teta_training(it,1)==0
        
        n=n+1;

        Classe_1(:,n)=[x(it,1),y(it,1)];      
        
    elseif  Teta_training(it,1)==1    
        
        m=m+1;

        Classe_2(:,m)=[x(it,1),y(it,1)]; 

    elseif  Teta_training(it,1)==2  
        
        p=p+1;

        Classe_3(:,p)=[x(it,1),y(it,1)]; 
        
    else   
        
        q=q+1;

        Classe_4(:,q)=[x(it,1),y(it,1)]; 
        
        

    end
    
end

%Grafico Treinamento
figure(1)
scatter(Classe_1(1,:),Classe_1(2,:),'^','red');
hold on
scatter(Classe_2(1,:),Classe_2(2,:),'o','blue');
hold on
scatter(Classe_3(1,:),Classe_3(2,:),'d','green');
hold on
scatter(Classe_4(1,:),Classe_4(2,:),'d','yellow');
hold off


sorteio_2= sorteio(1,(quant_training+1):end);

for passo_t=1:quant_teste

    %Dados Treinamento em MATRIZ
    d_test(passo_t,:)=data(sorteio_2(1,passo_t),:);

end


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
     cont_4=0;

[l,c]=sort(d);

    for ik=1:k

        a = Teta_training(c(1,ik),1);

        if a==0

            cont_1=cont_1+1;

        elseif a==1

            cont_2=cont_2+1;
            
        elseif a==2

            cont_3=cont_3+1;

        else

            cont_4=cont_4+1;

        end


    end
    
    
        cont=[cont_1 cont_2 cont_3 cont_4];
        
        %Quantidade de acertos
        [~,b]=max(cont);

        if (b-1)==Teta_t(iy,1)

            acerto=acerto+1;

        else 

            erro=erro+1;        

        end
    
    
        %Grafico Teste
        figure(2)
        scatter(Classe_1(2,:),Classe_1(1,:),'.','red');    
        hold on
        scatter(Classe_2(2,:),Classe_2(1,:),'.','blue');
        hold on
        scatter(Classe_3(2,:),Classe_3(1,:),'.','green');
        hold on
        scatter(Classe_4(2,:),Classe_4(1,:),'.','c');
        hold on

        if cont_1 > cont_2 && cont_1 > cont_3 && cont_1 > cont_4

        disp('Classificação: 0');
        scatter(d_test(iy,1),d_test(iy,2),'^','red');
        hold on

        elseif  cont_2 > cont_1 && cont_2 > cont_3 && cont_2 > cont_4

        disp('Classificação: 1');
        scatter(d_test(iy,1),d_test(iy,2),'o','blue');
        hold on
        
        elseif  cont_3 > cont_1 && cont_3 > cont_2 && cont_3 > cont_4

        disp('Classificação: 2');
        scatter(d_test(iy,1),d_test(iy,2),'d','green');
        hold on

        else 

        disp('Classificação: 3');
        scatter(d_test(iy,1),d_test(iy,2),'d','c');
        hold on   

        end
    
end


%Acurácia
Ac=(acerto/quant_teste)*100;
X = ['Acurácia: ',num2str(Ac),'%'];
disp(X);    
    

    
    
    
 