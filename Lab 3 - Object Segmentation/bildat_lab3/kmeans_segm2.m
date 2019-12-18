function [ segmentation, centers ] = kmeans_segm2(image, K, L, seed, split)
if nargin < 5 
    split = 0; 
end
if nargin < 4
    seed = 14;
end

% H  = size(image,1);
% W = size(image,2);
% image = reshape(image,H*W,3);
rng(seed)
N = size(image,1);
RGB = size(image,2);
image = double(image);

if split
    if split > K 
        disp('split must be <=K, split = K')
        split = K;
    end
    Sigma = 10; 
    mu = zeros(split,RGB);
    centers = zeros(K,RGB);
    K_floor = floor(K/split);
    K_rest = mod(K,split);
    for i = 1:split
        mu(i,:) = mean(image(((i-1)*floor(end/split))+1:i*floor(end/split)));
        centers(1+K_floor*(i-1):K_floor*i,:) = repmat(mu(1,:),K_floor,1) + randn(K_floor,3)*Sigma;
    end
    centers((K-K_rest)+1:end,:) = [randi([0, 255], K_rest,RGB)];
end


if ~ split
centers = randi([0,255], K, RGB);
end

D = pdist2(image,centers);
for l = 1:L
    [~,I] = min(D,[],2);
    for j = 1:K
       temp = image( I == j,:);
       centers(j,:) = mean(temp);
    end
    D = pdist2(image,centers);
end
centers = centers( ~isnan(centers(:,1)),:);
D = D(:, ~isnan(D(1,:)));
[~,I] = min(D,[],2);
segmentation = I;


% segmentation = reshape(I,H,W,1); 


% segmentation = zeros(N,1);
% for j = 1:K
%    segmentation( I == j,:) = round(sum(centers(j,:)));
% end
% segmentation = reshape(segmentation,H,W,1);
end