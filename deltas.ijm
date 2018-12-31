// This macro batch measures a folder of images.
// Use the Analyze>Set Measurements command
// to specify the measurement parameters.
// outputs to results table the specified measurements including 
// the area of the bulbil (column heading = 'area', the percent red extent of tetrazolium treated bulbils (column heading = 'perc_area'),
// and the delta red values (column heading = 'mean')

// place this file in the imageJ plugins->Analyze folder

    dir = getDirectory("Choose a Directory ");
    list = getFileList(dir);
    setOption("display labels", true);
    setBatchMode(true);
    for (i=0; i<list.length; i++) {
        path = dir+list[i];
        max = dir+"MAX_"+list[i];	
        showProgress(i, list.length);
        IJ.redirectErrorMessages();
        open(path);
        open(path);	
        if (nImages>=1) {
	run("RGB Stack");
    setAutoThreshold("Mean dark");
	//run("Threshold...");
	run("Convert to Mask", "method=Mean dark");
	run("Z Project...", "projection=[Max Intensity]");
	run("Create Selection");
	run("Make Inverse");
	run("Clear Outside");
	sel = getTitle();
	selectWindow(list[i]);
	run("Split Channels");
	selectWindow(list[i]+" (red)");
	red = getTitle();
	selectWindow(list[i]+" (blue)");
	blue = getTitle();
	selectWindow(list[i]+" (green)");
	green = getTitle();
	imageCalculator("Subtract create", red, blue);
	rb = getTitle();
	imageCalculator("Subtract create", red, green);
	rg = getTitle();
	imageCalculator("Average create", rb, rg);
	avg = getTitle();
	run("Select None");
	selectWindow(sel);
	selectWindow(avg);
	run("Restore Selection");
	run("Measure");
	close();
        } else
            print("Error opening "+path);
    }
