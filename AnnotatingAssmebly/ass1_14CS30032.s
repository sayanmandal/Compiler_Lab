	.file	"ass1_14CS30032.c"                  	# Source file name is ass1_14CS30032.c
	.section	.rodata				# This indicates that is a read-only data section
	.align 8					# Align with 8 byte boundary
.LC0:							#Label Of f-string 1st printf
	.string	"Enter how many elements you want:" 	
.LC1:							#Label Of f-string scanf
	.string	"%d"					
.LC2:							#Label Of f-string 2nd printf
	.string	"Enter the %d elements:\n"
.LC3:							#Label Of f-string 3rd printf
	.string	"\nEnter the item to search"
.LC4:							#Label Of f-string 4th printf
	.string	"\n%d found in position: %d\n"
.LC5:							#Label Of f-string 5th printf
	.string	"\n%d inserted in position: %d\n"
.LC6:							#Label Of f-string 6th printf
	.string	"The list of %d elements:\n"
.LC7:							#Label Of f-string 7th printf
	.string	"%6d"
	.text						#Code Starts
	.globl	main					#main is a global name
	.type	main, @function				#main is a function
main:							#main:starts
.LFB0:							#stands for function beginning
	.cfi_startproc					#Call Frame Information
	pushq	%rbp					#save old base pointer
	.cfi_def_cfa_offset 16				#cfi_directives are used for creation of .eh_frame to unwind stack frames for debugging
	.cfi_offset 6, -16				#and exception handling
	movq	%rsp, %rbp				#rbp <--- rsp set new stack base pointer
	.cfi_def_cfa_register 6
	subq	$432, %rsp				#create space for array and local variables
	movq	%fs:40, %rax				#fs is file segment register and 40 is offset..
	movq	%rax, -8(%rbp)				#these three instructions check for stack(sets the return address)
	xorl	%eax, %eax				#boundary violation
	movl	$.LC0, %edi				#edi<----starting of the format string,1st parameter
	call	puts					#call puts for print
	leaq	-432(%rbp), %rax			#rax <--- (rbp-432)(&n)[stands for load effective address]
	movq	%rax, %rsi				#rsi <--- rax(&n,2nd parameter)
	movl	$.LC1, %edi				#edi <--- starting of the format string, 1st parameter
	movl	$0, %eax				#eax <--- 0
	call	__isoc99_scanf				#calls scanf,return value is in eax
	movl	-432(%rbp), %eax			#eax <--- (rbp-432)[n]
	movl	%eax, %esi				#esi <--- eax(n,2nd parameter)
	movl	$.LC2, %edi				#edi <--- starting of the format string,1st parameter
	movl	$0, %eax				#eax <--- 0
	call	printf					#call printf
	movl	$0, -424(%rbp)				#M[rbp-424] <--- 0 ; i <--- 0
	jmp	.L2					#jump to L2
.L3:
	leaq	-416(%rbp), %rax			#[Load effective address] rax <--- (rbp-416) (&a[0])		
	movl	-424(%rbp), %edx			#edx <--- (rbp-424)[copy the value of i to edx]
	movslq	%edx, %rdx				#conversion from 32 bit to 64 bit(sign extended)
	salq	$2, %rdx				#shift operation;2 bit left shift ; 4*i 
	addq	%rdx, %rax				#rax <--- rax+rdx; a+4*i = &a[i]
	movq	%rax, %rsi				#rsi <--- rax (&a[i],2nd parameter)
	movl	$.LC1, %edi				#edi <--- starting of the format string , 1st parameter
	movl	$0, %eax				#eax <--- 0
	call	__isoc99_scanf				#calls scanf, return value in eax
	addl	$1, -424(%rbp)				#add 1 with i => i=i+1
.L2:
	movl	-432(%rbp), %eax			#eax <--- n ; copy the value to eax
	cmpl	%eax, -424(%rbp)			#compare the value to the value of i
	jl	.L3					#jump to L3(if i < n)
	movl	-432(%rbp), %edx			#edx <--- (rbp-432)[copy the value of n to edx]	
	leaq	-416(%rbp), %rax			#[Load Effective Address] rax <--- (rbp-416)(&a[0])
	movl	%edx, %esi				#esi <--- edx (n,2nd parameter)
	movq	%rax, %rdi				#rdi <--- rax (a,1st parameter)
	call	inst_sort				#call inst_sort
	movl	$.LC3, %edi				#edi <--- starting address of the printf format string,1st parameter
	call	puts					#call puts for print
	leaq	-428(%rbp), %rax			#[Load Effective Address] rax <--- (rbp-428) (&item)
	movq	%rax, %rsi				#rsi <--- rax(&item,2nd parameter)
	movl	$.LC1, %edi				#starting address of the format string , 1st parameter
	movl	$0, %eax				#eax <--- 0
	call	__isoc99_scanf				#calls scanf, return value is in eax
	movl	-428(%rbp), %edx			#edx <--- (item,3rd parameter)
	movl	-432(%rbp), %ecx			#ecx <--- n
	leaq	-416(%rbp), %rax			#rax <--- (rbp-416)[Load Effective Address](a)
	movl	%ecx, %esi				#copy n to esi(n,2nd parameter)
	movq	%rax, %rdi				#rdi <--- rax(a,1st parameter)
	call	bsearch					#call bsearch,return value in eax
	movl	%eax, -420(%rbp)			#loc <--- eax
	movl	-420(%rbp), %eax			#eax <--- loc
	cltq						#rax <--- eax
	movl	-416(%rbp,%rax,4), %edx			#edx <--- (rbp-416+rax*4) (a[loc])
	movl	-428(%rbp), %eax			#eax <--- item
	cmpl	%eax, %edx				#compare a[loc] and item
	jne	.L4					#jump to L4 if not equal
	movl	-420(%rbp), %eax			#eax <---loc
	leal	1(%rax), %edx				#edx <--- loc+1,3rd parameter
	movl	-428(%rbp), %eax			#eax <--- item
	movl	%eax, %esi				#esi <--- item,2nd parameter
	movl	$.LC4, %edi				#edi <--- starting address of format string,1st parameter
	movl	$0, %eax				#0 <--- eax
	call	printf					#call printf
	jmp	.L5					#jump to L5
.L4:
	movl	-428(%rbp), %edx			#edx <--- item
	movl	-432(%rbp), %ecx			#ecx <--- n
	leaq	-416(%rbp), %rax			#rax <--- (rbp-416)(a)
	movl	%ecx, %esi				#esi <--- n,2nd parameter
	movq	%rax, %rdi				#rdi <--- item,3rd parameter
	call	insert					#call insert
	movl	%eax, -420(%rbp)			#loc <--- eax[return value]
	movl	-432(%rbp), %eax			#eax <--- n
	addl	$1, %eax				#val(eax) <--- val(eax)+1
	movl	%eax, -432(%rbp)			#n <--- n+1	
	movl	-420(%rbp), %eax			#eax <--- loc
	leal	1(%rax), %edx				#edx <--- loc+1,3rd parameter
	movl	-428(%rbp), %eax			#eax <--- item
	movl	%eax, %esi				#esi <--- item,2nd parameter
	movl	$.LC5, %edi				#edi <--- starting address of the format string,1st parameter
	movl	$0, %eax				#eax <--- 0
	call	printf					#call printf
.L5:
	movl	-432(%rbp), %eax			#eax <--- n
	movl	%eax, %esi				#esi <--- n,2nd parameter
	movl	$.LC6, %edi				#edi <--- starting address of the format string , 1st parameter
	movl	$0, %eax				#0 <--- eax(return value)
	call	printf					#call printf
	movl	$0, -424(%rbp)				#i <--- 0
	jmp	.L6					#jump to L6
.L7:
	movl	-424(%rbp), %eax			#eax <--- i
	cltq						#convert from 32 bit to 64 bit
	movl	-416(%rbp,%rax,4), %eax			#eax <--- M[rbp-416+rax*4](a[i])
	movl	%eax, %esi				#esi <--- a[i],2nd parameter
	movl	$.LC7, %edi				#edi <--- starting address of the format string , 1st parameter
	movl	$0, %eax				#eax <--- 0
	call	printf					#call printf
	addl	$1, -424(%rbp)				#i <--- i+1
.L6:
	movl	-432(%rbp), %eax			#eax <--- n
	cmpl	%eax, -424(%rbp)			#compare i with n
	jl	.L7					#jump to L7 if i < n
	movl	$10, %edi				#edi <--- 10(ascii code for '\n')
	call	putchar					#call putchar(print newline)
	movl	$0, %eax				#eax <--- 0 [return value]
	movq	-8(%rbp), %rcx				#rcx = canary				
	xorq	%fs:40, %rcx				#check if equal to the original value
	je	.L9					#if equal go to L9
	call	__stack_chk_fail			#if not equal no return
.L9:
	leave						#remove stack frame
	.cfi_def_cfa 7, 8       			#Call frame information				
	ret						#return
	.cfi_endproc					#end procedure
.LFE0:							#stands for function ending
	.size	main, .-main				#This directive is generated by compilers to include auxiliary debugging information
	.globl	inst_sort				#makes visible to linker
	.type	inst_sort, @function			#it is a function
inst_sort:						#inst_sort starts
.LFB1:
	.cfi_startproc					#Call frame Information(start procedure)
	pushq	%rbp					#save old base pointer
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp				#rbp <--- rsp
	.cfi_def_cfa_register 6				
	movq	%rdi, -24(%rbp)				#(rbp-24) <--- (num,1st parameter)
	movl	%esi, -28(%rbp)				#(rbp-28) <--- (n,2nd parameter)
	movl	$1, -8(%rbp)				#j <--- 1
	jmp	.L11					#jump to L11
.L15:
	movl	-8(%rbp), %eax				#eax <--- j
	cltq						#conversion of 32 bit into 64 bit
	leaq	0(,%rax,4), %rdx			#rdx <--- rax*4 (address of j)
	movq	-24(%rbp), %rax				#rax <--- M[rbp-24](&num[0])
	addq	%rdx, %rax				#rax <--- rax + rdx (num+j)
	movl	(%rax), %eax				#eax <--- *(num+j){num[j]}
	movl	%eax, -4(%rbp)				#k <--- num[j]
	movl	-8(%rbp), %eax				#eax <--- j 
	subl	$1, %eax				#val(eax) <--- val(eax)-1
	movl	%eax, -12(%rbp)				#i <--- j-1
	jmp	.L12					#jump to L12
.L14:
	movl	-12(%rbp), %eax				#eax <--- i
	cltq						#conversion of 32 bit into 64 bit
	addq	$1, %rax				#i <--- i+1
	leaq	0(,%rax,4), %rdx			#rdx <--- rax*4
	movq	-24(%rbp), %rax				#rax <--- rbp-24 [&num[0]]
	addq	%rax, %rdx				#rdx <-- rax + rdx [num[i+1]]
	movl	-12(%rbp), %eax				#eax <--- i
	cltq						#conversion of 32 bit into 64 bit
	leaq	0(,%rax,4), %rcx			#rcx <--- rax*4
	movq	-24(%rbp), %rax				#rax <--- rbp-24 [&num[0]]
	addq	%rcx, %rax				#rax <--- rax + rcx
	movl	(%rax), %eax				#eax <--- num[i]
	movl	%eax, (%rdx)				#num[i+1] <--- num[i]
	subl	$1, -12(%rbp)				#i <--- i - 1
.L12:
	cmpl	$0, -12(%rbp)				#compare i with 0
	js	.L13					#jump to L13 if sign flag is set[if(!(i>=0))
	movl	-12(%rbp), %eax				#eax <--- i
	cltq						#conversion of 32 bit into 64 bits
	leaq	0(,%rax,4), %rdx			#rdx <--- rax*4
	movq	-24(%rbp), %rax				#rax <--- (rbp-24)[&num[0]]
	addq	%rdx, %rax				#rax <--- rax + rdx [&(num+i)]
	movl	(%rax), %eax				#eax <--- *(num+i)
	cmpl	-4(%rbp), %eax				#compare k with num[i](num[i] > k)
	jg	.L14					#jump to L14 if greater(i >= 0 && num[i] > k)
.L13:
	movl	-12(%rbp), %eax				#eax <--- i
	cltq						#conversion of 32 bit to 64 bit
	addq	$1, %rax				#rax <--- rax+1
	leaq	0(,%rax,4), %rdx			#rdx <--- rax*4;
	movq	-24(%rbp), %rax				#rax <--- (rbp-24)(&num[0])
	addq	%rax, %rdx				#rdx <--- rax + rdx (num+i+1)
	movl	-4(%rbp), %eax				#eax <--- k 
	movl	%eax, (%rdx)				#*(num+i+1) <--- k
	addl	$1, -8(%rbp)				# j <--- j + 1
.L11:
	movl	-8(%rbp), %eax				#eax <--- j
	cmpl	-28(%rbp), %eax				#compare j with n
	jl	.L15					#jump to L15 if j < n
	popq	%rbp					#pop rbp,break stack frame
	.cfi_def_cfa 7, 8
	ret						#return
	.cfi_endproc
.LFE1:							#stands for function ending
	.size	inst_sort, .-inst_sort			#generated by compiler to include auxiliary debugging information
	.globl	bsearch					#visible to linker
	.type	bsearch, @function			#bsearch is a function
bsearch:						#bsearch:starts
.LFB2:							#stands for function beginning
	.cfi_startproc				
	pushq	%rbp					#save old base pointer
	.cfi_def_cfa_offset 16				
	.cfi_offset 6, -16			
	movq	%rsp, %rbp				#rbp <--- rsp 
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)				#rdi <--- (rbp-24) (&a[0]),1st parameter
	movl	%esi, -28(%rbp)				#esi <--- n , 2nd parameter
	movl	%edx, -32(%rbp)				#edx <--- item , 3rd parameter
	movl	$1, -8(%rbp)				#bottom <--- 1
	movl	-28(%rbp), %eax				#eax <--- n
	movl	%eax, -12(%rbp)				#top <--- n
.L20:							#start of the do_while loop
	movl	-8(%rbp), %edx				#edx <--- bottom
	movl	-12(%rbp), %eax				#eax <--- top
	addl	%edx, %eax				#eax <--- top+bottom
	movl	%eax, %edx				#edx <--- eax
	shrl	$31, %edx				#edx <--- high bit of (top+bottom) ,0 if top+bottom >= 0 , 1 if top+bottom <0
	addl	%edx, %eax				#eax <--- eax+edx
	sarl	%eax					#eax <--- (top+bottom)/2
	movl	%eax, -4(%rbp)				#mid <--- (top+bottom)/2
	movl	-4(%rbp), %eax				#eax <--- mid
	cltq						#conversion of 32 bit to 64 bit
	leaq	0(,%rax,4), %rdx			#rdx <--- rax*4
	movq	-24(%rbp), %rax				#rax <--- (rbp-24)[&a[0]]
	addq	%rdx, %rax				#rax <--- rax+rdx [&a[mid]]
	movl	(%rax), %eax				#eax <--- a[mid]
	cmpl	-32(%rbp), %eax				#compare a[mid] with item
	jle	.L17					#jump to L17 if a[mid] <= item
	movl	-4(%rbp), %eax				#eax <--- mid
	subl	$1, %eax				#eax <--- mid-1
	movl	%eax, -12(%rbp)				#top <--- mid-1
	jmp	.L18					#jump to L18
.L17:
	movl	-4(%rbp), %eax				#eax <--- mid
	cltq						#conversion of 32 bit into 64 bit
	leaq	0(,%rax,4), %rdx			#rdx <--- rax*4
	movq	-24(%rbp), %rax				#rax <--- (rbp-24) (&a[0])
	addq	%rdx, %rax				#rax <--- rax+rdx (&a[mid])
	movl	(%rax), %eax				#eax <--- a[mid]
	cmpl	-32(%rbp), %eax				#compare a[mid] with item
	jge	.L18					#jump to L18 if a[mid] >= item
	movl	-4(%rbp), %eax				#eax <--- mid
	addl	$1, %eax				#eax <--- mid+1
	movl	%eax, -8(%rbp)				#bottom <--- mid+1
.L18:
	movl	-4(%rbp), %eax				#eax <--- mid
	cltq						#conversion of 32 bit to 64 bit
	leaq	0(,%rax,4), %rdx			#rdx <--- rax * 4
	movq	-24(%rbp), %rax				#rax <--- (rbp-24) (&a[0])
	addq	%rdx, %rax				#rax <--- rax+rdx (&a[mid])
	movl	(%rax), %eax				#eax <--- a[mid]
	cmpl	-32(%rbp), %eax				#compare item with a[mid]
	je	.L19					#jump to L19 if item == a[mid]
	movl	-8(%rbp), %eax				#eax <--- bottom
	cmpl	-12(%rbp), %eax				#compare bottom <= top
	jle	.L20					#jump to L20 if (a[mid] != item && bottom <= top)
.L19:
	movl	-4(%rbp), %eax				#eax <--- mid[return value]
	popq	%rbp					#pop rbp
	.cfi_def_cfa 7, 8
	ret						#return[break stack frame]
	.cfi_endproc						
.LFE2:							#function ending
	.size	bsearch, .-bsearch			
	.globl	insert					#visible to linker
	.type	insert, @function			#insert is a function
insert:			
.LFB3:							#function beginning
	.cfi_startproc	
	pushq	%rbp					#save old base pointer
	.cfi_def_cfa_offset 16				
	.cfi_offset 6, -16	
	movq	%rsp, %rbp				#rbp <--- rsp
	.cfi_def_cfa_register 6			  
	movq	%rdi, -24(%rbp)				#(rbp-24) <--- rdi[&num[0],1st parameter]
	movl	%esi, -28(%rbp)				#(rbp-28) <--- esi [n,2nd parameter]
	movl	%edx, -32(%rbp)				#(rbp-32) <--- edx[k,3rd parameter]
	movl	-28(%rbp), %eax				#eax <--- n
	movl	%eax, -4(%rbp)				#i <--- n
	jmp	.L23					#jump to L23
.L25:
	movl	-4(%rbp), %eax				#eax <--- i
	cltq						#conversion of 32 bit to 64 bit
	addq	$1, %rax				#eax <--- i+1
	leaq	0(,%rax,4), %rdx			#rdx <--- rax*4[load effective address]
	movq	-24(%rbp), %rax				#rax <--- (rbp-24)[&num[0]]
	addq	%rax, %rdx				#rdx <--- rdx + rax [&num[i+1]]
	movl	-4(%rbp), %eax				#eax <--- i
	cltq						#conversion of 32 bit to 64 bit
	leaq	0(,%rax,4), %rcx			#rcx <--- rax*4[load effective address]
	movq	-24(%rbp), %rax				#rax <--- (rbp-24)[&num[0]]
	addq	%rcx, %rax				#rax <--- rax+rcx (&num[i])
	movl	(%rax), %eax				#eax <--- num[i]
	movl	%eax, (%rdx)				#num[i+1] <--- num[i]
	subl	$1, -4(%rbp)				#i <--- i - 1
.L23:		
	cmpl	$0, -4(%rbp)				#compare i with 0
	js	.L24					#jump to L24 if (!(i >= 0))
	movl	-4(%rbp), %eax				#eax <--- i
	cltq						#conversion from 32 bit to 64 bit
	leaq	0(,%rax,4), %rdx			#rdx <--- rax*4[load effective address]
	movq	-24(%rbp), %rax				#rax <--- (rbp-24) [&num[0]]
	addq	%rdx, %rax				#rax <--- rax+rdx
	movl	(%rax), %eax				#eax <--- num[i]
	cmpl	-32(%rbp), %eax				#compare k with num[i]
	jg	.L25					#jump to L25 if num[i] > k
.L24:
	movl	-4(%rbp), %eax				#eax <--- i
	cltq						#conversion of 32 bit to 64 bit
	addq	$1, %rax				#rax <--- rax + 1
	leaq	0(,%rax,4), %rdx			#rdx <--- rax*4 [Load effective address]
	movq	-24(%rbp), %rax				#rax <--- (rbp-24)(&num[0])
	addq	%rax, %rdx				#rdx <--- rax + rdx(&num[i+1])
	movl	-32(%rbp), %eax				#eax <--- k
	movl	%eax, (%rdx)				#num[i+1] <--- k
	movl	-4(%rbp), %eax				#eax <--- i
	addl	$1, %eax				#eax <--- i+1
	popq	%rbp					#pop rbp
	.cfi_def_cfa 7, 8
	ret						#return
	.cfi_endproc
.LFE3:							#function ending
	.size	insert, .-insert			
	.ident	"GCC: (Ubuntu 4.9.3-13ubuntu2) 4.9.3"
	.section	.note.GNU-stack,"",@progbits
