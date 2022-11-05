function soundtest()
timeLength=0.1;                        % 采样时长，单位秒
samples=timeLength*44100;              % 默认采样率44100，计算采样点数
H = audioDeviceReader(...
    'NumChannels'   , 1 ,...               % 1 个通道
    'DeviceDataType', 'Default',...        % 16位采样                  %'OutputNumOverrunSamples',true,...     % 启用溢出标志
    'SamplesPerFrame', samples);           % 采样点数
[audioIn,~] = step(H);                     % 第一次采样
%创建图表
figure('Name','实时频谱图','MenuBar','none','ToolBar','none','NumberTitle','off');
xdata=(1:1:samples/2)*timeLength;
axes1= subplot(1,3,1);
axes2= subplot(1,3,2);
axes3= subplot(1,3,3);
pic  = plot(axes1, 1:1:samples, audioIn);    % 初始化音频波形图
pic2 = bar(axes2,xdata, xdata*0);           % 初始化频谱图
pic3 = plot(axes3,xdata,xdata*0);           %初始化窗函数频谱图
set(axes1,'xlim', [0 samples], 'ylim',[-1 1] ...
    ,'XTick',[],'YTick',[-1:0.5:1] );
set(axes2,'xlim', [min(xdata) max(xdata)], 'ylim',[0 4] , ...
    'xscale','log','XTick',[1 10 100 1e3 1e4],'YTick',[0:1:6] );
set(axes3,'xlim', [min(xdata) max(xdata)], 'ylim',[0 4], ...
    'xscale','log','XTick',[1 10 100 1e3 1e4]);
xlabel(axes2,'Frequency (Hz)','Position',[4.0 -0.4]);
xlabel(axes1,'Wave');
xlabel(axes3,'Hanningwindow');
%确定图表位置
set(gcf,'Position',[200,50,600,600]);
axes2.Position=[0.045 0.71 0.92 0.25];   % 左，下，宽度，高度
axes1.Position=[0.045 0.37 0.92 0.25];
axes3.Position=[0.045 0.08 0.92 0.25];
grid(axes1,'on');grid(axes2,'on');grid(axes3,'on');
drawnow;

while 1
    [audioIn,Overrun] = step(H);        % 采样
    if Overrun > 0
        warning('数据溢出 %d 位\n',Overrun);
    end
    ydata_fft=fft(audioIn);                 % 傅里叶变换
    ydata_abs=abs(ydata_fft(1:samples/2));  % 取绝对值
    A=mean(abs(audioIn));
    title(axes1,['\bf A:',num2str(A)]);  %'\bf F: ',num2str(y),' Hz',
    title(axes2,'\bf Fs:44100Hz N=44100 df=1Hz');
%     %加窗函数
%     N=length(audioIn);
%     w2=hanning(N);
%     % w3=w2';
%     z=w2.*audioIn;
%     y2=fft(z);
%     A2=2.*abs(y2)./(N/2);
    set(pic, 'ydata',audioIn);                           % 更新波形图数据
    set(pic2, 'ydata',log10(ydata_abs));                 % 更新频谱图数据
    set(pic3,'ydata',ydata_abs);     %更新窗函数处理后的频谱图 log10((A2(1:length(A2)/2,1)))
    drawnow;                                             % 刷新
end
end