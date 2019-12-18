function edgecurves = extractedge(inpic, scale, shape, threshold)
%Edge detection function from DD2423 computer vision course. 
%Authors: Ilian Corneliussen and Andrej Wilczek.
%Input: Inpic [Picture], scale [Scaling i.e. gaussian variance],
%       Threshold [Min value for first derivative], shape [Conv2 shape].
%
%Output: edgecurves [the edges of the inpic]
if nargin < 4
    threshold = 0;
end
pixels = Lv(discgaussfft(inpic, scale), shape);
pixels =-((pixels - threshold) < 0);

Lvv = Lvvtilde(discgaussfft(inpic, scale), shape);
Lvvv = -(Lvvvtilde(discgaussfft(inpic, scale), shape) > 0);

edges = zerocrosscurves(Lvv, Lvvv);
edgecurves = thresholdcurves(edges, pixels);
end