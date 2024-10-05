
lat1 = 0;
long1 = 0;
lat2 = 30;
lat3 = 60;

data = functionReadData("igsg3350.19i");
date = string(functionGetDate("igsg3350.19i"));

IGSDelay1 = delayTableIGS(data, lat1, long1);
IGSDelay2 = delayTableIGS(data, lat2, long1);
IGSDelay3 = delayTableIGS(data, lat3, long1);

fileName = "brdc3350.19n";


kDelay1 = createKlobucharTable(fileName, lat1, long1);
kDelay2 = createKlobucharTable(fileName, lat2, long1);
kDelay3 = createKlobucharTable(fileName, lat3, long1);

kDelaybyTwo1 = createKlobucharTableByTwo(fileName, lat1, long1);
kDelaybyTwo2 = createKlobucharTableByTwo(fileName, lat2, long1);
kDelaybyTwo3 = createKlobucharTableByTwo(fileName, lat3, long1);


delayDiff1 = tblDiff(IGSDelay1, kDelaybyTwo1);
delayDiff2 = tblDiff(IGSDelay2, kDelaybyTwo2);
delayDiff3 = tblDiff(IGSDelay3, kDelaybyTwo3);

%%%%%%%%%%%%%%%%%%%
arr1 = table2array(delayDiff1);
sum1 = 0.0;
avg1 = 0.0;
for i = 1:13
    sum1 = sum1 + arr1(i, 2);
end
avg1 = sum1 / 13;

trueD1 = table2array(IGSDelay1);
accuracy1 = zeros(13, 1);
avgAcc1 = 0.0;
sumAcc1 = 0.0;
for i = 1:13
    accuracy1(i) = (arr1(i, 2)/trueD1(i, 2)) * 100;
    sumAcc1 = sumAcc1 + accuracy1(i);
end
avgAcc1 = sumAcc1/13;

%%%%%%%%%%%%%%%%%%%
arr2 = table2array(delayDiff1);
sum2 = 0.0;
avg2 = 0.0;
for i = 1:13
    sum2 = sum2 + arr2(i, 2);
end
avg2 = sum2 / 13;

trueD2 = table2array(IGSDelay2);
accuracy2 = zeros(13, 1);
avgAcc2 = 0.0;
sumAcc2 = 0.0;
for i = 1:13
    accuracy2(i) = (arr2(i, 2)/trueD2(i, 2)) * 100;
    sumAcc2 = sumAcc2 + accuracy2(i);
end
avgAcc2 = sumAcc2/13;


%%%%%%%%%%%%%%%%%%%
arr3 = table2array(delayDiff3);
sum3 = 0.0;
avg3 = 0.0;
for i = 1:13
    sum3 = sum3 + arr3(i, 2);
end
avg3 = sum3 / 13;

trueD3 = table2array(IGSDelay3);
accuracy3 = zeros(13, 1);
avgAcc3 = 0.0;
sumAcc3 = 0.0;
for i = 1:13
    accuracy3(i) = (arr3(i, 2)/trueD3(i, 2)) * 100;
    sumAcc3 = sumAcc3 + accuracy3(i);
end
avgAcc3 = sumAcc3/13;

%%%%%%%%%%%%%%%%%%%%
figure(1);
plot(IGSDelay1, "UTC", "IGSDelay", "LineWidth", 2.0, 'Color', [0, 0, 0]);
legend()
grid on;
ylabel('Ionospheric Delay (m)')
xlabel('UTC')
xlim([0, 24])
ylim([0, 5]);

hold on;

%plot(kDelay, "UTC", "klobucharDelay", "LineWidth", 2.0, "LineStyle", "--");
plot(kDelay1, "UTC", "klobucharDelay", "LineWidth", 2.0, "LineStyle", "--", 'Color', [0, 0, 1]);
legend('IGS GIM', 'Klobuchar')
grid on;
ylabel('Ionospheric Delay (m)')
xlabel('UTC')
xlim([0, 24])
ylim([0, 5]);
title(date + " / Latitude: " + lat1)


figure(2);
plot(IGSDelay2, "UTC", "IGSDelay", "LineWidth", 2.0, 'Color', [0, 0, 0]);
legend('IGS GIM', 'Klobuchar')
grid on;
ylabel('Ionospheric Delay (m)')
xlabel('UTC')
xlim([0, 24])
ylim([0, 5]);

hold on;

%plot(kDelay, "UTC", "klobucharDelay", "LineWidth", 2.0, "LineStyle", "--");
plot(kDelay2, "UTC", "klobucharDelay", "LineWidth", 2.0, "LineStyle", "--", 'Color', [0, 0, 1]);
legend('IGS GIM', 'Klobuchar')
grid on;
ylabel('Ionospheric Delay (m)')
xlabel('UTC')
xlim([0, 24])
ylim([0, 5]);
title(date + " / Latitude: " + lat2)


figure(3);
plot(IGSDelay3, "UTC", "IGSDelay", "LineWidth", 2.0, 'Color', [0, 0, 0]);
legend('IGS GIM', 'Klobuchar')
grid on;
ylabel('Ionospheric Delay (m)')
xlabel('UTC')
xlim([0, 24])
ylim([0, 5]);

hold on;

%plot(kDelay, "UTC", "klobucharDelay", "LineWidth", 2.0, "LineStyle", "--");
plot(kDelay3, "UTC", "klobucharDelay", "LineWidth", 2.0, "LineStyle", "--", 'Color', [0, 0, 1]);
legend('IGS GIM', 'Klobuchar')
grid on;
ylabel('Ionospheric Delay (m)')
xlabel('UTC')
xlim([0, 24])
ylim([0, 5]);
title(date + " / Latitude: " + lat3)


figure(4);
plot(delayDiff1, "UTC", "difference", "LineWidth", 2.0);
grid on;
ylabel('Ionospheric Delay (m)')
xlabel('UTC')
xlim([0, 24])
ylim([0, 5]);

hold on;

plot(delayDiff2, "UTC", "difference", "LineWidth", 2.0, 'LineStyle', ':');
grid on;
ylabel('Ionospheric Delay (m)')
xlabel('UTC')
xlim([0, 24])
ylim([0, 5]);

hold on;

plot(delayDiff3, "UTC", "difference", "LineWidth", 2.0, 'LineStyle', '--');
grid on;
ylabel('Ionospheric Delay (m)')
xlabel('UTC')
xlim([0, 24])
ylim([0, 5]);

legend('Latitude: 0', 'Latitude: 30', 'Latitude: 60');
title(date)

