a.out: 	Mylmain.o libass2_14CS30032.a
	gcc Mylmain.o libass2_14CS30032.a 

Mylmain.o: Mylmain.c myl.h
	gcc -Wall -c Mylmain.c

libass2_14CS30032.a: ass2_14CS30032.o
	ar -rcs libass2_14CS30032.a ass2_14CS30032.o

ass2_14CS30032.o: ass2_14CS30032.c myl.h
	gcc -Wall -c ass2_14CS30032.c 

clean:
	rm a.out Mylmain.o libass2_14CS30032.a ass2_14CS30032.o