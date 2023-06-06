clear all;
close all;
clc;

%% ENVIRONMENT GENERATION

% Define the size of the environment
width =  10;
height = 10;

% Create the figure
figure, hold on;
axis equal;
axis([0 width 0 height]);
grid on;
plot(NaN, NaN, 'r', 'LineWidth', 2);

% Define the obstacles
numObstacles =   4;
ObstacleWidth =  [2, 1, 1, 1];    % width
ObstacleHeight = [1, 2, 1, 2];    % height
ObstaclesPosition = [1, 1;
                     5, 3;
                     3, 7;
                     8, 6];
% Rotate the last obstacle
rotationAngle = -45;                         % rotation angle (deg)
rotationAngleRad = deg2rad(rotationAngle);   % rotation angle (rad)

rotationMatrix = [cos(rotationAngleRad) -sin(rotationAngleRad); ...
    sin(rotationAngleRad) cos(rotationAngleRad)];

centerOfRotation = [ObstaclesPosition(4, 1) + ObstacleWidth(4)/2, ...
    ObstaclesPosition(4, 2) + ObstacleHeight(4)/2];

translatedX = [ObstaclesPosition(4, 1), ObstaclesPosition(4, 1) + ObstacleWidth(4), ...
    ObstaclesPosition(4, 1) + ObstacleWidth(4), ObstaclesPosition(4, 1)] - centerOfRotation(1);
translatedY = [ObstaclesPosition(4, 2), ObstaclesPosition(4, 2), ...
    ObstaclesPosition(4, 2) + ObstacleHeight(4), ObstaclesPosition(4, 2) + ObstacleHeight(4)] - centerOfRotation(2);

rotatedCoords = rotationMatrix * [translatedX; translatedY];

rotatedX = rotatedCoords(1, :) + centerOfRotation(1);
rotatedY = rotatedCoords(2, :) + centerOfRotation(2);

% Draw the obstacles
for i = 1:numObstacles
    if (i == 1) || (i == 2) || (i == 3)
        rectangle('Position', [ObstaclesPosition(i, 1), ...
            ObstaclesPosition(i, 2), ObstacleWidth(i), ObstacleHeight(i)], ...
            'FaceColor', 'r');
    elseif i == 4
        % Plot the rotated rectangle
        patch(rotatedX, rotatedY, 'r');
    end
end

title('Environment with some obstacles');
