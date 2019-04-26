function [rcv,y]=rcc(Binv,N,cb,cn)
y=cb'*Binv;
rcv=cn'-y*N;