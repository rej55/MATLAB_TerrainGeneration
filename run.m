%% Initialize
clear
close

%% Set the range of area to generate the terrain
x = [0:0.01:10];
y = [0:0.01:10];

%% Generate the random terrain with Perlin noise
[X, Y] = meshgrid(x,y);
f = @(t) myinterpolation(t);
H = perlin_2d(f, X, Y);

%% Display the result
imagesc(x, y, H)
axis square