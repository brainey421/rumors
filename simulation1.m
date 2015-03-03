% Simulates the spread of one rumor using the synchronous stochastic 
% cellular automaton SIR model.

%% Initialize definitions and parameters

SUS = 1;
INF = 2;
REM = 3;

N = 100;        % Square root of population
T = 1000;       % Number of steps

alpha = 0.55;    % Spreading coefficient in [0, 1]

%% Simulate

[S, I, R, L] = lattice(N, T, alpha);

%% Plot solution curves

tt = 1:T;

clf;
hold all;
set(gca, 'FontSize', 15, 'LineWidth', 1);

plot(tt, S, 'k', 'LineWidth', 2);
plot(tt, I, 'r', 'LineWidth', 2);
plot(tt, R, 'b', 'LineWidth', 2);

axis([0, T, 0, N*N]);
title('Lattice Model of a Rumor');
xlabel('steps');
ylabel('people');
legend('S', 'I', 'R');

hold off;

%% Plot lattice

clf;
hold all;
set(gca, 'FontSize', 15, 'LineWidth', 1);

for ii=1:N
    for jj=1:N
        if L(ii, jj) == INF
            plot(ii, jj, 'rs', 'MarkerFaceColor', 'r', 'MarkerSize', 4);
        elseif  L(ii, jj) == REM
            plot(ii, jj, 'bs', 'MarkerFaceColor', 'b', 'MarkerSize', 4);
        end
    end
end

plot(floor(N/2), floor(N/2), 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 16);

axis([0, N+1, 0, N+1]);
title('Lattice Model of a Rumor');

hold off;