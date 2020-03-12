clc
clear all
close all


k=[1	3	5	7	9];
prec=[0.495328803	0.485849171	0.460283237	0.441028076	0.445647348];
revoc=[0.5	0.496592968	0.497166804	0.498528139	0.499193548];
Acuracia=[99.5	98.16666667	95.58333333	93.08333333	93.75];
desvio_Ac=[0.78360391	2.016017729	3.757059632	3.165743171	2.529070744];
tempo=[0.086128	0.065834	0.070755	0.062287	0.063106];




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

