function x = generate_signal(sigsize, sparsity, noise)
%
% generate_signal: randomly choose non-zero frequencies and give them
%          frequencies that are Gaussian random variables
%
% inputs:  sigsize: size (frequency bandwidth) of signal.
%          sparsity: number of non-zero frequencies
%          noise: the variance of the AWGN in the signal
% 
% outputs:  x: physical-space signal
%           x.inds : location of non-zero frequencies (assuming we start with 1)
%           x.spx : fourier-space signal
%           x.nu : variance of the AWGN in signal
% 
% Anna C. Gilbert

	a = randperm(sigsize);  % permute frequencies
 	x.inds = a(1:sparsity);   
 	x.spx = randn(1,sparsity);   % Gaussian random coefficients
 	x.nu = noise;
    