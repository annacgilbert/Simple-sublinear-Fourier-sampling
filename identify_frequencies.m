function Omega = identify_frequencies(xs, Lambda, k, ats, N)
% Identify the k dominating frequencies in             
% residual = x - current approximation (given by Lambda)
% This function returns frequencies assuming that we start
% indexing them at 0 (which is non-standard for Matlab)
%
% Anna C. Gilbert

i = sqrt(-1);
reps = length(ats(:,1)); 
Omega = zeros(1,k); 
alpha = log2(N);

sig = ats(1,2);
for b = 0:(alpha - 1),
    vote = zeros(1,k);
    for j = 1:reps,
        t = ats(j,1);
        u = sample_shattering(xs(1,:,j), Lambda, t, sig, N);
        v = sample_shattering(xs(2+b,:,j), Lambda, t + (N/(2^(b+1))), sig, N);
 
        for s = 1:k,
            E0= u(s)+ v(s)*exp(-i*pi*Omega(s)/(2^b));
            E1= u(s)- v(s)*exp(-i*pi*Omega(s)/(2^b));
            if ( abs(E1) >= abs(E0) ), 
				vote(s) = vote(s) + 1; 
			end
        end
    end
    for s = 1:k,
        if (vote(s) > reps/2), 
			Omega(s) = Omega(s) + (2^b); 
		end
    end
end

% return the list of unique frequencies found
Omega = unique(Omega);

	   


