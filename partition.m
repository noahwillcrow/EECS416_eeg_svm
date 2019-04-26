function [cb,cn,N,B]=partition(A,c,BV,NBV,V)
nb=length(BV);nnb=length(NBV);
for i=1:nb
    k=find(V==BV(i));
    cb(i)=c(k);B(:,i)=A(:,k);
end
for i=1:nnb
    kk=find(V==NBV(i));
    cn(i)=c(kk);N(:,i)=A(:,kk);
end
cb=cb';cn=cn';