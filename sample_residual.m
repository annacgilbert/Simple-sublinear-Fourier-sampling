function r = sample_residual(samples, Lambda, t, sig, N)
	
	% if the current repn is NOT empty, then draw samples from it.
	% current repn = sparse Fourier signal (without any noise)
	%
	% Anna C. Gilbert
	
	if (~isempty(Lambda))   

		freq = Lambda(:,1);
 		coef = Lambda(:,2);

		k = length(samples);
		r = zeros(1,k); 
	
		for q = 1:k,
    		vq = 0;
    		for j = 1:length(freq),
                vq = vq + coef(j) * exp(2*pi*i*(freq(j)-1) * ...
                    (t + sig*(q-1))/N); 

    		end
    		r(q) = samples(q) - (1/sqrt(N))*vq;
		end
	else
		r = samples;
	end


