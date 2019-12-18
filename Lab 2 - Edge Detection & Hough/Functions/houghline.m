function [linepar, acc] = houghline(curves, magnitude,  nrho, ntheta, ...
                                    threshold, nlines, verbose)
                                
% Making the accumolator space:
acc = zeros(nrho, ntheta);
linepar = zeros(2,nlines);
% Taking out the theta. 
delta_theta = 180/ntheta;
theta_vec = -90:delta_theta:89;

k = 3;
count = 0;
for ii = 1:length(curves)
    % Extracting edges. 
    x = curves(2,ii);
    y = curves(1,ii);

    % For all theta in [-pi,pi)
    for kk = 1:length(theta_vec)
       theta = theta_vec(kk);
       rho = x*cosd(theta) + y*sind(theta);
       index_1 = ceil(rho + nrho/2) +1;
       index_2 = kk;
%        
%        disp('x')
%        disp(x)
%        disp('y')
%        disp(y)
       if  x > length(magnitude) || x < 1 || y > length(magnitude) || y<1
           continue
       elseif threshold > magnitude(round(x),round(y))
           continue
       end
       

       % To ensure to be inside the bounds.
       if (0 < index_1) && (index_1 <= nrho)          
            acc( index_1, index_2 ) =  acc( index_1, index_2 )  + 1;%magnitude(round(x),round(y));
       else 
           %disp('Outside!')
           count = count + 1; 
       end
    end
end

if verbose == 0 || verbose == 1
    figure(80)
    imshow(imadjust(rescale(acc)));
    colormap(gca, hot)
    xlabel('\theta (degrees)')
    ylabel('\rho')
    %axis on
    %axis([-90/delta_theta,89/delta_theta,-nrho/2, nrho/2])
    hold on
    
end
if verbose == 0 || verbose == 2
    disp(['Number of outside = ', num2str(count)]);
end

[pos, value] = locmax8(acc);
[dummy, indexvector] = sort(value);
nmaxima = size(value,1);

for idx = 1:nlines
    rhoidxacc = pos(indexvector(nmaxima -idx +1), 1);
    thetaidxacc = pos(indexvector(nmaxima - idx +1), 2);
    
    linepar(:,idx) = [ceil(rhoidxacc-nrho/2-1);theta_vec(thetaidxacc)];
end

end
