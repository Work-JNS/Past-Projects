/*
 * Jared Singh, G01416039
 * CS 262, Lab Section 201
 *
 *
 * Lab2: BSA calculator
 *
 * NOTICE: COMPILE WITH -lm arg
 *
 */


#include <stdio.h>
#include <math.h>


int main(){
	
	
	float weight = 0, height = 0, surfArea;
	char in[8];

	
	printf("Enter your height(cm): ");
	
	//takes in 8 chars from terminal
	fgets(in, 8, stdin);
	//scans the input for a float
	sscanf(in, "%f", &height);
	
	printf("Enter your weight(kgs): ");
	
	fgets(in, 8, stdin);
	sscanf(in, "%f", &weight);
	
	//calculate surface area
	surfArea = 0.007184 * pow(weight, 0.425) * pow(height, 0.725);
	
	//print results to console
	printf("Height of %0.1fcm\nWeight of %0.1fkgs\nBSA: %0.4fm2\n", height, weight, surfArea);
	
	
	
	
}

