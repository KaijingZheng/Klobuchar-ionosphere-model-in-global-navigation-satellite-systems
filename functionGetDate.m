
function date = functionGetDate(fileName)
    lines = readlines(fileName);

    for n = 1:height(lines)
        currRow = strtrim(lines(n));

        if (currRow.contains("EPOCH OF FIRST MAP", "IgnoreCase", true))
            dateArr = split(currRow);
            break;
        end
    end

    yr = str2double(dateArr(1));
    mth = str2double(dateArr(2));
    day = str2double(dateArr(3));

    date = datetime([yr, mth, day]);
end