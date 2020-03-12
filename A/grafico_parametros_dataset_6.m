clc
clear all
close all


k=[1	3	5	7	9];

prec=[0.332142857	0.330555556	0.333333333	0.332142857	0.333333333];
revoc=[0.325424298	0.327956765	0.327380414	0.323803326	0.324400599];
Acuracia=[99.125	99	98.5	96.5	97.125];
desvio_Ac=[1.223401212	1.256561725	2.206449875	2.486807296	2.18773495];
tempo=[0.148405	0.295844	0.215746	0.185747	0.187800];






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

