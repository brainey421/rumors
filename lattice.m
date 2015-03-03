% Simulates the spread of a rumor using the synchronous stochastic 
% cellular automaton SIR model.

%% Initialize definitions and parameters

SUS = 1;        % Susceptible
INF = 2;        % Infected
REM = 3;        % Removed

N = 100;        % Square root of population
T = 1000;       % Number of steps

% Probabilities should be in [0, 1]
alpha = 0.6;    % spreading coefficient

source = [50, 50];

%% Simulate

L = zeros(N, N);

for ii=1:N
    for jj=1:N
        L(ii, jj) = SUS;
    end
end

L(source(1), source(2)) = INF;

S = zeros(T, 1);
I = zeros(T, 1);
R = zeros(T, 1);

S(1) = N*N - 1;
I(1) = 1;
R(1) = 0;

for step=2:T
    Lold = L;
    for ii=1:N
        for jj=1:N
            if Lold(ii, jj) == INF
                cell = rand;
                offsetx = 0;
                offsety = 0;
                if cell < 0.25
                    offsetx = 1;
                elseif cell < 0.5
                    offsetx = -1;
                elseif cell < 0.75
                    offsety = 1;
                else
                    offsety = -1;
                end
                neighbor = [mod(ii + offsetx - 1, N) + 1, mod(jj + offsety - 1, N) + 1];
                
                if Lold(neighbor(1), neighbor(2)) == SUS
                    if rand < alpha
                        L(neighbor(1), neighbor(2)) = INF;
                    else
                        L(neighbor(1), neighbor(2)) = REM;
                    end
                end
            end
        end
    end
    
    S(step) = 0;
    I(step) = 0;
    R(step) = 0;
    for ii=1:N
        for jj=1:N
            if L(ii, jj) == SUS
                S(step) = S(step) + 1;
            elseif L(ii, jj) == INF
                I(step) = I(step) + 1;
            else
                R(step) = R(step) + 1;
            end
        end
    end
end

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
legend('S(t)', 'I(t)', 'R(t)');

hold off;

%% Plot lattice

clf;

hold all;

set(gca, 'FontSize', 15, 'LineWidth', 1);

for ii=1:N
    for jj=1:N
        if L(ii, jj) == INF
            plot(ii, jj, 'r.');
        elseif  L(ii, jj) == REM
            plot(ii, jj, 'b.');
        end
    end
end

plot(source(1), source(2), 'k.', 'MarkerSize', 32);

axis([0, N+1, 0, N+1]);
title('Lattice Model of a Rumor');

hold off;