function predicted_labels = simple_classify(data, avg_0, avg_1)
    predicted_labels=zeros(1, length(data));
    for i=1:size(data, 1)
        sample = data(i, :);
        if norm(sample - avg_0) > norm(sample - avg_1)
            % the test point is closer to the average point in class 1
            predicted_labels(i) = 1;
        end
    end
end