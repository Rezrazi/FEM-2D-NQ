%Main Main script
%==========================================================================
% User input
%==========================================================================
clear variables
close all
clc
disp('************************************************');
disp('*                MEF 2D NQ1/NQ2                *');
disp('************************************************');

%################### HARDCODED ###################
X1 = -2;
X2 = 2;
Y1 = -1;
Y2 = 1;
elementTypeIndex = 1;
nGauss = 4;
NX = 64;
NY = 64;
%################### HARDCODED ###################


% disp('Choisir type elements:');
% disp('    | - (1) Elements NQ1');
% disp('    | - (2) Elements NQ2');
% elementTypeIndex = input('> Choix : ');
% disp('Choisir le nombre de points de Gauss:');
% disp('    | - (4) Points');
% disp('    | - (9) Points');
% nGauss = input('> Choix : ');
% NX = input('> Entrer nombre elements suivant (Ox) : ');
% NY = input('> Entrer nombre elements suivant (Oy) : ');

X = [X1 X2];
Y = [Y1 Y2];
N = [NX NY];

% Second membre
f=@(x,y) -2*x^2-2*y^2+10;
% Solution exacte
ue=@(x,y) (x^2-4)*(y^2-1);

switch elementTypeIndex
    case 1
        elementType = 'nq1';
    case 2
        elementType = 'nq2';
    otherwise
        error('Veuillez choisir un type entre 1-2');
end
if nGauss ~= 4 && nGauss ~= 9
    error('Nombre de points de Gauss invalide. Choisir <4|9>');
end

[X,T,b,h] = Maillage2D(X,Y,N,elementType,true);

[Kb,Fb,U] = MEF2D(elementTypeIndex,X,T,h,b,f,nGauss);


% Affichage et comparaison

% Solution approchée
Affichage([X1 X2],[Y1 Y2],X,h,N,U,'Solution approchée');

%Solution exacte
uee=(X(:,1).^2-4).*(X(:,2).^2-1);
Affichage([X1 X2],[Y1 Y2],X,h,N,uee,'Solution exacte');

%--------------------------------
% Calcul de l'erreur en norme L2
error_L2=norm(U-uee,2);
err_rela=error_L2\norm(uee,2);
fprintf('\t\t %4d \t\t %20.16e \t\t %20.16e\n\n', NX*NY,error_L2,err_rela);
fprintf('On a fini normalement\n');