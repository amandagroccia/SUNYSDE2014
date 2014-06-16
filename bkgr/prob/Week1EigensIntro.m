clear all
clc
n=10;
P=[.4 .02; .6 .98];
[V,L]=eig(P); %V is a matrix of eigenvectors, L (lambda) is eigenvalues
invV=inv(V); %finds inverse of V
% P^n = V*(L^n)*invV    = P
Pn=V*(L.^n)*invV %P^n
