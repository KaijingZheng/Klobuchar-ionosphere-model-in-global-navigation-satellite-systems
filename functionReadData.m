
function data = functionReadData(fileName)
    %2 hour time incremments
    lines = readlines(fileName);
    
    exp = -1;
    startIndex = 1;
    for n = 1:height(lines)
        currRow = strtrim(lines(n));

        if (currRow.contains("LAT1 / LAT2 / DLAT", "IgnoreCase", true))
            str = split(currRow);
            startLatitude = abs(str2double(str(1)));
            diffLat = abs(str2double(str(3)));
        end

        if (currRow.contains("LON1 / LON2 / DLON", "IgnoreCase", true))
            str = split(currRow);
            startLongitude = abs(str2double(str(1)));
            diffLong = abs(str2double(str(3)));
        end

        if (currRow.contains("EXPONENT", "IgnoreCase", true))
            str = split(currRow);
            exp = str2double(str(1));
        end

        if (currRow.contains("START OF TEC MAP", "IgnoreCase", true) && currRow.contains("1", "IgnoreCase", true))
            startIndex = n+2;
            break;
        end

    end

    mult = 1;
    exp = exp*10;
    if exp < 0
        mult = mult/abs(exp);
    else
        mult = mult*exp;
    end


    numRows = ((startLatitude/diffLat)*2) + 1.0;
    numCols = ((startLongitude/diffLong)*2) + 1.0;
    numTimes = 12;

    %rows - latitudes; cols - longitudes
    %TEC in same col - same latitude

    data = zeros(numRows, numCols, numTimes);

    r = 0;
    c = 1;
    t = 1;

    for n = startIndex:height(lines)
        currRow = strtrim(lines(n));
    
        if currRow.contains("START OF RMS MAP", "IgnoreCase", true) || currRow.contains("END OF FILE", "IgnoreCase", true)
            break;
        end

        if currRow.contains("EPOCH OF CURRENT MAP", "IgnoreCase", true)
            continue;
        end

        if currRow.contains("START OF TEC MAP", "IgnoreCase", true)
            continue;
        end


        if currRow.contains("END OF TEC MAP", "IgnoreCase", true) 
            t = t + 1;
            r = 0;
            c = 1;
            continue;
        end

        if currRow.contains("LAT/LON1/LON2/DLON/H", "IgnoreCase", true) 
            r = r + 1;
            c = 1;
            continue;
        end

        str = split(currRow);
    
        for l = 1:length(str)
            num = str2double(str(l));
            data(r, c, t) = num*mult;
            c = c+1;
        end
    end
end