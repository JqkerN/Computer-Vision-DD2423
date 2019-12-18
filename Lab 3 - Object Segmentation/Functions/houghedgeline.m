function [linepar, acc] = houghedgeline(pic, scale, gradmagnthreshold, ...
                                        nrho, ntheta, nlines, verbose)
% Parmaters:
shape = 'same';
edgecurves = extractedge(pic, scale, shape, gradmagnthreshold);
threshold = gradmagnthreshold;
magnitude = Lv(discgaussfft(pic, scale), shape);
[linepar, acc] = houghline(edgecurves, pic, nrho, ntheta, ...
                                     threshold, nlines, verbose);

for idx = 1:size(linepar,2)
    r = linepar(1,idx);
    theta = linepar(2,idx);
    if theta == 0
        theta = 0.00001;
    end
    x0 = 0;
    y0 = (r-x0*cosd(theta))/sind(theta);
    dx = 10000000;
    dy = (r-(dx)*cosd(theta))/sind(theta);
    outcurves(1, 4*(idx-1) + 1) = 0;
    outcurves(2, 4*(idx-1) + 1) = 3;
    outcurves(2, 4*(idx-1) + 2) = x0 - dx;
    outcurves(1, 4*(idx-1) + 2) = y0 - dy;
    outcurves(2, 4*(idx-1) + 3) = x0;
    outcurves(1, 4*(idx-1) + 3) = y0;
    outcurves(2, 4*(idx-1) + 4) = x0 + dx;
    outcurves(1, 4*(idx-1) + 4) = y0 + dy;
end

if verbose == 0 || verbose == 3
    figure(83)
    subplot(2,1,1)
    overlaycurves(pic, edgecurves)
    subplot(2,1,2)
    overlaycurves(pic, outcurves)
    axis([0,length(pic),0,length(pic)])
end


