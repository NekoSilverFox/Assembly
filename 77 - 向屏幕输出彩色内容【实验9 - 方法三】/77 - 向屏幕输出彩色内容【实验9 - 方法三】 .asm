; 77 - 向屏幕输出彩色内容【实验9 - 方法三】 
; =================================================================
; 要求: 在屏幕中间分别显示绿色、绿底红色、白底蓝色字符串“welcome to masm!”
; ===============================================================
assume cs:codesg, ds:datasg, ss:stacksg

; =================================================================

datasg segment
		db 'welcome to masm!'
		db 00000010B, 10100100B, 01110001B
datasg ends

; =================================================================

stacksg segment
		dw 16 dup (0)
stacksg ends

; =================================================================

codesg segment
start:		mov ax, datasg
		mov ds, ax

		mov ax, stacksg
		mov ss, ax
		mov sp, 32

		; where data go
		mov ax, 0B800H
		mov es, ax
		mov bx, 160 * 11 + 64
		
		mov cx, 3
		mov si, 0
		mov di, 16

setALL:		push cx	
		mov cx, 16
		mov ah, ds:[di]

setRow:		mov al, ds:[si]
		inc si
		mov es:[bx], ax
		add bx, 2
		loop setRow

		add bx, 160 - 32
		mov si, 0
		inc di
		pop cx
		loop setALL

		mov ax, 4c00h
		int 21h

codesg ends
end start

; =================================================================;
