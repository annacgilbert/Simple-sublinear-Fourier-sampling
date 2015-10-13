# Simple-sublinear-Fourier-sampling
This library of matlab code provides a very simple implementation of a sublinear Fourier sampling algorithm. This is not the fastest algorithm or implementation, nor is it the most sophisticated, but it is an example of a straightforward sublinear time algorithm. 

It is modeled on A. C. Gilbert ; S. Muthukrishnan and M. Strauss, "Improved time bounds for near-optimal sparse Fourier representations", Proc. SPIE 5914, Wavelets XI, 59141A (May 04, 2011); doi:10.1117/12.615931; http://dx.doi.org/10.1117/12.615931.

Files included are
* estimate_coeffs.m
* eval_sig.m
* fourier_sampling.m
* generate_sample_set.m
* generate_signal.m
* generate_tspairs.m
* identify_frequencies.m
* sample_residual.m
* sample_shattering.m
* test_AAFFT_with_presampling.m

The driver file is __test_AAFFT_with_presampling.m__ At the top of this file, you set up the signal and all of its parameters (length, number of tones, and total l2 norm of the additive white noise, if there is any). The function __generate_signal.m__ sets up a data structure for the signal. It does *not* generate *all* of the signal values as this would be a wasteful procedure! Next, you set up the parameters of the AAFFT algorithm. Please see the comments for reasonable values. __generate_tspairs.m__ generates the pairs of random numbers for the random arithmetic progressions while the code in __generate_sample_set.m__ actually generates the indices at which we sample the signal. There are two different sampling sets, __samp1__ and __samp2__; one for identification and one for estimation. Note that they are structured differently. Also, if you want to visualize just what indices are sampled, you can plot these sets. The variables __xs1__ and __xs2__ contain the actual sample values. Note that we actually compute the signal at these sample points rather than sampling from a large vector (more space-efficient). The function __fourier_sampling.m__ does all of the important work and returns a data structure containing frequencies and their associated coefficients. The last lines of the driver file compute the error of the returned representation.
