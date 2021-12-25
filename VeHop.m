function VeHop(handles,x0,y0,z0,a,b,h,colr)
% x0 y0 z0: toa do tam cua day
% h: chieu cao
% a, b: chieu dai, chieu rong
% colr: mau
corner = -pi : pi/2 : pi;                                % Define Corners
ph = pi/4;                                          % Define Angular Orientation (‘Phase’)
x = a/2*[cos(corner+ph); cos(corner+ph)]/cos(ph);
y = b/2*[sin(corner+ph); sin(corner+ph)]/sin(ph);
z = [z0*ones(size(corner)); (z0+h)*ones(size(corner))];
surf(handles.robot_plot, x, y, z, 'FaceColor',colr)                      % Plot Cube
patch(handles.robot_plot, x', y', z', colr)                              % Make Cube Appear Solid