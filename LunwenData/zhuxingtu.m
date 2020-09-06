close all; clear all; clc

results=[95,85,71,100;83,90,89,97];

bar3(results,0.8)

xlabel('Students');
ylabel('Courses');
zlabel('Scores')

title('The results of three students');
colorbar