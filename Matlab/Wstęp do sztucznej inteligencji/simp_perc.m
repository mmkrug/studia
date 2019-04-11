function [w,k] = simp_perc(D,eta)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[m,n] = size(D);
n = n-2;

w = zeros(1,n+1);
k = 0;  % k_max w zakresie 500-5000

while (k<5000)
    E = [];
    
    for i=1:m
        x = D(i,1:n+1);
        y = D(i,end);
        s = w*x';
        f = -1;
        if (s>0)
            f = 1;
        end
        
        if (f ~= y)
            E = [E;[x y]];
            break;
        end
    end
    
    if (isempty(E))
        return
    end
    % random integer, z wektora min i max
    i = randi([1, size(E,1)]);
    
    x = E(i,1:n+1);
    y = E(i,end);
    
    w = w + eta * x * y;
    k = k+ 1;
    
    
end

%outputArg1 = inputArg1;
%outputArg2 = inputArg2;
end

