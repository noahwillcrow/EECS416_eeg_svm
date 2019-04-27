SEIZURE_SET = dlmread('../data/training_set_s.txt')';
NON_SEIZURE_SET = dlmread('../data/training_set_n.txt')';
TEST_SET = dlmread('../data/test_set.txt')';
TEST_LABELS = [1 1 0 0 1 0 0 1 1 0 1 0 0 1 1 1 1 1 1 0 1 0 1 0 1 1 1 1 0 1 1 1 0 1 0 0 0 1 0 0 1 0 0 1 1 0 0 1 0 0 0 1 0 0 1 1 0 1 0 0 1 1 1 1 1 0 0 1 0 1 0 0 0 1 1 1 0 0 1 1 1 1 0 0 0 0 1 0 0 0 1 1 1 0 0 0 0 1 0 0]';

%passing in the function like this doesn't actually work, but I don't
%understand matlab
accuracies = run_cv(SEIZURE_SET,NON_SEIZURE_SET,TEST_SET,TEST_LABELS,'simple_train', 'simple_test');

%[nonlinear_a, nonlinear_b] = nonlinearsvm(SEIZURE_SET, NON_SEIZURE_SET);
%nonlinear_predicted_labels = classify(TEST_SET, nonlinear_a, nonlinear_b);
%classificationKey(nonlinear_predicted_labels)