%% Read and listen
fs = 44100;

bass = audioread("bass.mp3");
sound(bass, fs);

guitars = audioread("guitars.mp3");
sound(guitars, fs);

synths = audioread("synths.mp3");
sound(synths, fs);

drums = audioread("drums.mp3");
sound(drums, fs);

bassDur = length(bass) / fs;
guitarsDur = length(guitars) / fs;
synthsDur = length(synths) / fs;
drumsDur = length(drums) / fs;
%% Melody Matrix
melodyMatrix = [bass, guitars, synths, drums];
tmpVector = ones(4, 1);
melody = melodyMatrix * tmpVector;
sound(melody, fs);
%% Minus one
sound(melody - guitars, fs);
%% Signal distortion
T=bassDur/2;
N=length(bass);
timeArray=(0:N-1)/fs;
volumeMod=sin(2*pi*timeArray/T);
volumeMod=volumeMod';
result_1=volumeMod.*melody;
sound(result_1,fs);
%pause(32);
vm2=volumeMod.^2.*2-1;
result_2=vm2.*melody;
sound(result_2,fs)
%% Shorten melody
% А)
X = melodyMatrix';
tmp = X(1:1:length(X(:))/2);
halfMelodyMatrix = reshape(tmp, 4,length(tmp)/4);
halfMelody = sum(halfMelodyMatrix);
%sound(halfMelody,fs);
% Б)
N=size(melodyMatrix,1);
melodyMatrixHalf=melodyMatrix(1:N/2,:);
melodyHalf=sum(melodyMatrixHalf,2);
%sound(melodyHalf,fs);
%% 2-channel sound
chanel_1=melody(melody>0);
chanel_2=melody(melody<0);
fs1=length(chanel_1)/bassDur;
fs2=length(chanel_2)/bassDur;

ch_1=melody.*(melody>0.5);
ch_2=melody.*(melody<0.5);
multiSignal=[ch_1 ch_2];
flip(ch_2);
%sound(multiSignal,fs);
sound(flip(melody),fs);