function [thresholded_im] = eccentricity_threshold(thresholded_im)
    CC = bwconncomp(thresholded_im);
    stats = regionprops(CC, 'Area','Eccentricity'); 
    idx = find([stats.Eccentricity] < 0.95);

    len_idx = length(idx);

    for i=1:len_idx
        thresholded_im(CC.PixelIdxList{idx(i)}) = 0;
    end
    %figure,imshow(thresholded_im);
end
