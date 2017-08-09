function [encoded_barcode] = encode_barcode(barcode)
    [row, col] = size(barcode);
    for i=1:col
        black_count = sum(barcode(:,i) == 0);
        white_count = sum(barcode(:,i) == 1);
        if black_count > white_count
            barcode(:,i) = 0;
        else
            barcode(:,i) = 1;
        end
    end
    figure,imshow(barcode);
    
    startx = 1;
    for i=1:col
        if barcode(1,i) == 1
            startx = startx + 1;
        else
            break;
        end
    end
    
    endx = col;
    for i=col:-1:1
        if barcode(1,i) == 1
            endx = endx - 1;
        else
            break;
        end
    end
    
    meanx = (endx-startx+1)/95;
    
    cnt_black = 0;
    cnt_white = 0;
    cnt = 0;
    for i=startx:endx
        if barcode(1,i) == 0
            cnt_black = cnt_black + 1;
            if cnt_white ~= 0
                c = round(cnt_white/meanx);
                for j=1:c
                    encoded_barcode(cnt+j) = 0;
                end
                cnt_white = 0;
                cnt = cnt + c;
            end
        elseif barcode(1,i) == 1
            cnt_white = cnt_white + 1;
            if cnt_black ~= 0
                c = round(cnt_black/meanx);
                for j=1:c
                    encoded_barcode(cnt+j) = 1;
                end
                cnt_black = 0;
                cnt = cnt + c;
            end
        end
    end
    if cnt_black ~= 0
        c = round(cnt_black/meanx);
        for j=1:c
            encoded_barcode(cnt+j) = 1;
        end
        cnt_black = 0;
        cnt = cnt + c;
    end
    if cnt_white ~= 0
        c = round(cnt_white/meanx);
        for j=1:c
            encoded_barcode(cnt+j) = 0;
        end
        cnt_white = 0;
        cnt = cnt + c;
    end
end