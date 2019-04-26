function predicted_labels=classify(data, a, b)
    predicted_labels = zeros(1, size(data, 1));
    for i = 1:size(data, 1)
        predicted_labels(i) = (sign(a' * data(i, :)' - b) + 1) / 2;
    end
end