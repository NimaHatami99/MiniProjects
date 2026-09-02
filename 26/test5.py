import timeit
import numpy as np
N = 3000

def func(i, j):
    return i + j

def a():
    return np.fromfunction(lambda i, j: func(i, j), (N, N), dtype=float)
def b():
    a = np.zeros((N, N), float)
    for i in range(N):
        for j in range(N):
            a[i, j] = func(i, j)
    return a
at = timeit.timeit('a()', number=10, setup="from __main__ import a")
bt = timeit.timeit('b()', number=10, setup="from __main__ import b")
print(at, bt)
print(a()==b())