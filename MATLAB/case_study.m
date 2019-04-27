NON_SEIZURE_SET = dlmread('data/training_set_n.txt')'; % Label = 0
SEIZURE_SET = dlmread('data/training_set_s.txt')'; % Label = 1
TEST_SET = dlmread('data/test_set.txt')';
TEST_LABELS = [1 1 0 0 1 0 0 1 1 0 1 0 0 1 1 1 1 1 1 0 1 0 1 0 1 1 1 1 0 1 1 1 0 1 0 0 0 1 0 0 1 0 0 1 1 0 0 1 0 0 0 1 0 0 1 1 0 1 0 0 1 1 1 1 1 0 0 1 0 1 0 0 0 1 1 1 0 0 1 1 1 1 0 0 0 0 1 0 0 0 1 1 1 0 0 0 0 1 0 0]';

%run all classifiers with 5-fold stratified crossvalidation
<<<<<<< HEAD
cv_accuracies = run_cv(NON_SEIZURE_SET,SEIZURE_SET,TEST_SET,TEST_LABELS,@simple_train, @simple_classify)';
cv_accuracies = [cv_accuracies; run_cv(SEIZURE_SET,NON_SEIZURE_SET,TEST_SET,TEST_LABELS,@nonlinearsvm, @classify)'];
=======
[folds0, folds1] = make_cv(SEIZURE_SET,NON_SEIZURE_SET,TEST_SET,TEST_LABELS);

cv_accuracies = run_cv(folds0, folds1, @simple_train, @simple_classify)';
cv_accuracies = [cv_accuracies; run_cv(folds0, folds1, @nonlinearsvm, @classify)'];
>>>>>>> dfa8a323444097e0aa888cade3d28c581ecda215

%run all classifiers on the given training set and test set
[avg_0,avg_1] = simple_train(NON_SEIZURE_SET, SEIZURE_SET);
simple_predicted_labels = simple_classify(TEST_SET,avg_0,avg_1);
accuracies = classificationKey(simple_predicted_labels);


[nonlinear_a, nonlinear_b] = nonlinearsvm(NON_SEIZURE_SET, SEIZURE_SET);
nonlinear_predicted_labels = classify(TEST_SET, nonlinear_a, nonlinear_b);
accuracies = [accuracies, classificationKey(nonlinear_predicted_labels)];

cv_accuracies
accuracies