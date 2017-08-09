function [J] = rotate_barcode(img)
    %clear;
    %img = 'UPCA.png';
    barcode = imread(img);
    %barcode = img;
    
    [x,y, channels] = size(barcode);
    
    if channels == 3
        barcode = rgb2gray(barcode);
    else
        if islogical(barcode)
            barcode = double(barcode);
        else
            barcode = barcode./max(max(barcode));
        end
    end
    barcode = imadjust(barcode);
    %barcode = medfilt2(barcode);

    level = graythresh(barcode);

    barz = imbinarize(barcode,'adaptive','ForegroundPolarity',...
        'dark','Sensitivity',level);
    %figure,imshow(barz);
    barz = double(barz);
    
    bar_edge = edge(barz,'canny');  

    [H, theta, rho] = hough(bar_edge);

    peak = houghpeaks(H);

    bar_angle = theta(peak(2));
    if (abs(bar_angle) == 90)
        bar_angle = 0;
    end

    J = imrotate(barz,bar_angle,'bilinear','crop');
    
    figure,imshow(J);
    %figure,imshow(barz,[]);
end