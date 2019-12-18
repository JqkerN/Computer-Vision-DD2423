function pixels = Lv(inpic, shape)
if (nargin <2 ) 
    shape = 'same';
end
dxmask = [-1 0 1;-2 0 2; -1 0 1];
dymask = [-1 -2 -1; 0 0 0; 1 2 1];
Lx = conv2(inpic, dxmask, shape);
Ly = conv2(inpic, dymask, shape);
pixels = sqrt(Lx.^2 + Ly.^2);