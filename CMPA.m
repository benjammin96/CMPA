%%
clear all
close all

V= linspace(-1.95,0.7,200);
Is=0.01E-12;
Ib=0.1E-12;
Vb=1.3;
Gp=0.1;
I = Is*(exp(1.2/0.025*V) -1) + Gp*V - Ib*(exp((-1.2/0.025*(V+Vb)))-1);

for i =1:length(V)
    I2(i)=I(i)+I(i)*(rand()*0.4 -0.2);
end

figure(1)
plot(I)
figure(2)
plot(I2)
figure(3)
semilogy(I)
figure(4)
semilogy(I2)
%%
p=polyfit(V,I,4);
p1=polyfit(V,I2,8);
f=polyval(p,V);
f1=polyval(p1,V);

figure(5)
plot(f)
figure(6)
plot(f1)
%%

fo = fittype('A.*(exp(1.2*x/25e-3)-1) + Gb.*x - C*(exp(1.2*(-(x+Vb))/25e-3)-1)');
Vnew=V';
Inew=I';
ff=fit(Vnew,Inew,fo);
If = ff(V);
figure(7)
plot(If);

%%
inputs = V;
targets = I;
hiddenLayerSize = 10;
net = fitnet(hiddenLayerSize);
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
[net,tr] = train(net,inputs,targets);
outputs = net(inputs);
errors = gsubtract(outputs,targets);
performance = perform(net,targets,outputs)
view(net)
Inn = outputs;
figure(8)
plot(Inn)
