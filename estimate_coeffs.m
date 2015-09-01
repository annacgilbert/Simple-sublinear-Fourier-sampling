function c = estimate_coeffs(xs, Lambda, Omega, k, ats, N)
	
	i = sqrt(-1);
	[reps, ~] = size(ats);
	L = length(Omega);
	c = zeros(reps,L);
	
	for j = 1:reps
		t = ats(j,1);
		sig = ats(j,2);
		u = sample_residual(xs(j,:), Lambda, t, sig, N);
		for l = 1:L
 			c(j,l) = sum( u .* exp(-2*pi*i*Omega(l)*sig.*(0:1:k-1)/N) );
 			c(j,l) = sqrt(N)/k * c(j,l) * exp(-2*pi*i*Omega(l)*t/N);
		end
    end
	
    c = median(c);