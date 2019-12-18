function Lvv_tilde = Lvvtilde(inpic, shape)
if (nargin <2 ) 
    shape = 'same';
end
temp = [-1/2, 0, 1/2];
dx = zeros(5,5);
dx(3, 2:4) = temp;
dy = dx';

temp = [1, -2, 1];
dxx = zeros(5,5);
dxx(3, 2:4) = temp;
dyy = dxx';

dxy = conv2(dx,dy,shape);
dxxx = conv2(dx, dxx, shape);
dxxy = conv2(dxx,dy,shape);

Lx = conv2(inpic, dx, shape);
Ly = conv2(inpic, dy, shape);
Lxx = conv2(inpic, dxx, shape);
Lyy = conv2(inpic, dyy, shape);
Lxy = conv2(inpic, dxy, shape);

Lvv = (Lx.^2.*Lxx + 2*Lx.*Ly.*Lxy + Ly.^2.*Lyy)./(Lx.^2 + Ly.^2);
Lv_tilde = Lv(inpic, shape);
Lvv_tilde = Lv_tilde.^2.* Lvv;
end