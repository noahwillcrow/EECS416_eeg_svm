function predicted_labels = simple_classification(tr0, tr1, ts)
    predicted_labels=zeros(length(ts),1);

    avg_0 = mean(tr0);
    avg_1 = mean(tr1);
    
    for i=1:length(ts)
        if norm(ts(i,:) - avg_1) < norm(ts(i,:) - avg_0)
            % the test point is closer to the average point in class 1
            predicted_labels(i) = 1;
        end
    end
end
