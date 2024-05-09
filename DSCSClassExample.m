close all
clear all
clc

%% acoustic material
material = struct( 'acoustics', true, ...
                   'v', 1, ...
                   'Frequency', 10, ...
                   'correlationLength', 10, ...
                   'spectralType', 'exp', ...
                   'coefficients_of_variation', [0.1 0.2], ...
                   'correlation_coefficients', -0.5 );
d = 3;
obj = DSCSClass(mat,d);
