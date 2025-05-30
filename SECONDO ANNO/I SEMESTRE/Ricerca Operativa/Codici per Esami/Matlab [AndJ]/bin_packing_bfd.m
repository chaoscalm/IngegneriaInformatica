%% Function to solve bin packing with best fit
% Written by AndJ

function [] = bin_packing_bfd(items, V)

% items=[70 60 50 33 33 33 11 7 3]
% V=100
% items indica il vettore degli oggetti da inserire nei bin
% V indica la capacità dei bin

% do the actual work
binSize = V;
numItems = length(items);

items = sort(items, 'descend');

R = binSize * ones(numItems, 1); % there can not be more bins than items
assignment = zeros(numItems, 1);

for i = 1:numItems
    validBins = find(R >= items(i)); % find bins where the item fits
    [~, bestBin] = min(R(validBins)); % find the bin with the smallest remaining space among valid bins
    chosenBin = validBins(bestBin);
    assignment(i) = chosenBin;
    R(chosenBin) = R(chosenBin) - items(i);
end

R = R(R < binSize);

vI=ceil(sum(items)/V);

disp("vI: ");
disp(vI);

% make a figure
figure
hold on
for i = 1:length(R)
    itemInds = find(assignment == i);
    sizes = items(itemInds);
    plot(i, cumsum(sizes), '*');
    text(i * ones(size(sizes)) + .1, cumsum(sizes), num2str(itemInds));
end

ylim([0 round(binSize*1.1)]);
plot([.5 length(R)+.5], [binSize binSize], '--');
xlim([.5, length(R)+.5]);
title("BFD");
set(gca, 'xtick', 1:length(R));
xlabel('bin index');
ylabel('fill');
end
