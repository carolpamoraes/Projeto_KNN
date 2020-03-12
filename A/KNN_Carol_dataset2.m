tic
tempo=tic;

clc
clear all
close all

itsimu=0;
simu=20;
Media_M_confu=zeros(2,2);

for itsimu=1:simu

    %Teste KNN
    %Inicializa��o
    k=3;
    n=0;
    m=0;
    M_saudavel=zeros(2,3);
    M_doente=zeros(2,4);

    %Quantidade de dados
    quant_training=16;
    quant_teste=9;
    total=25;

    %Contadores de acerto e erro
    acerto=0;
    erro=0;

    %Matriz de Confus�o
    dim=2;
    M_confu=zeros(dim,dim);

    load('dataset2.txt')

    sorteio=randperm(total);

        for passo_tr=1:quant_training

            %Dados Treinamento em MATRIZ
            d_training(passo_tr,:)=dataset2(sorteio(1,passo_tr),:);

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
            d_test(passo_t,:)=dataset2(sorteio_2(1,passo_t),:);

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


    end
    
    prec_l=zeros(2,1);
    revoc_l=zeros(2,1);


    %Precis�o
    for itd=1:dim    

        prec_l(dim,:)=M_confu(dim,dim)/sum(M_confu(dim,:));

    end

   
    % Precis�o M�dia
    prec_media(itsimu,:)=sum(prec_l(:,1))/dim;


    
    %Revoca��o
    for itd=1:dim    

        revoc_l(:,dim)=M_confu(dim,dim)/sum(M_confu(:,dim));

    end


    %Revoca��o M�dia
    revoc_media(itsimu,:)=sum(revoc_l(1,:))/dim;
    
    

    %Acur�cia
    Ac(itsimu,:)=(acerto/quant_teste)*100;
    

     Media_M_confu=Media_M_confu+M_confu;
     
  
   
    %Tempo de 1 simula��o
     if itsimu==1
       time=toc;  
     end
    
end
    
    %m�dia 
    M_prec= sum(prec_media)/simu;
    
    M_revoc= sum(revoc_media)/simu;
    
    M_Ac=sum(Ac)/simu;
    
    Media_M_confu=Media_M_confu./simu;
    
    desvio_M_Ac=std(Ac);
    
    Z = ['Prec M�dia: ',num2str(M_prec)];
    disp(Z);

    Y = ['Revoca��o M�dia: ',num2str(M_revoc)];
    disp(Y);
 
    X = ['Acur�cia M�dia: ',num2str(M_Ac),'%'];
    disp(X);
    
    W = ['Desvio Acur�cia: ',num2str(desvio_M_Ac)];
    disp(W);
    
    Resultados=[M_prec;M_revoc;M_Ac;desvio_M_Ac];
    
    