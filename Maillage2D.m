function [X,T,b,h] = Maillage2D(x,y,n,elementType,shouldPlot)
%Maillage2D Generate a mesh for a 2D domain
%==========================================================================
% INPUT
% - x (array) Boundaries coordinates on X [x1 x2]
% - y (array) Boundaries coordinates on Y [y1 y2]
% - n (array) Number of elements per axis [nx ny]
% - elementType (string) Finite element type <'nq1'|'nq2'>
% - shouldPlot (boolean) Show the scatter of the mesh
%==========================================================================
% OUTPUT
% - X (array) Nodes coordinates array
% - T (array) Element indexes array
% - b (array) Boundarie nodes
% - h (array) Step between nodes
%==========================================================================

%%
switch elementType
    case 'nq1'
        N = (2*n(1)*n(2))+n(1)+n(2);
        h = [(x(2)-x(1))/(2*n(1)) (y(2)-y(1))/(2*n(2))];
        X = zeros(1,2);
        
        xx = ((x(1)+h(1)):2*h(1):(x(2)-h(1)));
        yy = ((y(1)+h(2)):2*h(2):(y(2)-h(2)));
        
        subX = x(1):2*h(1):x(2);
        subY = y(1):2*h(2):y(2);
        
        A = ones(size(subY,2),1) * xx;
        B = (ones(size(xx,2), 1) * subY)';
        v = [A(:) B(:)];
        
        B = ones(size(subX,2),1) * yy;
        A = (ones(size(yy,2), 1) * subX)';
        vv = [A(:) B(:)];
        
        X = [v;vv];
        X = sortrows(X,[2 1]);
        
        if shouldPlot == true
            figure('Name','Maillage NQ1');
            scatter(X(:,1),X(:,2),'filled');
            axis 'tight';
            ss = num2str((1:N)');
            c = cellstr(ss);
            dx = (x(2)-x(1))/100; dy = dx;
            text(X(:,1)+dx, X(:,2)+dy, c);
        end
        
        T = zeros(n(1)*n(2),4);
        
        for i=1:n(2)
            for j=1:n(1)
                ielem = (i-1)*n(1)+j;
                inode = (i-1)*(2*n(1)+1)+j;
                T(ielem,:) = [inode   inode+n(1)   inode+n(1)+1  inode+n(1)+n(2)+1];
                positionRectangle = [X(T(ielem,1),1)-h(1) X(T(ielem,1),2) 2*h(1) 2*h(2)];
                rectangle('Position',positionRectangle','EdgeColor','b');
                text('Position',[positionRectangle(1)+positionRectangle(3)/2 positionRectangle(2)+positionRectangle(4)/2],'string',strcat('T',num2str(ielem)),'FontWeight','bold','Color','red');
            end
        end
        
        b=[1:n(1),n(1)+1:2*n(1)+1:N,2*n(1)+1:2*n(1)+1:N,N-n(1)+1:N];
        
    case 'nq2'
        N = (4*n(1)*n(2))+2*n(1)+2*n(2)+n(1)*n(2);
        h = [(x(2)-x(1))/(3*n(1)) (y(2)-y(1))/(3*n(2))];
        X = zeros(1,2);
        
        xx = round(((x(1)+h(1)):h(1):(x(2)-h(1))),4);
        yy = round(((y(1)+h(2)):h(2):(y(2)-h(2))),4);
        xx = setdiff(xx,round(x(1):3*h(1):x(2),4));
        yy = setdiff(yy,round(y(1):3*h(2):y(2),4));
        subX = x(1):3*h(1):x(2);
        subY = y(1):3*h(2):y(2);
        
        A = ones(size(subY,2),1) * xx;
        B = (ones(size(xx,2), 1) * subY)';
        v = [A(:) B(:)];
        
        B = ones(size(subX,2),1) * yy;
        A = (ones(size(yy,2), 1) * subX)';
        vv = [A(:) B(:)];
        
        hh = [(x(2)-x(1))/n(1) (y(2)-y(1))/n(2)];
        midX = x(1)+hh(1)/2:hh(1):x(2)-hh(1)/2;
        midY = y(1)+hh(2)/2:hh(2):y(2)-hh(2)/2;
        A = ones(size(midY,2),1) * midX;
        B = (ones(size(midX,2), 1) * midY)';
        vvv = [A(:) B(:)];
        
        X = [v;vv;vvv];
        X = sortrows(X,[2 1]);
        
        if shouldPlot == true
            figure('Name','Maillage NQ2');
            scatter(X(:,1),X(:,2),'filled');
            axis 'tight';
            ss = num2str((1:N)');
            c = cellstr(ss);
            dx = (x(2)-x(1))/100; dy = dx;
            text(X(:,1)+dx, X(:,2)+dy, c);
        end
        
        T = zeros(n(1)*n(2),9);
        
        for i=1:n(2)
            for j=1:n(1)
                ielem = (i-1)*n(1)+j;
                inode = (i-1)*(5*n(1)+2)+2*j-1;
                T(ielem,:) = [inode   inode+1   inode+2*n(1)-j+1  inode+2*n(1)-j+2  inode+3*n(1)-j+2 inode+5*n(1)-j-1 inode+5*n(1)-j inode+3*n(1)+2*n(2)+2 inode+3*n(1)+2*n(2)+3];
                positionRectangle = [X(T(ielem,1),1)-h(1) X(T(ielem,1),2) 3*h(1) 3*h(2)];
                rectangle('Position',positionRectangle','EdgeColor','b');
                text('Position',[positionRectangle(1)+positionRectangle(3)/3 positionRectangle(2)+positionRectangle(4)/3],'string',strcat('T',num2str(ielem)),'FontWeight','bold','Color','red');
            end
        end
        
        b=[1:2*n(1),2*n(1)+1:5*n(1)+2:N,4*n(1)+2:5*n(1)+2:N,3*n(1)+1:5*n(1)+2:N,5*n(1)+2:5*n(1)+2:N,N-2*n(1)+1:N];
        
    otherwise
        error('Element type not selected ! <nq1|nq2>');
end
end


