%%  谱阵算法的实现过程 (自编算法
Fs=40960; dt=1.0/Fs; T=4; N=T/dt; 
x=linspace(0,T,N);
y =0.5*chirp(x,20,T,500,'li');
t=linspace(0,T,N); 
figure; plot(t,y,'LineWidth',1);
N1=4096; M=N/N1;
bb=zeros(M,N1);
figure;
view(5,76); 
for i=1:M
k=1+(i-1)*N1;
y1=y(k:k+N1-1); % 截断
A1=abs(fft(y1)); % 局部谱
bb(i,:)=A1; % 保存
mesh(bb); % 显示
xlim([0,300]); 
pause(1);
end

%%  窗长的影响

Fs = 5120.0;
N=32768;
dt=1.0/Fs; 
df=(500.0/N);
T=dt*N;
t=linspace(0,T,N);

for i = 1:8192
x(i) =sin(2*pi*200*i*dt);
x(i+8192) =sin(2*pi*400*i*dt);
x(i+16384) =sin(2*pi*600*i*dt);
x(i+24576) =sin(2*pi*800*i*dt); 
end 
Len=1024; Ove=Len/2;
Z=spectrogram(x,Len,Ove);
P=20*log10(sqrt(Z.* conj(Z)));
[NN,MM]=size(P);
X=linspace(0,Fs/2, NN);
Y=linspace(0,dt*N, MM);
mesh(X,Y,P');
view(15,70);


%%  调频调幅波信号
Fs = 5120; N=32768; 
dt=1.0/Fs; T=dt*N; 
t=linspace(0,T,N);
x1=sin(2*pi*0.31*t);
x2=chirp(t,20,T,1500,'lo');
x=x1.*x2;
subplot(2,1,1);
plot(t,x); 
Z=spectrogram(x,1024,512);
P=sqrt(Z.* conj(Z));
[NN,MM]=size(P);
X=linspace(0,Fs/2,NN);
Y=linspace(0,dt*N,MM);
subplot(2,1,2);
mesh(X,Y,P'); 
view(15,70);

%%  语音文件语谱图分析  (暂时不行)

clear; clc;
[y,fs] = audioread("sunnyday.aac");
subplot(2,1,1);
plot(y);
subplot(2,1,2);
spectrogram(y,2048,fs,2048,1000);


%%  语谱图+音调分析
clear;clc;
[y,fs] = audioread('sunnyday.aac');
%sound(y,fs);
N=length(y);
winLength = round(0.05*fs);
overlapLength = round(0.045*fs);
dt=1.0/fs;
t=linspace(0,N*dt,N);
subplot(3,1,1);
plot(t,y);
subplot(3,1,2);
y1=y(:,1);
spectrogram(y1,2048,120,2048,1000);  %y,
[f0,idx] = pitch(y,fs,'Method','SRH','WindowLength',winLength,'OverlapLength',overlapLength);
tf0 = idx/fs;
hr = harmonicRatio(y,fs,"Window",hamming(winLength,'periodic'),"OverlapLength",overlapLength);
threshold = 0.9;
f0(hr < threshold) = nan;
subplot(3,1,3);
plot(tf0,f0,'linewidth',1.5)


%% 谱阵分析

clear;clc;
[y,fs] = audioread('sunnyday.aac');
%sound(y,fs);
N=length(y);
winLength = round(0.05*fs);
overlapLength = round(0.045*fs);
dt=1.0/fs;
t=linspace(0,N*dt,N);
subplot(3,1,1);
plot(t,y);
subplot(3,1,2);
y1=y(:,1);
spectrogram(y1,2048,120,2048,1000);  %y,

Z=spectrogram(y1,1024,512);
P=sqrt(Z.* conj(Z));
[NN,MM]=size(P);
X=linspace(0,fs/2,NN);
Y=linspace(0,dt*N,MM);

ax2=subplot(3,1,3);
%ax2=nexttile;
xlim(ax2,[0 40]);
ylim(ax2,[0 3000]);
mesh(ax2,X,Y,P');
view(35,75);


