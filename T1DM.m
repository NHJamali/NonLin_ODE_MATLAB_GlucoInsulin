% x1(t)= G(t) plasma glucose concentration
% x2(t)= I(t) Plasma Insulin Concentration
theta=[2.08;-4.60;-7.99;-2.91; 0.08;2.15;-0.07; 0.39;-0.03];
b0=theta(1); %is the constant increase in plasma glucose concentration due to constant baseline liver glucose release
b1=exp(theta(2)); %is the spontaneous glucose 1st order disappearance rate,
b2=exp(theta(3)); %is the insulin-dependent glucose disappearance rate.


% Meal and Glucose release in the blood from Gut,  model μ(t −tM)+ exp(ν(t −tM)+)
tM % starting time of the meal,
v1=-abs(theta(7)); %is the parameter related to the rate of glucose absorption from the gut
meu1=abs(theta(6));%is the product of the distribution volume and the constant related to the total amount of carbohydrates consumed
meu2=abs(theta(8));
v2=-abs(theta(9));

c1=exp(theta(4)); % is the insulin 1st order disappearance rate
c2=theta(5); % is the reciprocal of the volume of the insulin distribution space
% r(t) [mU/min] is the IV insulin infusion rate.


% for T1DM patients, the pancreas does not release insulin,
% and insulin concentration I(t) is independent of G(t). Thus, we consider the following
% nonhomogeneous nonlinear ODE model for an individual T1DM subject
% on IV insulin delivery and consuming L meals at times tM1, . . . , tML

x(t)=[x1(t),x2(t)]';
u(t)=[u1(t),u2(t),u3(t)]';


f1(x(t),u(t),t,theta) =b0 -b1*x1(t)-b2*x1(t)*x2(t)+ meu1*u1(t)*exp(v1*u1(t)) + meu2*u2(t)*exp(v2*u2(t));

f2(x(t),u(t),t,theta)=-c1*x2(t)+c2*u3(t);


