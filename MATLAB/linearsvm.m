function [m, b]=linearsvm(tr0, tr1)
    nf = size(tr0, 2);
    combined_data = [tr0; tr1];
    
    lp_A = [combined_data, -combined_data, ones(length(combined_data), 1)];
    lp_b = [-ones(length(tr0), 1); ones(length(tr1), 1)];
    lp_c = ones(2*nf + 1, 1);
    
    size_A = size(lp_A)
    size_b = size(lp_b)
    size_c = size(lp_c)
    
    ge_cons = (length(tr0) + 1):length(lp_b);
    eq_cons = [];
    neg_var = [];
    free_var = [2*nf + 1];
    [x, y, z, iters] = rsimplex(lp_A, lp_b, lp_c, 'min', ge_cons, eq_cons, neg_var, free_var);
    
    m = z(1:nf) - z(nf + 1:2*nf);
    b = z(2*nf + 1);
end