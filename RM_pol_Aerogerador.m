                  
%    Autor: Diego Martins Gomes 
 clear
 clc

 
load aerogerador.dat
x=aerogerador(:, 1);    %armazena os valores de velocidade do vento
y=aerogerador(:, 2);    %armazena os valores de potência gerada
n = length(x); %Tamanho do vetor
grau = input('Digite o grau do polinomio (2,3,4,5) :');%grau recebe o grau do polinomio para regressao polinomial.

for k=2:6
    X=ones(n, grau+1);
    for j=2:grau+1
        X(:, j)=x.^j;       %matriz X
    end
    
    %Regularização de Tikhov
    lambida=0.0001;
    I=zeros(grau+1, grau+1);      
    for j=1:grau+1
        I(j, j)=1;          %matriz identidade
    end
end
if(grau==2)
    hold on
    plot(x,y,'b*')
    grid on 
    
    X=[ones(n,1),x,(x.^2)]; %Vetor

    B=((X'*X+lambida*I)^(-1)*X'*y);
 
 
    y_chap=(X*B);
    title('Regressão-Aerogerador')
    xlabel('Velocidade')
    ylabel('Potência')
    plot(x,y_chap,'m-');
    
    
end
%-----------------------------------------
if(grau==3)
    hold on
    plot(x,y,'b*')
    grid on 
 
    X=[ones(n,1),x,(x.^2),(x.^3)]; %Vetor
 
 
    B=((X'*X+lambida*I)^(-1)*X'*y);
 
 
    y_chap=(X*B);
 
 
    plot(x,y_chap,'k-');
end

%----------------------------------------------------
if(grau==4)
    hold on
    plot(x,y,'b*')
    grid on 
 
    X=[ones(n,1),x,(x.^2),(x.^3),(x.^4)];%Vetor
 
 
    B=((X'*X+lambida*I)^(-1)*X'*y);
 
 
    y_chap=(X*B);
 
 
    plot(x,y_chap,'r-');
end
%---------------------------------------------------
if(grau==5)
    hold on
    plot(x,y,'b*')
    grid on 
 
    X=[ones(n,1),x,(x.^2),(x.^3),(x.^4),(x.^5)];%Vetor
 
 
    B=((X'*X+lambida*I)^(-1)*X'*y);
 
 
    y_chap=(X*B);
 
 
    plot(x,y_chap,'g-');
end 
%Analise dos coeficientes:
   
e=y-y_chap;      %calculo do erro

SQe=sum((e).^2);
Syy=sum((y-mean(y)).^2);
R2(grau)= 1 - (SQe/Syy); % calculando o coeficiente de determinacao

p=grau;

R2aj(grau)=1 - ((SQe/(n-p))/(Syy/(n-1))); % calculando o coeficiente de determinacao ajustado
display('Coeficiente de Determinação - polinomial: ');
display(R2);

display('Coeficiente de Determinação ajustado - polinomial: ');
display(R2aj);
