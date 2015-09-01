function [xs1, xs2, samp1, samp2] = generate_sample_set(x, N, m, ats1, ats2, width)
	% generates sample set for identification and for estimation. 
	
	K = width*m;
	
	[nr1, ~] = size(ats1);
	samp1 = zeros(log2(N)+1,K,nr1);
	xs1 = zeros(log2(N)+1,K,nr1);
	for j = 1:nr1,
			t = ats1(j,1); 
			s = ats1(j,2);
	    	final = t + s*(K-1);
	    	aprog = t:s:final;
			for b = 0:log2(N),
				geoprog = mod(aprog + (N/(2^b)),N);
				xs1(b+1,:,j) = eval_sig(x, geoprog, N);
	        	samp1(b+1,:,j) = geoprog;
	    	end
	end

	[nr2, ~] = size(ats2);
	samp2 = zeros(nr2,K);
	xs2 = zeros(nr2,K);
	for j = 1:nr2,
	    t = ats2(j,1); 
		s = ats2(j,2);
		final = t + s*(K-1);
		aprog = t:s:final;
		xs2(j,:) = eval_sig(x, mod(aprog,N), N);
		samp2(j,:) = mod(aprog,N);
	end
	