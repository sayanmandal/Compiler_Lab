#define BUFF 20
#define MAXSIZE 100001

int id;



int printi(int n)
{
	char buff[BUFF], zero='0';
	int i = 0, j, k, bytes;
	if(n == 0)
		buff[i++] = zero;
	else {
		if(n < 0) {
 			buff[i++] = '-';
			n = -n;
		}
		while(n) {
			int dig = n%10;
			buff[i++] = (char)(zero+dig);
			n /= 10;
		}
		if(buff[0] == '-')
			j = 1;	
		else
			j = 0;
		k=i-1;
		while( j<k ) {
			char temp = buff[j];
			buff[j++] = buff[k];
			buff[k--] = temp;
		}
	}

	bytes = i;
	__asm__ __volatile__ (
		"movl $1, %%eax \n\t"
		"movq $1, %%rdi \n\t"
		"syscall \n\t"
		:
		:"S"(buff), "d"(bytes)
	) ; // $4: write, $1: on stdin

	return bytes;
}


int prints(char* str){
	char buff[MAXSIZE];
	int i = 0,bytes;
	while(str[i] != '\0'){
		buff[i] = str[i];
		i++;
	}
	bytes = i;
	__asm__ __volatile__ (
		"movl $1, %%eax \n\t"
		"movq $1, %%rdi \n\t"
		"syscall \n\t"
		:
		:"S"(buff), "d"(bytes)
	) ; //$1 : write (%eax), $1 : stdout(%rdi)

	return bytes;
}


//If it is Error Then the Integer Value Is 0

int readi(int* ep){
	int LEN = 1;
	int num = 0;
	int status = 0;
	int i;
	int sign = 1;
	char lastchar;
	char c;
	*ep = 0;
	while(1){
		__asm__ __volatile__ (
		"movl $0, %%eax \n\t"
		"movq $0, %%rdi \n\t"
		"syscall \n\t"
		:
		:"S"(&c), "d"(LEN)
	) ;  //$0 : read (%eax), $0 : stdin(%rdi)
	if(status == 0){
		if((int)c == 32 || (int)c == 9 || c == '\n')
			continue;
		if(c == '+' || c == '-' || (c >= '0' && c <= '9')){
			lastchar = c;
			status = 1;
			if(c == '-')
				sign = -1;
			else if(c >= '0' && c <= '9')
				num = 10*num+((int)(c-'0'));
		}else{
			*ep = 1;
			return 0;
		}
	}else{
		if((int)c == 32 || (int)c == 9 || c == '\n'){
			if(lastchar == '+' || lastchar == '-' ){
				*ep = 1;
				return 0;
			}else
				break;
		}
		lastchar = c;
		if(c >= '0' && c <= '9')
			num = num*10+(int)(c-'0');
		else{
			*ep = 1;
			return 0;
		}
	}
	}
	num = num*sign;
	return num;
}


//If It is Error then the float value is 0.000000

//Just Ignoring the initial whitespaces (space and tab only) ans start reading when i am getting the first character except space and tab and newline
//and after decimal point reading upto 6 digits only and ignoring after that
//in the midway of reading if a space appears, then breaking the method
//e.g.
//1nput: 1.23  output:1.23
//same goes for integer

int readf(float *fp){
	int LEN = 1;
	int num = 0;
	int status = 0;
	int pointstatus = 0;
	int i;
	int sign = 1;
	char lastchar;
	float fraction = 1;
	*fp = 0.000000;
	char c;
	int count = 0;
	while(1){
		__asm__ __volatile__ (
		"movl $0, %%eax \n\t"
		"movq $0, %%rdi \n\t"
		"syscall \n\t"
		:
		:"S"(&c), "d"(LEN)
	) ;  //$0 : read (%eax), $0 : stdin(%rdi)
	if(status == 0){
		if((int)c == 32 || (int)c == 9 || c == '\n')
			continue;
		if(c == '+' || c == '-' || c == '.' || (c >= '0' && c <= '9')){
			status = 1;
			lastchar = c;
			if(c == '-')
				sign = -1;
			if(c == '.')
				pointstatus = 1;
			if(c >= '0' && c <= '9')
				num = num*10+(int)(c-'0');
		}else{
			*fp = 0;
			return 1;
		}
		continue;
	}
	if(status == 1){
		if((int)c == 32 || (int)c == 9 || c == '\n'){
			if(lastchar == '+' || lastchar == '-' || lastchar == '.'){
				*fp = 0.000000;
				return 1;
			}
			break;
		}
		if(pointstatus == 0){
			lastchar = c;
			if(c >= '0' && c <= '9')
				num = num*10 + (int)(c-'0');
			else if(c == '.'){
				pointstatus = 1;
				continue;
			}
			else{
				*fp = 0.000000;
				return 1;
			}
		}
		if(pointstatus == 1){
			lastchar = c;
			count++;
			if(count > 6)
				break;
			if(c >= '0' && c <= '9'){
				fraction = 0.1 * fraction;
				*fp = (*fp)+(fraction * ((int)(c-'0')));
			}else{
				*fp = 0;
				return 1;
			}
		}
	}
	}
	*fp = num + (*fp);
	if(sign == -1)
		*fp = -(*fp);
	return 0;
	}



int printd(float fp){
	int SIZE = 30;
	float tmp;
	char buff[SIZE], zero='0';
	int i = 0, j, k, bytes;
	if(fp == 0.0){
		buff[i++] = zero;
		buff[i++] = '.';
		int count;
		for(count = 0;count < 6 ; count++)
			buff[i++] = zero;
	}
	else {
		if(fp < 0) {
 			buff[i++] = '-';
			fp = -fp;
		}
		tmp = fp - (int)fp;
		//printf("Inside Printd: %f",temp);
		int n = fp;
		while(n) {
			int dig = n%10;
			buff[i++] = (char)(zero+dig);
			n /= 10;
		}
		if(buff[0] == '-')
			j = 1;	
		else
			j = 0;
		k=i-1;
		while( j<k ) {
			char temp = buff[j];
			buff[j++] = buff[k];
			buff[k--] = temp;
		}
		if(tmp == 0.0){
			buff[i++] = '.';
			int count;
			for(count = 0;count < 6 ; count++)
				buff[i++] = zero;
		}else{
		buff[i++] = '.';
		int c ;
		float t;
		int rem;
		//printf("%f",tmp);
		//printf("%d",numpy);
		int numpy = (tmp*1000000);
		for(c = 0 ; c < 6 ; c++){
			rem = numpy%10;
			numpy /= 10;
			buff[i++] = (char)(zero+rem);
			}
		j = i-6;
		k = i-1;
		while( j<k ) {
			char temp = buff[j];
			buff[j++] = buff[k];
			buff[k--] = temp;
		}	
		}
	}
	bytes = i;
	__asm__ __volatile__ (
		"movl $1, %%eax \n\t"
		"movq $1, %%rdi \n\t"
		"syscall \n\t"
		:
		:"S"(buff), "d"(bytes)
	) ; // $4: write, $1: on stdin

	return bytes;
	}

