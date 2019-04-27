function predicted_labels = simple_classify(data, avg_0,avg_1)
    predicted_labels=zeros(1,length(data));
        for i=1:size(data, 1)
            if norm(data(i,:) - avg_1) > norm(data(i,:) - avg_0)
                % the test point is closer to the average point in class 1
                predicted_labels(i) = 1;
            end
        end
end