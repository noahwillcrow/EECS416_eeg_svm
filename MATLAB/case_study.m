NON_SEIZURE_SET = dlmread('../data/training_set_n.txt')'; % Label = 0
SEIZURE_SET = dlmread('../data/training_set_s.txt')'; % Label = 1
TEST_SET = dlmread('../data/test_set.txt')';
TEST_LABELS = dlmread('../data/test_labels.txt')';

% Run all classifiers with 5-fold stratified crossvalidation
[folds0, folds1] = make_cv(NON_SEIZURE_SET, SEIZURE_SET, TEST_SET, TEST_LABELS);

results_per_fold = zeros(3, 5, 2, 2);

results_per_fold(1,:,:,:) = run_cv(folds0, folds1, @simple_train, @simple_classify);
results_per_fold(2,:,:,:)  = run_cv(folds0, folds1, @linearsvm, @linear_classify);
results_per_fold(3,:,:,:)  = run_cv(folds0, folds1, @nonlinearsvm, @nonlinear_classify);

cv_accuracies = zeros(3,5);
cv_tp_rate = zeros(3,5);
cv_fp_rate = zeros(3,5);

avg_accuracies = zeros(1,3);
avg_tp_rate = zeros(1,3);
avg_fp_rate = zeros(1,3);

for i=1:3
    for j=1:5
        tp = results_per_fold(i,j,2,2);
        tn = results_per_fold(i,j,1,1);
        fp = results_per_fold(i,j,2,1);
        fn = results_per_fold(i,j,1,2);
        
        cv_accuracies(i,j) = (tp+tn)/(tp+tn+fp+fn);
        cv_tp_rate(i,j) = (tp)/(tp+fn);
        cv_fp_rate(i,j) = (fp)/(fp+tn);
        
        avg_accuracies = mean(cv_accuracies');
        avg_tp_rate = mean(cv_tp_rate');
        avg_fp_rate = mean(cv_fp_rate');
    end
    
    
end

% Run all classifiers on the given training set and test set
results = zeros(3, 2, 2);

[avg_0, avg_1] = simple_train(NON_SEIZURE_SET, SEIZURE_SET);
simple_predicted_labels = simple_classify(TEST_SET, avg_0, avg_1);
results(1,:,:) = confusionmat(TEST_LABELS, simple_predicted_labels');

[linear_a, linear_b] = linearsvm(NON_SEIZURE_SET, SEIZURE_SET);
linear_predicted_labels = linear_classify(TEST_SET, linear_a, linear_b);
results(2,:,:)= confusionmat(TEST_LABELS, linear_predicted_labels');

[nonlinear_a, nonlinear_b] = nonlinearsvm(NON_SEIZURE_SET, SEIZURE_SET);
nonlinear_predicted_labels = nonlinear_classify(TEST_SET, nonlinear_a, nonlinear_b);
results(3,:,:)= confusionmat(TEST_LABELS, nonlinear_predicted_labels');

accuracies = zeros(1,3);
tp_rate = zeros(1,3);
fp_rate = zeros(1,3);

for i=1:3
        tp = results(i,2,2);
        tn = results(i,1,1);
        fp = results(i,2,1);
        fn = results(i,1,2);
        
        accuracies(i) = (tp+tn)/(tp+tn+fp+fn);
        tp_rate(i) = (tp)/(tp+fn);
        fp_rate(i) = (fp)/(fp+tn);
end