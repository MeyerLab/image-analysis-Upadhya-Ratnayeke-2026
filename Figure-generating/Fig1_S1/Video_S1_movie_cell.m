%% Load data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
[file_loc] = fileparts(matlab.desktop.editor.getActiveFilename);
cd(file_loc);
% cd('C:\Users\swu4001\OneDrive - med.cornell.edu\APC_Paper\APC_final_figs\Fig1\');
dataDir = '..\..\FINAL DATA files';
%%% Experiment Paremeters


load([dataDir filesep 'A038_data.mat'],'S','settings','allIF');
% S = loadData(conditions, dataDir);
conditions = settings.conditions;

framesPerHr = 60/12;
frameDrugAdded = 0;
frameEdU = 0;
timeStart = 0;

folding =5;

numFrames = size(S(1).area,2);
xFrames = 1:numFrames;
xTime = (xFrames-1)./framesPerHr;

% times = arrayfun(@(x)(numFrames - x.POI)/framesPerHr,S,'UniformOutput',false);
% [S.POI_time] = times{:};

for i = 1:length(S)
    S(i).POI_realtime = S(i).POI/framesPerHr;
    S(i).POI_drug_time = (frameDrugAdded - S(i).POI)/framesPerHr;
end
%% set filepaths %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
liveImagePath='C:\Users\swu4001\OneDrive - med.cornell.edu\APC_Paper\FINAL DATA files\A038-images\';
presentationdir='..\..\FINAL DATA files\';
formatCode = 'Time%1$05d_Well%2$s_*.tiff';

livemaskname='nucedge_';
names_live = {'CFP','YFP_','RFP_','iRFP_'};

%%% set viewing parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
winrad=35; %org:70
imageScaleLive = 1;

linecol = [0 0 0];
linewidthvar=6;
graphfontsize=32;
imagefontsize=40;

save_movie = true;
save_single = true;
save_box = false;
save_trace = false;
%%% define scale bar
bar_length = 5;
pixel = 0.65;
%% set cell parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cond =5;
imSat = {[100 200],[1000 2000],[1500 5000],[500 15000]};
% colors_live = [0 0 1; 1 1 1; 1 1 0; 1 0 1; 0 1 1];
 colors_live = [0 0 1; 0 1 0 ;1 0 0; 1 0 1  ];
 
 maxDHB = mean(maxk(S(cond).cdkCyt,4,2),2);
  possibleCells = find(~isnan(S(cond).POI_realtime(:,3)) &S(cond).POI_realtime(:,1)<10 &S(cond).POI_realtime(:,3)<15 &... 
   isnan(S(cond).POI_realtime(:,2)));
% % cellInds = possibleCells(3); %cell 7
% cellInds = possibleCells(5); %cell 5
 cellInds=135;
close all
for j = 1:length(cellInds)
           cellInd = cellInds(j);

 
    figure, plot(S(cond).apcNuc(cellInd,:)');
figure, plot(S(cond).crlNuc(cellInd,:)');
    liveShot = S(cond).shot{cellInd};
    liveSite = S(cond).wellindex(cellInd,3);
    liveRow = S(cond).wellindex(cellInd,1);
    liveCol = S(cond).wellindex(cellInd,2);
    
    liveRawDir = [liveImagePath,'Raw\',liveShot,'\'];
    liveMaskDir = [liveImagePath,'Mask\',liveShot,'\',liveShot,'_'];
    
    shottrack=[liveShot,'_Emi1kd_reporter_movie_black',num2str(cellInd)];
    boxtrack=[liveShot,'_test_noout_boxw',num2str(cellInd)];
    tracetrack = [liveShot,'_test_noout_tracew',num2str(cellInd)];
    savedir = fullfile(presentationdir, shottrack);
    if save_movie & ~exist(savedir)
        mkdir(savedir)
    end
    %% SAVE MOVIE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% initialize
    f1 = figure('Units', 'Inches', 'Position', [0, 0, 2.5, 2.5*length(names_live)],'color','black');
    % f2 = figure('Units', 'Inches', 'Position', [0, 0, 4*length(names_live), 4 ],'color','white')
    % f3 = figure('Units', 'Inches', 'Position', [0, 0, 5, 5*length(names_live)],'color','white')
    
    if save_movie
        M = VideoWriter([savedir,filesep,shottrack],'MPEG-4'); %Uncompressed AVI or MPEG-4
        M.FrameRate=5;
        open(M);
        
    end

    if save_trace
            Mtrace = VideoWriter([savedir,filesep,tracetrack],'MPEG-4'); %Uncompressed AVI or MPEG-4
                Mtrace.FrameRate=20;
                open(Mtrace);
    end
 

    
    if save_box
        Mbox = VideoWriter([savedir,filesep,boxtrack],'MPEG-4'); %Uncompressed AVI or MPEG-4
        Mbox.FrameRate=20;
        open(Mbox);
    end
    

    %%% load POIs
    POI = S(cond).POI(cellInd,:);
    lastFrame = S(cond).traceStats(cellInd,2);
    %firstFrame = max([S(cond).traceStats(cellInd,1) (lastFrame - movielength)]);
    firstFrame = POI(1);
    
    frames=firstFrame:lastFrame;
    lengthmovie = lastFrame - firstFrame;
    g1_frac = (POI(3)-POI(1))/lengthmovie;
    s_frac = (POI(5)-POI(3))/lengthmovie;
    g2_frac = (lastFrame - POI(5))/lengthmovie;
    
    POI_times = (POI - POI(1))/framesPerHr;
    end_time = (lastFrame - POI(1))/framesPerHr;
lasttime = lastFrame/framesPerHr;
    realtimeapc = [S(cond).apcNormM(cellInd,:); xTime];

    realtimecrl = [S(cond).crlNormAct(cellInd,:); xTime];

    realtimecdk = [S(cond).cdk(cellInd,:); xTime];

   % realtimedbf4 = [S(cond).sigNuc(cellInd,:); xTime];
    %% Loop through movie %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i=1:numel(frames) %full *used this for presentation
        %%% Load images
        f = frames(i);
        nucmask=double(imread([liveMaskDir,livemaskname,num2str(f),'.tif']));
        nanmask = logical(imfill(nucmask));
        
        shotSearch = sprintf(formatCode,f-1,rowColumnTowellName(liveRow,liveCol),liveSite-1);
        fileName = findFile(liveRawDir,shotSearch);
        raw=[];
        for n = 1:length(names_live)
            raw(:,:,n) = imread(fullfile(liveRawDir,fileName),n) - 100;
            %raw=imfilter(raw,fspecial('disk',1),'symmetric');
            %             raw{n}=bgsubmasked_global_NR(raw{n},nanmask,1,4,25);
        end
        
        %% crop images around cell of interest %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        cpos=int16(squeeze(S(cond).pos(cellInd,f,:)-single(S(cond).jitters(cellInd,f,:))))';
        raw = crop_cell(raw,cpos,winrad);
        nucmask = crop_cell(nucmask,cpos,winrad);
        
        %%% select cell of interest
        [reheight,rewidth,channels]=size(raw);
        position=[round(0.5*rewidth) round(0.5*reheight)]; %(x from left, y from top)
        filledMask = imfill(nucmask);
        centerNuc =  bwmorph(bwselect(filledMask,position(1), position(2)),'remove');
        %     centerNuc = double(imdilate(centerNuc,strel('disk',1)));
        
        %%% resize images
        frame=imresize(raw,imageScaleLive,'nearest');
        framemask=logical(imresize(nucmask,imageScaleLive,'nearest'));
        centerNuc = logical(imresize(centerNuc,imageScaleLive,'nearest'));
        [reheight,rewidth]=size(frame);
        
        %% Plot channel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        for c = 2:length(names_live)
            cell_image = mat2gray(frame(:,:,c),imSat{c});
            RGB = cell_image.*reshape(colors_live(c,:),1,1,[]);
%             RGB = imoverlay(RGB,framemask,[.6 .6 0]);
            RGB = imoverlay(RGB,centerNuc,'y');
            
            %%% Plot cell
            figure(f1)
            subplot(3,1,c-1)
            
            imshow(RGB)
             if c==2
                ylabel('APC/C reporter','color','green')
             elseif c==3
             ylabel('S phase reporter','color','red')
             else 
             ylabel('H2B (nucleus)','color','magenta')
             end 
            hold on
            plot ([38 69],[62 62],'w','linewidth',2)
     text(42,66,'20\mum','color','w')
     text(45,56, [num2str(i/5),'h'],'color','w')
    
            % hold on
            % plot([3 3 + bar_length/pixel],reheight - [ 3 3],'w','LineWidth',8)
            % hold off
            if save_single
       %          
                imwrite(RGB,[savedir,filesep,shottrack,'_',names_live{c},'_',num2str(f),'.png']);
            end         

        end
      
        %% WRITE VIDEO FRAME
        if save_movie
            graphfig = getframe(f1);
            writeVideo(M,graphfig);            
        end
%         if i~=numel(frames)
%             clf(f1)
%         end
        drawnow()
        %% 


   
        %% Plot box
        % figure(f2)
        % clf
        % hold on
        % xlim([0 lasttime])
        % xlabel('Time (h)')
        % ylim([0 .5])
        % rectangle('Position',[0 0 POI_times(3)-0 .25 ],'FaceColor','#D4267D','EdgeColor','none');
        % rectangle('Position',[POI_times(3) 0 POI_times(5)-POI_times(3) .25 ],'FaceColor','#F47E1E','EdgeColor','none');
        % rectangle('Position',[POI_times(5) 0  POI_times(6) .25 ],'FaceColor','#8CAF1E','EdgeColor','none');
        % rectangle('Position',[POI_times(6) 0  lasttime .25 ],'FaceColor','#0AB5FF','EdgeColor','none');
        % 
        % plot(([f f] - firstFrame)/framesPerHr,[0 .3],'k','LineWidth',8,'color','black');
        % 
        % text(POI_times(3)/2,.12,'G1','HorizontalAlignment','center','FontSize',64,'FontWeight','bold','Color','white','FontAngle','italic');
        % text((POI_times(5)+POI_times(3))/2,.12,'S','HorizontalAlignment','center','FontSize',64,'FontWeight','bold','Color','white','FontAngle','italic');
        % text((POI_times(6)+POI_times(5))/2,.12,'G2','HorizontalAlignment','center','FontSize',64,'FontWeight','bold','Color','white','FontAngle','italic');
        % 
        % 
        % set(gca ,'Layer', 'Top','FontSize',32,'color','white','XColor','black','Ycolor','black')
        % h = gca;
        % h.YAxis.Visible = 'off';
        
        %% WRITE BOX FRAME
        if save_box
            graphfig = getframe(f2);
            writeVideo(Mbox,graphfig);            
        end
    %%      %%  %%  %% Plot channel traces %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       figure(f3)
%         clf
% 
%         hold on
% 
%         subplot(3,1,1,'color','white'), 
% 
%                         plot(realtimecdk(2,1:i),realtimecdk(1,1:i),'color',[.2 0 .8],'LineWidth',2)
%         ylabel('CDK reporter')
%         xlim([0 end_time])
%         ylim([0 2])
%          ytickformat('%.1f')
%          set(gca ,'Layer', 'Top','FontSize',32,'color','white','XColor','black','Ycolor','black')
% 
% 
%         subplot(3,1,2,'color','white'), 
% 
%          plot(realtimeapc(2,1:i),realtimeapc(1,1:i),'color',[.9 .6 .1],'LineWidth',2)
%         xlim([0 end_time])
%         ylabel('APC reporter')
%         ylim([0 1])
%                     set(gca ,'Layer', 'Top','FontSize',32,'color','white','XColor','black','Ycolor','black')
% 
%         subplot(3,1,3,'color','white'), 
% plot(realtimecrl(2,1:i),realtimecrl(1,1:i),'color','#FF157E','LineWidth',2)
%         ylabel('CRL4 reporter')
%         xlim([0 end_time])
%         ylim([0 1])
%                     set(gca ,'Layer', 'Top','FontSize',32,'color','white','XColor','black','Ycolor','black')

        
      
      % h = gca;
        % h.YAxis.Visible = 'off'        
         %% WRITE VIDEO FRAME trace
        if save_trace
            graphfig = getframe(f3);
            writeVideo(Mtrace,graphfig);            
        end
%         if i~=numel(frames)
%             clf(f1)
%         end
        drawnow()
    end
    hold off;
    %% WRITE VIDEO FRAME
    if save_movie
        figure(f1)
        graphfig=getframe(f1);
        writeVideo(M,graphfig);
        close(M)
    end
%     close(gcf);

   %% WRITE BOX  FRAME
    if save_box
        figure(f2)
        graphfig=getframe(f2);
        writeVideo(Mbox,graphfig);
        close(Mbox)
    end
%     close(gcf);
%% %%  %% WRITE VIDEO FRAME trace
    if save_movie
        figure(f3)
        graphfig=getframe(f3);
        writeVideo(Mtrace,graphfig);
        close(Mtrace)
    end

    
%     close(gcf);
end