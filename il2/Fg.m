function [sumg] = Fg(x, i, f)
    sumg = 0;
    g = @(x) (x+1).*heaviside(x+1) - 2*x.*heaviside(x) + (x-1).*heaviside(x-1);
    y = linspace(0, length(i), 3000);
    for a = 1:length(i)
        sumg = sumg + g(x-a+1)*f(a);
        plot(y, g(y-a+1)*f(a));
        hold on;
    end
end

