function predicted_labels = simple_classify(ts, avg_0,avg_1)
    predicted_labels=zeros(length(ts),1);
    for i=1:length(ts)
        if norm(ts(i,:) - avg_1) < norm(ts(i,:) - avg_0)
            % the test point is closer to the average point in class 1
            predicted_labels(i) = 1;
        end
    end
end