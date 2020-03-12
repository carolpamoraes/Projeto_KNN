clc
clear all
close all

%Teste KNN
%Inicialização
k=3;
n=0;
m=0;
M_saudavel=zeros(2,3);
M_doente=zeros(2,4);

%Quantidade de dados
quant_training=15;
quant_teste=10;

%Dados Treinamento
y=[-0.0730400000000000;1.33025900000000;-0.240956000000000;-0.222805000000000;-0.891250000000000;-0.745514000000000;-1.81288800000000;0.402803000000000;-0.0565120000000000;-0.499638000000000;1.63283600000000;-0.431471000000000;0.541344000000000;0.540100000000000;-0.467274000000000];
x=[-0.0688610000000000;0.120024000000000;-0.771250000000000;1.66989500000000;0.803029000000000;-0.100927000000000;-1.10161100000000;1.34972400000000;0.194620000000000;0.587306000000000;0.143140000000000;-0.134760000000000;-0.187588000000000;-2.16838100000000;-0.695636000000000];
Teta_training=[1;1;1;1;2;2;2;1;1;2;1;1;2;2;2];

%Dados Treinamento em MATRIZ
d_training=[y x];

%Contadores de acerto e erro
acerto=0;
erro=0;


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
y_t=[0.880074000000000;-0.529654000000000;-1.07172700000000;-0.940455000000000;-1.61464900000000;0.821424000000000;1.15432100000000;0.752619000000000;0.834107000000000;0.815140000000000];
x_t=[-0.0307330000000000;-0.686936000000000;0.403946000000000;0.239106000000000;0.315854000000000;-0.400639000000000;-0.742815000000000;0.630993000000000;-0.791591000000000;-0.509238000000000];
Teta_t=[1;1;2;2;2;1;1;1;1;1];


%Dados teste em MATRIZ
d_test=[y_t x_t];


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

    

    
    
    
 