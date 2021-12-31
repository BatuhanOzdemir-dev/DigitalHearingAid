clc;
clear;
close all;

%Program code of recording audio
z=audiorecorder;
h=msgbox('Speak Up, I am Recording...','Recording');
recordblocking(z,5); %Records a 15 sec audio
delete(h);
x = getaudiodata(z);
%Block to play audio and corresponding graph
promptMessage=sprintf('Do want to play your recorded file?');
titleBarCaption='Play';
button = questdlg(promptMessage,titleBarCaption,'Yes', 'No','Yes');
if strcmpi(button,'Yes')
play(z);
else
end
figure;
    plot(x);
    title('Recorded Sound');

Fs = 9000;
Ts = 1/Fs;
order = 12;
t = 0:Ts:1-Ts;
%x = sin(2*pi*4*t);
noise = 0.02*randn(size(x));
x = x+noise;
x = x/max(x);
%Block to play audio and corresponding graph
promptMessage=sprintf('Do want to play your noisy file?');
titleBarCaption='Play';
button = questdlg(promptMessage,titleBarCaption,'Yes', 'No','Yes');
if strcmpi(button,'Yes')
soundsc(x,Fs);
else
end
figure;
    plot(x);
    title('Noisy Sound');

%x = x';
b = fir1(order,0.3,'low');
d = filter(b,1,x);
mu = 0.03;
lms = dsp.LMSFilter(order+1, 'StepSize', mu, 'WeightsOutputPort', true);
[y,e,w] = step(lms, x,d);
stem([b.' w]); title('System Identification by LMS Filter');
%Block to play audio and corresponding graph
promptMessage=sprintf('Do want to play your recovered file?');
titleBarCaption='Play';
button = questdlg(promptMessage,titleBarCaption,'Yes', 'No','Yes');
if strcmpi(button,'Yes')
soundsc(y,Fs);
else
end
figure;
    plot(y);
    title('Last Sound');