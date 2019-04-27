function accuracies = run_cv(tr0, tr1, ts, ts_labels, trainingfun, testfun)
    numfolds = int32(5);
    accuracies = zeros(numfolds, 1);
    
    for i=1:length(ts)
        if ts_labels(i) == 0
            tr0 = [tr0; ts(i,:)];
        else
            tr1 = [tr1; ts(i,:)];
        end
    end
    
    foldsize0 = idivide(length(tr0),numfolds,'ceil');
    foldsize1 = idivide(length(tr1),numfolds,'ceil');
    
    folds0 = zeros(foldsize0, length(tr0(1,:)), numfolds);
    folds1 = zeros(foldsize1, length(tr1(1,:)), numfolds);
    
    for i=1:numfolds
        folds0(:,:,i) = tr0((i-1)*foldsize0+1:i*foldsize0,:);
        folds1(:,:,i) = tr1((i-1)*foldsize0+1:i*foldsize0,:);
    end
    
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