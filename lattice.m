function [S, I, R, L] = lattice(N, T, alpha)

% lattice(N, T, alpha)
%
% Simulates the spread of a rumor using the synchronous stochastic 
% cellular automaton model.
% 
% Parameters:
%
% N: Square root of population
% T: Number of steps
% alpha: Spreading coefficient in [0, 1]
% 
% Return values:
%
% S: Number of susceptible people over time
% I: Number of infected people over time
% R: Number of removed people over time
% L: Final lattice

SUS = 1;
INF = 2;
REM = 3;

L = zeros(N, N);

for ii=1:N
    for jj=1:N
        L(ii, jj) = SUS;
    end
end

L(floor(N/2), floor(N/2)) = INF;

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
                rr = rand;
                offsetx = 0;
                offsety = 0;
                if rr < 0.25
                    offsetx = 1;
                elseif rr < 0.5
                    offsetx = -1;
                elseif rr < 0.75
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

end