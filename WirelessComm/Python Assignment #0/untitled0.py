import numpy as np
import numpy.random as nr
import matplotlib.pyplot as plt
nSamples=10000000;
h= (nr.normal(0,1,nSamples)+1j*nr.normal(0,1,nSamples))/np.sqrt(2);
#h= (nr.normal(0,1/np.sqrt(2),nSamples)+1j*nr.normal(0,1/np.sqrt(2),nSamples)); both same
a= np.abs(h);
phi = np.angle(h);

nbins=1000;
#plt.figure(1)

#plt.tight_layout()

plt.subplot(1,2,1)
plt.hist(a, nbins, density=True)
plt.suptitle('Amplitude PDF')
plt.xlabel('x')
plt.ylabel('$f_A$(a)')


plt.subplot(1,2,2)
plt.hist(phi, nbins, density=True)
#plt.suptitle('Phase PDF')
plt.xlabel('$\phi$')
plt.ylabel('$f_\Phi(\phi)$')
plt.tight_layout()
#End of histogram
#Actual Rayleigh


