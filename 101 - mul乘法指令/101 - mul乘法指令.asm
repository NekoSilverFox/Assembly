; 101 - mul乘法指令
; =================================================================
; 
; mul 乘法指令
; 		
; 8位乘法：
; 		一个默认在AL中，另一个可以是8位reg或者内存单元 byte ptr ds:[??]	--> 结果在AX中
; 
; 16位乘法：
; 		一个默认在AX中，另一个可以是16位reg或者内存单元 word ptr ds:[??] --> 结果：低位在AX中，高位在DX中
; 
; 
; =================================================================

assume cs:codesg, ds:datasg

; =================================================================

datasg segment
		db 10
		dw 100
datasg ends

; =================================================================


codesg segment
start:		call set_segment

	; ---------------- 8 位乘法 ----------------
		mov ah, 0
		mov al, 100
		mul byte ptr ds:[0]

		mov ax, 0
		mov al, 10
		mov bl, 100
		mul bl


	; ---------------- 16 位乘法 ----------------
		mov ax, 0FFH
		mov bx, 2H
		mul bx

		mov ax, 2333
		mul word ptr ds:[1]
		
		mov ax, 4c00h
		int 21h

set_segment:	mov ax, datasg
		mov ds, ax
		ret

codesg ends
end start

; =================================================================;



