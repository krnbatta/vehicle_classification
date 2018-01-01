function net = create_pr_net(inputs,targets)
%CREATE_PR_NET Creates and trains a pattern recognition neural network.
%
%

% Create Network
numHiddenNeurons = 35;  
net = newpr(inputs,targets,numHiddenNeurons);
net.divideParam.trainRatio = 70/100;  
net.divideParam.valRatio = 15/100;  
net.divideParam.testRatio = 15/100; 

% Train and Apply Network
[net,tr] = train(net,inputs,targets);
outputs = sim(net,inputs);

% Plot
plotperf(tr);
plotconfusion(targets,outputs);

save net net