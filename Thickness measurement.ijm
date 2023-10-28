while(true){
nROI = roiManager("count");
if (nROI <2){

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

scale = 1/pw;

delta = newArray();

//Get shorter array
if (y1.length < y2.length){

min_length = y1.length;}
else {
min_length = y2.length;}



//Get minimum x to start substracting
if (x1[0] < x2[0]){

min_x = x2[0];}
else {
min_x = x1[0];}

x_test = 1;
idx1 = 0;

while(x_test > 0.5){
x_test = min_x - x1[idx1] ;
idx1 = idx1 + 1;
}
idx1 = idx1 - 1;

x_test = 1;
idx2 = 0;

while(x_test > 0.05){
x_test =min_x - x2[idx2] ;
idx2 = idx2 + 1;
}
idx2 = idx2 - 1;

y1 = Array.slice(y1,idx1,y1.length);
y2 = Array.slice(y2,idx2,y2.length);
x1 = Array.slice(x1,idx1,y1.length);
x2 = Array.slice(x2,idx2,y2.length);

//Get shorter array
if (x1.length < x2.length){

min_length = x1.length;}
else {
min_length = x2.length;}

y1 = Array.slice(y1,0,min_length);
y2 = Array.slice(y2,0,min_length);

x1 = Array.slice(x1,0,min_length);
x2 = Array.slice(x2,0,min_length);

for (i=0; i<min_length; i++) {
if( abs(x2[i]-x1[i]) < 2){
distance = sqrt(pow(x2[i]-x1[i],2)+pow(y2[i]-y1[i],2))/scale;
delta = Array.concat(delta, distance);}
else{
delta = Array.concat(delta, NaN);
}}



// add new table
Table.create("Data pixels");
// set a whole column
Table.setColumn("x_top", x1);
Table.setColumn("y_top", y1);
Table.setColumn("x_bttm", x2);
Table.setColumn("y_bttm", y2);
Table.setColumn("y_top-y_bttm (" + unit + ")", delta);

final_delta = newArray();
for (i=0; i<delta.length; i++){
if (isNaN(delta[i]) != true){
final_delta = Array.concat(final_delta, delta[i]);}}


Array.getStatistics(final_delta, min, max, mean, stdDev);
str = "thickness= " + mean + " " + unit + " std = " + stdDev + " " + unit + " RSD = " + stdDev/mean * 100 + " %.";
print(str);


waitForUser("Do you want to measure more layers in this micrograph?");
roiManager("deselect");
roiManager("delete");
}




