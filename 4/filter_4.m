%% 频域低通滤波

Fs = 2048; dt=1.0/Fs; T =1; 
N=T/dt; t=[0:N-1]/N;
x =sin(2*pi*50*t)+sin(2*pi*300*t) + sin(2*pi*500*t);
subplot(3,1,1); plot(t,x);
axis([0, 0.1, -2,2]);
X=fft(x,N);
P =2*abs(X)/N;
f=linspace(0,Fs/2,N/2);
subplot(3,1,2); plot(f,P(1:N/2));
df=Fs/N;
Fh=150; kh=floor(Fh/df);
H=ones(1,N);
for k=kh:N-kh+1      %去掉相关频率
H(k)=0;
end
Y=X.*H;
y = ifft(Y);
subplot(4,1,4); plot(t,y);
axis([0,0.1,-2,2]);

%% 带通滤波器
Fs = 2048; dt=1.0/Fs; T=1; 
N=T/dt; t=[0:N-1]/N;
x =sin(2*pi*50*t)+sin(2*pi*300*t) + sin(2*pi*500*t);
subplot(3,1,1); plot(t,x);axis([0, 0.1, -2,2]);
X=fft(x,N); P =2*abs(X)/N;
f=linspace(0,Fs/2,N/2); subplot(3,1,2); 
plot(f,P(1:N/2)); df=Fs/N;
Fl=200; kl=floor(Fl/df);   %FL 为限制频率下限
Fh=400; kh=floor(Fh/df);   %Fh 为限制频率上限
H=ones(1,N);
for k=1:kl
H(k)=0;
end
for k=N-kl+1:N
H(k)=0;
end
for k=kh:N-kh+1    %去掉对称部分的频率
H(k)=0;
end
Y=X.*H; y = ifft(Y);
subplot(4,1,4); plot(t,y); 
axis([0, 0.1, -2,2]);


%% 时域FIR滤波器

Fs = 5120; dt=1.0/Fs; 
N=4096; T=dt*N; 
t0=linspace(0,T,N);
x=sin(2*pi*20*t0)+sin(2*pi*60*t0)+sin(2*pi*120*t0)+sin(2*pi*200*t0);
subplot(3,1,1);
plot(t0,x,'linewidth',1);
%Morlet Wavelet Filter
Fc=20;
t1=linspace(-T/2,T/2,N);
f0=5/(2*pi); nn=Fc/f0;
x1=cos(2*pi*nn*f0*t1);
x2=exp(-nn*nn*t1.*t1/2);
wt=x1.*x2;
subplot(3,1,2);
plot(t1,wt,'r','linewidth',1);
y = conv(x,wt);
N1=length(y);
y=y(N/2:N+N/2-1); 
subplot(3,1,3);
plot(t0,y,'r','linewidth',1);

