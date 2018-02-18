function [Xgauss,Wgauss]=Quadrature(elementTypeIndex, nGauss) 
% fonction qui donne les poids et les noeuds de Gauss en 2D
%
% Entrées:    
%     elem:  type d'élément (0 pour quadrilatères et 1 pour triangles)
%   Ngauss:  Nombre des noeuds de Gauss dans l'élément courant
% Output:   
%          Xgauss: les noeuds de Gauss dans l'élément de Référence
%          Wgauss: les poids de Gauss dans l'élément de Référence

if elementTypeIndex == 1 || elementTypeIndex == 2
    if nGauss == 4    % degré 1
        pos1 = 1/sqrt(3); 
        Xgauss=[-pos1   -pos1 
                pos1   -pos1 
                pos1    pos1 
               -pos1    pos1]; 
        Wgauss=[1 1 1 1];
    elseif nGauss == 9  % degré 2 
        pos1 = sqrt(3/5);
        Xgauss=[-pos1   -pos1
                   0   -pos1
                pos1   -pos1
               -pos1     0
                  0      0
                pos1     0
               -pos1    pos1
                  0     pos1
                pos1    pos1];
        pg1=5/9; pg2=8/9; pg3=pg1;
        Wgauss= [pg1*pg1 pg2*pg1 pg3*pg1 pg1*pg2 pg2*pg2 pg3*pg2 pg1*pg3 pg2*pg3 pg3*pg3];
    else 
        error(' Cette quadrature avec ce nombre de points  nest pas programmée') 
    end
else
    error(' Cette quadrature n est pas programmée') 
end
