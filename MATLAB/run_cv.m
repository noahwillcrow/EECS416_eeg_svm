function accuracies = run_cv(folds0, folds1, trainingfun, testfun)
    numfolds = int32(5);
    accuracies = zeros(numfolds, 1);
    
    for i=1:numfolds
        training0 = [];
        training1 = [];
        testing0 = [];
        testing1 =[];
        for j=1:numfolds
            if i==j
                testing0 = [testing0; folds0(:,:,i)];
                testing1 = [testing1; folds1(:,:,i)];
            else
                training0 = [training0; folds0(:,:,i)];
                training1 = [training1; folds1(:,:,i)];
            end
        end
        
        [a,b] = trainingfun(training0, training1);
        predicted_labels = testfun([testing0; testing1], a, b);
        
        num_correct = 0;
        for j=1:length(predicted_labels)
            if j > length(testing1) && predicted_labels(j) == 1
                num_correct = num_correct+1;
            elseif j <= length(testing1) && predicted_labels(j) == 0
                num_correct = num_correct+1;
            end
        end
        
        accuracies(i) = num_correct/(length(testing0) + length(testing1));
    end
   
    
end