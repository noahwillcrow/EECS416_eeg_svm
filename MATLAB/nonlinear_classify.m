function predicted_labels=nonlinear_classify(data, m, b)
    predicted_labels = zeros(1, size(data, 1));
    for i = 1:size(data, 1)
        predicted_labels(i) = (sign((m' * data(i, :)')^2 - b) + 1) / 2;
    end
end