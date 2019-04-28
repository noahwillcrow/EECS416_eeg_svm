function results = run_cv(folds0, folds1, trainingfun, testfun)
    numfolds = int32(5);
    results = zeros(numfolds, 2, 2);
    
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
        true_labels = [zeros(1,length(testing0)), ones(1,length(testing1))];
        
        results(i,:,:)= confusionmat(true_labels, predicted_labels);
    end
   
    
end