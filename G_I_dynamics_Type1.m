function dxdt = G_I_dynamics_Type1(t, x, u, theta)
    b0 = theta(1);
    b1 = exp(theta(2));
    b2 = exp(theta(3));
    v1 = -abs(theta(7));
    meu1 = abs(theta(6));
    meu2 = abs(theta(8));
    v2 = -abs(theta(9));
    c1 = exp(theta(4));
    c2 = theta(5);
    
    x1 = x(1);
    x2 = x(2);
    
    if t >= u(1)
        u1_val = t - u(1);
 

        
    else
        u1_val = 0;
    end
    
    if t >= u(2)
        u2_val = t - u(2);
       
        
    else
        u2_val = 0;
    end


    % Insulin dose (external)
    if t >= 30 && t<= u(1)+100
       IV_G1 = u(3);
        
    else
       IV_G1 =5;
    end
    
    if t >= 330 && t<= u(2)+100
        IV_G2 = u(3);
        
    else
        IV_G2 = 5;
    end
    
    dxdt = zeros(2, 1);
    dxdt(1) = b0 - b1 * x1 - b2 * x1 * x2 + meu1 * u1_val * exp(v1 * u1_val) + meu2 * u2_val * exp(v2 * u2_val);
    dxdt(2) = -c1*x2 + c2*IV_G1+c2*IV_G2; % Incorporate time-dependent input
    
end