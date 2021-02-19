function [M] = aggreg_hyperspectral(spectralfile,SCOPEspec)

% Aggregate spectral data over SCOPE bands by averaging (over rectangular band
% passes)

% Read file with prescribed spectral data
tindex = 2 + 1;

s   = importdata(spectralfile);
wlM = s(2,:);
T   = s(tindex,:);

U     = T;

nwM   = length(wlM);

nreg  = SCOPEspec.nreg;
streg = SCOPEspec.start;
enreg = SCOPEspec.end;
width = SCOPEspec.res;

% Nr. of bands in each region

nwreg = int32((enreg-streg)./width)+1;

off   = int32(zeros(nreg,1));

for i=2:nreg
    off(i) = off(i-1)+nwreg(i-1);
end

nwS = sum(nwreg);
n   = zeros(nwS,1);    % Count of spectral data contributing to a band
S   = zeros(nwS,1);    % Intialize sums

j   = int32(zeros(nreg,1));  % Band index within regions

for iwl = 1:nwM
    w   = wlM(iwl);    % MODTRAN wavelength
    for r = 1:nreg
        j(r) = int32(round(w-streg(r))./(width(r)))+1;
        if j(r)>0 && j(r)<=nwreg(r)                 % test if index is in valid range
            k      = j(r)+off(r);                   % SCOPE band index
            S(k)   = S(k)+T(iwl);                   % Accumulate from contributing spectral data
            n(k)   = n(k)+1;                        % Increment count
        end
    end
end

M = zeros(size(S,1),1);
M(:) = S(:)./n;             % Calculate averages per SCOPE band

end