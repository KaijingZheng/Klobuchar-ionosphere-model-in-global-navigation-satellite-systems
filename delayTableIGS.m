function tbl = delayTableIGS(data, lat, long)
    %table - TEC_lat_long
    
    s = size(data);
    numRows = s(1);
    numCols = s(2);
    numTimes = s(3);

    %find lat
    latIndex = 1;
    for i=87.5:-2.5:-87.5
        if abs(i-lat) < 1.25
            break;
        end
        latIndex = latIndex+1;
    end

    %find long
    longIndex = 1;
    for i=-180:5:180
        if abs(i-long) < 2.5
            break;
        end
        longIndex = longIndex+1;
    end

    %{
    TEC_0_0 = zeros(numTimes, 1);
    d_0_0 = zeros(numTimes, 1);
    latitude_0 = cast((numRows/2), "int8");
    longitude_0 = cast((numCols/2), "int8");

    TEC_45_0 = zeros(numTimes, 1);
    d_45_0 = zeros(numTimes, 1);
    latitude_45 = cast((numRows/4), "int8");

    TEC_675_0 = zeros(numTimes, 1);
    d_675_0 = zeros(numTimes, 1);
    latitude_675 = cast((numRows/8), "int8");
    %}

    TEC = zeros(numTimes, 1);
    IGSDelay = zeros(numTimes, 1);

    for n=1:numTimes
        TEC(n) = data(latIndex, longIndex, n);

        IGSDelay(n) = calculateDelayIGS(TEC(n));
    end

    UTC = [0; 2; 4; 6; 8; 10; 12; 14; 16; 18; 20; 22; 24];
    %UTC = [0; 1; 2; 3; 4; 5; 6; 7; 8; 9; 10; 11; 12; 13; 14; 15; 16; 17; 18; 19; 20; 21; 22; 23; 24];
    tbl = table(UTC, IGSDelay);
end