from scipy.fftpack import fft, fftshift, ifft
from scipy.fftpack import fftfreq
import numpy as np
import matplotlib.pyplot as plt
# matplotlib inline

t_s = 0.01   #采样周期
t_start = 0.5  #起始时间
t_end = 5     #结束时间
t = np.arange(t_start, t_end, t_s)

f0 = 5
f1 = 30

# 绘制图表
plt.figure(figsize=(10, 8))
# 构建原始信号序列
y = 1.5*np.sin(2*np.pi*f0*t) + 3*np.sin(2*np.pi*f1*t) + np.random.randn(t.size)
ax=plt.subplot(211)
ax.set_title('original signal')
plt.xlabel(u" ")
plt.tight_layout()
plt.plot(y)

# FFT(Fast Fourier Transformation)快速傅里叶变换

Y = fft(y)
ax=plt.subplot(212)
ax.set_title('fft transform')
plt.plot(np.abs(Y)/210)
plt.xlabel(u"Freq(Hz)")
plt.xlim(right=300)
plt.gcf().subplots_adjust(bottom=0.07)
plt.show()