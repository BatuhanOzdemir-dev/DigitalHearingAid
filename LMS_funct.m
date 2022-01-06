clc;
clear;
close all;


answer = inputdlg({'Frequency 1','Frequency 2','Frequency 3','Frequency 4', 'Max Gain', 'Psat'},'Please input frequency spacings and max gain');
frequancys = [str2double(answer{1}),str2double(answer{2}),str2double(answer{3}),str2double(answer{4})];
g = str2double(answer{5});
Psat = str2double(answer{6});

%Program code of recording audio
z=audiorecorder(20000,16,1);
h=msgbox('Speak Up, I am Recording...','Recording');
recordblocking(z,5); %Records a 5 sec audio
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
    title('Kaydedilen Ses');

Fs = 20000;
Ts = 1/Fs;
order = 12;
t = 0:Ts:1-Ts;
%x = sin(2*pi*4*t);
noise = 0.015*randn(size(x));
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
    title('Gürültü Eklenmiş Ses');
%x = x';
b = fir1(order,0.2,'low');
d = filter(b,1,x);
mu = 0.03;
lms = dsp.LMSFilter(order+1, 'StepSize', mu, 'WeightsOutputPort', true);
[y,e,w] = step(lms, x,d);
stem([b.' w]); title('LMS Filtresinin Sistem Görünümü');
hold;

% testing
figure;
    plot(y);
    title('Kazanım Eklenmemiş Sinyal');

promptMessage=sprintf('Play the filtered signal without gain implemented?')
titleBarCaption='Play';
button = questdlg(promptMessage,titleBarCaption,'Yes', 'No','Yes');
if strcmpi(button,'Yes')
soundsc(y,Fs);
else
end

figure;
xf = applySkiSlope(y, g, frequancys, Fs);
yt = powerCompress(xf, Psat, Fs);

%Block to play audio and corresponding graph
promptMessage=sprintf('Do want to play your recovered file?');
titleBarCaption='Play';
button = questdlg(promptMessage,titleBarCaption,'Yes', 'No','Yes');
if strcmpi(button,'Yes')
soundsc(yt,Fs);
else
end
figure;
    plot(yt);
    title('Sesin Son Çıktısı');