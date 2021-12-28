% Program of LMS Algorithm
clc;
clear;
close all;
% Generating Desired Signal
t = 0.001:0.001:1;
D = 2*sin (2*pi*50*t);
% Generating signal Corrupted with Noise
n = numel (D);
A = D(1:n) +0.9*randn(1,n);

M = 25;
w = zeros(1,M);
wi = zeros(1,M);
E = [];
mu = 0.0005;
for i = M:n
    E(i) = D(i) - wi*A(i:-1:i-M+1)';
    wi = wi + 2*mu*E(i)*A(i:-1:i-M+1);
end

% Estimation of the signal
Est = zeros(n,1);
for i = M:n
    j = A(i:-1:i-M+1);
    Est (i) = ((wi)*(j)');
end

% Computing the Error Signal
Err = Est'-D;
Err2 = D - Est;
% Dispilay of Signals
subplot(5,1,1), plot(D);
title('Desired Signal');
subplot(5,1,2), plot(A);
title('Signal Corrupted with Noise');
subplot(5,1,3), plot(Est);
title('Estimation Signal');
subplot(5,1,4), plot(Err);
title('Error Signal');

