
% Script to demonstrate composite Gauss quadrature and Richardson
% extrapolation as required in the five questions.

clear; clc; close all;

%% Question 1 -----------------------------------------------------------
% The composite Gauss quadrature is implemented in gauss_quad.m together
% with helper routine gauss_legendre.m.

%% Question 2 -----------------------------------------------------------
% Test the implementation on f(x) = exp(x)*sin(x) over [-pi, 7*pi/6].

f = @(x) exp(x) .* sin(x);
a = -pi;
b = (7*pi)/6;

I_exact = analytical_integral(a, b);

n_values = 1:5;

m_values = 2.^(1:10);

errors = calc_errors(f, a, b, n_values, m_values, I_exact);
plot_results(m_values, errors, n_values, '复合高斯求积法误差');

rates = estimate_rates(errors, m_values);
fprintf('\n-- 问题2 收敛阶 --\n');
for i = 1:numel(n_values)
    fprintf('n = %d 的收敛阶约为 %.2f\n', n_values(i), rates(i));
end

%% Question 3 -----------------------------------------------------------
% Apply Richardson extrapolation to obtain more accurate results.

errors_ext = calc_errors_richardson(f, a, b, n_values, m_values, I_exact);
plot_results(m_values, errors_ext, n_values, '理查森外推法误差');

rates_ext = estimate_rates(errors_ext, m_values);
fprintf('\n-- 问题3 收敛阶 --\n');
for i = 1:numel(n_values)
    fprintf('n = %d 的理查森外推法收敛阶约为 %.2f\n', n_values(i), rates_ext(i));
end

%% Question 4 -----------------------------------------------------------
% Choose a non-linear non-polynomial function and repeat the tests.

f_new = @(x) exp(-x.^2) .* sin(x); % smooth oscillatory function
% Integrate on [0,2].
a_new = 0;
b_new = 2;

I_exact_new = integral(f_new, a_new, b_new, 'AbsTol', 1e-14);

n = 5; % use 5 Gauss points for better accuracy on oscillatory integrand
errors_new = calc_errors(f_new, a_new, b_new, n, m_values, I_exact_new);
errors_new_ext = calc_errors_richardson(f_new, a_new, b_new, n, m_values, I_exact_new);

figure;
loglog(1./m_values, errors_new, '-o', 'DisplayName', '原始方法');
hold on;
loglog(1./m_values, errors_new_ext, '-s', 'DisplayName', '理查森外推');
xlabel('子区间长度 h');
ylabel('误差');
title('非多项式函数积分误差');
legend('Location', 'best');
grid on;

rate_new = estimate_rates(errors_new, m_values);
rate_new_ext = estimate_rates(errors_new_ext, m_values);
fprintf('\n-- 问题4 收敛阶 --\n');
fprintf('原始方法收敛阶约为 %.2f\n', rate_new);
fprintf('理查森外推法收敛阶约为 %.2f\n', rate_new_ext);

%% Question 5 -----------------------------------------------------------
% The code is organised into separate functions with clear comments to
% improve readability and structure.
