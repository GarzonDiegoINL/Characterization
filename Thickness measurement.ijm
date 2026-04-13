while(true){
nROI = roiManager("count");
if (nROI < 2){

waitForUser("Waiting for user to draw the top border line...");
roiManager("Add");
roiManager("show all with labels");

waitForUser("Waiting for user to draw the bottom border line...");
roiManager("Add");
roiManager("show all with labels");}

roiManager("Select", 0);
run("Interpolate", "interval=1 adjust");
Roi.getCoordinates(x1, y1);

roiManager("Select", 1);
run("Interpolate", "interval=1 adjust");
Roi.getCoordinates(x2, y2);

getPixelSize(unit, pw, ph, pd);

// Guard against unscaled images
if (pw == 0) {
    pw = 1;
    unit = "px";
}

delta = newArray();

//Get minimum x to start subtracting
if (x1[0] < x2[0]){
    min_x = x2[0];}
else {
    min_x = x1[0];}

// Find start index for top line (with bounds guard)
x_test = 1;
idx1 = 0;
while(x_test > 0.5 && idx1 < x1.length - 1){
    x_test = min_x - x1[idx1];
    idx1 = idx1 + 1;
}
idx1 = maxOf(0, idx1 - 1);

// Find start index for bottom line (fixed tolerance: was 0.05, now 0.5; with bounds guard)
x_test = 1;
idx2 = 0;
while(x_test > 0.5 && idx2 < x2.length - 1){
    x_test = min_x - x2[idx2];
    idx2 = idx2 + 1;
}
idx2 = maxOf(0, idx2 - 1);

// Slice all four arrays using their OWN lengths (fixed: x1 was incorrectly sliced using y1.length)
y1 = Array.slice(y1, idx1, y1.length);
y2 = Array.slice(y2, idx2, y2.length);
x1 = Array.slice(x1, idx1, x1.length);
x2 = Array.slice(x2, idx2, x2.length);

// Trim to equal length
min_length = minOf(x1.length, x2.length);
y1 = Array.slice(y1, 0, min_length);
y2 = Array.slice(y2, 0, min_length);
x1 = Array.slice(x1, 0, min_length);
x2 = Array.slice(x2, 0, min_length);

// Compute vertical thickness in calibrated units (removed abs(x2[i]-x1[i])<2 filter that caused most values to be NaN)
delta = newArray(min_length);
for (i = 0; i < min_length; i++) {
    delta[i] = abs(y2[i] - y1[i]) * pw;
}

// Add new table
Table.create("Data pixels");
Table.setColumn("x_top", x1);
Table.setColumn("y_top", y1);
Table.setColumn("x_bttm", x2);
Table.setColumn("y_bttm", y2);
Table.setColumn("thickness (" + unit + ")", delta);

Array.getStatistics(delta, min, max, mean, stdDev);
str = "thickness= " + mean + " " + unit + " std = " + stdDev + " " + unit + " RSD = " + stdDev/mean * 100 + " %.";
print(str);

waitForUser("Do you want to measure more layers in this micrograph?");
roiManager("deselect");
roiManager("delete");
}