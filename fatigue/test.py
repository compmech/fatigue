import numpy as np
import pyximport; pyximport.install()
from rainflow import rainflow

print(rainflow(np.array([0, 1, 2, 1, 2, 0.])))
