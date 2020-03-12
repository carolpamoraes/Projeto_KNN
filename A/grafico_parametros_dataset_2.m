clc
clear all
close all


k=[1	3	5	7	9 11];
prec=[0.491666667	0.479166667	0.470833333	0.425	0.466666667	0.13444];
revoc=[0.414761905	0.425	0.388333333	0.36	0.3025	0.277083333];
Acuracia=[91.11111111	92.77777778	88.88888889	85.55555556	83.88888889	73.88888889];
desvio_Ac=[9.9380799	9.030307788	10.81476141	10.25978352	12.21158495	23.16003593];
tempo=[0.043704	0.043479	0.052515	0.051698	0.068871	0.07230];



figure(1)
subplot(2,1,1)
errorbar(k,Acuracia,desvio_Ac,'LineWidth',[3])
xlabel('(a) k vizinhos','FontSize',15)
ylabel('Acurácia','FontSize',15)
axis([0.5 11.5 60 110])
hold on
subplot(2,1,2)
plot(k,prec,'r','LineWidth',[3])
LineWidth=[3]
hold on
plot(k,revoc,'black','LineWidth',[3])
hold on
plot(k,tempo,'g','LineWidth',[3])
legend('Precisão média','Revogação média','Tempo de 1 simulação')
xlabel('(b) k vizinhos','FontSize',15)
hold off

