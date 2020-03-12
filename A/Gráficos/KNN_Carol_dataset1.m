clc
clear all
close all

%Teste KNN
%Inicialização
k=5;
n=0;
m=0;
M_saudavel=zeros(2,3);
M_doente=zeros(2,4);

%Quantidade de dados
quant_training=12;
quant_teste=8;

%Dados Treinamento
y=[5.43985200000000;5.81988300000000;4.32097200000000;5.07111900000000;5.21587400000000;-5.08924500000000;-5.00957700000000;-4.59116600000000;-5.63482500000000;-4.88205400000000;-5.00920900000000;-5.23341300000000];
x=[-0.277979000000000;-0.0188670000000000;0.396589000000000;-0.00566800000000000;-0.484750000000000;0.0896420000000000;-0.773319000000000;-0.248177000000000;0.0768960000000000;0.140839000000000;-0.410600000000000;0.607227000000000];
Teta_training=[1;1;1;1;1;2;2;2;2;2;2;2];

%Dados Treinamento em MATRIZ
d_training=[y x];



for it=1:quant_training
    
    if Teta_training(it,1)==2
        
        n=n+1;

        M_saudavel(:,n)=[x(it,1),y(it,1)];       

    else
        
        m=m+1;

        M_doente(:,m)=[x(it,1),y(it,1)]; 

    end
    
end

%Grafico Treinamento
figure(1)
scatter(M_saudavel(1,:),M_saudavel(2,:),'o','blue');
hold on
scatter(M_doente(1,:),M_doente(2,:),'^','green');
hold off


%Dados teste
y_t=[4.26617700000000;4.91491400000000;4.65611200000000;5.20009800000000;4.58300800000000;-4.92794900000000;-4.78798700000000;-5.34179600000000];
x_t=[0.0361680000000000;-0.511141000000000;-0.502988000000000;0.0442960000000000;-0.673976000000000;0.946253000000000;-0.711671000000000;-0.604879000000000];
Teta_t=[1;1;1;1;1;2;2;2];

%Dados teste em MATRIZ
d_test=[y_t x_t];

%Contadores de acerto e erro
acerto=0;
erro=0;

for iy=1:quant_teste
    
    for ix=1:quant_training
        
        d(:,ix)=norm(d_test(iy,:)-d_training(ix,:));
        
    end
    
     cont_d=0;
 cont_s=0;

[l,c]=sort(d);

for ik=1:k

    a = Teta_training(c(1,ik),1);
    
    
    if a==1
        
        cont_d=cont_d+1;
        
    else
        
        cont_s=cont_s+1;
        
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
    scatter(M_doente(1,:),M_doente(2,:),'+','red');    
    hold on
    scatter(M_saudavel(1,:),M_saudavel(2,:),'.','blue');
    hold on

    if cont_d > cont_s

    disp('Classificação: 1');
    scatter(d_test(iy,2),d_test(iy,1),'^','red');
    hold on

    else 

    disp('Classificação: 2');
    scatter(d_test(iy,2),d_test(iy,1),'o','blue');
    hold on

    end
    
end


%Acurácia
Ac=(acerto/quant_teste)*100;
X = ['Acurácia: ',num2str(Ac),'%'];
disp(X);

    
    
    
 