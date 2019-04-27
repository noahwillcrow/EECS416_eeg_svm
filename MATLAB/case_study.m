SEIZURE_SET = dlmread('../data/training_set_s.txt')';
NON_SEIZURE_SET = dlmread('../data/training_set_n.txt')';
TEST_SET = dlmread('../data/test_set.txt')';
TEST_LABELS = [1 1 0 0 1 0 0 1 1 0 1 0 0 1 1 1 1 1 1 0 1 0 1 0 1 1 1 1 0 1 1 1 0 1 0 0 0 1 0 0 1 0 0 1 1 0 0 1 0 0 0 1 0 0 1 1 0 1 0 0 1 1 1 1 1 0 0 1 0 1 0 0 0 1 1 1 0 0 1 1 1 1 0 0 0 0 1 0 0 0 1 1 1 0 0 0 0 1 0 0]';

%run all classifiers with 5-fold stratified crossvalidation
cv_accuracies = run_cv(SEIZURE_SET,NON_SEIZURE_SET,TEST_SET,TEST_LABELS,@simple_train, @simple_classify)';
cv_accuracies = [cv_accuracies; run_cv(SEIZURE_SET,NON_SEIZURE_SET,TEST_SET,TEST_LABELS,@nonlinearsvm, @classify)'];

%run all classifiers on the given training set and test set
[avg_0,avg_1] = simple_train(SEIZURE_SET, NON_SEIZURE_SET);
simple_predicted_labels = simple_classify(TEST_SET,avg_0,avg_1);
accuracies = [classificationKey(simple_predicted_labels)];


[nonlinear_a, nonlinear_b] = nonlinearsvm(SEIZURE_SET, NON_SEIZURE_SET);
nonlinear_predicted_labels = classify(TEST_SET, nonlinear_a, nonlinear_b);
accuracies = [accuracies, classificationKey(nonlinear_predicted_labels)];