%% 频率
Fs = 44100;
Fc=400;
dt=1.0/Fs;
T =1; N=T/dt;
t=[0:N-1]/N;
x1 =sin(2*pi*10*t);
subplot(3,1,1); plot(t,x1); 
axis([0, 0.2, -2,2]);
y1 =pmmod(x1,Fc,Fs,3.14);
subplot(3,1,2);plot(t,y1); 
axis([0, 0.2, -2,2]);
y2=pmdemod(y1,Fc,Fs,3.14);
subplot(3,1,3);plot(t,y2); 
axis([0, 0.2, -2,2]);

% %% 
% Fs = 44100;
% dt=1.0/Fs;
% T =1;
% N=T/dt;
% t=[0:N-1]/N;
% x1 =sin(2*pi*10*t)+1.3;
% y1 = ammod(x1,400,Fs);   %幅值调制
% P=fft(y1,N);
% Pyy =2*sqrt(P.* conj(P))/N;
% f=linspace(0,Fs/2,N/2);
% Pdb =20*log10(Pyy);
% plot(f,Pdb(1:N/2));
% y1=fmmod(x1,400,Fs,200);   %相位调制
% P=fft(y1,N);
% Pyy =2*sqrt(P.* conj(P))/N;
% f=linspace(0,Fs/2,N/2);
% Pdb =20*log10(Pyy);
% plot(f,Pdb(1:N/2));
