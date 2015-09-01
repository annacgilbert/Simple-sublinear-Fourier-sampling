function [ats1 ats2] = generate_tspairs(N,reps1,reps2,reps3)
	% function to generate t and sigma pairs for running one instance of AAFFT.
	% Anna C. Gilbert

	% ats1 contains all the (t,s) pairs required for all repetions of frequency
	% identification routine
	% ats2 contains all the (t,s) pairs required for all repetions of estimation
	% routine

	ats1 = zeros(reps1*(reps2),2);
	ats2 = zeros(reps1*(reps3),2);
	alpha = log2(N);

	for j = 0:reps1-1,
		r = floor((2^(alpha-1))*rand(1)) + 1; 
		s = 2*r-1;        % draw s uniformly at random from the ODD integers [1,N-1]

		for n = 1:reps2,
			t = floor(N*rand(1));        % draw t uniformly at random from integers [0,N-1]
			ats1(j*(reps2)+n,1) = t; 
			ats1(j*(reps2)+n,2) = s;
		end

		for n = 1:reps3,
			r = floor((2^(alpha-1))*rand(1)) + 1; 
			s = 2*r-1;                   % draw s uniformly at random from the ODD integers [1,N-1]
			t = floor(N*rand(1));        % draw t uniformly at random from integers [0,N-1]
			ats2(j*(reps3)+n,1) = t; 
			ats2(j*(reps3)+n,2) = s; 
		end
	end
