function errors = calc_errors(f, a, b, n_values, m_values, I_exact)
%CALC_ERRORS Compute errors of composite Gauss quadrature.
%
% errors(i,j) corresponds to using n = n_values(i) Gauss points and
% m = m_values(j) subintervals.

errors = zeros(length(n_values), length(m_values));
for i = 1:length(n_values)
    n = n_values(i);
    for j = 1:length(m_values)
        m = m_values(j);
        I_num = gauss_quad(f, a, b, m, n);
        errors(i, j) = abs(I_num - I_exact);
    end
end
end