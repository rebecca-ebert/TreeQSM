function OptQSM = qsm_execution(inputFile, name, output_path)
%QSM_EXECUTION Parallel execution of TreeQSM.
%   Import points from inputFile and save as "points_name". 
%   Parallel QSM execution with 5 models generated for each input.
%   Select optimum and save this QSM as "name_qsm".
%
% Inputs:
% inputFile         String, the file name of the point cloud of a tree      
% name              String, the name of the file where the QSMs are saved
% output_path       String, the path where the QSMs are saved
% 
% Output:
% OptQSM    The single best QSM for the tree

% define inputs
P = importfile(inputFile);
inputs = define_input(P,2,3,2); 
inputs.plot = 0;
inputs.savemat = 0;
inputs.savetxt= 0;

% parallel QSM execution
str = [output_path, 'points_', name];
save(str, "P");
QSMs = make_models_parallel(str, name, 5, inputs );
[ ~ , ~ , ~ , OptQSM ] = select_optimum( QSMs );

save([output_path, name, '_qsm'], "OptQSM"); 
end