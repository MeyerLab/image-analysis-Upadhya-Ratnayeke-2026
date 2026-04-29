% Rename live sequence
nikon_rename({'K:\A077-live\20251016_171725_349'},...
     'E:\A077\A077-live\Raw','COPY',false,'SINGLE_SITE',true)
%% Calculate Bias live
clear p
p.biaspath='F:\A077\A077-live\Bias\';  % Output path for bias
p.imagepath='F:\A077\A077-live\Raw\';  % Image directory. If nikon, single folder for all sites
p.shadingpath=''; % cmos offset file for IX micro
p.names={
    'CFP';
    'YFP';
    'RFP';
    'iRFP';
       
    };
p.row_mat = [2:7];%1:8
p.col_mat = [2:11];%2:4
p.site_mat = [1];
p.frame_mat=[2 12];
p.biasAll = 1; % Save averaged bias across sites
% Formatting code for nikon files, 1$ is timepoint, 2$ is well, 3$ is point
% 'Time%1$05d_Well%2$s_Point%2$s_%3$04d_*.tiff' if multipoint       Time%1$05d_Well%2$s_*.tiff
p.formatCode = 'Time%1$05d_Well%2$s_*.tiff';
p.microscope = 'nikon';
p.nuc_channel = 4;

%%% Settings
p.maskforeground = 1;   % 1 to mask nuclei
p.nucradius=12;%12;
p.blur_radius = 5;
p.adaptive = [0 0 0 0];   % use add channels together to segment foreground
p.dilate = {1.5,2,.75 .75};   % multiples of nucradius, default .5, to expand mask
p.foreground_calc = 0;  % 1 for foreground calc (average foreground signal)
p.method = 'block';     % or pixel
p.blocknum= 11;
p.prctilethresh = 50;
p.compress = .25;
p.prctile_thresh=[0 100]; % pixel remove outliers
p.sigma = 25;             % pixel smooth window


% biasCalc(p,0);


%% Prep live processing 
%% Paths
s.experiment_name='A077-live';                % Experiment name
s.image_drive = 'E:\A077\A077-live\';    % Location of images base folder
s.savepath=fullfile('E:\A077\',s.experiment_name,'Data'); % Output location of mat files
s.imagepath=fullfile(s.image_drive,'Raw');                       % All sites in same folder for nikon
s.biaspath=fullfile(s.image_drive,'Bias');                       % Location of bias files
s.maskpath=fullfile(s.image_drive,'Mask');                       % Future location of mask saving
s.bgcmospath='';
% Formatting code for nikon files, 1$ is timepoint, 2$ is well, 3$ is point
s.formatCode =  'Time%1$05d_Well%2$s_*.tiff'; % if multipoint 'Time%1$05d_Well%2$s_*.tiff';  Time%1$05d_Well%2$s_Point%2$s_%3$04d_*.tiff
s.microscope = 'nikon';
s.nucChannel = 4;

%%% General parameters
s.startFrame =1;
s.endFrame = getMaxFrame(fullfile(s.imagepath,'2_2_1'),'Time(\d+)_');
s.magnification=20;               % 10=10x or 20=20x
s.binsize=2;                      % 1=bin 1 or 2=bin 2
s.postbin = 0;             % 0 for no software bin, number for scaling factor (e.g. 0.5 for 2x2 bin);
s.signals={'CFP', 'YFP', 'RFP','iRFP';};
s.maskwrite = 1;                  % 1 = save an image with the nucmask; 0 = dont save an image with the nucmask
s.maskname = 'nucedge_';
s.register = 0;                   % Register images between timepoints for all
s.register_exception = [1 2 3];        % If don't register images, manually put in sites to register


%%% Quantification parameters
s.bgcmoscorrection = 1;
s.bias = [0 0 0 0];
s.signal_foreground = [ 0 0 0 0 ];
s.nuc_dilate = [1 2 1 1 ]; %1 for nuclear signals 2 for cytoplasmic 
s.bgsubmethod = {'global mode','global mode','global mode','global mode'}; 
                                  % Options:'global mode','global percentile','tophat','semi-local nuclear', 'none'
s.compression = 2;                % For bg subtraction
s.bgprctile = [10];         % Set bg as perctile for each channel
s.sigblur = [ 3 3 3 3]; 
s.localbgmeasure = [ 1 1 1 1];       % Measure local background in box around cell
s.ringcalc = [ 1 1 0 0 ];
s.ringthresh = [ 0 0 0 0 ];         % Threshold for foregroundbre ring pixels
s.punctacalc = 0;                 % Analyze puncta in nucleus
s.punctaThresh = [];
s.varThresh = [];


%%% Segmentation parameters
s.firstsegmethod = 'log contour';  % Options: 'concavity', 'log', 'single adapt', 'double adapt', 'single', 'double', 'log contour'
s.secondsegmethod = 'log contour'; % Options: 'concavity', 'log', 'single adapt', 'double adapt', 'single', 'double','log contour'
s.nucr = 12;                     % 10x bin1 = 12 and 20x bin2 = 12
s.blurradius  =  3;              % 10x: 3
s.soliditythresh = 0.8;          % Minimum solidity of nucleus allowed
s.debrisarea = 100;              % 10x = 100 % 150 if no mitosis
s.boulderarea = 1500;            % 10x = 1500 for big cells and clumps 
s.blobthreshold = -0.02;         % For blobdector 'log' segmentation
s.split_mult = 1.1; %1.25
s.blocksize = 10000;

%%% Tracking parameters
s.maxjump = s.nucr*5;
s.masschangethreshold = 0.30;
s.areachangethreshold = 0.60;
s.daughtervariance = 0.10;
s.massweight = 1;
s.adaptlink = 10;
s.minjump = s.nucr*3;
s.masschangeLAP = 0.30;

% Timelapse_upgrade(s,2,2,1,1)
% % 
%% Run timelapse
rows = [2:7];
cols = [2:11];
sites = [1];                        
Parallelwell({@Timelapse_upgrade},s,rows,cols,sites)