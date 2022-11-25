# 209194141 Ynon Hendin
	.data
id:     .quad   209194141   
printTrue:   .string "True\n"
printFalse:  .string "False\n"

	.section	.rodata			#read only data section
format1: .string "%ld\n"
	########
	.text	#the beginnig of the code
.globl	main	#the label "main" is used to state the initial point of this program
	.type	main, @function	# the label "main" representing the beginning of a function

printId:    
        movq    $id, %rax       #move id number address to %rax
        movq    (%rax), %rsi    #move id number value to %rsi
        movq    $format1, %rdi  #move format to printf
        call    printf
        ret
#============================

checkDec_2:
            movq    $id, %rcx   #move id number address to %rcx
            xor     %rax, %rax    #clear %rax
            movb    1(%rcx), %al    #move dec_2 into %al
            test    $1, %al     #if lsb of %al is 0, then dec_2 is even and set ZF. else dec_2 is odd
            movq    (%rcx), %rax    #move id number value to %rax for div and mul operations ahead
            je      even        #if ZF (dec_2 is even) go to even
            
            imul    $3, %rax    #multiplying id number by 3
            movq    %rax, %rsi  #move product to %rsi for printing
            movq    $format1, %rdi  
            call    printf
            ret
            
even:       
            xor     %rdx, %rdx      #clear %rdx
            movq    $3, %rcx  #set divisor to %rcx
            div     %rcx     #divide %rax by %rcx
            movq    %rdx, %rsi     #move division remainder stored in %rdi to %rsi for printing
            movq    $format1, %rdi
            call    printf
            ret
#============================

part3:
            movq    $id, %rax       #move id number address to %rax
            xor     %rcx, %rcx      #clear %rcx
            movb    2(%rax), %cl    #move 3rd byte of id number to %cl
            xor     (%rax), %cl     #xor between first and third byte of id number
            movq    $127, %rax      #move value 127 to %rax
            cmp     %cl, %al        #check if %cl is greater than 127. if greater cmp will set SF
            js      true            #if dec_3 > 127 jump to true
            
            movq    $printFalse, %rdi #print False
            call    printf
            ret
            
true:
            movq    $printTrue,%rdi #print True
            call    printf
            ret
#============================

countBits:
            movq    $id, %rax
            xor     %rcx, %rcx
            movb    3(%rax), %cl    #move 4th byte of id number to %cl
            xor     %rdx, %rdx      #clearing %rdx. will be where we store our counted bits
            xor     %rax, %rax
addLsb:     
            cmp     $0, %cl        #check if %cl == 0. is zero, set ZF and jump to finish, meaning there are no more ones in %cl. else continue
            je      finish
            
            movq    $1, %rax       #set %rax to be 1
            and     %cl, %al       #all bits of %al are zero except for the lsb. if lsb of %cl is 1 then and will set %al to 1. else %al will be 0
            add     %rax, %rdx     #adds the outcome of line above to bit count
            shr     $1, %cl        #logical right shift of %cl, in order to get the next bit to be the lsb and check it next iteration
            jmp     addLsb         #jump to top of function to count next bit
finish:
            movq    %rdx, %rsi
            movq    $format1, %rdi
            call    printf
            ret  
#============================
        
main:
    movq %rsp, %rbp #for correct debugging	# the main function:
	pushq	%rbp		#save the old frame pointer
	movq	%rsp, %rbp	#create the new frame pointer
	pushq	%rbx		#saving a callee save register.
        
        call   printId
        call   checkDec_2
        call   part3
        call   countBits
                
	#return from printf 2nd time - end of program:
	movq	$0, %rax	#return value is zero.
	movq	-8(%rbp), %rbx	#restoring the save register (%rbx) value, for the caller function.
	movq	%rbp, %rsp	#restore the old stack pointer - release all used memory.
	popq	%rbp		#restore old frame pointer (the caller function frame)
	ret			#return to caller function (OS).

