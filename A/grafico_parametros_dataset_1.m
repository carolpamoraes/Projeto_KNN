clc
clear all
close all


k=[1	3	5	7	9];
prec=[0.5	0.5	0.5	0.5	0.5];
revoc=[0.5	0.5	0.5	0.5	0.5];
Acuracia=[100	100	100	100	100];
desvio_Ac=[	0	0	0	0	0];
tempo=[0.058784	0.059110	0.072898	0.080400	0.109716];


figure(1)
subplot(2,1,1)
errorbar(k,Acuracia,desvio_Ac,'LineWidth',[3])
xlabel('(a) k vizinhos','FontSize',15)
ylabel('Acurácia','FontSize',15)
axis([1 9 80 110])
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

