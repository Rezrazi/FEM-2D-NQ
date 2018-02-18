function [phi,grad] = FoncChap(elementTypeIndex,xGauss)
%FoncChap Generate shape functions for a given element type
%==========================================================================
% INPUT
% - elementTypeIndex (int) Element type index <1|2>
% - xGauss (int) Evaluated quadrature coordinates
%==========================================================================
% OUTPUT
% - phi (array) Shape functions
% - grad (array) Gradient shape functions
%==========================================================================

s = xGauss(:,1);
t = xGauss(:,2);

if elementTypeIndex == 1  %NQ1
    phi   = 0.25*[-s.^2+t.^2-2*t+1,s.^2-t.^2-2*s+1,s.^2-t.^2+2*s+1,-s.^2+t.^2+2*t+1];
    grad  = 0.25*[-2*s,2*s-2,2*s+2,-2*s;2*t-2,-2*t,-2*t,2*t+2];
elseif elementTypeIndex == 2 %NQ2
    phi = ones(elementTypeIndex);
    grad = ones(elementTypeIndex);
else
    error('Element type not valid ! Must be <1|2>.');
end

