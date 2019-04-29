function predicted_labels=linear_classify(data, m, b)
    predicted_labels = zeros(1, size(data, 1));
    for i = 1:size(data, 1)
        predicted_labels(i) = (sign(m' * data(i, :)' - b) + 1) / 2;
    end
end