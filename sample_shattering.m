function z = sample_shattering(samples, Lambda, t, sig, N)
	% Input
	% samples : a set of samples from the signal
	% Lambda : data structure containing current frequencies and coefficients
	% t : one random offset (for arithmetic progression)
	% sig : one random step-size (for arithmetic progression)
	% N : signal length (should be a power of two)
	%
	% Output : a vector z that is the FFT of samples from residual
	%
	% Anna C. Gilbert
	
	z = sample_residual(samples, Lambda, t, sig, N);
	n = length(z);
	z = (1/sqrt(n))*fft(z);
