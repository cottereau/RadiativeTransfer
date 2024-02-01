% This code works in 2D/3D. The initial condition is modeled as gaussian 
% with standard deviation source.lambda and uniformly-distributed angle(s).
% The initial direction is uniform.

geometry = struct( 'dimension', 2 );

% Point source
source = struct( 'numberParticles', 1e6, ...
                 'polarization', 'P', ...
                 'lambda', 0.1 );

% observations
observation = struct('dr', 0.04, ...        % size of bins in space
                     'time', 0:0.0167:34.13, ...  % observation times
                     'Ndir', 10 );         % number of bins for directions           
 
% material properties
% material.coefficients_of_variation defines the coefficients of variaiton
% of lambda, mu (Lamé coefficients) and rho (density), respectively.
% material.correlation_coefficients defines the correlation coefficient
% between (lambda,mu), (lambda,rho), and (mu,rho), respectively.
material = struct( 'acoustics', false, ...
                   'vp', 6, ...
                   'vs', 3.46, ...
                   'Frequency', 0.1, ...
                   'correlationLength', 20, ...
                   'spectralType', 'exp', ...
                   'coefficients_of_variation', [0.8 0.8 0.], ...
                   'correlation_coefficients', [0.1 0. 0.]);
% 2D
material.sigma = {@(th) 1/2/pi*ones(size(th))*0.05*6, @(th) 1/2/pi*ones(size(th))*0.05*6; ...
                  @(th) 1/2/pi*ones(size(th))*0.029*3.46, @(th) 1/2/pi*ones(size(th))*0.144*3.46};

% 3D
% material.sigma = {@(th) 1/8/pi*ones(size(th)), @(th) 2*sqrt(3)^3/20/pi*ones(size(th)); ...
%                   @(th) 1/20/pi*ones(size(th)), @(th) 1/8/pi*ones(size(th))};

% material.sigma = PSDF2sigma( material, geometry.dimension );

% radiative transfer solution - acoustic with boundaries
obs = radiativeTransferUnbounded( geometry.dimension, source, material, observation );

% plotting output
sensors = [1 0 0; 9 0 0];
plotEnergies( obs, material, source.lambda, sensors );
