function [m, b]=linearsvm(tr0, tr1)
    X = tr1;
    Y = tr0;
    
    nf = size(X, 2);
    nx = size(X, 1);
    ny = size(Y, 1);
    n = nf + 1 + nx + ny;
    Q = zeros(n, n);
    Q(1:nf, 1:nf) = eye(nf);
    Tau = 1000;
    q = [zeros(nf + 1, 1); Tau * ones(nx + ny, 1)];
    A = [-X   ones(nx, 1)      -eye(nx)        zeros(nx, ny);
         Y    -ones(ny, 1)     zeros(ny, nx)   -eye(ny)];
    b = -ones(nx + ny, 1);
    L = [-inf * ones(nf + 1, 1); zeros(nx + ny, 1)];

    [z, f] = quadprog(Q, q, A, b, [], [], L, [], []);
    
    m = z(1:nf);
    b = z(nf + 1);
end