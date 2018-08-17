function [pointarmonic,parameter,gamma,p_old,tol,nit,er,nflagface,...
    nflagno,weightDMP,Hesq,Kde,Kn,Kt,Ded,auxface,calnormface]=preNLFV(kmap,N,metodoP,benchmark,bedge)
global elem
nflagno=0;
nflagface=0;
pointarmonic=0;
parameter=0;
auxface=0;
weightDMP=0;
Hesq=0;
Kde=0;
Kn=0;
Kt=0;
Ded=0;
calnormface=0;
%% faces alrededor de um n�
w=0;
s=0;
if strcmp(metodoP,'nlfvLPEW')
    %% calculo dos parametros ou constantes (ksi)
    % esta rutina estamos usando de 7/2/2016
    %[parameter]=coefficientPPS(kmap); % urgente revisar
    %temos usado para muitos estes o seguinte rutina
    [parameter,calnormface]=coefficientLPSangle(kmap); 
    % adequa��o dos flags de contorno
    nflagno= contflagno(benchmark,bedge);
    %% calculo dos pesos
    %[w,s] = weightnlfv(kmap,N,interpol);
elseif strcmp(metodoP,'nlfvDMPSY')|| strcmp(metodoP,'lfvHP') || strcmp(metodoP,'nlfvDMPV1')
    %% faces alrededor de um elemento
    [facelement]=element_face;
    %% calculoa dos pontos armonicos
    [pointarmonic]=harmonicopoint(kmap,N,benchmark);
    %% calculo dos parametros ou constantes (ksi)
    % temos usado este parametro durante muito tempo em muitos testes
    [parameter,auxface]=coefficientPPSharmonicpoint(facelement,pointarmonic,kmap);
    % esta rutina estamos usando de 7/2/2016
    %[parameter]=coefficientPPSusingHP(kmap,facelement,pointarmonic); %para lfvHP
    % adequa��o dos flag de face de contorno
    nflagface= contflagface(benchmark,bedge);
    % adequa��o dos nos flags de contorno
    nflagno= contflagno(benchmark,bedge);
    %% calculo dos pesos DMP
    [weightDMP]=weightnlfvDMP(kmap);
elseif strcmp(metodoP,'lfvLPEW')
    %% calculo dos parametros ou constantes (ksi)
    
    %[parameter]=coefficientLPS(kmap);
    [parameter]=coefficientLPSangle(kmap);
    % adequa��o dos flags de contorno
    nflagno= contflagno(benchmark,bedge);
    % calculo dos pesos DMP
    [weightDMP]=weightnlfvDMP(kmap);
    % outra maneira de calcular os pesos proposto no artigo
    %[weightDMP]=weightlfv(parameter);
elseif strcmp(metodoP,'mpfad')
    
    %% calculo das constantes fisicos-geometrico
    [Hesq, Kde, Kn, Kt, Ded]=preMPFAD(kmap);
     % adequa��o dos flags de contorno
    nflagno= contflagno(benchmark,bedge);
else
    %% calculo das constantes fisicos-geometrico
    [Hesq, Kde, Kn, Kt, Ded]=preMPFAD(kmap);
     % adequa��o dos flags de contorno
    nflagno= contflagno(benchmark);
    
end
%% dados inicializa��o m�todos dos volumes finitos n�o linear
gamma=0.0;                       % este parametro esta no intervalo [0,1]
%r = 0 + (2-0).*rand(size(elem,1),1);
%p_old=r;
p_old=1e1*ones(size(elem,1),1); % inicializando a press�o
tol=1e-8;                        % tolerancia
nit=1000;                       % # itera��es de Picard
er=1;
end