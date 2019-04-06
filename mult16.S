		;		ARM Programming Assignment #1: 16 bit multiplier
		;
		;		Write a 16-bit multiplier, meaning numbers that have their high 16 bits set to 0.
		;		Use the standard shift-and-add operation.
		;		Note that we cannot address half-words here. We can only address words and bytes (B).
		;		Use the two numbers as an example but write it so it works for any two 16-bit numbers.
		;		Write the result in the provided "fill" word.
		;		Indicate if there was a high-bit carry using the provided "fill" word.
		
		;		Your code here
		
		numbers	DCD		0b1000101110010100, 0b1111010101000011
		
result	FILL		4
carry	FILL		4
		
		ADR		R12, numbers 		; Load mem address of numbers into R12
		ADR		R11, result		; Load mem address of result into R11
		ADR		R10, carry		; Load mem address of carry into R10
		LDR		R0, [R12] 		; (B) Load first number into R0
		LDR		R1, [R12, #4]! 	; (Q) Load second number in R1
		
		MOV		R2, #0 			; (A) initialize to 0
		MOV		R3, #16			; (N) bit-counter, 16 for 16bit numbers (N)
		MOV		R4, #0			; Set carry-counter 0
		
checkQ	TST		R1, #0b1			; test if LSB in R1 is 1
		BEQ		skipadd			; Skip adding if LSB in R1 = 0
		
		ADDS		R2, R2, R0		; A = A + B
		BCC		skipadd			; skip tracking carry if no carry
		ADD		R4, R4, #1		; add 1 carry to R4
		
		
skipadd	MOV		R0, R0, LSL #1		; Shift B left
		MOV		R1, R1, LSR #1		; shift Q right
		
		SUBS		R3, R3, #1		; N = N - 1
		
		BNE		checkQ			; if N != 0, go back to check LSB of Q
		
		STR		R4, [R10]			; Stores the # of carries that occurred
		
		STR		R2, [R11]			; Store product into 'result' in mem

		END
		
		
