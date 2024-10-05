function tbl = tblDiff(tbl1, tbl2)
    UTC  = [0; 2; 4; 6; 8; 10; 12; 14; 16; 18; 20; 22; 24];

    difference = zeros(13, 1);
    delay1 = tbl1.(2);
    delay2 = tbl2.(2);

    for i=1:length(delay1)
        d1 = delay1(i);
        d2 = delay2(i);

        difference(i) = abs(d1 - d2);
    end

    tbl = table(UTC, difference);
end