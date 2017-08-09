function [] = adaptive_thresholding(img)
    %img = 'segmentation.png';
    im = imread(img);

    [x,y, channels] = size(im);

    if channels == 3
        im = rgb2gray(im);
    else
        if islogical(im)
            im = double(im);
        else
            im = im./max(max(im));
        end
    end

    im = imadjust(im);

    level = graythresh(im);

    thresholded_im = imbinarize(im,'adaptive','ForegroundPolarity',...
            'dark','Sensitivity',level);

    %thresholded_im = thresholdLocally(im);
    figure,imshow(thresholded_im);
    thresholded_im = imcomplement(thresholded_im);


    thresholded_im = eccentricity_threshold(thresholded_im);
    thresholded_im = majoraxis_threshold(thresholded_im);
    thresholded_im = orientation_threshold(thresholded_im);

    %figure,imshow(BW);
    [row,col] = size(thresholded_im);
    for i=1:row
        if(sum(thresholded_im(i,:)) ~= 0)
            break;
        end
    end

    for j=1:col
        if(sum(thresholded_im(:,j)) ~= 0)
            break;
        end
    end

    thresholded_im = imcomplement(thresholded_im);
    figure,imshow(thresholded_im);
    thresholded_im = im(i:row,j:col);

    imwrite(thresholded_im, 'extracted.png');
    figure,imshow(thresholded_im);

end
