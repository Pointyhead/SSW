// This macro batch measures a folder of images.
// Use the Analyze>Set Measurements command
// to specify the measurement parameters.

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
        if (nImages>=1) {
	selectWindow(list[i]);
	run("RGB Stack");
    setAutoThreshold("Mean dark");
	//run("Threshold...");
	run("Convert to Mask", "method=Mean dark");
	run("Z Project...", "projection=[Max Intensity]");
	selectWindow("MAX_"+list[i]);
	run("Create Selection");
	run("Make Inverse");
	run("Save","MAX_"+list[i]+".tif");
	close();
        } else
            print("Error opening "+path);
    }


