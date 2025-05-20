function rates = estimate_rates(errors, m_values)
%ESTIMATE_RATES Estimate convergence rates from error table.
%
% rates(i) is the estimated order for the i-th row of errors.

rates = zeros(1, size(errors, 1));
for i = 1:size(errors, 1)
    p = polyfit(log(1 ./ m_values), log(errors(i, :)), 1);
    rates(i) = -p(1);
end
end