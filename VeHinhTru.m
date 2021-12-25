function VeHinhTru(handles,x0,y0,z0,r,h,colr)
% x0 y0 z0: toa do tam
% r: ban kinh day
% h: chieu cao
[X,Y,Z] = cylinder(r,100);
X = X + x0;
Y = Y + y0;
Z = Z*h + z0;
surf(handles.robot_plot,X,Y,Z,'facecolor',colr,'LineStyle','none');
fill3(handles.robot_plot,X(1,:),Y(1,:),Z(1,:),colr)
fill3(handles.robot_plot,X(2,:),Y(2,:),Z(2,:),colr)