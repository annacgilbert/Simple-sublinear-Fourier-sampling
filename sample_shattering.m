function z = sample_shattering(samples, Lambda, t, sig, N)
	
	z = sample_residual(samples, Lambda, t, sig, N);
	n = length(z);
	z = (1/sqrt(n))*fft(z);
