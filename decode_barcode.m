function [] = decode_barcode(encoded_barcode)
    digitL = [0 0 0 1 1 0 1;
              0 0 1 1 0 0 1;
              0 0 1 0 0 1 1;
              0 1 1 1 1 0 1;
              0 1 0 0 0 1 1;
              0 1 1 0 0 0 1;
              0 1 0 1 1 1 1;
              0 1 1 1 0 1 1;
              0 1 1 0 1 1 1;
              0 0 0 1 0 1 1;
            ];

    digitR = ones(10,7) - digitL;

    start = [1 0 1]; %start and end is same
    middle = [0 1 0 1 0];

    [row,col] = size(encoded_barcode);

    i=1;
    while i <= col
        flag_num = 0;
        for j=1:1:10
            if i <= col-6 && ...
                    isequal(encoded_barcode(1,i:i+6),digitL(j,:))
                disp(j-1);
                i = i + 7;
                flag_num = 1;
            elseif i <= col-6 &&...
                    isequal(encoded_barcode(1,i:i+6),digitR(j,:))
                disp(j-1);
                i = i + 7;
                flag_num = 1;
            end
        end
        if i <= col-4 &&...
                flag_num == 0 && isequal(encoded_barcode(1,i:i+4),middle)
            disp('middle');
            i = i + 5;
            flag_num = 1;
        elseif i == 1 &&...
                flag_num == 0 && isequal(encoded_barcode(1,i:i+2),start)
            disp('start');
            flag_num = 1;
            i = i + 3;
        elseif i == col-2 &&...
                flag_num == 0 && isequal(encoded_barcode(1,i:i+2),start)
            disp('end');
            break;
            flag_num = 1;
            i = i + 3;
        end
        if flag_num == 0
            disp('Digit not found');
            break;
        end
    end
end