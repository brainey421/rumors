% Computes and plots solution curves for the SIR model of a rumor 
% using Euler's method.

%% Initialize parameters and functions

N = 10000;      % population
T = 0.01;       % total time

% Probabilities should be in [0, 1]
alpha = 0.5;    % spreading coefficient
beta = 0.5;     % quashing coefficient

h = 0.0001;     % step size for Euler's method

% System of differential equations
Sprime = @(S, I, R)(-S*I);
Iprime = @(S, I, R)(alpha*S*I - beta*I*(I + R));
Rprime = @(S, I, R)((1-alpha)*S*I + beta*I*(I + R));

% Initial condition
I1 = 1;

%% Compute solutions

npts = T/h + 1;

S = zeros(npts, 1);
I = zeros(npts, 1);
R = zeros(npts, 1);

S(1) = N - I1;
I(1) = I1;
R(1) = 0;

for ii=2:npts
    S(ii) = S(ii-1) + h*Sprime(S(ii-1), I(ii-1), R(ii-1));
    I(ii) = I(ii-1) + h*Iprime(S(ii-1), I(ii-1), R(ii-1));
    R(ii) = R(ii-1) + h*Rprime(S(ii-1), I(ii-1), R(ii-1));
end

%% Plot solution curves

tt = linspace(0, T, npts);

clf;

hold all;

set(gca, 'FontSize', 15, 'LineWidth', 1);

plot(tt, S, 'k', 'LineWidth', 2);
plot(tt, I, 'r', 'LineWidth', 2);
plot(tt, R, 'b', 'LineWidth', 2);

axis([0, T, 0, N]);
title('SIR Model of a Rumor');
xlabel('time');
ylabel('people');
legend('S', 'I', 'R');

hold off;