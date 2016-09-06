function y = Chorus(x,Fs,delTime,rate,depth)

if nargin < 3
% del time
delTime = 0.002;
% modulator rate
rate = 5;
% mod depth
depth = 0.5;
end

[r,c] = size(x);
idx = 1:r;
% deltime in samps
maxDelSamp = round(delTime*Fs);
% empty out vec.
y = zeros(r,c);

% dont reference empty samps
y(1:maxDelSamp) = x(1:maxDelSamp);
% Make modulating sine wave
sinTab = repmat((depth*sin(2*pi*idx*(rate/Fs)))',1,c);

% iterate over each sample of signal
for i = (maxDelSamp+1 :length(x)),
    mod = abs(sinTab(i));
    mod2Del = ceil(mod * maxDelSamp);
    y(i,:) = (x(i,:)) + (x(i-mod2Del,:));
end

% normalise output
y =  y/max(abs(y));

