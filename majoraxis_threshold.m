function [thresholded_im] = majoraxis_threshold(thresholded_im)
    CC = bwconncomp(thresholded_im);
    stats = regionprops(CC, 'MajorAxisLength'); 

    nbins = round((max([stats.MajorAxisLength]) - min([stats.MajorAxisLength]))/5);
    figure;
    hist = histogram([stats.MajorAxisLength],nbins);
    
    [maxi, maxi_index] = max([hist.Values]);

    idx = find(([stats.MajorAxisLength] < hist.BinEdges(maxi_index)/2)...
        | ([stats.MajorAxisLength] > 2*hist.BinEdges(maxi_index)));
    len_idx = length(idx);

    for i=1:len_idx 
        thresholded_im(CC.PixelIdxList{idx(i)}) = 0;
    end
    %figure,imshow(thresholded_im);
end