import numpy as np
cimport numpy as np

ctypedef np.float64_t CDOUBLE

cdef extern from "./rainflow.h":
    void rainflowc(int n, double *points, double *array_out)

def rainflow(np.ndarray[ndim=1, dtype=CDOUBLE] points):
    cdef int n = points.shape[0]
    cdef np.ndarray[ndim=2, dtype=CDOUBLE] array_out
    array_out = np.zeros((n, 3), dtype=np.float64)
    rainflowc(n, &points[0], &array_out[0, 0])
    return array_out

