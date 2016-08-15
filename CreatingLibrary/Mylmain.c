#include <stdio.h>

#include "myl.h"

void main(){
	int n,k,ep,n1,ep1,ef;
	float fp;
	prints("Enter Any Float :");
	ef= readf(&fp);
	printd(fp);
	//printf("\n The Float is : %f",fp);
	char *str = "My Name Is Sayan";
	prints("Enter one Integer :");
	n = readi(&ep);
	//n1 = readi(&ep1);
	if(ep == 0){
	prints("You Entered the Integer: ");
	k = printi(n);
	printf("\nNumber of Characters printed : %d\n",k);
	}else{
	prints("There is an error, You didn't enter an integer ");
	}
	/*if(ep1 == 0){
	prints("You Entered the Integer: ");
	k = printi(n1);
	printf("\nNumber of Characters printed : %d\n",k);
	}else{
	prints("There is an error, You didn't enter an integer ");
	}*/
	k = prints(str);
	printf("\nNumber of Characters printed in the string : %d\n",k);
	}
