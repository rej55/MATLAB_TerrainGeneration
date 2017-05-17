%% Generate the random terrain with Perlin noise
function H = perlin_2d(f, X, Y)
    %% Generate the gradient on control points
    [cpx, cpy] = meshgrid([floor(X(1,1)):ceil(X(end, end))], [floor(Y(1,1)):ceil(Y(end, end))]);
    Gx = randn(size(cpx));
    Gy = randn(size(cpy));
    FGx = scatteredInterpolant(cpx(:), cpy(:), Gx(:));
    FGy = scatteredInterpolant(cpx(:), cpy(:), Gy(:));

    %% Calculate the control points corresponding to each input coordinates
    I0 = floor(X);
    I1 = ceil(X);
    J0 = floor(Y);
    J1 = ceil(Y);

    %% Calculate the distance between each coordinates and control points 
    U0 = X - I0;
    U1 = X - I1;
    V0 = Y - J0;
    V1 = Y - J1;

    %% Interpolate the heights on each coordinates from the gradients on control points
    N00 = FGx(I0, J0).*U0 + FGy(I0, J0).*V0;
    N01 = FGx(I0, J1).*U0 + FGy(I0, J1).*V1;
    N10 = FGx(I1, J0).*U1 + FGy(I1, J0).*V0;
    N11 = FGx(I1, J1).*U1 + FGy(I1, J1).*V1;

    n0 = (1 - f(U0)).*N00 + f(U0).*N10;
    n1 = (1 - f(U0)).*N01 + f(U0).*N11;
    H = (1 - f(V0)).*n0 + f(V0).*n1;
end
    