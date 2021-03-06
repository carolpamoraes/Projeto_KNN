clc
clear all
close all

%Teste KNN
%Inicialização
k=3;
n=0;
m=0;
Classe_0=zeros(2,3);
Classe_1=zeros(2,4);

%Quantidade de dados
quant_training=550;
quant_teste=450;
total=1000;

load('dataset_half.mat')

sorteio=randperm(total);

for passo_tr=1:quant_training

    %Dados Treinamento em MATRIZ
    d_training(passo_tr,:)=data(sorteio(1,passo_tr),:);

end

%Dados Treinamento
y=d_training(:,1);
x=d_training(:,2);
Teta_training= d_training(:,3);



for it=1:quant_teste
    
    if Teta_training(it,1)==0
        
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
    
 cont_classe_0=0;
 cont_classe_1=0;

 [l,c]=sort(d);

for ik=1:k

    a = Teta_training(c(1,ik),1);
    
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
    
    
    %Grafico Teste
    figure(2)
    scatter(Classe_0(2,:),Classe_0(1,:),'.','blue');       
    hold on
    scatter(Classe_1(2,:),Classe_1(1,:),'.','red'); 
    hold on

    if cont_classe_0 > cont_classe_1

    disp('Classificação: 0');
    scatter(d_test(iy,1),d_test(iy,2),'^','blue');
    hold on

    else 

    disp('Classificação: 1');
    scatter(d_test(iy,1),d_test(iy,2),'o','red');
    hold on

    end
    
end


    
%Acurácia
Ac=(acerto/quant_teste)*100;
X = ['Acurácia: ',num2str(Ac),'%'];
disp(X);
    
    
    
 