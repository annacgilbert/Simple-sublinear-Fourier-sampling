function s = eval_sig_vect(x, pts, N)
	% Assumes that the input signal x IS given as a vector of length N, rather than a k-term
	% trigonometric polynomial.

	p = length(pts);
	s = zeros(1,p);

	s = x(mod(pts, N) + 1);
