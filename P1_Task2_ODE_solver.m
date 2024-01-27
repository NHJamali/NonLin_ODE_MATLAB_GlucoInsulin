% Define the time span
t_start = 0;
t_end = 600; % Specify the end time of the simulation

% Define the initial conditions
initial_x1 = 150; % Specify the initial value of x1
initial_x2 = 30; % Specify the initial value of x2
x0 = [initial_x1; initial_x2];

% Define the constant input value for r(t)
r = 80;
tM1 = 1;
tM2 = 300;
% Define the input functions
u = @(t) [tM1;tM2; r];

% Define the parameter vector theta
theta = [2.08; -4.60; -7.99; -2.91; 0.08; 2.15; -0.07; 0.39; -0.03]; % Added theta(10)

% Solve the ODE system
[t, x] = ode45(@(t, x) G_I_dynamics_Type1(t, x, u(t), theta), [t_start, t_end], x0);

% Plot the results
figure

subplot(2,1,1)

plot(t, x(:, 1), 'b-', 'LineWidth', 2); % Plot x1(t)
hold on;
xlabel('Time (min)');
title('Glucose-Insulin Dynamics');
ylabel('Glucose Concentration (mg/dl)');
legend('x1(t)','G_r');
grid on;
axis([0 t_end 0 400])
subplot(2,1,2)
plot(t, x(:, 2), 'b-', 'LineWidth', 2); % Plot x2(t)
xlabel('Time (min)');
ylabel('Insulin Concentration mU/l');
legend('x2(t)','I_r');
axis([0 t_end 0 150])
grid on;