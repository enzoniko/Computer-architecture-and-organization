max = 4
A = []
B = []
# Construir Matriz A
for i in range(max):
    t = []
    for j in range(max):
        t.append(i+j)
    A.append(t)

# Construir Matriz B
for i in range(max):
    t = []
    for j in range(max):
        t.append(i+j)
    B.append(t)

print(A)
print(B)

# Algoritmo que multiplica a matriz A pela transposta de B
for i in range(max):
    for j in range(max):
        A[i][j] = A[i][j] + B[j][i]
    
print(A)    