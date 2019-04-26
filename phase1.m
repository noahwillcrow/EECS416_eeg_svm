function [BV,NBV,Bi,A,b,c,V]=phase1(A1,b1,c1,BV0,NBV0,AV,V)

[m,n]=size(A1);BV=BV0;NBV=NBV0;
cw=zeros(1,n)';
for i=1:length(AV), cw(AV(i))=1; end
for i=1:m, cb(i)=cw(BV(i)); end
for j=1:n-m, cn(j)=cw(NBV(j));N(:,j)=A1(:,NBV(j)); end
cb=cb';cn=cn';

Bi=eye(m);A=A1;b=b1;c=c1;
opt1=0;

while opt1==0
    [rcv,y]=rcc(Bi,N,cb,cn);
    [p,i_in]=Bland(A,Bi,rcv,NBV,V);
    
    if p==-1
        error('unbounded solution');
        opt1=1;
    
    elseif p>0
        [m,n]=size(A);
        q=leavingV(Bi,A,b,p,V);
        Bi=BINV(Bi,A(:,p),q);
        cb(q)=cw(p);
        Q=find(AV==BV(q));
        if length(Q)>0
            NBV=[NBV(1:i_in-1),NBV(i_in+1:n-m)];
            N=[N(:,1:i_in-1),N(:,i_in+1:n-m)];cn=[cn(1:i_in-1);cn(i_in+1:n-m)];
            k=find(V==BV(q));V=[V(1:k-1),V(k+1:n)];
            A=[A(:,1:k-1),A(:,k+1:n)];
            cw=[cw(1:k-1);cw(k+1:n)];
            c=[c(1:k-1);c(k+1:n)];
            AV=[AV(1:Q-1),AV(Q+1:length(AV))];
        else
            NBV(i_in)=BV(q);
            k=find(V==BV(q));
            cn(i_in)=cb(q);N(:,i_in)=A(:,k);      
        end
        BV(q)=p;
    
    else   %p==0
        if length(AV)==0
            BV=BV;NBV=NBV;Bi=Bi;A=A;b=b;c=c;V=V;
            opt1=1;
        elseif cb'*Bi*b>0
            error('Problem is Infeasible')
            opt1=1;
        else
            [BV,NBV,Bi,A,b,c,V]=pivotoutAV(A,b,c,Bi,BV,NBV,AV,V);
            opt1=1;
        end
    end
end