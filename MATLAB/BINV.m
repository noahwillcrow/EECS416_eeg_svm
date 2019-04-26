%from canvas

function Bnew=BINV(Binv,a,q)
m=length(a);ahat=Binv*a;
if ahat(q)<=0
   Bnew='error ahat(q)<=0';
   return
end
Bnew(q,:)=Binv(q,:)/ahat(q);
for i=1:m
    if i~=q
        Bnew(i,:)=Binv(i,:)-ahat(i)*Bnew(q,:);
    end
end
    