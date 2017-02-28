function ml_setup(varargin)
% Setup the environments
% By: Minh Hoai Nguyen (minhhoai@cs.stonybrook.edu)
% Created: 12-Jul-2015
% Last modified: 12-Jul-2015

pathOfThisFile = mfilename('fullpath');
libRootPath = pathOfThisFile(1:end-length('ml_setup'));

libs = {'.', 'Classifier', 'Misc', 'ComponentAnalysis', 'Video', 'Kmeans'};

% Add directories to Matlab paths
for i=1:length(libs)
    libPath = sprintf('%s%s', libRootPath, libs{i});
    addpath(libPath);
end;

% Check if ffmpeg and VL_FEAT are installed 
isVideoWork = 1;
try 
    a = vl_version();
catch
    fprintf('VL_FEAT library not found\n');
    fprintf('  Some functions in %sVideo might not work', libRootPath);
    isVideoWork = 0;
end;

ffmpegBin = ML_Ffmpeg.getFfmpegBin();
[retCode, retOutput] = system(sprintf('%s -version', ffmpegBin));
if retCode ~=0
    fprintf('FFMPEG library not installed or incorrect ffmpeg binary\n');
    fprintf('  Some functions in %sVideo will not work\n', libRootPath);
    fprintf('  Install FFMPEG and set the correct paths in %sVideo/ML_Ffmpeg.m\n', libRootPath);
    isVideoWork = 0;
end
    
[version, date] = ml_version();
