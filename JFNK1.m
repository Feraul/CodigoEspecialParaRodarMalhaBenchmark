
function [p,step,errorelativo,flowrate,flowresult] = JFNK1(tolnewton,kmap,...
    parameter,metodoP,auxflag,w,s,nflag,fonte,gamma,...
    nflagno,benchmark,M_old1,RHS_old1,p_old1,R0,weightDMP,...
    auxface,wells,mobility,Hesq, Kde, Kn, Kt, Ded,calnormface)
% inicializando
R= M_old1*p_old1-RHS_old1;
er=1;
step= 0; % iteration counter
while tolnewton<er
    step = step + 1 % update iteration counter
    
    % O m�todo de Newton- Krylov aqui implementado foi proposto no
    % artigo "Jacobian-free Newton�Krylov methods:a survey of approaches and applications
    % D.A. Knoll, D.E. Keyes e foi implementado no Matlab segui o site:
    % http://www.mathworks.com/matlabcentral/fileexchange/45170-jacobian-free-newton-krylov--jfnk--method
    % para sistema de equa��es dadas, n�s adaptamos a nosso contexto.
    j_v_approx1 = @(v)JV_APPROX1(v, R,p_old1,M_old1,RHS_old1);
    
    % Calculo pelo m�todo de itera��o GMRES do Matlab
    %[v,flag,relres,iter,resvec] = gmres(j_v_approx1, R,2,1e-5,size(elem,1)*0.25,[],[],x0); % solve for Krylov vector
    
    % Calculo pelo m�todo de itera��o BICGSTAB do Matlab
    [v,flag]=bicgstab(j_v_approx1,R,1e-4,5000);
    flag
    
    % Calculo da press�o na itera��o k+1
    p_new = p_old1 - v;
    % garantido a positividade
    n=1;
    while min(p_new)<0
        p_new=p_old1-v*(1/2^n);
        n=2*n;
    end
    
    % Plotagem no visit
    S=ones(size(p_new,1),1);
    postprocessor(p_new,S,step)
    
    % Interpola��o das press�es na arestas (faces)
    [pinterp_new]=pressureinterp(p_new,nflag,nflagno,w,s,auxflag,metodoP,...
        parameter,weightDMP,mobility);
    
    % Calculo da matriz global
    [M_new,RHS_new]=globalmatrix(p_new,pinterp_new,gamma,nflag,nflagno...
        ,parameter,kmap,fonte,metodoP,w,s,benchmark,weightDMP,...
        auxface,wells,mobility,Hesq, Kde, Kn, Kt, Ded,calnormface);
    
    % Calculo do residuo
    R= M_new*p_new - RHS_new;
    if (R0 ~= 0.0)
         er = abs(norm(R)/R0)
       % er = R/norm(RHS_new)
    else
        er = 0.0; %exact
    end
    errorelativo(step)=er;
    errorelativo(step)=er;
    
    % Atualizando a press�o
    p_old1=p_new;
    M_old1=M_new;
    RHS_old1=RHS_new;
end
p=p_old1;
pinterp=pressureinterp(p,nflag,nflagno,w,s,auxflag,metodoP,parameter,weightDMP,mobility);
if strcmp(metodoP,'nlfvDMPSY')
    % implementa��o do fluxo NLFV-DMP
    [flowrate,flowresult]=flowrateNLFVDMP(p, pinterp, parameter,nflag,kmap,gamma,weightDMP);
else
    % implementa��o do fluxo NLFV
    [flowrate,flowresult]=flowrateNLFV(p, pinterp, parameter,mobility);
    
end
end
