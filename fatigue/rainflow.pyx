import numpy as np
cimport numpy as np

ctypedef np.float64_t CDOUBLE

cdef extern from "./rainflow.h":
    void rainflowc(int n, double *points, double *array_out)


cdef np.ndarray[ndim=1, dtype=CDOUBLE] sig2ext(np.ndarray[ndim=1, dtype=CDOUBLE] sig):
    cdef int dt=1
    cdef np.ndarray[ndim=1, dtype=CDOUBLE] w1, ext
    w1 = np.diff(sig)
    test = (w1[:-1]*w1[1:]) <= 0
    test[0] = True
    test[-1] = True
    ext = sig[test]
    w1 = np.diff(ext)
    test = (w1[:-1]==0) & (w1[1:]==0)
    test[0] = False
    test[-1] = False
    ext = w1[~test]

    test = ext[:-1]==ext[1:]
    test[0] = False
    test[-1] = False
    ext = ext[~test]
    if ext.shape[0] > 2:
        w1 = np.diff(ext)
        ext = w1[(w1[:-1]*w1[1:]) < 0]
    return ext


def rainflow(np.ndarray[ndim=1, dtype=CDOUBLE] points):
    cdef np.ndarray[ndim=1, dtype=CDOUBLE] ext
    cdef np.ndarray[ndim=2, dtype=CDOUBLE] array_out
    print(points)
    ext = sig2ext(points)
    print(ext)
    cdef int n = ext.shape[0]
    array_out = np.zeros((n, 3), dtype=np.float64)
    rainflowc(n, &ext[0], &array_out[0, 0])
    return array_out

