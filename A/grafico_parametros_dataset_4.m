clc
clear all
close all


k=[1	3	5	7	9];
prec=[0.49265873	0.479791667	0.466098485	0.432632576	0.449244228];
revoc=[0.430088384	0.437681277	0.428250153	0.427276335	0.396798132];
Acuracia=[96.25	96.125	94.875	93.5	92.875];
desvio_Ac=[2.221308292	2.747606614	3.929895539	4.087851063	4.236045201];
tempo=[0.070049	0.063876	0.076214 0.088479	0.0899070];





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

