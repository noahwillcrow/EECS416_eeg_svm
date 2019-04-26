%from canvas

function [x,y,z,iter]=rsimplex(A0,b0,c0,o_sign,c_GE,c_E,v_neg,v_free)

[A1,b1,c1,BV0,NBV0,AV]=S_form(A0,b0,c0,o_sign,c_GE,c_E,v_neg,v_free);
V=[1:length(c1)];

if length(AV)>0
    [BV,NBV,Bi,A,b,c,V]=phase1(A1,b1,c1,BV0,NBV0,AV,V);
else
    BV=BV0;NBV=NBV0;A=A1;b=b1;c=c1;Bi=eye(length(b1));V=V;
end

[m,n]=size(A);opt=0;iter=1;
[cb,cn,N]=partition(A,c,BV,NBV,V);

while opt==0
    [rcv,y]=rcc(Bi,N,cb,cn);
    [p,i_in]=Bland(A,Bi,rcv,NBV,V);
    if p==-1
        z='unbounded solution';
        x=[];y=[];opt=1;
    elseif p==0
        xb=Bi*b;z=cb'*xb;y=y';x=zeros(n,1);
        for i=1:m
            x(BV(i))=xb(i);
        end
        opt=1;
    else
        q=leavingV(Bi,A,b,p,V);
        NBV(i_in)=BV(q);BV(q)=p;;
        cn(i_in)=c(find(V==NBV(i_in)));cb(q)=c(find(V==p));
        N(:,i_in)=A(:,find(V==NBV(i_in))); 
        Bi=BINV(Bi,A(:,p),q);
        iter=iter+1;
    end
end