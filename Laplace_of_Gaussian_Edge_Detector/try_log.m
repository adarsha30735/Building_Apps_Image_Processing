% 
% kernelSize=9;
% lin = round(linspace(-floor(kernelSize/2),floor(kernelSize/2),kernelSize));
% [X,Y] = meshgrid(lin,lin);
% hg = exp(-(X.^2 + Y.^2)/(2*(sigma^2)));
% kernel_t = hg.*(X.^2 + Y.^2-2*sigma^2)/(sigma^4*sum(hg(:)));
% 
% 
% % make the filter sum to zero
% kernel = kernel_t - sum(kernel_t(:))/kernelSize^2;
