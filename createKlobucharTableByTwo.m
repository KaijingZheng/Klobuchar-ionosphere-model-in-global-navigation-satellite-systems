function tbl = createKlobucharTableByTwo(fileName, lat, long)

    alpha = readAlphaParam(fileName);
    beta = readBetaParam(fileName);

    % Time (UTC)
    year = 2019;
    month = 12;
    day = 1;

    MIN = 0;
    sec = 0;  
    elev = 90;                        % Elevation (deg)
    azimuth = 0;                      % Azimuth   (deg)
    fi = lat;                         % Latitude
    lambda = long;                    % Longitude (deg)

    UTC = [0; 2; 4; 6; 8; 10; 12; 14; 16; 18; 20; 22; 24];

    klobucharDelay = zeros(8 ,1);
    index = 1;
    for t=0:2:24
        hour = t;

        % Compute Time-of-Week in seconds (UTC)
        [week,tow] = cal2gpstime(year,month,day,hour,MIN,sec);

        % Ionospheric L1 corr.
        dIon = klobuchar(fi,lambda,elev,azimuth,tow,alpha,beta);
        klobucharDelay(index) = dIon;

        index = index+1;
    end

    tbl = table(UTC, klobucharDelay);

    %{
    delay45 = zeros(8 ,1);
    index = 1;
    fi = 38.803;
    for t=0:3:24
        hour = t;

        % Compute Time-of-Week in seconds (UTC)
        [week,tow] = cal2gpstime(year,month,day,hour,MIN,sec);

        % Ionospheric L1 corr.
        dIon = klobuchar(fi,lambda,elev,azimuth,tow,alpha,beta);
        delay45(index) = dIon;

        index = index+1;
    end

    delay675 = zeros(8 ,1);
    index = 1;
    fi = 67.5;
    for t=0:3:24
        hour = t;

        % Compute Time-of-Week in seconds (UTC)
        [week,tow] = cal2gpstime(year,month,day,hour,MIN,sec);

        % Ionospheric L1 corr.
        dIon = klobuchar(fi,lambda,elev,azimuth,tow,alpha,beta);
        delay675(index) = dIon;

        index = index+1;
    end

    %}
end