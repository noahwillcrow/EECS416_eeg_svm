function numMatching=countMatching(X, Y)
    numMatching = 0;
    for i=1:size(X, 1)
        if X(i) == Y(i)
            numMatching = numMatching + 1;
        end
    end
    
%     x = linspace(1, size(X, 1), size(X, 1));
%     
%     y1 = Y;
%     scatter(x, y1, 'filled')
%     title('Combine Plots')
%     
%     hold on
%     
%     y2 = X;
%     scatter(x, y2)
%     
%     hold off
end