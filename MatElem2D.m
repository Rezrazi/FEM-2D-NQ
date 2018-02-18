function [Ke] = MatElem2D(elementTypeIndex,X,T,h,elementIndex,grad,xGauss,wGauss,nGauss)
%MatElem2D Generate stiffness matrix for a reference element
%==========================================================================
% INPUT
% - elementTypeIndex (int) Element type index <1|2>
% - X (array) Nodes coordinates array
% - T (array) Element indexes array
% - h (array) Step between nodes
% - elementIndex (int) Current element index
% - grad (array) Gradient of shape functions
% - xGauss,wGauss,nGauss (array) Gauss quadrature evaluated values
%==========================================================================
% OUTPUT
% - Ke (array) Element stiffness matrix
%==========================================================================

if elementTypeIndex==1 %NQ1
    nGeom = 4;
    x=X(T(elementIndex,1:nGeom),:);
    
    subX(1,:) = x(1,:)+[-h(1) 0];
    subX(2,:) = x(2,:)+[2*h(1) -h(2)];
    subX(3,:) = x(3,:)+[0 h(2)];
    subX(4,:) = x(4,:)+[-h(1) 0];
    
    coef_a(1,:) = (subX(1,:)+subX(2,:)+subX(3,:)+subX(4,:))*0.25;
    coef_a(2,:) = (-subX(1,:)+subX(2,:)+subX(3,:)-subX(4,:))*0.25;
    coef_a(3,:) = (-subX(1,:)-subX(2,:)+subX(3,:)+subX(4,:))*0.25;
    coef_a(4,:) = (subX(1,:)-subX(2,:)+subX(3,:)-subX(4,:))*0.25;
    
    %
    KKe=zeros(4);
    %
    %calcul de la matrice élémentaire Ke
    for i=1:4
        for j=i:4
            for k=1:nGauss
                J=[coef_a(2,1)+coef_a(4,1)*xGauss(j,2),coef_a(3,1)+coef_a(4,1)*xGauss(j,1);coef_a(2,2)+coef_a(4,2)*xGauss(j,2),coef_a(3,2)+coef_a(4,2)*xGauss(j,1)];
                KKe(i,j)=KKe(i,j)+wGauss(k)*det(J)*(J\grad(k:nGauss:k+nGauss,i))'*(J\grad(k:nGauss:k+nGauss,j));
            end
            KKe(j,i)=KKe(i,j);
        end
    end
    Ke=KKe;
    %
else
    error(' ce type Pk n est pas encore programmé')
end
end

