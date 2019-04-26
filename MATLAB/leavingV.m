%from canvas

function q=leavingV(Bi,A,b,p,V)
m=length(b);minratio=1e6;
bhat=Bi*b;
ahat=Bi*A(:,find(V==p));
q=0;
for i=1:m
    if ahat(i)>0
        ratio=bhat(i)/ahat(i);
        if minratio>ratio
            minratio=ratio;
            q=i;
        end
    end
end