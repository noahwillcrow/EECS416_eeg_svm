function c = classificationKey(x)
%%--  Classification Result Examiner
%%--  Case Study -- EECS 416
%%--  c = classificationKey(x)
%%--  x: A binary sequence of your classification result
%%--  x=0 - Non-seizure period
%%--  x=1 - Seizure period
if (length(x)~=100); error('The length of your input is not correct!'); end;
if ((max(x)~=1)||min(x)~=0); error('Your input is not binary!'); end;
if (size(x,1)>size(x,2)); x=x'; end;
[x2,s] = ex1(x);
x3 = ex2(x2,s);
c = ex6(x2,x3);


function [y,s] = ex1(x)
v = rand(size(x));
[r,s] = sort(v);
for k = 1:length(s);
    y(k) = x(s(k));
end;
function y = ex2(x,s)
A = [0,1.1111,2.2222,-11.111,-9.4444,21.111,16.111,35.556,10.556,12.778;
    7.7778,-13.333,-4.4444,28.333,4.4444,18.333,36.111,-6.1111,16.667,-3.8889;
    -11.667,13.333,-16.667,13.889,32.222,26.111,33.889,37.778,28.889,5;
    32.778,1.6667,14.444,26.667,-6.6667,31.667,6.6667,34.444,24.444,27.222;
    -12.222,11.111,37.222,-1.1111,-1.6667,7.2222,25.556,27.778,2.7778,-7.2222;
    22.222,17.222,-8.8889,21.667,-17.222,9.4444,35,8.8889,30,-12.778;
    11.667,17.778,-15,29.444,30.556,25,-8.3333,-5,23.333,5.5556;
    18.889,-5.5556,-15.556,3.8889,12.222,-2.7778,15.556,33.333,-10.556,15;
    -7.7778,20,0.55556,-13.889,8.3333,36.667,-14.444,23.889,6.1111,-0.55556;
    -16.111,-10,20.556,22.778,10,31.111,-2.2222,-3.3333,3.3333,19.444];
B = ex3(A);
y = ex4(x,B,s);
function [y,s] = ex3(x)
y = x';
function g = ex4(x,A,s)
for k = 1:length(s);
    id = s(k);
    id2 = ex7(id);
    y = A(id2);
    g(k) = ex5(y);
end;
function y = ex5(x)
y = 1*((round(x*9/5)+32)>50);
function t = ex6(x,y)
t = sum(x==y);
function y = ex7(x)
a = floor(x/10);
b = rem(x,10);
if (b~=0)
    y1 = (b-1)*10;
    y2 = (10-a);
else
    y1 = 91;
    y2 = (10-a);
end;
y = y1+y2;
