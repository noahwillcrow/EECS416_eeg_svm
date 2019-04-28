NON_SEIZURE_SET = dlmread('data/training_set_n.txt')'; % Label = 0
SEIZURE_SET = dlmread('data/training_set_s.txt')'; % Label = 1
TEST_SET = dlmread('data/test_set.txt')';
TEST_LABELS = dlmread('data/test_labels.txt')';

% Run all classifiers with 5-fold stratified crossvalidation
[folds0, folds1] = make_cv(NON_SEIZURE_SET, SEIZURE_SET, TEST_SET, TEST_LABELS);

cv_accuracies = run_cv(folds0, folds1, @simple_train, @simple_classify)';
cv_accuracies = [cv_accuracies; run_cv(folds0, folds1, @linearsvm, @classify)'];
cv_accuracies = [cv_accuracies; run_cv(folds0, folds1, @nonlinearsvm, @classify)'];

% Run all classifiers on the given training set and test set
[avg_0, avg_1] = simple_train(NON_SEIZURE_SET, SEIZURE_SET);
simple_predicted_labels = simple_classify(TEST_SET, avg_0, avg_1);
accuracies = countMatching(simple_predicted_labels', TEST_LABELS);

[linear_a, linear_b] = linearsvm(NON_SEIZURE_SET, SEIZURE_SET);
linear_predicted_labels = classify(TEST_SET, linear_a, linear_b);
accuracies = [accuracies, countMatching(linear_predicted_labels', TEST_LABELS)];

[nonlinear_a, nonlinear_b] = nonlinearsvm(NON_SEIZURE_SET, SEIZURE_SET);
nonlinear_predicted_labels = classify(TEST_SET, nonlinear_a, nonlinear_b);
accuracies = [accuracies, countMatching(nonlinear_predicted_labels', TEST_LABELS)];

cv_accuracies
accuracies