function errors = calc_errors_richardson(f, a, b, n_values, m_values, I_exact)
%CALC_ERRORS_RICHARDSON Compute errors using Richardson extrapolation.
%
% errors(i,j) corresponds to n = n_values(i) and m = m_values(j).

errors = zeros(length(n_values), length(m_values));
for i = 1:length(n_values)
    n = n_values(i);
    p = 2 * n; % order of Gauss quadrature
    for j = 1:length(m_values)
        m = m_values(j);
        I_ext = richardson(f, a, b, m, n, p);
        errors(i, j) = abs(I_ext - I_exact);
    end
end
end