function [K,F] = Assemblage2D(elementTypeIndex,X,T,h,f,phi,grad,xGauss,wGauss,nGauss)
%Assemblage2D Assemble elementary matrix
%==========================================================================
% INPUT
% - elementTypeIndex (int) Element type index <1|2>
% - X (array) Nodes coordinates array
% - T (array) Element indexes array
% - h (array) Step between nodes
% - f (function) Right hand function of the equation
% - phi (array) Shape functions
% - grad (array) Gradient of shape functions
% - xGauss,wGauss,nGauss (array) Gauss quadrature evaluated values
%==========================================================================
% OUTPUT
% - K (array) Global stiffness matrix
% - F (array) Global right hand F matrix
%==========================================================================

Nn=size(X,1); %nombre des noeuds
Nt=size(T,1);  % nombre des éléments
K=zeros(Nn,Nn);% initialisation de K
F=zeros(Nn,1);% initialisation de F comme matrice creuse
%

for elementIndex = 1:Nt
    Tie = T(elementIndex,:);
    [Ke] = MatElem2D(elementTypeIndex,X,T,h,elementIndex,grad,xGauss,wGauss,nGauss);
    [Fe] = SMelem(elementTypeIndex,X,T,h,f,elementIndex,phi,xGauss,wGauss,nGauss);
    K(Tie,Tie)=K(Tie,Tie)+Ke;
    F(Tie)=F(Tie)+Fe;
    clear Ke Fe;
end

end

