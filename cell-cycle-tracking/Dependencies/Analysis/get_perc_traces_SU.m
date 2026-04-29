function [frames, perctraces] = get_perc_traces_SU( traces, POI, thresh, greater)

    numcells=size(traces,1);
    numframes=size(traces,2);
    alignmat=NaN*ones(numcells,numframes*2);
    

    total=zeros(1,2*numframes);


    for j=1:numcells
        if ~isnan(POI(j)) %if POI(j), which is the frame of POI, is not NA
            alignmat(j,(numframes-POI(j)+1):(2*numframes-POI(j)))=traces(j,:); %matrix value for each cell j is (117-frame of POI):(2*117 - frame of POI) is align_time = data.POI(:,POI_align)
        end

 
    end

    if greater
       % perctraces = sum(alignmat > thresh, 1)./sum(~isnan(alignmat), 1);

          total(1) = sum(~isnan(alignmat(:,1)), 1);


    for i = 2:length(alignmat(1,:))
    total(i) = total(i-1) + sum(alignmat(:,i) > thresh);

     perctraces(i) = total(1,i)./(numcells(1,:));
    end 

    else
        perctraces = sum(alignmat < thresh, 1)./sum(~isnan(alignmat), 1);
    end


  


    nanmedian(alignmat,1);
    %semtrace=nanstd(alignmat,1);%./(2*sqrt(sum(~isnan(alignmat),1)));
    frames=-numframes:numframes-1;

    
end

