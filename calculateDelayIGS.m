function delay = calculateDelayIGS(tec)
    delay = (40.3/(1575420000^2))*tec*(10^16);
end