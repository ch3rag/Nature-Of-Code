// CHIRAG SINGH RAJPUT
// Github.com/IamBharatSingh
// Fractal Tree

import java.util.Comparator;
import java.util.Collections;

ArrayList <Line> lines = new ArrayList <Line> ();
ArrayList <Line> currentLevel;

float log2(float num) {
	return log(num)/log(2);
}

float angle = PI/6;
int startFrame;
int numFrames = 45;
color trunk = color(128, 64, 64);
color leaves = color(51, 179, 80);
int i = 0;
int p = 0;

void setup() {

	size(640, 480);
	background(255);
	branch(width/2, height, 100,0);
	Collections.sort(lines, compareLines);

}
void draw() {

	if(currentLevel == null || frameCount % numFrames == 0) {
		int k;
		currentLevel = new ArrayList <Line> ();
		for(k = i; k < i + pow(2,p); k++) {
			currentLevel.add(lines.get(k));
		}
		startFrame = frameCount;
		i = k;
		p++;
	}
	stroke(lerpColor(trunk, leaves, map(p,0,log2(lines.size()),0,1)));

	for(Line l : currentLevel) {
		l.animateLine(startFrame, numFrames - 1);
	}

	if(i == lines.size()) noLoop();
	
}

Comparator <Line> compareLines = new Comparator <Line> () {
	int compare(Line l1, Line l2) {
		float d1 = PVector.dist(l1.start, l1.end);
		float d2 = PVector.dist(l2.start, l2.end);
		return int(d2 - d1);
 }};

void branch(float x, float y, float length, float angle_) {

	if(length < 5) {
		return;
	}
	float xl = x + length * cos(-angle_ - PI/2); 
	float yl = y + length * sin(-angle_ - PI/2);
	lines.add(new Line(x, y, xl, yl, (int)dist(x,y,xl,yl)/10));
	branch(xl, yl, length * 0.8, angle_ + angle + random(-0.3, 0.3));
	branch(xl, yl, length * 0.8, angle_ - angle + random(-0.3, 0.3));

}
