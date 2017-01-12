import numpy as np
import pyximport; pyximport.install()
from rainflow import rainflow

a = np.array([0., -1, 1., -1, 1, -1, 1, -1, 0.])
out = rainflow(a)
print(out)
print(np.histogram(out))

