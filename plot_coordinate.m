function plot_coordinate(x,y,z,u,stt)
    hold on
    u=u*0.15;
    quiversensorx = quiver3(x,y,z,u(1,1),u(2,1),u(3,1));
    quiversensory = quiver3(x,y,z,u(1,2),u(2,2),u(3,2));
    quiversensorz = quiver3(x,y,z,u(1,3),u(2,3),u(3,3));
    plot3(x,y,z,'m.','MarkerSize',10);
    set(quiversensorx, 'Color', 'blue');
    set(quiversensory, 'Color', 'black');
    set(quiversensorz, 'Color', 'red');
    
    set(quiversensorx, 'LineWidth', 1);
    set(quiversensory, 'LineWidth', 1);
    set(quiversensorz, 'LineWidth', 1);
    textx = text(x+u(1,1),y+u(2,1),z+u(3,1),strcat('x',stt));
    set(textx,'color','blue');
    texty = text(x+u(1,2),y+u(2,2),z+u(3,2),strcat('y',stt));
    set(texty,'color','black');
    textz = text(x+u(1,3),y+u(2,3),z+u(3,3),strcat('z',stt));
    set(textz,'color','red');
end