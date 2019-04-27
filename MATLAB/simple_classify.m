<<<<<<< HEAD
function predicted_labels = simple_classify(ts, avg_0,avg_1)
    predicted_labels=zeros(length(ts),1);
    for i=1:length(ts)
        if norm(ts(i,:) - avg_1) < norm(ts(i,:) - avg_0)
            % the test point is closer to the average point in class 1
            predicted_labels(i) = 1;
=======
function predicted_labels = simple_classify(data, avg_0,avg_1)
    predicted_labels=zeros(1,length(data));
        for i=1:size(data, 1)
            if norm(data(i,:) - avg_1) > norm(data(i,:) - avg_0)
                % the test point is closer to the average point in class 1
                predicted_labels(i) = 1;
            end
>>>>>>> dfa8a323444097e0aa888cade3d28c581ecda215
        end
    end
end