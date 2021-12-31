function [detrend_y] = low_pass_filter(signal,Fs)
%LOWPASSFIR Low Pass FIR Filter.
%   Filter the signal with Low Pass Finite Impulse Response. FilterOrder
%   and CutoffFrequency can be changed for better accuracy.
signal = signal';
d = designfilt('lowpassfir', 'FilterOrder', 8, 'CutoffFrequency', 10, 'SampleRate', Fs);
y = filtfilt(d,signal);
detrend_y = detrend(y);
detrend_y = detrend_y';
end

