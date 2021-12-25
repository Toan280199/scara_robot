function deg_out = ToTrigonometricCircle(deg_in)

% input: any angle
% output: [-180:180]
% example: 470 deg => 110 deg
deg_out = deg_in;

while deg_out >= 180
    deg_out = deg_out - 360;
end

while deg_out <= -180
    deg_out = deg_out + 360;
end