// Clean up before we start
run("Close All");
run("Clear Results");
roiManager("reset");

// Select and open your image
image = File.openDialog("Where are your images?");
open(image);
rename("img");
path = File.getDirectory(image);
name= File.getNameWithoutExtension(image);
savename = path + name;
// Preprocessing for the evaluation
run("RGB Color");
selectWindow("img");
close();
selectWindow("img (RGB)");
run("Colour Deconvolution", "vectors=H&E hide");
selectWindow("img (RGB)");
close();
selectWindow("img (RGB)-(Colour_3)");
close();
selectWindow("img (RGB)-(Colour_2)");
close();
selectWindow("img (RGB)-(Colour_1)");
rename(name);
run("Subtract Background...", "rolling=5 light");
run("Gaussian Blur...", "sigma=1");


// Drawing of your Regions of Interest
waitForUser("Time to do some stuff", "1) Distribute ROIs across your tissue section \n2) Add each one to the Manager by pressing t \nKlick ok when done");
roiManager("show all with labels");

// Cell counting
a = roiManager("count");

for (i = 0; i < a; i++) {
	roiManager("Select", i);
	run("Find Maxima...", "prominence=10 light output=Count");
}

// Saving & Good-bye :-)
run("Flatten");
saveAs("tiff", savename + "_with_ROIs.tif");
roiManager("save", savename + ".zip");
saveAs("Results", savename + ".csv");

run("Close All");
