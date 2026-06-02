import sys
import socket
import numpy as np
import pandas as pd
import sklearn
import matplotlib

print("Python executable:", sys.executable)
print("Python version:", sys.version)
print("Node:", socket.gethostname())

print("numpy:", np.__version__)
print("pandas:", pd.__version__)
print("sklearn:", sklearn.__version__)
print("matplotlib:", matplotlib.__version__)

print("Basic calculation:", np.mean([1, 2, 3, 4, 5]))
print("Environment test succeeded.")