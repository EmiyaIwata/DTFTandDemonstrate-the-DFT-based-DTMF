clc
[h,Fs]=audioread('test.wav');%�����źţ������ʺͲ���λ����
h=h(:,1);
t=1:length(h);
plot(t,h);