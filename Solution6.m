% Define the time span
t_start = 0;
t_end = 430; % Specify the end time of the simulation
data=load('PT3_data.mat');
T_r=data.Time;
G_r=data.PT3_Glucose;
I_r=data.PT3_Insulin;

% Define the initial conditions
initial_x1 = 280; % Specify the initial value of x1
initial_x2 = 50; % Specify the initial value of x2
x0 = [initial_x1; initial_x2];

% Define the constant input value for r(t)
r = 60;
tM1 = 80;
tM2 = 300;
% Define the input functions
%u = @(t) [tM1;tM2; r];

% Define the parameter vector theta
theta = [2.08; -4.60; -7.99; -2.91; 0.08; 2.15; -0.07; 0.39; -0.03;tM1;tM2; r]; % Added theta(10)

%using fminsearch

sol=fminsearch(@(theta) obj_Func_odefun3(theta,T_r,G_r,I_r,x0),theta);
u = [sol(10),sol(11),sol(12)];
% Solve the ODE system
[t, x] = ode45(@(t, x) odefun3(t, x, u, sol), [t_start, t_end], x0);



%Plot the results
figure
title('Glucose-Insulin Dynamics');
subplot(2,1,1)
plot(t, x(:, 1), 'b-', 'LineWidth', 2); % Plot x1(t)
hold on;
plot(T_r,G_r,'r+')
xlabel('Time (min)');
ylabel('Glucose Concentration (mg/dl)');
legend('Glucose-Model','Glucose-Patient3');
grid on;
title('Fitting the Model to Patient3 data')
axis([0 t_end 0 400])
subplot(2,1,2)
plot(t, x(:, 2), 'b-', 'LineWidth', 2); % Plot x2(t)
hold on;
plot(T_r,I_r,'r*')
xlabel('Time (min)');
ylabel('Insulin Concentration mU/l');
legend('Insulin-Model','Insulin-Patient3');
axis([0 t_end 0 150])

grid on;