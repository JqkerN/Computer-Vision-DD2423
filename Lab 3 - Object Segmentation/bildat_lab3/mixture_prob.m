function [prob] = mixture_prob(image, K, L, mask)
%Let I be a set of pixels and V be a set of K Gaussian components in 3D (R,G,B).
% SUMMARY:
% #1. Store all pixels for which mask=1 in a Nx3 matrix
% #2. Randomly initialize the K components using masked pixels
% #3. Iterate L times
% #4. Expectation: Compute probabilities P_ik using masked pixels
% #5. Maximization: Update weights, means and covariances using masked pixels
% #6. Compute probabilities p(c_i) in Eq.(3) for all pixels I.
VERBOSE = 0;

[h,w,c] = size(image);

% #1. Store all pixels for which mask=1 in a Nx3 matrix
tmp = zeros(h*w,c);
mask = reshape(mask,h*w,1);
image = single(reshape(image,h*w,c));
tmp(mask == 1,:) = image(mask == 1,:); 

pixels = single(image(mask == 1,:)); % all index which mask = 1. 


if VERBOSE == 0
    tmp = reshape(tmp,h,w,c);

    tmp = uint8(tmp);
    figure()
    subplot(1,2,1)
    imshow(tmp)
    title('Masked part')
    subplot(1,2,2)
    tmp2 = uint8(image);
    tmp2 =reshape(tmp2,h,w,c);
    imshow(tmp2)
    title('Original')
end


% #2. Randomly initialize the K components using masked pixels
g_func =@(E,diff) 1/sqrt((2*pi)^3*det(E))*exp(-0.5*sum(diff * E^(-1) .* diff,2));
[segments, centers] = kmeans_segm2(pixels, K, L,6);
K = size(centers,1);
cov = cell(K,1);
weight = zeros(K,1);
for k = 1:K
    cov(k) = {eye(3)*rand*255}; 
    weight(k) = sum(segments == k)/(size(pixels,1));
end

% #3. Iterate L times
N = size(pixels,1);
g = zeros(N,K);
for l = 1:L
    % #4. Expectation: Compute probabilities P_ik using masked pixels
    for k = 1:K
        E = cov{k};
        diff = bsxfun(@minus, pixels, centers(k,:));
        g(:,k) = g_func(E, diff);
        wg(:,k) = weight(k)*g(:,k);
    end
    p = wg./(sum(wg,2));
%     plot(sum(p,2));
    % #5. Maximization: Update weights, means and covariances using masked pixels
    weight = sum(p,1)/N;
    centers = p'*pixels./sum(p',2);
    for k = 1:K
        diff = bsxfun(@minus, pixels, centers(k,:));
        cov(k) =  {(p(:,k)'.*diff')*diff/sum(p(:,k))};
    end   
end
% #6. Compute probabilities p(c_i) in Eq.(3) for all pixels I.
g_tot = zeros(size(image,1),K);
for k = 1:K
    E = cov{k};
    diff = bsxfun(@minus, image, centers(k,:));
    g_tot(:,k) = g_func(E, diff);
    wg_tot(:,k) = weight(k)*g_tot(:,k);
end
prob = sum(wg_tot,2);
end