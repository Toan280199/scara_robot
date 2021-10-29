classdef SCARA
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        %% DH parameter
        a;
        d;
        alpha;  % unit deg
        theta;  % unit deg
        
        %% Limatation of workspace
        theta1_max;
        theta2_max;
        d3_max; %%maximum value of d3
        pos;    %%position of 4 joints 1 2 3 4
        orien;  %%orientation of 4 joints 1 2 3 4, unit radian
    end
    
    methods(Static)
        function obj = SCARA(handles,a1,a2,d1,t1_max,t2_max,d3_max)
            obj.a = [0; 0; 0; 0];
            obj.d = [0; 0; 0; 0];
            obj.alpha = [0.00; 0.00; 0.00; 180];
            obj.theta = [0.00; 90.0; 0.00; 0.00];
            obj.a(1)=a1;
            obj.a(2)=a2;
            obj.d(1)=d1;
            obj.theta1_max = t1_max;
            obj.theta2_max = t2_max;
            obj.d3_max = d3_max;
            [obj.pos,obj.orien] = obj.ForwardKinematic(obj);
            set(handles.vl_a1,'String',a1) 
            set(handles.vl_a2,'String',a2) 
            set(handles.vl_d1,'String',d1)
        end
        function [p_robot,o_robot] = ForwardKinematic(obj)
            a = obj.a;
            alpha = obj.alpha*pi/180;
            d = obj.d;
            theta = obj.theta*pi/180;
            
            theta1_max = obj.theta1_max;
            theta2_max = obj.theta2_max;
            d3_max = obj.d3_max;

            if (abs(theta(1))*180/pi>theta1_max)||(abs(theta(2))*180/pi>theta2_max)||(d(3)<-d3_max)
                ok = 0;
                obj = obj;
                warndlg('Out of workspace','Warning');
                return
            end

            %% Ham tinh dong hoc thuan c?a robot
            % Input: DH Parameter
            % Output: joint position p1 p2 p3 p4     (x y z)
            %         joint orientation o1 o2 o3 o4  (roll pitch yaw)
            %% FK Matrix
            A0_1 = Link_matrix(a(1),alpha(1),d(1),theta(1)) ;
            A1_2 = Link_matrix(a(2),alpha(2),d(2),theta(2)) ;
            A2_3 = Link_matrix(a(3),alpha(3),d(3),theta(3)) ;
            A3_4 = Link_matrix(a(4),alpha(4),d(4),theta(4)) ;

            A0_2=A0_1*A1_2;
            A0_3=A0_1*A1_2*A2_3;
            A0_4=A0_1*A1_2*A2_3*A3_4;   % Te

            p0 = [0;0;0];
            [p1, o1] = cal_pose(A0_1,p0);
            [p2, o2] = cal_pose(A0_2,p0);
            [p3, o3] = cal_pose(A0_3,p0);
            [p4, o4] = cal_pose(A0_4,p0);

            p_robot = [p1 p2 p3 p4]';
            o_robot = [o1; o2; o3; o4];
        end
        
        function [obj,ok] = InverseKinematic(x,y,z,yaw,obj)
            % Input: x y z yaw a1 a2
            % Output: theta1 theta2 d3 theta4
            a1 = obj.a(1);
            a2 = obj.a(2);
            d1 = obj.d(1);

            c2 = (x^2 + y^2 - a1^2 - a2^2)/(2*a1*a2);
            if (abs(c2)<=1)
                s2 = sqrt(1-c2^2);
                theta2 = atan2(s2,c2);

                t1 = [a1+a2*c2 -a2*s2;a2*s2 a1+a2*c2]^(-1)*[x;y];
                c1 = t1(1);
                s1 = t1(2);
                theta1 = atan(s1/c1);

                d3 = z - d1;
                theta4 = yaw - ( theta1 + theta2 );

                if(theta4>pi)
                    theta4 = theta4-2*pi;
                end

                if(theta4<-pi)
                    theta4 = theta4+2*pi;
                end
                
                if (abs(theta1*180/pi)>obj.theta1_max)||(abs(theta2*180/pi)>obj.theta2_max)||(d3<-obj.d3_max)
                    ok = 0;
                    obj = obj;
                    warndlg('Out of workspace','Warning');
                    return
                else
                    ok = 1;
                    obj.theta(1) = theta1*180/pi;
                    obj.theta(2) = theta2*180/pi;
                    obj.d(3) = d3;
                    obj.theta(4) = theta4*180/pi;
                end
            else
                ok = 0;
                obj = obj;
                warndlg('Out of workspace','Warning');
                return
            end
        end
    end
end

