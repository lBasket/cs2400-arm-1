		;		ARM Programming Assignment #1: Capitalizer
		;
		;		Write a program that goes through the characters in chars,
		;		and Capitalizes every lower-case letter that it finds..
		;		Write the number of capitalizations the program performed
		;		In the caps "fill" memory provided.
		
		; NOTES:
		; I designed the code to assume a NULL terminator (0) is used to signify end of array
		; This WILL NOT WORK if the array does not end with a 0
		; This allows you to use any size array of characters that you want
		
		ADR		R12, chars 		; Load addr of chars (array) into R12
		ADR		R11, caps			; Load addr of caps into R11
		MOV		R10, #0 			; Initialize R10 to track caps performed
		
loop		LDR		R0, [R12] 		; Load array element
		MOV		R1, R12 			; Store memory location for writeback
		ADD		R12, R12, #4 		; Increment address
		CMP		R0, #0 			; Check if retrieved element is 0 (NULL terminator)
		BEQ		arrayend 			; If element retrieved=0, leave loop, finish program
		
		CMP		R0, #97 			; Check if value represents ASCII 'a' or greater
		BLT		loop 			; Branch to 'loop' to grab next variable, this isn't lowercase letter
		
		CMP		R0, #122 			; Check if value represents ASCII 'z' or lower
		BGT		loop 			; Branch to 'loop' to grab next variable, this isn't lowercase letter
		
		SUB		R0, R0, #32 		; Capitlize value in R0
		STR		R0, [R1] 			; Store capitilized value in R0 back into the array
		ADD		R10, R10, #1 		; add 1 to number of caps performed
		B		loop 			; Keep looping through

		END
		
arrayend ; branch here when you hit null terminator
		STR		R10, [R11]		; Store number of caps performed into 'caps' memory location
		
		
chars	DCD		'a', 'B', '5', 'q', '0', 'O', '1', 's', 'b', 'i', 'G', 'z', 'q', 0
caps		FILL		4
