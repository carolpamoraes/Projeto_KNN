tic
tempo=tic;

clc
clear all
close all



%Inicialização   
k=1;
n=0;
m=0;
M_saudavel=zeros(2,3);
M_doente=zeros(2,4);


%Quantidade de dados
quant_training=12;
quant_teste=8;
total=20;


%Contadores de acerto e erro
acerto=0;
erro=0;

%Matriz de Confusão
dim=2;
M_confu=zeros(dim,dim);

load('dataset1.txt')

sorteio=randperm(total);

    for passo_tr=1:quant_training

        %Dados Treinamento em MATRIZ
        d_training(passo_tr,:)=dataset1(sorteio(1,passo_tr),:);

    end

    %Dados Treinamento
    y=d_training(:,1);
    x=d_training(:,2);
    Teta_training= d_training(:,3);



    for it=1:quant_training

        if Teta_training(it,1)==2

            n=n+1;

            M_saudavel(:,n)=[x(it,1),y(it,1)];       

        else

            m=m+1;

            M_doente(:,m)=[x(it,1),y(it,1)]; 

        end

    end

    sorteio_2= sorteio(1,(quant_training+1):end);

    for passo_t=1:quant_teste

        %Dados Treinamento em MATRIZ
        d_test(passo_t,:)=dataset1(sorteio_2(1,passo_t),:);

    end


    %Dados teste
    y_t=d_test(:,1);
    x_t=d_test(:,2);
    Teta_t=d_test(:,3);


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

      
        cont=[cont_d cont_s];

        %Quantidade de acertos
        [~,b]=max(cont);

        if b==Teta_t(iy,1)

            acerto=acerto+1;
            
            if b==1
                
                M_confu(1,1)=M_confu(1,1)+1;
            else
                M_confu(2,2)=M_confu(2,2)+1;
                
            end
              
                

        else 

            erro=erro+1;  
            
            if b==1
                
                M_confu(1,2)=M_confu(1,2)+1;
            else
                M_confu(2,1)=M_confu(2,1)+1;
                
            end

        end


%         %Grafico Teste
%         figure(2)
%         scatter(M_doente(1,:),M_doente(2,:),'.','red');    
%         hold on
%         scatter(M_saudavel(1,:),M_saudavel(2,:),'.','blue');
%         hold on
% 
%         if cont_d > cont_s
% 
%         disp('Classificação: 1');
%         scatter(d_test(iy,2),d_test(iy,1),'^','red');
%         hold on
% 
%         else 
% 
%         disp('Classificação: 2');
%         scatter(d_test(iy,2),d_test(iy,1),'o','blue');
%         hold on
% 
%         end

    end
       
    
%Precisão
for itd=1:dim    
    
    prec_l(dim,:)=M_confu(dim,dim)/sum(M_confu(dim,:));

end

% Precisão Total
prec_total=sum(prec_l(:,1))/dim;

Z = ['Prec Média: ',num2str(prec_total)];
disp(Z);

%Revocação
for itd=1:dim    
    
    revoc_l(:,dim)=M_confu(dim,dim)/sum(M_confu(:,dim));

end


%Revocação Total
revoc_total=sum(revoc_l(1,:))/dim;
Y = ['Revocação Média: ',num2str(revoc_total)];
disp(Y); 


%Acurácia
Ac=(acerto/quant_teste)*100;
X = ['Acurácia: ',num2str(Ac),'%'];
disp(X);    



toc
