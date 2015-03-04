% Simulates the spread of multiple rumors using the synchronous stochastic 
% cellular automaton SIR model. Plots a distribution of the number of 
% people who hear the rumor, and plots a probability distribution for 
% the final lattice.

%% Initialize definitions and parameters

SUS = 1;
INF = 2;
REM = 3;

N = 100;        % Square root of population
T = 5000;       % Number of steps
trials = 1000;  % Number of trials

alpha = 0.5;    % Spreading coefficient in [0, 1]

%% Simulate

S = zeros(trials, T);
I = zeros(trials, T);
R = zeros(trials, T);
L = zeros(trials, N, N);

for ii=1:trials
    ii
    [S(ii, 1:T), I(ii, 1:T), R(ii, 1:T), L(ii, 1:N, 1:N)] = lattice(N, T, alpha);
end

%% Plot distribution of number of people who hear rumor

clf;
hold all;
set(gca, 'FontSize', 15, 'LineWidth', 1);

width = floor(N*N/20);
xx = 1:width:N*N;
hist(R(1:trials, T), xx);

xlim([-width, N*N + width]);
title('Lattice Model of a Rumor');
xlabel('people who heard rumor');
ylabel('frequency');

hold off;

%% Plot probability distribution for the final lattice

clf;
hold all;
set(gca, 'FontSize', 15, 'LineWidth', 1);

Lavg = zeros(N, N);

for ii=1:N
    for jj=1:N
        for kk=1:trials
            if L(kk, ii, jj) == REM
                Lavg(ii, jj) = Lavg(ii, jj) + 1;
            end
        end
        Lavg(ii, jj) = Lavg(ii, jj) / trials;
    end
end

for ii=1:N
    for jj=1:N
        ha = plot(ii, jj, 's', 'MarkerSize', 4);
        set(ha, 'color', [1-Lavg(ii, jj), 1-Lavg(ii, jj), 1]);
        set(ha, 'MarkerFaceColor', [1-Lavg(ii, jj), 1-Lavg(ii, jj), 1]);
    end
end

plot(floor(N/2), floor(N/2), 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 4);

axis([0, N+1, 0, N+1]);
title('Lattice Model of a Rumor');

hold off;