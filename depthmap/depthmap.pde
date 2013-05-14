int[] depthValues;
Line[] compareLines;
Line[] totalLines;
int[] MaxMin = new int[2];
import peasy.*;
PeasyCam cam;



void setup(){
	size(640, 640, P3D);

	//Setup
	cam = new PeasyCam(this, 100);
	cam.setMinimumDistance(1);
	cam.setMaximumDistance(5000);

	PVector [] start = loadPoints("startPoints.txt");
	PVector [] end = loadPoints("endPoints.txt");
	println("number of Lines: " + start.length);

	PVector[] mapStart = mappedPoints(start);
	PVector[] mapEnd = mappedPoints(end);


	// compareLines = new Line[4];
	compareLines = new Line[start.length];
	for (int i = 0; i<start.length; i++){
		compareLines[i] = new Line(mapStart[i], mapEnd[i]);
	}
	
	// compareLines[0] = new Line(new PVector(0, 0), new PVector(10, 10));
	// compareLines[1] = new Line(new PVector(10, 10), new PVector(20, 10));
	// compareLines[2] = new Line(new PVector(10, 10), new PVector(30, 30));
	// compareLines[3] = new Line(new PVector(30, 30), new PVector(45, 35));
	// compareLines[4] = new Line(new PVector(30, 28), new PVector(00, 2));

	int a = millis();
	println(millis());
	depthValues = runOnce(compareLines, compareLines);

	for (int i = 0; i<depthValues.length; i++){
		// println(depthValues[i]);
	}

	println("Max: " + max(depthValues));
	println("Min: " + min(depthValues));
	println(millis()-a);

	// for (int o : depthValues){
	// 	println(o);
	// }
}


void draw(){

	background(100, 0, 0);
	for (int i = 0; i<compareLines.length; i++){
				
		stroke(map(depthValues[i], min(depthValues), max(depthValues), 255, 0));
		compareLines[i].draw();
		}		
}



PVector[] loadPoints(String path) {

	String[] points = loadStrings(path);
	PVector[] a = new PVector[points.length];
	int[] x = new int[points.length];
	int[] y = new int[points.length];
	for (int i=0; i<points.length; i++) {

		String[] coordinates = split(points[i], ',');
		x[i] = int(coordinates[0]);
		y[i] = int(coordinates[1]);
		a[i] = new PVector(int(coordinates[0]), int(coordinates[1]));
	}
	println(path+" min(x): "+min(x));	
	println(path+" max(x): "+max(x));
	println(path+" min(y): "+min(y));	
	println(path+" max(y): "+max(y));
	return a;
}

PVector[] mappedPoints(PVector[] a) {

	// startPoints.txt min(x): 545053
	// startPoints.txt max(x): 551210
	// startPoints.txt min(y): 181161
	// startPoints.txt max(y): 183894
	// endPoints.txt min(x): 545223
	// endPoints.txt max(x): 551343
	// endPoints.txt min(y): 181272
	// endPoints.txt max(y): 183833

	PVector[] b = new PVector[a.length];
	float x;
	float y;
	for (int i = 0; i<a.length; i++){
		x = map(a[i].x, 545053, 551343, 0, width);
		y = map(a[i].y, 181161, 183894, 0, height) *181161/551343;

		b[i] = new PVector(x, y);
	}
	return b;

}

// void getMinMax(){
//   for(int i=0;i<xs.size();i++){
//     if(xs.get(i)<minX && xs.get(i)>5000f) minX=xs.get(i);
//     if(xs.get(i)>maxX) maxX=xs.get(i);
//     if(ys.get(i)<minY) minY=ys.get(i);
//     if(ys.get(i)>maxY) maxY=ys.get(i);
//   }
// }

// void scaleShape(){
//   float sr = getSR();
  
//   for(int i=0;i<xs.size();i++){
//     float f = xs.get(i);
//     f=(f-minX)*sr;
//     xs.set(i,f);
//   }
// for(int i=0;i<ys.size();i++){
//     float f = ys.get(i);
//     f=(f-minY)*sr;
//     ys.set(i,f);
//   }
  
// }

// void drawShape(){
//   for (int i=0;i<edgeN1.size();i++){
//     float x1 = xs.get(edgeN1.get(i));
//     float y1 = ys.get(edgeN1.get(i));
//     float x2 = xs.get(edgeN2.get(i));
//     float y2 = ys.get(edgeN2.get(i));
//     line(x1,y1,x2,y2);
//   }
// }