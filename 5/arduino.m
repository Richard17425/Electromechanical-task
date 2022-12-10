%serialportlist("available")    
%寻找串口，因为不同的电脑与Arduino的通信串口不一样，所以要先搜索，然后把下一行代码中的串口改成相应值
s = serialport('COM11',9600); % 定义串口对象
%第二次运行的时候要注释掉，如果第二次执行的时候没有把上面的语句注释，或者没有清除变量s。都会出现错误
counter = 1;
numero_muestras = 36;
data = ones(10e6,1);
fig = figure('Name','Serial communication:Matlab + Arduino');
title('arduino 和 Matlab通信');
xlabel('信号数');
ylabel('信号');
grid on;
hold on;
x = 1:1:10e6;
f = 10;
for i=1:1:10e6
    d = [];
    while isempty(d)
        d = sscanf(readline(s),"sensor: %f",1);
    end
    data(i,1) = d;
    if i>f && mod(i,f) == 1
        flush(s);
        plot(x(i-f:i),data(i-f:i));
        ylim([0,1000]);
        drawnow;      
    end
    pause(0.01);
end
k=0;
