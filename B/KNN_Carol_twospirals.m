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
        %Inicialização
        k=9;
        n=0;
        m=0;
        Classe_0=zeros(2,3);
        Classe_1=zeros(2,4);

        %Quantidade de dados
        quant_training=1300;
        quant_teste=700;
        total=2000;

        load('dataset_twospirals.mat')


       %Contadores de acerto e erro
        acerto=0;
        erro=0;

        %Matriz de Confusão
        dim=2;
        M_confu=zeros(dim,dim);
        
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

                Classe_0(:,n)=[x(it,1),y(it,1)];       

            else

                m=m+1;

                Classe_1(:,m)=[x(it,1),y(it,1)]; 

            end

        end


            sorteio_2= sorteio(1,(quant_training+1):end);

            for passo_t=1:quant_teste

                %Dados Treinamento em MATRIZ
                d_test(passo_t,:)=data(sorteio_2(1,passo_t),:);

            end


            %Dados teste
            y_t=d_test(:,1);
            x_t=d_test(:,2);
            Teta_t=d_test(:,3);




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
            
            result_knn(iy,1)=b-1;

            if (b-1)==Teta_t(iy,1)

                acerto=acerto+1;

            else 

                erro=erro+1;        

            end


        end

     Media_M_confu=Media_M_confu+confusionmat(Teta_t,result_knn);
     
     M_confu=confusionmat(Teta_t,result_knn);
            
    prec_l=zeros(2,1);
    revoc_l=zeros(2,1);


    %Precisão
    for itd=1:dim    

        prec_l(dim,:)=M_confu(dim,dim)/sum(M_confu(dim,:));

    end

   
    % Precisão Média
    prec_media(itsimu,:)=sum(prec_l(:,1))/dim;


    
    %Revocação
    for itd=1:dim    

        revoc_l(:,dim)=M_confu(dim,dim)/sum(M_confu(:,dim));

    end


    %Revocação Média
    revoc_media(itsimu,:)=sum(revoc_l(1,:))/dim;
    
    

    %Acurácia
    Ac(itsimu,:)=(acerto/quant_teste)*100;
    


    %Tempo de 1 simulação
     if itsimu==1
       time=toc;  
     end
   
   

end

    %Média 
    M_prec= sum(prec_media)/simu;
    
    M_revoc= sum(revoc_media)/simu;
    
    M_Ac=sum(Ac)/simu;
    
    desvio_M_Ac=std(Ac);
    
    Media_M_confu=Media_M_confu./simu;  
    
    Z = ['Prec Média: ',num2str(M_prec)];
    disp(Z);

    Y = ['Revocação Média: ',num2str(M_revoc)];
    disp(Y);
 
    X = ['Acurácia Média: ',num2str(M_Ac),'%'];
    disp(X);
    
    W = ['Desvio Acurácia: ',num2str(desvio_M_Ac)];
    disp(W);
    
    Resultados=[M_prec;M_revoc;M_Ac;desvio_M_Ac;time];
    

    
 