function b = readBetaParam(fileName)
    lines = readlines(fileName);
    
    found = 0;
    for n = 1:length(lines)
        currRow = strtrim(lines(n));

        if currRow.contains("ION BETA", "IgnoreCase", true)
            row = split(currRow);
            b = [str2num(row(1)) str2num(row(2)) str2num(row(3)) str2num(row(4))];
            found = 1;
            break;
        end
    end

    if found == 0
        disp("File does not work");
        exit();
    end
end