%from canvas

function [A,b,c,BV0,NBV0,AV]=S_form(A0,b0,c0,o_sign,c_GE,c_E,v_neg,v_free)
[m,n0]=size(A0);
n_GE=length(c_GE);n_E=length(c_E);n_neg=length(v_neg);n_free=length(v_free);

if o_sign=='max'
    c=-c0;
else
    c=c0;
end

if n_neg>0
    for i=1:n_neg
        c(v_neg(i))=-c(v_neg(i));
        A0(:,v_neg(i))=-A0(:,v_neg(i));
    end
end

if n_free>0
    for i=1:n_free
        A0=[A0(:,1:v_free(i)+i-1),-A0(:,v_free(i)+i-1),A0(:,v_free(i)+i:n0)];
        c=[c(1:v_free(i)+i-1);-c(v_free(i)+i-1);c(v_free(i)+i:n0)];
        n0=n0+1;
    end
end

b_neg=find(b0<0);
n_bneg=length(b_neg);
if n_bneg>0
    for i=1:n_bneg
        A0(b_neg(i),:)=-A0(b_neg(i),:);b0(b_neg(i))=-b0(b_neg(i));
        I=find(c_GE==b_neg(i));n_I=length(I);
        if n_I==0
            I1=find(c_E==b_neg(i));
            if length(I1)==0
                c_GE=[c_GE,b_neg(i)];
            end
        else
            c_GE=[c_GE(1:I(1)-1),c_GE(I(1)+1:n_GE)];
        end
    end
end

BV0=[];AV=[];NBV0=[1:n0];E=eye(m);n=n0;
for i=1:m
    i_GE=find(c_GE==i);
    if length(i_GE)==0
        i_E=find(c_E==i);
        if length(i_E)==0
            BV0=[BV0,n+1];n=n+1;
            A0=[A0,E(:,i)];c=[c;0];
        else
            BV0=[BV0,n+1];AV=[AV,n+1];n=n+1;
            A0=[A0,E(:,i)];c=[c;0];
        end
    else
        BV0=[BV0,n+2];NBV0=[NBV0,n+1];AV=[AV,n+2];n=n+2;
        A0=[A0,-E(:,i),E(:,i)];c=[c;0;0];
    end
end

A=A0;b=b0;c=c;AV=AV;