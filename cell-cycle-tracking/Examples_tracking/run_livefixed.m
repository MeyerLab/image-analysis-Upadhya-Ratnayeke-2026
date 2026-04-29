nikon_rename({'J:\A075-live\20250826_115238_648','J:\A075-live\20250826_160137_749'},...
     'E:\A075\A075-live\Raw','COPY',false,'SINGLE_SITE',true)
  
%% Prep live processing 
%% Paths
s.experiment_name='A075-live';                % Experiment name
s.image_drive = 'E:\A075\A075-live\';    % Location of images base folder
s.savepath=fullfile('E:\A075\',s.experiment_name,'Data'); % Output location of mat files
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
s.register_exception = [20 21 22];        % If don't register images, manually put in sites to register


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
%% 
%  %% %% Rename fixed IF sequence
% nikon_rename({'J:\A075-IF1\20250828_121743_055'},...
%      'E:\A075\A075-IF1\Raw','COPY',false, 'SINGLE_SITE', true)
%% Setup add IF images
clear settings
settings.data_path = 'E:\A075-live\Data\';      % Output location of mat files
settings.IF_imagesessions = {'E:\A075\A075-IF1\'};
settings.live_imagepath = 'E:\A075\A075-live\Raw\';    % Live imaging raw image path
settings.bgcmospath = '';
settings.crop_save = 'E:\A075\A075-IF-crop\';           % Output cropped images, leave empty if no save
settings.mask_save = 'E:\A075\A075-IF-crop\';          % Output mask, leave empty if no save
settings.maskname = 'mask';
settings.primaryMaskRound = 1;
settings.maskIndex = [1 ];

%%% General parameters
settings.microscope = 'nikon';
% Formatting code for nikon files, 1$ is timepoint, 2$ is well, 3$ is point
settings.formatCodeLive = 'Time%1$05d_Well%2$s_*.tiff'; %'Time%1$05d_Well%2$s_Point%2$s_%3$04d_*.tiff'
settings.formatCodeFixed = 'Time%1$05d_Well%2$s_*.tiff';
settings.magnification = 20;     % 10 = 10x or 20 = 20x fixed magnification
settings.binsize = 1;            % 1 = bin 1 or 2 = bin 2 fixed binning
settings.postbin = [0 0 ];           % 0 for no software bin, number for scaling factor (e.g. 0.5 for 2x2 bin);
settings.match10x20x = 0;
settings.numsites = 1;           % Number of sites imaged for 20x to 10x (double check order is correct)
settings.scaleLive =1;          % Scale live to have same pixel size as final IF image
settings.signals = {{'DAPI','iRFP'}};  % Each imaging session in a cell inside cell array
settings.nucLive = 'iRFP_';       % Label for IX micro live nucleus (assume first tiff in stack for nikon)
settings.liveChannel = 4;         % If nikon use this tiff in stack for nuclear live
settings.manualLiveFrame = [];   % Manually set last frame for live imaging, otherwise use tracedata if empty

%%% Segmentation parameters
settings.segmethod = {'log'};  % 'log' or 'single' or 'double' or 'concavity'
settings.nucr = 12;                           % 10x bin1 = 12 and 20x bin2 = 12
settings.debrisarea = 100;                    % 100
settings.boulderarea = 2500;                  % 1500 
settings.blobthreshold = -0.1;               % For blobdector 'log' segmentation -.03 - can get rid of tiny segmentations 
settings.blurradius = 3;                      % Blur for blobdetector
settings.soliditythresh = 0.8;               % Minimum solidity of nucleus allowed .8
settings.badFrameCheck = .25;                 % Min fraction of cells untracked before logging error, 0 for no check
settings.split_mult = 1;

%%% Quantification parameters
settings.bias = {[0 0 ] };
settings.biasall = {[0 0 ]};
settings.sigblur = {[0 0 ]};
settings.signal_foreground = {[0 0 ]};
settings.bleedthrough =  {[0 0 ] };   % Calculate bleedthrough for channel
settings.bleedthroughslope = {};              % Cell array of cell arrays
settings.bleedthroughoff = {};                % Cell array of cell arrays
settings.ringcalc = {[0 1 ]  };
settings.ringthresh =  {[0 0 ] };    % Threshold for foreground ring pixels
settings.punctacalc = {[0 0 ] };    % Analyze puncta in nucleus
settings.punctaThresh = {{[],[],[]},{[],[],[],[]}};      % Threshold for tophat filter for puncta
settings.punctatopsize = 2;                   % Top hat filter size
settings.cytopuncta =  {[0 0 ]};
settings.thickenradius = 2*settings.nucr; 

settings.localbg =  {[1 1 ] };     % Measure local background in box around cell
settings.minringsize = 100;
settings.bgcmoscorrection = 1;                % 1 = correct for shading; 0 = dont correct for shading;
settings.compression = 4;
settings.bgsubmethod = {{'global nuclear', 'global nuclear'}}; % 'global nuclear','global cyto','tophat','semi-local nuclear'
settings.bgperctile = {[20 25 ]};  % Set bg as perctile for each channel
settings.frameIF=1;
 


%%% Tracking parameters
settings.distthresh = 3*settings.nucr;
settings.arealowthresh = -.5;
settings.areahighthresh = 1.5;
settings.maxjit = 200;

% Timelapse_addIF(settings,2,2,1,1)

%% Run timelapse

rows = [2:7];
cols = [2:11];
sites = [1];
Parallelwell({@Timelapse_addIF},settings,rows,cols,sites)