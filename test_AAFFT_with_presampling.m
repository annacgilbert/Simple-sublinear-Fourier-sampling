% test AAFFT with pre-sampling; i.e., don't take the IFFT to generate 
% the signal explicitly + sample, just sample from the sparse signal.
%
% Anna C. Gilbert

clear all

% set up the parameters
N = 2^15;  % N = signal length, must be a power of 2
m = 2;     % number of total tones
nu = 0.01; % TOTAL norm of the additive white noise added to sparse signal

% generate the data structure that contains signal information
x = generate_signal(N,m,nu);   

% reps1 = # repetitions in the main loop of AAFFT (in fourier_sampling.m)
% reps2 = # repetitions in identification of frequencies
% reps3 = # repetitions in estimation of coefficients
% width = width of Dirchlet kernel filter
% typical values are 
% reps1 = 5
% reps2 = 5
% reps3 = 5

reps1 = 3; 
reps2 = 5; 
reps3 = 11;
width = 15; 

% ats1 = frequency identification => reps1 * reps2 pairs of random seeds t,s 
%        (reps2 independent seeds for s and reps1*reps2 seeds for t)
% ats2 = coefficient estimation => reps1 * reps3 pairs of random seeds t,s (all independent)
% to visualize where the sampling set is:
% samp1 = all the sampling points for identification
% samp2 = all the sampling points for estimation

[ats1, ats2] = generate_tspairs(N,reps1,reps2,reps3);

[xs1, xs2, samp1, samp2] = generate_sample_set(x, N, m, ats1, ats2, width);

Lambda = fourier_sampling( xs1, xs2, m, ats1, ats2, reps1, reps2, reps3, N, width );

% Lambda contains two columns: the first is the frequencies found and the second contains
% the estimated coefficients for each frequency.
% Calculate the relative l^2 error of the returned representation.

[~,recov_freq, orig_freq] = intersect(Lambda(:,1), x.inds);
if ~isempty(recov_freq)
    err_recov = norm(Lambda(recov_freq, 2).' - x.spx(orig_freq));
else
    err_recov = 0;
end
[~, recov_freq] = setdiff(Lambda(:,1), x.inds);
[~, orig_freq] = setdiff(x.inds, Lambda(:,1));
err_unrecov = norm(Lambda(recov_freq,2)) + norm(x.spx(orig_freq));
total_err = err_recov + err_unrecov;
fprintf('total rel. error = %f \n', total_err/norm(x.spx));



