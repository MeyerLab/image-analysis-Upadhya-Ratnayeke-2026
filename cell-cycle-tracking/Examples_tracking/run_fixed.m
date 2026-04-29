%% Rename fixed FP sequence
nikon_rename({'K:\A088-IF1\20251116_121226_656'},...
     'E:\A088\A088-IF1\Raw','COPY',false,'SINGLE_SITE',true)

 %% Rename fixed sequence
nikon_rename({'K:\A088-IF2\20251116_124254_818'},...
      'E:\A088\A088-IF2\Raw','COPY',false,'SINGLE_SITE',true)

 %%  %%  %% Rename fixed sequence
nikon_rename({'K:\A088-IF3\20251117_114623_916'},...
      'E:\A088\A088-IF3\Raw','COPY',false,'SINGLE_SITE',true)

 %% Calculate Bias IF round 1
clear p
p.biaspath='E:\A088\A088-IF1\Bias';  % Output path for bias
p.imagepath='E:\A088\A088-IF1\Raw';  % Image directory. If nikon, single folder for all sites
p.shadingpath=''; % cmos offset file for IX micro
p.names={
    'DAPI';
    'YFP';
    'RFP';
    'iRFP';
    };
p.row_mat = [1];
p.col_mat = [2:3];
p.site_mat = [1];
p.frame_mat=[1];
p.biasAll = 1; % Save averaged bias across sites
% Formatting code for nikon files, 1$ is timepoint, 2$ is well, 3$ is point
% 'Time%1$05d_Well%2$s_Point%2$s_%3$04d_*.tiff' if multipoint
p.formatCode = 'Time%1$05d_Well%2$s_*.tiff';
p.microscope = 'nikon';
p.nuc_channel = 1;

%%% Settings
p.maskforeground = 0;   % 1 to mask nuclei
p.nucradius=12;%12;
p.blur_radius = 5;
p.adaptive = [0 0 0 0];   % use add channels together to segment foreground
p.dilate = {.75,.75,.75 .75};   % multiples of nucradius, default .5, to expand mask
p.foreground_calc = 0;  % 1 for foreground calc (average foreground signal)
p.method = 'block';     % or pixel
p.blocknum= 11;
p.prctilethresh = 50;
p.compress = .25;
p.prctile_thresh=[0 100]; % pixel remove outliers
p.sigma = 25;             % pixel smooth window


% biasCalc(p,0);
%%  %% Calculate Bias IF2
clear p
p.biaspath='E:\A088\A088-IF2\Bias';  % Output path for bias
p.imagepath='E:\A088\A088-IF2\Raw';  % Image directory. If nikon, single folder for all sites
p.shadingpath=''; % cmos offset file for IX micro
p.names={
    'DAPI';
    'YFP';
    'RFP';
    'iRFP';
    };
p.row_mat = [2:4];
p.col_mat = [1];
p.site_mat = [1];
p.frame_mat=[1];
p.biasAll = 1; % Save averaged bias across sites
% Formatting code for nikon files, 1$ is timepoint, 2$ is well, 3$ is point
% 'Time%1$05d_Well%2$s_Point%2$s_%3$04d_*.tiff' if multipoint
p.formatCode = 'Time%1$05d_Well%2$s_*.tiff';
p.microscope = 'nikon';
p.nuc_channel = 1;

%%% Settings
p.maskforeground = 0;   % 1 to mask nuclei
p.nucradius=12;%12;
p.blur_radius = 5;
p.adaptive = [0 0 0 0];   % use add channels together to segment foreground
p.dilate = {.75,.75,.75 .75};   % multiples of nucradius, default .5, to expand mask
p.foreground_calc = 0;  % 1 for foreground calc (average foreground signal)
p.method = 'block';     % or pixel
p.blocknum= 11;
p.prctilethresh = 50;
p.compress = .25;
p.prctile_thresh=[0 100]; % pixel remove outliers
p.sigma = 25;             % pixel smooth window


% biasCalc(p,0);
%%  %% Calculate Bias if3
clear p
p.biaspath='E:\A088\A088-IF3\Bias';  % Output path for bias
p.imagepath='E:\A088\A088-IF3\Raw';  % Image directory. If nikon, single folder for all sites
p.shadingpath=''; % cmos offset file for IX micro
p.names={
    'DAPI';
    'YFP';
    'RFP';
    'iRFP';
    };
p.row_mat = [1];
p.col_mat = [2:3];
p.site_mat = [1];
p.frame_mat=[1];
p.biasAll = 1; % Save averaged bias across sites
% Formatting code for nikon files, 1$ is timepoint, 2$ is well, 3$ is point
% 'Time%1$05d_Well%2$s_Point%2$s_%3$04d_*.tiff' if multipoint
p.formatCode = 'Time%1$05d_Well%2$s_*.tiff';
p.microscope = 'nikon';
p.nuc_channel = 1;

%%% Settings
p.maskforeground = 0;   % 1 to mask nuclei
p.nucradius=12;%12;
p.blur_radius = 5;
p.adaptive = [0 0 0 0];   % use add channels together to segment foreground
p.dilate = {.75,.75,.75 .75};   % multiples of nucradius, default .5, to expand mask
p.foreground_calc = 0;  % 1 for foreground calc (average foreground signal)
p.method = 'block';     % or pixel
p.blocknum= 11;
p.prctilethresh = 50;
p.compress = .25;
p.prctile_thresh=[0 100]; % pixel remove outliers
p.sigma = 25;             % pixel smooth window


% biasCalc(p,0);

%% Setup add IF images 
clear settings
settings.data_path = 'E:\A088\Data';      % Output location of mat files
settings.IF_imagesessions = {'E:\A088\A088-IF1\','E:\A088\A088-IF2\','E:\A088\A088-IF3\'};    

settings.live_imagepath = '';    % Live imaging raw image path
settings.bgcmospath = '';
settings.crop_save = 'E:\A088\A088-IF1-crop\';           % Output cropped images, leave empty if no save
settings.mask_save = 'E:\A088\A088-IF1-crop\';           % Output mask, leave empty if no save
settings.maskname = 'mask';
settings.primaryMaskRound = 1;
settings.maskIndex = [1 1 1];

%%% General parameters
settings.microscope = 'nikon';
% Formatting code for nikon files, 1$ is timepoint, 2$ is well, 3$ is point
settings.formatCodeLive = 'Time%1$05d_Well%2$s_*.tiff'; %'Time%1$05d_Well%2$s_Point%2$s_%3$04d_*.tiff'
settings.formatCodeFixed = 'Time%1$05d_Well%2$s_*.tiff';
settings.magnification = 20;     % 10 = 10x or 20 = 20x fixed magnification
settings.binsize = 2;            % 1 = bin 1 or 2 = bin 2 fixed binning
settings.postbin = [0 0 0];           % 0 for no software bin, number for scaling factor (e.g. 0.5 for 2x2 bin);
settings.match10x20x = 0;
settings.numsites = 1;           % Number of sites imaged for 20x to 10x (double check order is correct)
settings.scaleLive =1;          % Scale live to have same pixel size as final IF image
settings.signals = {{'DAPI','YFP','RFP','iRFP'},{'DAPI','YFP','RFP','iRFP'},{'DAPI','YFP','RFP','iRFP'}};  % Each imaging session in a cell inside cell array
% settings.nucLive = 'iRFP_';       % Label for IX micro live nucleus (assume first tiff in stack for nikon)
 settings.liveChannel = 1;         % If nikon use this tiff in stack for nuclear live
settings.manualLiveFrame = [];   % Manually set last frame for live imaging, otherwise use tracedata if empty

%%% Segmentation parameters
settings.segmethod = {'single','single','single'};  % 'log' or 'single' or 'double'
settings.nucr = 12;                           % 10x bin1 = 12 and 20x bin2 = 12
settings.debrisarea = 100;                    % 100
settings.boulderarea = 1500;                  % 1500 
settings.blobthreshold = -0.03;               % For blobdector 'log' segmentation
settings.blurradius = 3;                      % Blur for blobdetector
settings.soliditythresh = 0.80;               % Minimum solidity of nucleus allowed
settings.badFrameCheck = .25;                 % Min fraction of cells untracked before logging error, 0 for no check
settings.split_mult = 1;

%%% Quantification parameters
settings.bias = {[1 1 1 1 ],[0 0 0 0] ,[1 1 1 1] };
settings.biasall = {[1 1 1 1],[0 0 0 0],[1 1 1 1] };
settings.sigblur = {[0 0 0 0 ],[0 0 0 0],[0 0 0 0]};
settings.signal_foreground = {[0 0 0 0 ] ,[0 0 0 0],[0 0 0 0]};
settings.bleedthrough = {[0 0 0 0] ,[0 0 0 0],[0 0 0 0]};   % Calculate bleedthrough for channel
settings.bleedthroughslope = {};              % Cell array of cell arrays
settings.bleedthroughoff = {};                % Cell array of cell arrays
settings.ringcalc = {[0 1 1 1 ],[0 1 1 1] ,[0 1 1 1]};
settings.ringthresh = { [0 0 0 0 ],[0 0 0 0],[0 0 0 0]};    % Threshold for foreground ring pixels
settings.punctacalc = {[0 0 0 0 ] ,[0 0 0 0],[0 0 0 0]};     % Analyze puncta in nucleus
settings.punctaThresh = {{[],[],[],[]},{}};      % Threshold for tophat filter for puncta
settings.punctatopsize = 2;                   % Top hat filter size
settings.cytopuncta = {[0 0 0 0 ],[0 0 0 0],[0 0 0 0] };
settings.thickenradius = 2*settings.nucr; 

settings.localbg = { [0 0 0 0 ],[0 0 0 0],[0 0 0 0]};        % Measure local background in box around cell
settings.minringsize = 100;
settings.bgcmoscorrection = 0;                % 1 = correct for shading; 0 = dont correct for shading;
settings.compression = 4;
settings.bgsubmethod = {{'global nuclear', 'global nuclear', 'global nuclear', 'global nuclear'},{'none', 'none','none', 'none'},{'global nuclear', 'global nuclear','global nuclear', 'global nuclear'}}; % 'global nuclear','global cyto','tophat','semi-local nuclear'
settings.bgperctile = {[20 25  25 25],[20 25 25 25  ],[20 25 25 25  ]};  % Set bg as perctile for each channel
settings.frameIF=1;
 


%%% Tracking parameters
settings.distthresh = 3*settings.nucr;
settings.arealowthresh = -.5;
settings.areahighthresh = 1.5;
settings.maxjit = 200;

% Fixed_IF(settings,2,2,1,1)

%% Run fixed analysis

rows = [2:4];
cols = [2:11];
sites = [1];
Parallelwell({@Fixed_IF},settings,rows,cols,sites)