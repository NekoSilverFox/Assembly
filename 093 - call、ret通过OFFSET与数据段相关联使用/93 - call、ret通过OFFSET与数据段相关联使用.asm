; 93 - call、ret通过OFFSET与数据段相关联使用
; =================================================================

assume cs:codesg, ds:datasg, ss:stacksg

; =================================================================

datasg segment
		dw 8 dup (0)
datasg ends

stacksg segment
		dw 8 dup (0)
stacksg ends

; =================================================================

codesg segment
		
	main:	mov ax, datasg
		mov ds, ax
		mov ax, stacksg
		mov ss, ax
		mov sp, 16

		mov ax, OFFSET sub1
		mov ds:[0], ax
		mov ax, OFFSET sub2
		mov ds:[2], ax
		mov ax, OFFSET sub3
		mov ds:[4], ax

		CALL WORD PTR ds:[0]		; <==== CALL 指令也可以使用 -P 跳过执行
		CALL WORD PTR ds:[2]
		CALL WORD PTR ds:[4]

		mov ax, 4c00h
		int 21H
		

	; ----------------------------------
	sub1:	mov ax, 1001H
		ret

	; ----------------------------------
	sub2:	mov ax, 1002H
		ret

	; ----------------------------------
	sub3:	mov ax, 1003H
		ret

codesg ends

; =================================================================
end main

