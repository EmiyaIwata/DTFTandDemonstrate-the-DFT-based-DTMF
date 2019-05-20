%�������
Fs=100000;%sampling rate ������
Fstop=25000;%stopband frenquency ���Ƶ��
Fcutoff=15000;%cutoff frequency 0.3db��ֹƵ��
dBcutoff=0.3;%0.3dB at cutoff frequency 0.3db 
dBstop=45;%a minimum stopband attenuation of 45dB��С���˥��45dB
Wstop=2*pi*Fstop/Fs;
Wcutoff=2*pi*Fcutoff/Fs;
%----------�����˲���ָ��ת��Ϊģ���˲���ָ��----------
%T=2;
OMEGAstop=tan(Wstop/2);
OMEGAcutoff=tan(Wcutoff/2);
%----------------------��ź�A----------------------------
a=sqrt((10^(dBcutoff/20))^2-1);
A=10^(dBstop/20);
%--------------���ȱȺͷֱ����----------------------------
k=(OMEGAcutoff)/(OMEGAstop);
k1=a/sqrt(A^2-1);
%-----------------��N����----------------------------------
N=log(1/k1)/log(1/k);
N=ceil(N);%����ȡ��
%-----------------���ֹƵ��Wc-----------------------
Wc=OMEGAstop/((A^2-1)^(1/(2*N)));
%------------------����˲���----------------------------
[z,p,K]=buttap(N);%��ư�����˹ģ���˲���
[num,den]=zp2tf(z,p,K); % Convert to transfer function formת��Ϊ���亯��
den=den.*(1/Wc).^(N:-1:0);%���˲�����ֹƵ���Ƶ�Wc����ȷ����ĸ
[z,p,K]=tf2zp(num,den);%���ݷ��ӷ�ĸȷ���㼫��
[zd,pd,kd]=bilinear(z,p,K,1/2);%˫���Բ��䷨�任
[num2,den2]=zp2tf(zd,pd,kd);%ȷ�����亯�����ӷ�ĸ
[h,w]=freqz(num2,den2,512);%���Ƶ��Ӧ
figure(1);
plot(w/pi,20*log10(abs(h)));
grid;
axis([0,1,-60,5]);
xlabel('\omega/\pi');
ylabel('Gain, dB');
title('Gain response');
figure(2);
plot(w/pi,unwrap(angle(h)));
grid;
axis([0,1,-16,1]);
xlabel('\omega/\pi'); 
ylabel('Phase, radians');
title('Phase response');