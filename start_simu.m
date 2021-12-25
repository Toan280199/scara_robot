function start_simu(robot,t,set_t1,set_t2,set_d3,set_t4);

set_param('PIDController/motor1/Integrator','InitialCondition',num2str(robot.theta(1)*pi/180));
set_param('PIDController/motor2/Integrator','InitialCondition',num2str(robot.theta(2)*pi/180));
set_param('PIDController/motor3/Integrator','InitialCondition',num2str(robot.d(3)));
set_param('PIDController/motor4/Integrator','InitialCondition',num2str(robot.theta(4)*pi/180));

sig1 = [t;set_t1'];
sig2 = [t;set_t2'];
sig3 = [t;set_d3'];
sig4 = [t;set_t4'];

save theta1set.mat sig1;
save theta2set.mat sig2;
save d3set.mat sig3;
save theta4set.mat sig4;

set_param('PIDController','StopTime',num2str(t(end)));
set_param('PIDController','SimulationCommand','start');