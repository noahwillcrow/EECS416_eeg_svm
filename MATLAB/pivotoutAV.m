%from canvas

function [BV,NBV,Bi,A,b,c,V]=pivotoutAV(A1,b1,c1,Bi,BV,NBV,AV,V)

A=A1;b=b1;c=c1;BV=BV;NBV=NBV;

while length(AV)>0
    q=find(BV==AV(1));k=find(V==AV(1));jflag=0;[m,n]=size(A);
    for j=1:length(NBV)
        ajhat=Bi*A(:,find(V==NBV(j)));
        if ajhat(q)~=0
            Bi(q,:)=Bi(q,:)/ajhat(q);
            for i=1:m
                if i~=q,
                    Bi(i,:)=Bi(i,:)-ajhat(i)*Bi(q,:);
                end
            end
            jflag=j;
            break
        end
    end
    if jflag==0
        A=[A(1:q-1,:);A(q+1:m,:)];b=[b(1:q-1);b(q+1:m)];c=[c(1:k-1);c(k+1:n)];;
        BV=[BV(1:q-1),BV(q+1:m)];NBV=NBV;
        Bi=[Bi(1:q-1,:);Bi(q+1:m,:)];Bi=[Bi(:,1:q-1);Bi(:,q+1:m)];
        print('Constraint',q,'is redundant')
    else
        A=[A(:,1:k-1),A(:,k+1:n)];c=[c(1:k-1);c(k+1,n)];b=b;
        BV(q)=NBV(jflag);NBV=[NBV(1:jflag-1),NBV(jflag+1:n-m)];
        Bi=Bi;
    end
AV=AV(2:length(AV);V=[V(1:k-1),V(k+1:n)];
end
                
                
        
 
                
        
            
                
        
            