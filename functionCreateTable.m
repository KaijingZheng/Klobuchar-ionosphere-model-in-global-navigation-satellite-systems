

function tbl = functionCreateTable(data)
    %table - TEC_lat_long
    
    s = size(data);
    numRows = s(1);
    numCols = s(2);
    numTimes = s(3);


    TEC_0_0 = zeros(numTimes, 1);
    latitude_0 = cast((numRows/2), "int8");
    longitude_0 = cast((numCols/2), "int8");

    TEC_45_0 = zeros(numTimes, 1);
    latitude_45 = cast((numRows/4), "int8");

    TEC_675_0 = zeros(numTimes, 1);
    latitude_675 = cast((numRows/8), "int8");


    for n=1:numTimes
        TEC_0_0(n) = data(latitude_0, longitude_0, n);
        TEC_45_0(n) = data(latitude_45, longitude_0, n);
        TEC_675_0(n) = data(latitude_675, longitude_0, n);
    end

    UTC = [0; 2; 4; 6; 8; 10; 12; 14; 16; 18; 20; 22; 24];
    tbl = table(UTC, TEC_0_0, TEC_45_0, TEC_675_0);

end