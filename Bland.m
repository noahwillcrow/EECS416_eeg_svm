function [i_neg,i_in]=Bland(A,Bi,rcv,NBV,V)
nnbv=length(rcv);i=1;
while i<=nnbv
    if rcv(i)<-1e-5
        break
    end
    i=i+1;
end
if i>nnbv 
    i_neg=0;i_in=[];
else
    if Bi*A(:,find(V==NBV(i)))<=0
        i_neg=-1;i_in=[];
    else
        i_neg=NBV(i);i_in=i;
    end
end