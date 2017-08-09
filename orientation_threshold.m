function [thresholded_im] = orientation_threshold(thresholded_im)
    CC = bwconncomp(thresholded_im);
    stats = regionprops(CC, 'Orientation'); 

    nbins = round((max([stats.Orientation]) - min([stats.Orientation]))/5);
    figure;
    hist = histogram([stats.Orientation],nbins);

    [maxi, maxi_index] = max([hist.Values]);

    idx = find(([stats.Orientation] > hist.BinEdges(maxi_index+1)));
    len_idx = length(idx);

    for i=1:len_idx 
        thresholded_im(CC.PixelIdxList{idx(i)}) = 0;
    end
end