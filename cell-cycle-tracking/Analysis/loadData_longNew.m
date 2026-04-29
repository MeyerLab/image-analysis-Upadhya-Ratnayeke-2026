%% DEFINE PARAMETERS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Conditions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
settings.conditions = {
    % row, column, site, frame drug added

       
      
     'siControl',2,2:11,1,0; %1
     % 'siDBF4',3,2:11,1,0; %1
     % 'siCyclinA2',4,2:11,1,0; %1


              


        



    
       


        };

%%% Paths %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
settings.dataDir = 'C:\Users\swu4001\Desktop\Data\A086\A086-live\Data';
settings.liveLabel = 'traceData_';
settings.liveNames = fullfile(settings.dataDir,'settings_live.mat');
settings.IFNames = fullfile(settings.dataDir, 'settings_live_IF.mat');
settings.saveName = 'A086_data_trace.mat';
settings.saveDir = 'C:\Users\swu4001\Desktop\Data\A086\Analysis';
%%% Analysis Options %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
settings.daughterGate = 1;  %0:no gating 1:daughters 2:no daughters
settings.type = 'cycling';   %'release', 'cycling' or 'hybrid
settings.minTraceFrac = .25;
settings.nuc = 'CFP';
settings.cdk = '';
settings.apc = 'RFP';
settings.crl = '';
settings.sig = '';
settings.PCNA = '';

%%% POI analysis
settings.poiCdk = 0;
settings.poiApc = 1;
settings.poiCrl = 0;
settings.poiG2 = 0;
settings.poiPCNA = 0;

%%% Live-fixed analysis
settings.IFoption = 1;        %0:No IF 1:IF
settings.IFlabel = 'IF_';


%% PROCESS DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Load data header
load(settings.liveNames,'names');
names = names(2,:);
if settings.IFoption
    load(settings.IFNames,'header');
    IFnames = header(2,:);
end

%%% Load conditions
S = gatherConditionGrowNew(settings);
allIF = struct();
%% PROCESS CONDITION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:length(S)
    %%% Load IF data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if settings.IFoption
      S(i).IFarea = S(i).IFdata(:, ismember(IFnames,'nuclear area'));
        S(i).DAPI1 = S(i).IFdata(:, ismember(IFnames,'1_DAPI_mean'));
        S(i).CFP1 = S(i).IFdata(:, ismember(IFnames,'1_CFP_mean'));
        S(i).CFP1cyt = S(i).IFdata(:, ismember(IFnames,'1_CFP_cyto ring'));
        S(i).YFP1 = S(i).IFdata(:, ismember(IFnames,'1_YFP_mean'));
        S(i).YFP1cyt = S(i).IFdata(:, ismember(IFnames,'1_YFP_cyto ring'));
        S(i).RFP1 = S(i).IFdata(:, ismember(IFnames,'1_RFP_mean'));
        S(i).RFP1cyt = S(i).IFdata(:, ismember(IFnames,'1_RFP_cyto ring'));
        S(i).iRFP1 = S(i).IFdata(:, ismember(IFnames,'1_iRFP_mean'));
        S(i).iRFP1cyt = S(i).IFdata(:, ismember(IFnames,'1_iRFP_cyto ring'));
        % S(i).Cy71 = S(i).IFdata(:, ismember(IFnames,'1_CY7_mean'));
        % S(i).Cy71cyt = S(i).IFdata(:, ismember(IFnames,'1_CY7_cyto ring'));
        
        S(i).DAPI2 = S(i).IFdata(:, ismember(IFnames,'2_DAPI_mean'));
        S(i).CFP2 = S(i).IFdata(:, ismember(IFnames,'2_CFP_mean'));
        S(i).CFP2cyt = S(i).IFdata(:, ismember(IFnames,'2_CFP_cyto ring'));
        S(i).YFP2 = S(i).IFdata(:, ismember(IFnames,'2_YFP_mean'));
        S(i).YFP2cyt = S(i).IFdata(:, ismember(IFnames,'2_YFP_cyto ring'));
        S(i).RFP2 = S(i).IFdata(:, ismember(IFnames,'2_RFP_mean'));
        S(i).RFP2cyt = S(i).IFdata(:, ismember(IFnames,'2_RFP_cyto ring'));
        S(i).iRFP2 = S(i).IFdata(:, ismember(IFnames,'2_iRFP_mean'));
        S(i).iRFP2cyt = S(i).IFdata(:, ismember(IFnames,'2_iRFP_cyto ring'));
        % S(i).Cy72 = S(i).IFdata(:, ismember(IFnames,'2_CY7_mean'));
        % S(i).Cy72cyt = S(i).IFdata(:, ismember(IFnames,'2_CY7_cyto ring'));
      



        S(i).DAPI3 = S(i).IFdata(:, ismember(IFnames,'3_DAPI_mean'));
        S(i).CFP3 = S(i).IFdata(:, ismember(IFnames,'3_CFP_mean'));
        S(i).CFP3cyt = S(i).IFdata(:, ismember(IFnames,'3_CFP_cyto ring'));
        S(i).YFP3 = S(i).IFdata(:, ismember(IFnames,'3_YFP_mean'));
        S(i).YFP3cyt = S(i).IFdata(:, ismember(IFnames,'3_YFP_cyto ring'));
        S(i).RFP3 = S(i).IFdata(:, ismember(IFnames,'3_RFP_mean'));
        S(i).RFP3cyt = S(i).IFdata(:, ismember(IFnames,'3_RFP_cyto ring'));
        S(i).iRFP3 = S(i).IFdata(:, ismember(IFnames,'3_iRFP_mean'));
        S(i).iRFP3cyt = S(i).IFdata(:, ismember(IFnames,'3_iRFP_cyto ring'));
        S(i).RFP203 = S(i).IFdata(:, ismember(IFnames,'3_20xRFP_mean'));
        S(i).RFP203cyt = S(i).IFdata(:, ismember(IFnames,'3_20xRFP_cyto ring'));


        S(i).DAPI4 = S(i).IFdata(:, ismember(IFnames,'3_DAPI_mean'));
        S(i).CFP4 = S(i).IFdata(:, ismember(IFnames,'4_CFP_mean'));
        S(i).CFP4cyt = S(i).IFdata(:, ismember(IFnames,'4_CFP_cyto ring'));
        S(i).YFP4 = S(i).IFdata(:, ismember(IFnames,'4_YFP_mean'));
        S(i).YFP4cyt = S(i).IFdata(:, ismember(IFnames,'4_YFP_cyto ring'));
        S(i).RFP4 = S(i).IFdata(:, ismember(IFnames,'4_RFP_mean'));
        S(i).RFP4cyt = S(i).IFdata(:, ismember(IFnames,'4_RFP_cyto ring'));
        S(i).iRFP4 = S(i).IFdata(:, ismember(IFnames,'4_iRFP_mean'));
        S(i).iRFP4cyt = S(i).IFdata(:, ismember(IFnames,'4_iRFP_cyto ring'));
        % S(i).RFP204 = S(i).IFdata(:, ismember(IFnames,'4_20xRFP_mean'));
        % S(i).RFP204cyt = S(i).IFdata(:, ismember(IFnames,'4_20xRFP_cyto ring'));
        % 
        % 
        % 
        % S(i).DAPI5 = S(i).IFdata(:, ismember(IFnames,'5_DAPI_mean'));
        % S(i).CFP5 = S(i).IFdata(:, ismember(IFnames,'5_CFP_mean'));
        % S(i).CFP5cyt = S(i).IFdata(:, ismember(IFnames,'5_CFP_cyto ring'));
        % S(i).YFP5 = S(i).IFdata(:, ismember(IFnames,'5_YFP_mean'));
        % S(i).YFP5cyt = S(i).IFdata(:, ismember(IFnames,'5_YFP_cyto ring'));
        % S(i).RFP5 = S(i).IFdata(:, ismember(IFnames,'5_RFP_mean'));
        % S(i).RFP5cyt = S(i).IFdata(:, ismember(IFnames,'5_RFP_cyto ring'));
        % S(i).iRFP5 = S(i).IFdata(:, ismember(IFnames,'5_iRFP_mean'));
        % S(i).iRFP5cyt = S(i).IFdata(:, ismember(IFnames,'5_iRFP_cyto ring'));
        % S(i).RFP205 = S(i).IFdata(:, ismember(IFnames,'5_20xRFP_mean'));
        % S(i).RFP205cyt = S(i).IFdata(:, ismember(IFnames,'5_20xRFP_cyto ring'));



        S(i).dna = S(i).DAPI1 .* S(i).IFarea;
        S(i).x = S(i).IFdata(:, ismember(IFnames,'x'));
        S(i).y = S(i).IFdata(:, ismember(IFnames,'y'));
        
        S(i).jitterX = S(i).IFdata(:, ismember(IFnames,'jitterX'));
        S(i).jitterY = S(i).IFdata(:, ismember(IFnames,'jitterY'));
        S(i).fixedRow = S(i).IFdata(:, ismember(IFnames,'row'));
        S(i).fixedCol = S(i).IFdata(:, ismember(IFnames,'col'));
        S(i).fixedSite = S(i).IFdata(:, ismember(IFnames,'fixed site'));
        
        
        %%% Ungated
        allIF(i).IFarea = S(i).IFdata(:, find(ismember(IFnames,'nuclear area')));
        
        allIF(i).DAPI1 = S(i).IFdata(:, find(ismember(IFnames,'1_DAPI_mean')));
        allIF(i).DNA = allIF(i).DAPI1 .* allIF(i).IFarea;  
        allIF(i).YFP1 = S(i).IFdata(:, find(ismember(IFnames,'1_YFP_mean')));
        allIF(i).YFP1cyt = S(i).IFdata(:, find(ismember(IFnames,'1_YFP_cyto ring')));
        allIF(i).CFP1 = S(i).IFdata(:, find(ismember(IFnames,'1_CFP_mean')));
        allIF(i).CFP1cyt = S(i).IFdata(:, find(ismember(IFnames,'1_CFP_cyto ring')));
        allIF(i).RFP1 = S(i).IFdata(:, find(ismember(IFnames,'1_RFP_mean')));
        allIF(i).RFP1cyt = S(i).IFdata(:, find(ismember(IFnames,'1_RFP_cyto ring')));
        allIF(i).iRFP1cyt = S(i).IFdata(:, find(ismember(IFnames,'1_iRFP_cyto ring')));
        allIF(i).iRFP1 = S(i).IFdata(:, find(ismember(IFnames,'1_iRFP_mean')));
        %  allIF(i).Cy71cyt = S(i).IFdata(:, find(ismember(IFnames,'1_CY7_cyto ring')));
        % allIF(i).Cy71 = S(i).IFdata(:, find(ismember(IFnames,'1_CY7_mean')));
        % 

        allIF(i).DAPI2 = S(i).IFdata(:, find(ismember(IFnames,'2_DAPI_mean')));
        allIF(i).CFP2 = S(i).IFdata(:, find(ismember(IFnames,'2_CFP_mean')));
        allIF(i).CFP2cyt = S(i).IFdata(:, find(ismember(IFnames,'2_CFP_cyto ring')));
        allIF(i).YFP2 = S(i).IFdata(:, find(ismember(IFnames,'2_YFP_mean')));
        allIF(i).YFP2cyt = S(i).IFdata(:, find(ismember(IFnames,'2_YFP_cyto ring')));
        allIF(i).RFP2 = S(i).IFdata(:, find(ismember(IFnames,'2_RFP_mean')));
        allIF(i).RFP2cyt = S(i).IFdata(:, find(ismember(IFnames,'2_RFP_cyto ring')));
        allIF(i).iRFP2 = S(i).IFdata(:, find(ismember(IFnames,'2_iRFP_mean')));
        allIF(i).iRFP2cyt = S(i).IFdata(:, find(ismember(IFnames,'2_iRFP_cyto ring')));
        % allIF(i).RFP202 = S(i).IFdata(:, find(ismember(IFnames,'2_20xRFP_mean')));
        % allIF(i).RFP202cyt = S(i).IFdata(:, find(ismember(IFnames,'2_20xRFP_cyto ring')));
        %  allIF(i).Cy72 = S(i).IFdata(:, ismember(IFnames,'2_CY7_mean'));
        % allIF(i).Cy72cyt = S(i).IFdata(:, ismember(IFnames,'2_CY7_cyto ring'));


        allIF(i).DAPI3 = S(i).IFdata(:, find(ismember(IFnames,'3_DAPI_mean')));
        allIF(i).CFP3 = S(i).IFdata(:, find(ismember(IFnames,'3_CFP_mean')));
        allIF(i).CFP3cyt = S(i).IFdata(:, find(ismember(IFnames,'3_YFP_cyto ring')));
        allIF(i).YFP3 = S(i).IFdata(:, find(ismember(IFnames,'3_YFP_mean')));
        allIF(i).YFP3cyt = S(i).IFdata(:, find(ismember(IFnames,'3_YFP_cyto ring')));
        allIF(i).RFP3 = S(i).IFdata(:, find(ismember(IFnames,'3_RFP_mean')));
        allIF(i).RFP3cyt = S(i).IFdata(:, find(ismember(IFnames,'3_RFP_cyto ring')));
        allIF(i).iRFP3 = S(i).IFdata(:, find(ismember(IFnames,'3_iRFP_mean')));
        allIF(i).iRFP3cyt = S(i).IFdata(:, find(ismember(IFnames,'3_iRFP_cyto ring')));
        allIF(i).RFP203 = S(i).IFdata(:, find(ismember(IFnames,'3_20xRFP_mean')));
        allIF(i).RFP203cyt = S(i).IFdata(:, find(ismember(IFnames,'3_20xRFP_cyto ring')));
        % 
        allIF(i).DAPI4 = S(i).IFdata(:, find(ismember(IFnames,'4_DAPI_mean')));
        allIF(i).CFP4 = S(i).IFdata(:, find(ismember(IFnames,'4_CFP_mean')));
        allIF(i).CFP4cyt = S(i).IFdata(:, find(ismember(IFnames,'4_YFP_cyto ring')));
        allIF(i).YFP4 = S(i).IFdata(:, find(ismember(IFnames,'4_YFP_mean')));
        allIF(i).YFP4cyt = S(i).IFdata(:, find(ismember(IFnames,'4_YFP_cyto ring')));
        allIF(i).RFP4 = S(i).IFdata(:, find(ismember(IFnames,'4_RFP_mean')));
        allIF(i).RFP4cyt = S(i).IFdata(:, find(ismember(IFnames,'4_RFP_cyto ring')));
        allIF(i).iRFP4 = S(i).IFdata(:, find(ismember(IFnames,'4_iRFP_mean')));
        allIF(i).iRFP4cyt = S(i).IFdata(:, find(ismember(IFnames,'4_iRFP_cyto ring')));
        % allIF(i).RFP204 = S(i).IFdata(:, find(ismember(IFnames,'4_20xRFP_mean')));
        % allIF(i).RFP204cyt = S(i).IFdata(:, find(ismember(IFnames,'4_20xRFP_cyto ring')));
        % 
        %   allIF(i).DAPI5 = S(i).IFdata(:, find(ismember(IFnames,'5_DAPI_mean')));
        % allIF(i).CFP5 = S(i).IFdata(:, find(ismember(IFnames,'5_CFP_mean')));
        % allIF(i).CFP5cyt = S(i).IFdata(:, find(ismember(IFnames,'5_YFP_cyto ring')));
        % allIF(i).YFP5 = S(i).IFdata(:, find(ismember(IFnames,'5_YFP_mean')));
        % allIF(i).YFP5cyt = S(i).IFdata(:, find(ismember(IFnames,'5_YFP_cyto ring')));
        % allIF(i).RFP5 = S(i).IFdata(:, find(ismember(IFnames,'5_RFP_mean')));
        % allIF(i).RFP5cyt = S(i).IFdata(:, find(ismember(IFnames,'5_RFP_cyto ring')));
        % allIF(i).iRFP5 = S(i).IFdata(:, find(ismember(IFnames,'5_iRFP_mean')));
        % allIF(i).iRFP5cyt = S(i).IFdata(:, find(ismember(IFnames,'5_iRFP_cyto ring')));
        % allIF(i).RFP205 = S(i).IFdata(:, find(ismember(IFnames,'5_20xRFP_mean')));
        % allIF(i).RFP205cyt = S(i).IFdata(:, find(ismember(IFnames,'5_20xRFP_cyto ring')));


        allIF(i).fixedRow = S(i).IFdata(:, ismember(IFnames,'row'));
        allIF(i).fixedCol = S(i).IFdata(:, ismember(IFnames,'col'));
        allIF(i).fixedSite = S(i).IFdata(:, ismember(IFnames,'fixed site'));
    end
    %% Gate based on division %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if settings.daughterGate == 1
        S(i) = gateout_all(S(i),S(i).isDaughter);
    elseif settings.daughterGate == 2
        S(i) = gateout_all(S(i),~S(i).isDaughter);
    end
    %% Extract nuclear channels%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    S(i).area = S(i).traceData(:,:,ismember(names,'nuclear area'));
    S(i).nucMean = S(i).traceData(:,:,ismember(names,[settings.nuc '_mean']));
    S(i).mass = S(i).area.*S(i).nucMean;
    S(i).massNorm = S(i).mass./repmat(max(S(i).mass,[],2),1,size(S(i).area,2));
    S(i).POI(:, 1) = S(i).traceStats(:,1);
    S(i).POI(:,6) = S(i).traceStats(:,2);
    S(i).POI(~S(i).isMother,6) = NaN;
    
    %% Gate on length%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    numFrames = size(S(i).traceData,2);
    minLengthTrace = ceil(numFrames*settings.minTraceFrac);

    S(i).traceStats(:,5) = findFirstInMat(~isnan(S(i).area));
    S(i).traceStats(:,6) = findLastInMat(~isnan(S(i).area));

    badlengths = (S(i).traceStats(:,6) - S(i).traceStats(:,5) < minLengthTrace) & ~S(i).isMother; %| sensor(i).motherStats(:,3)<5;
    S(i)=gateout_all(S(i),~badlengths);

    
    %% Gate nuclear %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    noiseThresh = .07; %(.07)
%     badNoise = gatenoisy(S(i).massNorm, S(i).traceStats, settings.daughterOption, strcmp(settings.type,'release'), noiseThresh, 4,4);
    badNoise = gatenoisy_hybrid(S(i).massNorm, S(i).traceStats, S(i).isDaughter, noiseThresh, 4,4);
    %     clear  highNoise;
    %     %%% Gate on absolute change
    %     for n = 1:size(S(i).massNorm,1)
    %         highNoise(n,1) = any(abs(diff(S(i).massNorm(n,:))) > .25);
    %     end
    S(i) = gateout_all(S(i),~(badNoise));
    
    %% Extract and gate cdk %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if ~isempty(settings.cdk)
        bg_ind = find(ismember(names,[settings.cdk '_mean']))- 4;
        bg_median = median(S(i).bg(:,:,bg_ind),1);
        bg_perc = prctile(S(i).bg(:,:,bg_ind),10);
       bg_perc = 400;
        
        S(i).cdkNuc = S(i).traceData(:,:,ismember(names,[settings.cdk '_mean'])) + S(i).bg(:,:,bg_ind) - bg_perc;
        S(i).cdkCyt = S(i).traceData(:,:,ismember(names,[settings.cdk '_cyto ring'])) + S(i).bg(:,:,bg_ind)- bg_perc;
        %         S(i).cdkLocalBg = S(i).traceData(:,:,ismember(names, [setting.cdk '_block bg']));
        
        maxThresh = 1000; %threshold above which max of each trace must be  %150
        noiseThresh = 100;%0.20; %threshold rate of DHBratio change (not absolute) above which trace is considered noisy
        smoothWindow = 6;
        [S(i).cdk,badTracesCdk] = gate_Cdk2_NR(S(i).cdkNuc,S(i).cdkCyt,maxThresh,noiseThresh,smoothWindow);
        lowCDK = max(S(i).cdkNuc,[],2) < 50;
        S(i).goodCdk = ~badTracesCdk & ~lowCDK;
       % S(i) = gateout_all(S(i),~badTracesCdk & ~lowCDK);% &S(i).isDaughter
    end
    
    %% Extract and gate apc %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if ~isempty(settings.apc)
        S(i).apcNuc = S(i).traceData(:,:,ismember(names,[settings.apc '_mean'])) ;%+ S(i).apcLocalBg;

      
%         S(i).apcNuc = correctBlankFrame(S(i).apcNuc, S(i).shot, 3:10, -5);
%         S(i).apcNuc = fillTraceVals(S(i).apcNuc, S(i).traceStats, 5);
        
        %%% Gate cell traces %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        highMean = false(size(S(i).apcNuc,1),1);
        badAPCdiv = false(size(S(i).apcNuc,1),1);        
        if strcmp(settings.type, 'release') | strcmp(settings.type, 'hybrid')
            % Quiescent released cells
            meanWindow = 1:20;
            lowThresh = 100;
            highMean(~S(i).isDaughter) = nanmean(S(i).apcNuc(~S(i).isDaughter,meanWindow),2) > lowThresh;
            %             noiseThresh = 200;
            %             maskTrace = [];
            %             noiseMask = ones(1,numFrames-1);
            %             noiseMask(maskTrace)=0;
            %             clear highTracestart highNoise;
            %             for n = 1:size(S(i).apcNuc,1)
            %                 highTracestart(n,1) = S(i).apcNuc(n,S(i).traceStats(n,1)) > lowThresh;
            %                 highNoise(n,1) = any(abs(diff(S(i).apcNuc(n,:))) > noiseThresh & noiseMask);
            %             end
            %S(i).apcBadTraces = highTracestart | highMean; % Don't gate out weird apc traces
        end
        if strcmp(settings.type, 'cycling') | strcmp(settings.type, 'hybrid')
            % Divided cells
            minMaxThresh = [300 10]; %[number that the minimum of each trace has to be below          number max of each trace has to be above]
            minMaxNoise = [-50000 50000];
            traceGem = S(i).apcNuc;
            buff = 5;
            postMitosis = 0;
            badAPCdiv(S(i).isDaughter) = gateSigTraces(traceGem(S(i).isDaughter,:), S(i).traceStats(S(i).isDaughter,:),...
                buff, postMitosis, minMaxThresh, minMaxNoise);          
        end
   S(i) = gateout_all(S(i),~(badAPCdiv | highMean));
         S(i).goodAPC = ~badAPCdiv;
        
        %%% Transform data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        S(i).apcArea = (S(i).apcNuc).*S(i).area;
        %         S(i).apcAreaSmooth = NaN*ones(size(S(i).apcNuc));
                badTracesAPC = false(size(S(i).apcNuc,2),1);

        if strcmp(settings.type,'cycling') | strcmp(settings.type,'hybrid') 
            S(i).apcNorm = (S(i).apcNuc-repmat(min(S(i).apcNuc,[],2),1,size(S(i).apcNuc,2)))...
                ./repmat(max(S(i).apcNuc,[],2),1,size(S(i).apcNuc,2));
            S(i).apcNormM = NaN*ones(size(S(i).apcNuc));
            S(i).apcAreaNormM = NaN*ones(size(S(i).apcArea));
            S(i).apcNorm = (S(i).apcNuc-repmat(min(S(i).apcNuc,[],2),1,size(S(i).apcNuc,2)))...
                ./repmat(max(S(i).apcNuc,[],2),1,size(S(i).apcNuc,2));
            S(i).apcAreaNorm = (S(i).apcArea-repmat(min(S(i).apcArea,[],2),1,size(S(i).apcArea,2)))...
                ./repmat(max(S(i).apcArea,[],2),1,size(S(i).apcArea,2));
        end
        
        for n = 1:size(S(i).apcArea,1)
            %             S(i).apcAreaSmooth(n,:) = nansmooth(S(i).apcArea(n,:),3);
            if strcmp(settings.type,'cycling') | strcmp(settings.type,'hybrid') 
                mitFrame = S(i).POI(n,1);
                window = [-10:10];
                if ~isnan(mitFrame) & mitFrame + window(1) > 0 & mitFrame + window(end) <= size(S(i).apcNuc,2)
                    if max(S(i).apcNuc(n,mitFrame+window)) > minMaxThresh(2) & min(S(i).apcNuc(n,mitFrame+window)) < minMaxThresh(1)
                        S(i).apcNormM(n,:) =  S(i).apcNuc(n,:) - min(S(i).apcNuc(n,mitFrame+window(1):end));
                        S(i).apcNormM(n,:) = S(i).apcNormM(n,:)/max(S(i).apcNormM(n,mitFrame+window));
                        
                        S(i).apcAreaNormM(n,:) =  S(i).apcArea(n,:) - min(S(i).apcArea(n,mitFrame+window(1):end));
                        S(i).apcAreaNormM(n,:) = S(i).apcAreaNormM(n,:)/max(S(i).apcAreaNormM(n,mitFrame+window));
                    else
                        S(i).apcNormM(n,:) =  S(i).apcNorm(n,:);
                        S(i).apcAreaNormM(n,:) =  S(i).apcAreaNorm(n,:);
                        badTracesAPC(n) = true;
                    end
                else
                    S(i).apcNormM(n,:) =  S(i).apcNorm(n,:);
                    S(i).apcAreaNormM(n,:) =  S(i).apcAreaNorm(n,:);
                    badTracesAPC(n) = true;
                    
                end
            end
        end
        %         S(i) = gateout_all(S(i),~(badTracesAPC));
        
        %%% Find APC inactivation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if settings.poiApc            
            %%% quiescent cells
            subset = find(~S(i).isDaughter);
             [S(i).POI(subset,2), badTracesAPC(subset)] = findAPCInact(S(i).apcNuc(subset,:), S(i).traceStats(subset,:), ...
                struct('postBuffer',10,'smooth',6,'cycling',0,...
                'buff',3,'thresh',0,'preBuffer',5,'lowThresh',200, 'increase',400,'trunc',1000, ...
                'medfilt',0,'early', 3,'debug',0));
            %%% Divided cells
            if strcmp(settings.type,'cycling') | strcmp(settings.type,'hybrid')
                subset = find(S(i).isDaughter);
                traces = S(i).apcNuc;
             % [S(i).POI(subset,2), badTracesAPC(subset)] = findAPCInact(S(i).apcAreaNormM(subset,:), S(i).traceStats(subset,:), ...
             %    struct('postBuffer',3,'smooth',4,'cycling',1,...
             %            'buff',5,'thresh',.001,'preBuffer',3,'lowThresh',.05, 'increase',.06 ,...
             %            'trunc',.95, 'medfilt',1,'early', 7,'debug',1));

             [S(i).POI(subset,2), badTracesAPC(subset)] = findAPCInact(S(i).apcAreaNormM(subset,:), S(i).traceStats(subset,:), ...
                 struct('postBuffer',5,'smooth',4,'cycling',1,...
                 'buff',5,'thresh',.001,'preBuffer',5,'lowThresh',.05, 'increase',.06,...
                 'trunc',.95, 'medfilt',0,'early', 5,'debug',0));

            end
            
            %S(i) = gateout_all(S(i),~(badTracesAPC));
            %S(i).apcBadTraces = S(i).apcBadTraces | badTracesAPC;
            
        end
        
    end
    
    %% Extract and gate crl %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if ~isempty(settings.crl)
        S(i).crlNuc = S(i).traceData(:,:,ismember(names,[settings.crl '_mean']));% - S(i).crlLocalBg;
%         S(i).crlNuc = correctBlankFrame(S(i).crlNuc, S(i).shot, 3:10, -5);
%         S(i).crlNuc = fillTraceVals(S(i).crlNuc, S(i).traceStats, 5);
        S(i).crlArea = (S(i).crlNuc).*S(i).area;
        S(i).crlCyto = S(i).traceData(:,:,ismember(names,[settings.crl '_cyto ring']));
        
        %%% Gate out traces %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        noiseThresh = 20000;
        maskTrace = [];
        %meanWindow = 20:30;
        lowThresh = 200; %max has to be above
        noiseMask = ones(1,numFrames-1);
        noiseMask(maskTrace)=0;
        clear lowTracestart highNoise;
        for n = 1:size(S(i).crlNuc,1)
            lowTracestart(n,1) = S(i).crlNuc(n,S(i).traceStats(n,1)) < lowThresh;
            highNoise(n,1) = any(abs(diff(S(i).crlNuc(n,:)))>noiseThresh & noiseMask);
%             inds = find(highNoise);
        end
        %lowMean = nanmean(S(i).crlNuc(:,meanWindow),2) < lowThresh;
        lowMax = max(S(i).crlNuc,[],2) < lowThresh;
        %S(i).crlExpress = ~lowMax;
        S(i) = gateout_all(S(i),~( highNoise | lowMax ));
        
        %%% Transform traces %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        S(i).crlNorm = NaN*ones(size(S(i).crlNuc));
        S(i).crlAreaNorm = NaN*ones(size(S(i).crlNuc));
        %S(i).crlAreaSmooth = NaN*ones(size(S(i).crlNuc));
        %S(i).crlDiff = NaN*ones(size(S(i).crlNuc));
        if strcmp(settings.type,'cycling')
            S(i).crlNormPostM = NaN*ones(size(S(i).crlNuc));
        end
        for n = 1:size(S(i).crlArea,1)
            S(i).crlNorm(n,:) =  S(i).crlNuc(n,:)./max(S(i).crlNuc(n,1:end-1));
            S(i).crlAreaNorm(n,:) =  S(i).crlArea(n,:)./max(S(i).crlArea(n,1:end-1));
            %S(i).crlNormSmooth(n,:) = nansmooth(S(i).crlNorm(n,:), 5);
            %S(i).crlDiff(n,:) = gradient(S(i).crlAreaSmooth(n,:));
            
            if strcmp(settings.type,'cycling')
                startFrame = S(i).POI(n,1);
                if ~isnan(startFrame) & startFrame +1 <= numFrames
                    S(i).crlNormPostM(n,:) =  S(i).crlArea(n,:)./max(S(i).crlArea(n,startFrame:end-1));
                else
                    S(i).crlNormPostM(n,:) =  S(i).crlAreaNorm(n,:);
                end
            end
        end
        
        %%% Find crl inactivation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if settings.poiCrl          
            %%% quiescent cells
            subset = find(~S(i).isDaughter);
            S(i).POI(subset,3:4) = findCRL4Act_v2_reverse(struct('CRLtrace',S(i).crlArea(subset,:),...
                'traceStats', S(i).traceStats(subset,:),'nuc',S(i).crlNuc(subset,:), 'cyto', S(i).crlCyto(subset,:)), ...
                struct('cycling',0,'smooth',7 ,'buff',1 , 'postBuffer', 6 ,'postBufferSec',3,...
                'firstD',0,'secD',.000,'decrease', .3, 'minSlope', -.01, 'early', 5,'falseCall', .8, 'cytoCheck', 0,'minExp',75,...
                'trunk',.4,'debug',0));
            %%% Divided cells
            subset = find(S(i).isDaughter);
            S(i).POI(subset,3:4) = findCRL4Act_v2_reverse(struct('CRLtrace',S(i).crlArea(subset,:),...
                'traceStats', S(i).traceStats(subset,:),'nuc',S(i).crlNuc(subset,:), 'cyto', S(i).crlCyto(subset,:)), ...
                struct('cycling',1,'smooth',4,'buff',5 , 'postBuffer',3,'postBufferSec',2,...
                'firstD',0.001,'secD',.1,'decrease', .1, 'minSlope', .01, 'early', 4,'falseCall', .8, 'cytoCheck', 0,'minExp',60,...
                'trunk',.4,'debug',0));
   
   
            
            %%% Transformations
            S(i).crlNormAct = NaN*ones(size(S(i).crlNuc));
            S(i).crlMaxAct = NaN*ones(size(S(i).crlNuc,1),1);
            for n = 1:size(S(i).crlArea,1)
                if ~isnan(S(i).POI(n,3))
                    %%% change if use Nuc signal
                    S(i).crlNormAct(n,:) =  S(i).crlArea(n,:)/S(i).crlArea(n,S(i).POI(n,3));
                    S(i).crlMaxAct(n) = S(i).crlNuc(n,S(i).POI(n,3));
                else
                    S(i).crlNormAct(n,:) = S(i).crlAreaNorm(n,:);
                end
            end
            
            if settings.poiG2
                [S(i).POI(:,5), badTracesCRL] = findCRLInact(S(i).crlNormAct, S(i).traceStats, S(i).POI(:,4), ...
                    struct('postBuffer',7,'smooth',6,...
                    'buff',5,'thresh',.002,'preBuffer',5,'lowThresh',.1,...
                    'increase',.0001*10,'trunc',.5, 'medfilt',0,'early',4,'debug',0));
            end
        end
        
    end
    
    %% Extract and gate sig %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if ~isempty(settings.sig)
        S(i).sigNuc = S(i).traceData(:,:,ismember(names,[settings.sig '_mean']));
        S(i).sigArea = (S(i).sigNuc).*S(i).area;
        
        %%% Gate out traces on noise and misexpression %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        noiseThresh = 20000;
        maskTrace = [];
        %meanWindow = 70:100;
        lowThresh = 20;
        noiseMask = ones(1,numFrames-1);
        noiseMask(maskTrace)=0;
        clear lowTracestart highNoise;
        for n = 1:size(S(i).sigNuc,1)
            highNoise(n,1) = any(abs(diff(S(i).sigNuc(n,:)))>noiseThresh & noiseMask);
        end
        %lowMean = nanmean(S(i).sigNuc(:,meanWindow),2) < lowThresh;
        lowMax = max(S(i).sigNuc,[],2) < lowThresh;
        S(i) = gateout_all(S(i),~( lowMax | highNoise));
        %S(i).sigExpress = ~lowMax;
        
        %%% Transform data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        for n = 1:size(S(i).sigArea,1)
            ignore_norm = 5;
            S(i).sigNorm(n,:) =  S(i).sigArea(n,:)./max(S(i).sigArea(n,ignore_norm:end-1));
            S(i).sigSmooth(n,:) = nansmooth(S(i).sigArea(n,:), 5);
            S(i).sigNormSmooth(n,:) = nansmooth(S(i).sigNorm(n,:), 5);
            S(i).sigDiff(n,:) = gradient(S(i).sigSmooth(n,:));
            
            
            if ~settings.quiescent
                startFrame = S(i).POI(n,1);
                if ~isnan(startFrame) & startFrame +1 <= numFrames & ~settings.quiescent
                    S(i).sigNormPostM(n,:) =  S(i).sigArea(n,:)./max(S(i).sigArea(n,startFrame:end-1));
                elseif ~settings.quiescent
                    S(i).sigNormPostM(n,:) =  S(i).sigNorm(n,:);
                end
            end
            S(i).sigNormSmoothPostM(n,:) = nansmoothm(S(i).sigNormPostM(n,:), 7, 'sgolay');
            S(i).sigNormNoise(n,:) = S(i).sigNormPostM(n,:) - S(i).sigNormSmoothPostM(n,:);
            
        end
        
        %%% Find crl inactivation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if settings.poiCrl
            S(i).POI(:,3) = findCRL4Act(S(i).sigNormSmoothPostM,S(i).traceStats, ...
                struct('cycling',~settings.quiescent,'low',.1,'smooth',0,'smoothSec',3, ...
                'firstD',-.0,'secD',-.001,'early', 20,'falseCall', .8,'buff',10, 'postBuffer', 3,'decrease', 3*.005,'debug',1));
            
            S(i).crlNormAct = NaN*ones(size(S(i).sigNuc));
            S(i).sigMax = NaN*ones(size(S(i).sigNuc,1),1);
            
            for n = 1:size(S(i).sigArea,1)
                if ~isnan(S(i).POI(n,3))
                    S(i).sigNormAct(n,:) =  S(i).sigNuc(n,:)/S(i).sigNuc(n,S(i).POI(n,3));
                    %                     if(log2(S(i).YFP3(n)) > 9 | log2(S(i).dna) < 23.75)
                    %                         S(i).POI(n,3) = NaN;
                    %                     end
                    S(i).sigMax(n) = S(i).sigNuc(n,S(i).POI(n,3));
                    
                else
                    S(i).sigNormAct(n,:) = S(i).sigNorm(n,:);
                end
            end
        end
        
    end
    
    
    %% Extract and gate PCNA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if ~isempty(settings.PCNA)
        S(i).pcnaNuc = S(i).traceData(:,:,ismember(names,'PCNA mean'));
        
        %%% Gate out traces on noise and misexpression %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        noiseThresh = 20000;
        maskTrace = [];
        meanWindow = 70:100;
        lowThresh = 200;
        noiseMask = ones(1,numFrames-1);
        noiseMask(maskTrace)=0;
        clear lowTracestart highNoise;
        for n = 1:size(S(i).pcnaNuc,1)
            highNoise(n,1) = any(abs(diff(S(i).pcnaNuc(n,:)))>noiseThresh & noiseMask);
        end
        lowMean = nanmean(S(i).pcnaNuc(:,meanWindow),2) < lowThresh;
        %lowMax = max(S(i).pcnaNuc,[],2) < lowThresh;
        S(i) = gateout_all(S(i),~( lowMean | highNoise));
        %         S(i) = gateout_all(S(i),~( highNoise));
        %         S(i).pcnaExpress = ~lowMax;
        
        %%% load data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        S(i).filterIntensity = S(i).traceData(:,:,ismember(names,'Filter mean'));
        S(i).filterArea = S(i).traceData(:,:,contains(names,'Filter Masked area'));
        S(i).filterMaskIntensity = S(i).filterArea.*S(i).traceData(:,:,contains(names,'Filter Masked mean'));
        
        S(i).varIntensity = S(i).traceData(:,:,ismember(names,'Variance mean'));
        S(i).varStd = S(i).traceData(:,:,ismember(names,'Variance std'));
        %         S(i).varIntensityNorm = S(i).varIntensity./repmat(nanmean(S(i).pcnaNuc(:,meanWindow),2),[1 size(S(i).pcnaNuc,2)]);
        S(i).varIntensityNorm = S(i).varIntensity-repmat(min(S(i).varIntensity,[],2),[1 size(S(i).pcnaNuc,2)]);
        S(i).varArea = S(i).traceData(:,:,contains(names,'Variance Masked area'));
        S(i).varMaskIntensity = S(i).varArea.*S(i).traceData(:,:,contains(names,'Variance Masked mean'));
        %S(i).varMaskIntensityNorm = S(i).varMaskIntensity./repmat(nanmean(S(i).pcnaNuc(:,meanWindow),2),[1 size(S(i).pcnaNuc,2)]);
        
        if settings.poiPCNA
            S(i).filterPOI = getPCNAstart_C117(S(i).filterArea(:,:,2),S(i).traceStats,10,10);
            % S(i).filterPOI = getPCNAstart_C114_intensity(S(i).varIntensityNorm(:,:),S(i).traceStats,10,20);
            
        end
    end
    
end

%% Extra transformations %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:length(S)
    
    
end

S = rmfield(S,{'traceData'});

save(fullfile(settings.saveDir, settings.saveName),'S','allIF','settings','-v7.3');




%% Extra code
%     S(i).traceData = S(i).traceData(:,1:end-1,:);
%     S(i).traceStats(S(i).traceStats == 156) = 155;
%     S(i).traceStats(:,3) = S(i).traceStats(:,2) - S(i).traceStats(:,1) + 1;
% Median filter to get rid of single frame noise
%     for numcell = 1:size(S(i).apcNuc,1)
%         S(i).apcNuc_filt(numcell,:) = S(i).apcNuc(numcell,:);
%         ind = ~isnan(S(i).apcNuc_filt(numcell,:));
%         S(i).apcNuc_filt(numcell,ind) = medfilt1(S(i).apcNuc_filt(numcell,ind),3);
%     end

%         S(i).crlLocalBg = S(i).traceData(:,:,ismember(names, [setting.crl '_block bg']));
%         [S(i).crlLocalBg, badBg] = fillTraceVals(S(i).crlLocalBg, S(i).traceStats, 5);
%         S(i).crlNuc = correctBlankFrame(S(i).crlNuc, S(i).shot, 10:40, -10);
%         S(i).crlNuc = fillTraceVals(S(i).crlNuc, S(i).traceStats, 5);
%         S(i).crlNuc(S(i).crlNuc <=0) = .01;
%         S(i).crl4Act = calcCRL4ActivityCycling_E1092(S(i).crlArea,S(i).traceStats,S(i).POI(:,3),...
%             struct('manualk_syn',NaN,'buffer',5,'k_deg', 0, 'k_mult',10, 'smooth',5));
%         S(i).crl4Act(S(i).crl4Act <= 0) = 1e-4;
%         S(i).logCrl4Act = log(S(i).crl4Act);
