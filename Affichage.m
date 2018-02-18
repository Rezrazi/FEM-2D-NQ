function Affichage(x,y,X,h,n,U,type)
%Affichage Display the results
%==========================================================================
% INPUT
% - x (array) Boundaries coordinates on X [x1 x2]
% - y (array) Boundaries coordinates on Y [y1 y2]
% - X (array) Nodes from the mesh
% - n (array) Number of elements per axis [nx ny]
% - U (array) Evaluated solution
% - type (string) For naming purposes
%==========================================================================

% subMesh
[xq,yq] = meshgrid(x(1):h(1):x(2),y(1):h(2):y(2));
% interpolation
Uq = griddata(X(:,1),X(:,2),U,xq,yq);
% Zeroing
Uq(1,:) = 0;
Uq(end,:) = 0;
Uq(:,1) = 0;
Uq(:,end) = 0;
newU = Uq(:);


subX = xq(1,:);
subY = yq(:,1)';
A = ones(size(subY,2),1) * subX;
B = (ones(size(subX,2), 1) * subY)';
v = [A(:) B(:)];
v = sortrows(v,[2 1]);
newT = zeros(4*n(1)*n(2),4);

for i=1:2*n(1)
    for j=1:2*n(2)
        ielem = (i-1)*2*n(1)+j;
        inode = (i-1)*(2*n(1)+1)+j;
        newT(ielem,:) = [inode   inode+1   inode+(2*n(1)+2) inode+(2*n(1)+1)];
    end
end
figure('Name',type);
axis tight;
patch('Faces',newT,'Vertices',v,'FaceVertexCData',newU,'FaceColor','interp');
colormap;

end

