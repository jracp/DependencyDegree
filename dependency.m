% Programmed by Javad Rahimipour Anaraki on 23/05/18
% Ph.D. Candidate
% Department of Computer Science
% Memorial University of Newfoundland
% jra066 [AT] mun [DOT] ca | www.cs.mun.ca/~jra066

% This is an implementation of fuzzy rough dependency degree to calculate the importance of selected feautres 
% Input: selected features
% Output: dependency degree
% More info: https://ieeexplore.ieee.org/document/4505335/

function out = dependency(filename, bSelF)

data = importdata(filename);
[r, ~] = size(data);
cData = data;
maxF = [];
lenF = 0;

%%====================Calculating Indiscernibilities=======================
pData=[cData(:,1), cData(:,end)];
[indI, cls] = IND(pData);
tmp = zeros(1, length(cls));
v = std(data, 1);
maxF = find(bSelF == 1);
lenF = length(maxF);
s = 1;
supMat = [];
moRmF = zeros(1, lenF);
md = zeros(r, 3);
md(:, 1) = data(:, 1);

for x=1:r
    for nCls = 1:length(cls)
        part = indI(s:cls(nCls)); %U/IND(output)
        for y = 1:r %for all data
            
            if (~isempty(find(data(y,1) == part(1,:), 1)))
                md(y, 2) = 1;
            end
            
            for h = 1:length(maxF)
                Mf = maxF(h);
                fTerm1 = (data(y,Mf)-(data(x,Mf)-v(Mf)))/(data(x,Mf)-(data(x,Mf)-v(Mf)));
                fTerm2 = ((data(x,Mf)+v(Mf))-data(y,Mf))/((data(x,Mf)+v(Mf))-data(x,Mf));
                moRmF(h) = max(min(fTerm1, fTerm2), 0);
            end
            if (length(moRmF) > 1)
                outM = max(moRmF(1) + moRmF(2) - 1, 0);
                for nMoRmF = 3:length(moRmF)
                    outM = max(outM + moRmF(nMoRmF) - 1, 0);
                end
            else
                outM = min(moRmF);
            end
            
            md(y, 3) = min(1-outM + md(y, 2), 1);
        end
        tmp(nCls) = min(md(:, 3));
        md = zeros(r, 3);
        md(:, 1) = data(:, 1);
        s = cls(nCls) + 1;
    end
    supMat(x) = max(tmp);
    s = 1;
end
out = sum(supMat) / r;
