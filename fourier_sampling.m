function Lambda = fourier_sampling(xs1, xs2, m, ats1, ats2, reps1, reps2, reps3, N, width)
	
	% function to implement simple version of AAFFT
    % Anna C. Gilbert
    %
	% Input 
    % xs1 : contains the samples of x required for all repetitions of the frequency
    %       identification function, organized in a 3-d data structure
    % xs2 : contains the samples of x required for all repetitions of the estimation
    %       function, organized in a 2-d data structure
    % ats1 : contains all the (t,s) pairs required for all repetions of frequency
    %        identification function
    % ats2 : contains all the (t,s) pairs required for all repetions of
    %        estimation
    % reps1, reps2, reps3 : number of repetitions for parts of the algorithm
    % N : signal length (should be a power of 2)
    % width : width of Dirichlet kernel (or bin) for hashing procedure (hash spectrum)
    %         into bins of size width * m
    %
	% Output : Lambda = m x 2 array, the second column contains the m largest
	% fourier coefficients of x and the first column contains their
	% corresponding frequencies + 1, freqs belong to 0 to N-1, but the column
	% contains frequency + 1, therefore belong to 1 to N.
	


k = width*m; 
Lambda = [];
Omega = zeros(k,1); 
c = Omega; 
list_length = 0;

for j = 1:reps1,
	
    % identify frequencies, generate a list of no more than k unique candidate frequencies

    Omega = identify_frequencies( xs1(:,:,reps2*(j-1)+1 : reps2*(j-1)+reps2,:), ...
    	Lambda, k, ats1(reps2*(j-1)+1 : reps2*(j-1)+reps2,:), N);

    % estimate the coefficients of the frequencies identified above

    c = estimate_coeffs( xs2(reps3*(j-1)+1 : reps3*(j-1)+reps3,:), ...
    	Lambda, Omega, k, ats2(reps3*(j-1)+1 : reps3*(j-1)+reps3,:), N);
        
    % adds 1 to deal with the Matlab indexing "bug"
    Omega = Omega + 1;

    % merges list of frequencies found in this iteration with those (if any)
    % found in previous iterations. If a frequency has already been identified
    % in a previous iteration, we update the coefficient associated with it
    % by adding it to the current estimation.
    for q = 1:length(Omega),
     	if (~isempty(Lambda))
	        I = find(Lambda(:,1) == Omega(q));
    	    if (I), 
        		Lambda(I,2) = Lambda(I,2) + c(q);
            else
                list_length = list_length + 1;
                Lambda(list_length,:) = [Omega(q), c(q)];
            end
         else 
         	list_length = list_length + 1;
         	Lambda(list_length,:) = [Omega(q), c(q)];
         end
    end
    
    % retain the top k = width*m frequencies (sorted by absolute value)
    % one could change this to keep more/fewer frequencies (although m^2
    % destroys the efficiency of the theoretical algorithm)
    [~,I] = sort(abs(Lambda(:,2)),'descend');
    p = min(k,length(I));
    Lambda = Lambda(I(1:p),:);
end

% return the top m frequencies (sorted by absolute value)
% one could change this to keep the top c*m for some constant c.
[~,I] = sort(abs(Lambda(:,2)),'descend');
p = min(m,length(I));
Lambda = Lambda(I(1:p),:);
