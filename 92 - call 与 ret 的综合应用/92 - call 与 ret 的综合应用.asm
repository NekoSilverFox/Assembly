; 92 - call 与 ret 的综合应用
; =================================================================

assume cs:codesg, ss:stacksg

; =================================================================

stacksg segment
		dw 8 dup (0)
stacksg ends

; =================================================================

codesg segment
		
	main:	mov ax, stacksg
		mov ss, ax
		mov sp, 16

		call sub1
		call sub2
		call sub3

		mov ax, 4c00h
		int 21h

	; ----------------------------------
	sub1:	mov ax, 1000H
		ret

	; ----------------------------------
	sub2:	mov ax, 1001H
		ret

	; ----------------------------------
	sub3:	mov ax, 1002H
		ret

codesg ends

; =================================================================
end main

