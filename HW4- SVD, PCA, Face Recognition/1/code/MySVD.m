%% MySVD

% Input matrix
A = [1, 3, 3, 2; 1, 2, 4, 6; 4, 5, 3, 9];

% mySVD function
[U,S,V] = mySVD(A);

disp("Input matrix:");
disp(A);

disp("U:")
disp(U);

disp("S:")
disp(S);

disp("V:")
disp(V);

check = U * S * V.';

disp("Check that USVt = A:")
disp(check);


function [U,S,V] = mySVD(A)

    B = A * A.';
    C = A.' * A;
    [U,SSt] = eig(B);
    [V,StS] = eig(C);

    S = U.' * A * V;    
end