function picker(x,y,z,yaw,w,h)

plot3([x-w/2*cos(yaw), x+w/2*cos(yaw)],[y-w/2*sin(yaw), y+w/2*sin(yaw)],[z, z],'linewidth',3,'color',[0.4660 0.6740 0.1880]);
plot3([x-w/2*cos(yaw), x-w/2*cos(yaw)],[y-w/2*sin(yaw), y-w/2*sin(yaw)],[z, z-h],'linewidth',3,'color',[0.4660 0.6740 0.1880]);
plot3([x+w/2*cos(yaw), x+w/2*cos(yaw)],[y+w/2*sin(yaw), y+w/2*sin(yaw)],[z, z-h],'linewidth',3,'color',[0.4660 0.6740 0.1880]);
end