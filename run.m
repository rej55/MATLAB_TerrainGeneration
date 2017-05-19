%% Initialize
clear
close

%% Set the range of area to generate the terrain
x = gpuArray([0:0.01:3]);
y = gpuArray([0:0.01:3]);

%% Generate the random terrain with Perlin noise
% Initial calculation
[X, Y] = meshgrid(x,y);
f = @(t) myinterpolation(t);
H = perlin_2d(f, 10, X, Y);

% Fractal Perlin noise
n = 8;
for i = 1:n
    xtmp = 2^i*x;
    ytmp = 2^i*y;
    [Xtmp, Ytmp] = meshgrid(xtmp, ytmp);
    Htmp = perlin_2d(f, 10*0.5^i, Xtmp, Ytmp);
    H = H + Htmp;
end

%% Display the result
h = surf(X, Y, 0.2*H);
h.EdgeColor = 'none';
axis([0 3 0 3 -15 15])
axis square