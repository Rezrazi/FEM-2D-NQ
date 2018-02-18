function [Kb,Fb,U] = MEF2D(elementTypeIndex,X,T,h,b,f,nGauss)
%MEF2D Evaluate solution matrix
%==========================================================================
% INPUT
% - elementTypeIndex (int) Element type index <1|2>
% - X (array) Nodes coordinates array
% - T (array) Element indexes array
% - h (array) Step between nodes
% - f (function) Right hand function of the equation
% - nGauss (array) Gauss quadrature evaluated values
%==========================================================================
% OUTPUT
% - Kb (array) Global stiffness matrix with boundaries conditions
% - Fb (array) Global right hand F matrix with boundaries conditions
% - U (array) Node-evaluated solution
%==========================================================================

[xGauss,wGauss]= Quadrature(elementTypeIndex, nGauss);
[phi,grad] = FoncChap(elementTypeIndex,xGauss);
[K,F] = Assemblage2D(elementTypeIndex,X,T,h,f,phi,grad,xGauss,wGauss,nGauss);

K(b,:)=0; K(:,b)=0;
F(b)=0;
K(b,b)=eye(length(b),length(b));
Kb=K; Fb=F;
%
U=Kb\Fb;
end

