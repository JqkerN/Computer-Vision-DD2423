function Lvvv_tilde = Lvvvtilde(inpic, shape)
if (nargin <2 ) 
    shape = 'same';
end

temp = [-1/2, 0, 1/2];
dx = zeros(5,5);
dx(3, 2:4) = temp;
dy = dx';

dxx = zeros(5,5);
temp = [1, -2, 1];
dxx(3, 2:4) = temp;
dyy = dxx';

dxxx = conv2(dx, dxx, shape);
dxxy = conv2(dxx,dy,shape);
dyyx = conv2(dyy,dx,shape);
dyyy = conv2(dy, dyy, shape);

Lx = conv2(inpic, dx, shape);
Ly = conv2(inpic, dy, shape);
Lxxx = conv2(inpic, dxxx, shape);
Lxxy = conv2(inpic, dxxy, shape);
Lyyx = conv2(inpic, dyyx, shape);
Lyyy = conv2(inpic, dyyy, shape);

Lvvv = (Lx.^3.*Lxxx + 3*Lx.^2.*Ly.*Lxxy + 3*Lx.*Ly.^2.*Lyyx + Ly.^3.*Lyyy)./(Lx.^2 + Ly.^2).^(3/2);
Lv_tilde = Lv(inpic, shape);
Lvvv_tilde = Lv_tilde.^3.* Lvvv;
end