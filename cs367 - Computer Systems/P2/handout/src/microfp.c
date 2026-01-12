/* This is the only file you will be editing.
 * - Copyright of Starter Code: Prof. Kevin Andrea, George Mason University.  All Rights Reserved
 * - Copyright of Student Code: You!  
 * - Restrictions on Student Code: Do not post your code on any public site (eg. Github).
 * -- Feel free to post your code on a PRIVATE Github and give interviewers access to it.
 * -- You are liable for the protection of your code from others.
 * - ASCII Art Adapted from Regular Calculator by Jeremy J. Olson
 * -- Original File: https://www.asciiart.eu/electronics/calculators
 * - Date: Sep 2024
 */

/* CS367 Project 2, Fall Semester, 2024
 * Fill in your Name, GNumber, and Section Number in the following comment fields
 * Name: Jared Singh
 * GNumber: G-01416039
 * Section Number: CS367-00_             (Replace the _ with your section number)
 */

/* _____________________
  |  _________________  |
  | |     MUAN    3.25| |
  | |_________________| |
  |  ___ ___ ___   ___  |
  | | 7 | 8 | 9 | | + | |
  | |___|___|___| |___| |
  | | 4 | 5 | 6 | | - | |
  | |___|___|___| |___| |
  | | 1 | 2 | 3 | | x | |
  | |___|___|___| |___| |
  | | . | 0 | = | | V | |
  | |___|___|___| |___| |
  |_____________________|
 */

#include <stdio.h>
#include <stdlib.h>
#include "common_structs.h"
#include "common_definitions.h"
#include "common_functions.h"
#include "microfp.h"

// Feel free to add many Helper Functions, Consts, and Definitions!


//TODO: Denormalized encode & Decode

#define BIAS 3
#define INF 0xE0
#define NAN 0xFF
#define NEG 0x100
#define FRAC 0x1F


//encoding

// Return 1 if a normalized value
int isNorm(Number_s* num){
	
	// is normalized if whole > 0
	if(num->whole > 0)
		return 1;
	else{
		//calc E
		int E = 0;
		unsigned short frac = num->fraction;
		while(frac < 0x8000){
			frac = frac<<1;
			E++;
		}
		// E is a denorm val
		if(E >= 2)
			return 0;
		// E is normal
		return 1;
		
	}
}
// get the E of a Number_s*
int normE(Number_s* num){
	unsigned short whl = num->whole;
	int E = 0;
	//for small normalized vals(0.5, .25, etc)
	if(whl == 0){
		whl = num->fraction;
		while(whl < 0x8000){
			if(whl == 0)
				return -1;
			whl = whl<<1;
			E--;
		}
		return E-1;
	}
	// for vals with whole numbers
	while(whl != 1){
		whl = whl>>1;
		E++;
	}
	return E;
}

//format whole # to get 1.frac
unsigned short formatWhl(Number_s* num){
	unsigned short whl = num->whole;
	//move first bit of whole to msb
	for(int i=0; i<16; i++){
		if(whl<0x8000)
			whl =  whl<<1;
	}
	
	return whl;
}

// return fraction in denormal form
unsigned short getDenormFrac(unsigned short frac){
	return frac>>(8);
}


//decoding

//get the exp of a microfp_s
unsigned short getExp(microfp_s val){
	return (val&INF)>>5;
	
}


//get the frac of a microfp_s
unsigned short getM(microfp_s val){
	return val&FRAC;
	
}

//get the E of a microfp_s
int getE(microfp_s val){
	int E = 0;
	
	//denorm E
	if(val&INF == 0)
		E = -2;
	else{
		//norm E
		E = getExp(val) - BIAS;
	}
}



// ----------Public API Functions (write these!)-------------------
/* toMicroFP - Converts a Number Struct (whole and fraction parts) into a MicroFP Value
 *  - number is managed by MUAN, DO NOT FREE number.
 *    - You may change the contents of number, but do not free it.
 *  - Follow the project documentation for this function.
 * Return the MicroFP Value or any legal MicroFP NaN representation if number is NULL.
 */
microfp_s toMicroFP(Number_s *number) {
	//Special cases
	if(number == NULL || number->is_nan == 1)
		return NAN;
	microfp_s rv = 0;
	//formal infinity case
	if(number->is_infinity){
		rv = INF;
		if(number->is_negative)
			return rv|NEG;
		return rv;
	}
	// Zero case
	if(number->whole == 0 && number->fraction == 0){
		if(number->is_negative)
			return NEG;
		return 0;
	}
	unsigned short frac = number->fraction;
	//Normalized
	if(isNorm(number)){		
		int E = normE(number);
		//informal inf case
		unsigned short exp = E+BIAS;
		if((exp<<5) >= INF)
			rv = INF;
		else{
			//format frac for whole insert
			if(E<0)
				E--;
			else
				E++;
			//move frac to make space for whole
			frac = frac>>E;
			//get 1.frac
			if(number->whole != 0)
				rv = frac|formatWhl(number);
			else
				rv = frac|0x8000;
			//get frac
			rv = rv<<1;
			//get frac in correct position
			rv = rv>>11;
			//add exp in correct position
			rv = rv|(exp<<5);
		}
	}
	//Denormalized
	else{
		frac = frac<<(BIAS-1);
		frac = frac>>11;
		rv = frac;
		
	}
	
	//Negative Case
	if(number->is_negative == 1)
		rv = negMicroFP(rv);
	return rv;
	
		
	
}

/* toNumber - Converts a MicroFP Value into a Number Struct (whole and fraction parts)
 *  - number is managed by MUAN, DO NOT FREE or re-Allocate number.
 *    - It is already allocated.  Do not call malloc/calloc for number.
 *  - Follow the project documentation for this function.
 *  If the conversion is successful, return 0. 
 *  - If number is NULL, return -1.
 */
int toNumber(Number_s *number, microfp_s value) {
	if(number == NULL)
		return -1;
	//format Number
	number->is_infinity = 0;
	number->is_negative = 0;
	number->is_nan = 0;
	number->whole = 0;
	number->fraction = 0;
	

	//Spec Case
	if(value == NAN){
		number->is_nan = 1;
		return 0;
	}
	
	//INF & NEGINF case
	if(value >= INF){
		number->is_infinity = 1;
		if(value&NEG != 0){
			number->is_negative = 1;
		}
		return 0;
	}
	
	
	unsigned short exp = getExp(value);
	int E = 0;
	
	//Normalized case
	if(exp > 0){
		E = exp - BIAS;
		unsigned short M = ((value&FRAC)|0x20);
		// for most normalized vals
		if(E>0)
			M = M<<E;
		//for near denorm cases
		else
			M = M>>abs(E);
		
		number->whole = M>>5;
		number->fraction = M<<11;
	}
	//Denormalized Case
	else{
		number->whole = 0;
		unsigned short frac = value&FRAC;
		frac = frac<<11;
		frac = frac>>BIAS-1;
		number->fraction = frac;
	}
	if(value >= NEG){
		number->is_negative = 1;
	}
	
	return 0;
	
	
	
}

/* mulMicroFP - Performs an operation on two MicroFP values
 *  - Follow the project documentation for this function.
 * Return the resulting microfp_s value
 */
microfp_s mulMicroFP(microfp_s val1, microfp_s val2) {
	microfp_s rv = 0; 
	// a Val is NAN
	if(val1 == NAN || val2 == NAN)
		return NAN;
	
	// a Val is INF
	if( (val1 >= INF) || (val2 >= INF) ){
		// 0 * infinity	
		if(val1 == 0 || val2 == 0){
			return NAN;
		}
		rv = INF;
		if(val1&NEG != 0 || val2&NEG != 0)
			return negMicroFP(rv);
		return rv;
	}
	
	// 0 * X
	if(val1 == 0 || val2 == 0)
		return 0;
	// 1*X
	if(val1 == 0x60)
		return val2;
	if(val2 == 0x60)
		return val1;
	
	// get E
	int E = getE(val1) + getE(val2);
	// mult M
	unsigned short M = getM(val1) * getM(val2);
	
	//format M
	while(M>0x3F){
		M = M>>1;
		E++;
	}
	M = M&FRAC;
	
	//get EXP
	unsigned short exp = (E + BIAS)<<5;
	//check overflow
	if(exp == INF)
		rv = INF;
	else
		rv = exp|M;
	
	//negative handling
	if(val1&NEG != 0){
		//both negative
		if(val2&NEG != 0)
			return rv;
		//val1 is neg
		return negMicroFP(rv);
	}
	//val 2 is neg
	if(val2&NEG != 0)
		return negMicroFP(rv);
	
	//none NEG
	return rv;
	
}

/* addMicroFP - Performs an operation on two MicroFP values
 *  - Follow the project documentation for this function.
 * Return the resulting microfp_s value
 */
microfp_s addMicroFP(microfp_s val1, microfp_s val2) {
	microfp_s rv = 0;
	if(val1 == NAN || val2 == NAN)
		return NAN;
	if(val1&NEG != 0){
		//only val 1 neg
		if(val2&NEG == 0)
			return subMicroFP(val2, val1);
	}//only val2 neg
	else if(val2&NEG != 0)
		return subMicroFP(val1, val2);
	
	
	Number_s* v1 = (Number_s*)malloc(sizeof(Number_s));
	toNumber(v1, val1);
	Number_s* v2 = (Number_s*)malloc(sizeof(Number_s));
	toNumber(v2, val2);
	v1->whole += v2->whole;
	v1->fraction +=v2->fraction;
	
	
	rv = toMicroFP(v1);
	free(v1);
	free(v2);
	
	return rv;
		
	
}

/* opMicroFP - Performs an operation on two MicroFP values
 *  - Follow the project documentation for this function.
 * Return the resulting microfp_s value
 */
microfp_s subMicroFP(microfp_s val1, microfp_s val2) {
	microfp_s rv = 0;
	if(val1 == NAN || val2 == NAN)
		return NAN;
	
	
	
	Number_s* v1 = (Number_s*)malloc(sizeof(Number_s));
	toNumber(v1, val1);
	Number_s* v2 = (Number_s*)malloc(sizeof(Number_s));
	toNumber(v2, val2);
	v1->whole = abs(v1->whole - v2->whole);
	v1->fraction = abs(v1->fraction - v2->fraction);
	if(v2->whole > v1->whole){
		v1->is_negative = 1;
	}else if(v2->fraction > v1->fraction)
		v1->is_negative = 1;
	
	rv = toMicroFP(v1);
	free(v1);
	free(v2);
	
	return rv;
}

/* negMicroFP - Negates a MicroFP Value.
 *  - Follow the project documentation for this function.
 * Return the resulting MicroFP Value
 */
microfp_s negMicroFP(microfp_s value) {
  return value | NEG;
}
