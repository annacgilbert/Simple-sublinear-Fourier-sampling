function s = eval_sig(x, pts, N)

	p = length(pts);
	s = zeros(1,p);

	for j = 1:p
		s(j) = 0;
		for l = 1:length(x.inds)
			s(j) = s(j) + x.spx(l) * exp( 2*pi*i*pts(j)*(x.inds(l)-1)/N );
        end
        % to get total l^2 norm = nu, scale random variable by 1/sqrt(N)
		s(j) = 1/sqrt(N) * (s(j) + x.nu * randn(1)); 
	end
