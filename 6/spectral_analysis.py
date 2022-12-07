# 第一种方法
""" import numpy as np
import matplotlib.pyplot as plt
from scipy.fft import fft, fftfreq

# 采样频率
fs = 1e2

# 生成信号
t = np.arange(0, 10, 1/fs); N = len(t)
# y = 10*np.sin(20*2*np.pi*t)
y = 10*np.sin(20*2*np.pi*t) + 20*np.sin(30*2*np.pi*t)

# 傅里叶变换
yf = fft(y)
xf = fftfreq(N, 1/fs)[:N//2]

# 画图
plt.plot(xf, 2.0/N * np.abs(yf[0:N//2]))
plt.xlabel('Frequency (B:Hz)');   plt.ylabel('Amplitude (A)')
plt.grid();     plt.show() """


# 第二种方法（虽然也不太行

""" import numpy as np#导入一个数据处理模块
import pylab as pl#导入一个绘图模块，matplotlib下的模块

sampling_rate = 8000         #采样频率为8000Hz
fft_size = 256               #FFT处理的取样长度
t = np.arange(0, 1.0, 1.0/sampling_rate)#np.arange(起点，终点，间隔)产生1s长的取样时间
x = np.sin(2*np.pi*150*t) + 2*np.sin(2*np.pi*230*t)#两个正弦波叠加，150HZ和230HZ
xs = x[:fft_size]                    # 从波形数据中取样fft_size个点进行运算
xf = np.fft.rfft(xs)/fft_size
freqs = np.linspace(0, int(sampling_rate/2), int(fft_size/2+1))
# np.linspace(start, stop, num=50, endpoint=True, retstep=False, dtype=None)
#在指定的间隔内返回均匀间隔的数字
xfp = np.log10(np.clip(np.abs(xf), 1e-20, 1e150))+3

#绘图显示结果
pl.figure(figsize=(8,4))
pl.subplot(211)
pl.plot(t[:fft_size], xs)
pl.xlabel(u"Time(S)")
pl.title(u"150Hz and 230Hz WaveForm And Freq")
pl.subplot(212)
pl.plot(freqs, xfp)
pl.xlabel(u"Freq(Hz)")
pl.subplots_adjust(hspace=0.4)
pl.show() """

from scipy.fftpack import fft, fftshift, ifft
from scipy.fftpack import fftfreq
import numpy as np
import matplotlib.pyplot as plt
# matplotlib inline

"""
t_s:采样周期
t_start:起始时间
t_end:结束时间
"""
t_s = 0.01
t_start = 0.5
t_end = 5
t = np.arange(t_start, t_end, t_s)

f0 = 5
f1 = 20

# 绘制图表
plt.figure(figsize=(10, 12))

# 构建原始信号序列
y = 1.5*np.sin(2*np.pi*f0*t) + 3*np.sin(2*np.pi*20*t) + np.random.randn(t.size)
ax=plt.subplot(511)
ax.set_title('original signal')
plt.tight_layout()
plt.plot(y)

"""
FFT(Fast Fourier Transformation)快速傅里叶变换
"""
Y = fft(y)
ax=plt.subplot(512)
ax.set_title('fft transform')
plt.plot(np.abs(Y))

"""
Y = fftshift(X) 通过将零频分量移动到数组中心，重新排列傅里叶变换 X。
"""
shift_Y = fftshift(Y)
ax=plt.subplot(513)
ax.set_title('shift fft transform')
plt.plot(np.abs(shift_Y))

"""
得到正频率部分
"""
pos_Y_from_fft = Y[:Y.size//2]
ax=plt.subplot(514)
ax.set_title('fft transform')
plt.tight_layout()
plt.plot(np.abs(pos_Y_from_fft))

"""
直接截取 shift fft结果的前半部分
"""
pos_Y_from_shift = shift_Y[shift_Y.size//2:]
ax=plt.subplot(515)
ax.set_title('shift fft cut')
plt.plot(np.abs(pos_Y_from_shift))
plt.show()