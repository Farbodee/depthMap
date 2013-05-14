class Line {

	PVector a, b;
	int attribute = 0;

	Line (PVector a, PVector b) {
		this.a = a;
		this.b = b;
	}

	void draw() {
		line(a.x, a.y, b.x, b.y);
	}
}
