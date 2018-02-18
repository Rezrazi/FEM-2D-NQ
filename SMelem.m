function [Fe] = SMelem(elementTypeIndex,X,T,h,f,elementIndex,phi,xGauss,wGauss,nGauss)
%SMelem Generate right hand side F matrix for a reference element
%==========================================================================
% INPUT
% - elementTypeIndex (int) Element type index <1|2>
% - X (array) Nodes coordinates array
% - T (array) Element indexes array
% - h (array) Step between nodes
% - f (function) Right hand function of the equation
% - elementIndex (int) Current element index
% - phi (array) Shape functions
% - xGauss,wGauss,nGauss (array) Gauss quadrature evaluated values
%==========================================================================
% OUTPUT
% - Fe (array) Right hand F matrix
%==========================================================================

if elementTypeIndex==1 %NQ1
    nGeom = 4;
    Fe=zeros(4,1); %initialiser les tailles de Me et Fe
    x=X(T(elementIndex,1:nGeom),:);
    Xc=zeros(nGauss,2);
    
    for i=1:nGauss
        subX(1,:) = x(1,:)+[-h(1) 0];
        subX(2,:) = x(2,:)+[2*h(1) -h(2)];
        subX(3,:) = x(3,:)+[0 h(2)];
        subX(4,:) = x(4,:)+[-h(1) 0];
        
        coef_a(1,:) = (subX(1,:)+subX(2,:)+subX(3,:)+subX(4,:))*0.25;
        coef_a(2,:) = (-subX(1,:)+subX(2,:)+subX(3,:)-subX(4,:))*0.25;
        coef_a(3,:) = (-subX(1,:)-subX(2,:)+subX(3,:)+subX(4,:))*0.25;
        coef_a(4,:) = (subX(1,:)-subX(2,:)+subX(3,:)-subX(4,:))*0.25;
        
        Xc(i,1)=coef_a(1,1)+coef_a(2,1)*xGauss(i,1)+coef_a(3,1)*xGauss(i,2)+coef_a(4,1)*xGauss(i,1)*xGauss(i,2);
        Xc(i,2)=coef_a(1,2)+coef_a(2,2)*xGauss(i,1)+coef_a(3,2)*xGauss(i,2)+coef_a(4,2)*xGauss(i,1)*xGauss(i,2);
    end
    
    for i=1:4
        s=0;
        for j=1:nGauss
            J=[coef_a(2,1)+coef_a(4,1)*xGauss(j,2),coef_a(3,1)+coef_a(4,1)*xGauss(j,1);coef_a(2,2)+coef_a(4,2)*xGauss(j,2),coef_a(3,2)+coef_a(4,2)*xGauss(j,1)];
            s=s+(det(J)*wGauss(j)*f(Xc(j,1),Xc(j,2))*phi(j,i));
        end
        Fe(i)=s;
    end
    
else
    error('NQ2 ?');
end
end

