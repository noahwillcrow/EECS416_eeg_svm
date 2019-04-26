SEIZURE_SET = dlmread('data/training_set_s.txt')';
NON_SEIZURE_SET = dlmread('data/training_set_n.txt')';
TEST_SET = dlmread('data/test_set.txt')';
TEST_LABELS = [1 1 0 0 1 0 0 1 1 0 1 0 0 1 1 1 1 1 1 0 1 0 1 0 1 1 1 1 0 1 1 1 0 1 0 0 0 1 0 0 1 0 0 1 1 0 0 1 0 0 0 1 0 0 1 1 0 1 0 0 1 1 1 1 1 0 0 1 0 1 0 0 0 1 1 1 0 0 1 1 1 1 0 0 0 0 1 0 0 0 1 1 1 0 0 0 0 1 0 0]';

[nonlinear_a, nonlinear_b] = nonlinearsvm(SEIZURE_SET, NON_SEIZURE_SET);
nonlinear_predicted_labels = classify(TEST_SET, nonlinear_a, nonlinear_b);
classificationKey(nonlinear_predicted_labels)