; 160 - 以0结尾的字符串中小写字母转大写
; =================================================================

; 编写一个子程序，将包含任意字符，以0结尾的字符串中的小写字母转变为大写字母

; 名称：letterc
; 功能：将以0结尾的字符串中的小写字母转变为大写字母
; 参数：ds:si 指向字符串首地址
; 
; =================================================================
assume cs:code, ss:stack, ds:data
; =================================================================
data segment
		db	"Beginner's All-purpose Symbolic Instruction Code.", 0
data ends
; =================================================================
stack segment stack
		db	128 dup (0)
stack ends
; =================================================================
code segment
start:		mov ax, stack
		mov ss, ax
		mov sp, 128

		mov ax, data
		mov ds, ax
		mov si, 0

		call letterc

		mov ax, 4c00h
		int 21h


	; ----------------------------------------
	; 名称：letterc
	; 功能：将以0结尾的字符串中的小写字母转变为大写字母
	; 参数：ds:si 指向字符串首地址
	letterc:push cx
		push ds
		push si
		
		mov cx, 0

		_letterc:	mov cl, ds:[si]		; 小写字母ASCII范围：[61H, 7A]
				jcxz _retLetterRc
				cmp cl, 61H
				jb _nextLetter
				cmp cl, 7AH
				ja _nextLetter
				and cl, 11011111B
				mov ds:[si], cl

		_nextLetter:	inc si
				jmp _letterc

		_retLetterRc:	pop si
				pop ds
				pop cx
				ret	
code ends

end start
