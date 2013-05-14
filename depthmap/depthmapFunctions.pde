int[] runOnce(Line[] compare, Line[] total) {

	int[] depthList = new int[compare.length];

	for (int i = 0; i<compare.length; i++){
		int d = calculateDepth(compare[i], total);
		depthList[i] = d;
	}
	return depthList;
}

int calculateDepth(Line a, Line[] lineList) {

	for (int i = 0; i<lineList.length; i++){
		lineList[i].attribute = 0;
	}

	int depth = 0;
	int d = 0;
	ArrayList<Line> Queue = new ArrayList<Line>();
	a.attribute = d;
	Queue.add(a);

	//Goes on untill the Queue is empty	
	while (Queue.size() > 0) {
		//Get first item, add their attribute to the depth
		//Also remove the first item of the Queue
		Line c = Queue.get(0);
		Queue.remove(0);  
		int val = c.attribute;
		depth+=val;

		//Get all the connected lines of the first item on the Queue 
		ArrayList<Line> connected = findIntersectingCurves(c, lineList);
		//Check them all, if the the first line on the Queue has not been checked

		for (int i = 0; i<connected.size(); i++){
			if (c.attribute == 0 ){
				//Increase by one and give it to the connected Lines
				d = val + 1;
				connected.get(i).attribute = d;
				Queue.add(Queue.size(), connected.get(i));
			}
		}
	}
	return depth;
}

ArrayList<Line> findIntersectingCurves(Line a, Line[] lineList){
	ArrayList<Line> intersected = new ArrayList<Line>();	
	int count=0;

	for (int i = 0; i<lineList.length; i++){
		Line b = lineList[i];
		boolean intersect = segInt(a.a, a.b, b.a, b.b);
		if (intersect){
			intersected.add(lineList[i]);
		}
	}

	int depth = 0;
	return intersected;

} 

//Calculates if there is an Intersection
boolean segInt(PVector v1, PVector v2, PVector v3, PVector v4) {

	boolean a;
	float x1 = v1.x;
	float y1 = v1.y;

	float x2 = v2.x;
	float y2 = v2.y;


	float x3 = v3.x;
	float y3 = v3.y;

	float x4 = v4.x;
	float y4 = v4.y;

	float bx = x2 - x1;
	float by = y2 - y1;
	float dx = x4 - x3;
	float dy = y4 - y3;
	float b_dot_d_perp = bx * dy - by * dx;

	// int range = 1;
	// if 		( (x1 <= x3+range || x1 >= x3-range) &&  (y1 <= y3+range || y1 >= y3-range) ) {  //start to start
	// 	return a = true;
	// }	
	// else if ( (x2 <= x4+range || x2 >= x4-range) &&  (y2 <= y4+range || y2 >= y4-range) ) { //end to end
	// 	return a = true;		
	// }
	// else if ( (x2 <= x4+range || x2 >= x4-range) &&  (y1 <= y3+range || y1 >= y3-range) ) { //start to end
	// 	return a = true;		
	// }

	if (b_dot_d_perp == 0) {
		return  a = false;//null;
	}

	float cx = x3 - x1;
	float cy = y3 - y1;
	float t = (cx * dy - cy * dx) / b_dot_d_perp;

	if (t < 0 || t > 1) {
		return a = false;//null;
	}
	float u = (cx * by - cy * bx) / b_dot_d_perp;
	if (u < 0 || u > 1) {
		return a = false;//null;
	}


	return a = true;
}