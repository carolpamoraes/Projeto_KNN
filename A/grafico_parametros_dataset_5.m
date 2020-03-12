clc
clear all
close all


k=[1	3	5	7	9];
prec=[0.333333333	0.333333333	0.333333333	0.333333333	0.333333333];
revoc=[0.333333333	0.333333333	0.333333333	0.333333333	0.333333333];
Acuracia=[100	100	100	100	100];
desvio_Ac=[0	0	0	0	0];
tempo=[0.064894	0.052943	0.057329	0.064670	0.064894];






figure(1)
subplot(2,1,1)
errorbar(k,Acuracia,desvio_Ac,'LineWidth',[3])
xlabel('(a) k vizinhos','FontSize',15)
ylabel('Acurácia','FontSize',15)
axis([0.5 9.5 60 110])
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

