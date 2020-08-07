; 75 - 向屏幕输出彩色内容【实验9】 

; =================================================================
; 要求: 在屏幕中间分别显示绿色、绿底红色、白底蓝色字符串“welcome to masm!”
; =================================================================

assume cs:codesg, ds:datasg, es:colorsg, ss:stacksg

; =================================================================

datasg segment
		dw 'w','e','l','c','o','m','e',' ','t','o',' ','m','a','s','m','!'
		dw 'w','e','l','c','o','m','e',' ','t','o',' ','m','a','s','m','!'
		dw 'w','e','l','c','o','m','e',' ','t','o',' ','m','a','s','m','!'
datasg ends

; =================================================================

colorsg segment
		db 00000010B, 10101100B, 01111001B
colorsg ends

; =================================================================

stacksg segment
		dw 48 dup (0)
stacksg ends

; =================================================================

codesg segment
start:		mov ax, stacksg
		mov ss, ax
		mov sp, 61H


		mov cx, 48
		mov bx, 5EH
		mov ax, datasg
		mov ds, ax
pushData:	push ds:[bx]	; 把welcome to masm! 都送入到栈中
		sub bx, 2
		loop pushData

		mov ax, colorsg
		mov ds, ax
		mov di, 0
		mov dx, 3	; 3行

		mov ax, 0B800H
		mov es, ax
		mov bx, 160 * 12 + 64
		
		; 处理每一行的数据
		mov cx, 3	; 如果忘了这个会出现很神奇的效果！！！
loop3:		mov dx, cx
		mov cx, 16
		oneRow:		pop es:[bx]
				mov ah, ds:[di]
				mov es:[bx + 1], ah
				add bx, 2
				loop oneRow

		inc di
		add bx, 160 - 32
		mov cx, dx
		loop loop3

		mov ax, 4c00h
		int 21h


codesg ends

end start

; =================================================================


; ===============================================================
;assume cs:codesg, ds:datasg, es:colorsg, ss:stacksg
;
;; =================================================================
;
;datasg segment
;		dw 'w','e','l','c','o','m','e',' ','t','o',' ','m','a','s','m','!'
;		;dw 'w','e','l','c','o','m','e',' ','t','o',' ','m','a','s','m','!'
;		;dw 'w','e','l','c','o','m','e',' ','t','o',' ','m','a','s','m','!'
;datasg ends
;
;; =================================================================
;
;colorsg segment
;		db 00000010B, 10100100B, 01110001B
;colorsg ends
;
;; =================================================================
;
;stacksg segment
;		dw 16 dup (0)
;stacksg ends
;
;; =================================================================
;
;codesg segment
;start:		mov ax, stacksg
;		mov ss, ax
;		mov sp, 33
;
;
;		mov cx, 16
;		mov bx, 30
;		mov ax, datasg
;		mov ds, ax
;pushData:	push ds:[bx]
;		sub bx, 2
;		loop pushData
;
;		mov ax, colorsg
;		mov ds, ax
;		mov di, 0
;		mov dx, 3	; 3行
;
;		mov ax, 0B800H
;		mov es, ax
;		mov bx, 160 * 12 + 64
;		mov cx, 16
;		; 把第一行的数据拷贝到
;oneRow:		pop es:[bx]
;		mov ah, ds:[di]
;		mov es:[bx + 1], ah
;		add bx, 2
;		jcxz initCX
;		loop oneRow
;		
;
;initCX:		dec dx
;		mov cx, dx
;		jcxz exit
;		mov cx, 16
;		mov di, 0
;		add bx, 160 - 64
;		jmp initStack
;back:		jmp short oneRow
;
;exit:		mov ax, 4c00h
;		int 21h
;		
;
;initStack:		mov cx, 16
;			mov bx, 30
;			mov ax, datasg
;			mov ds, ax
;	pushAgain:	push ds:[bx]
;			sub bx, 2
;			loop pushAgain
;	jmp short back
;
;codesg ends
;
;end start
;
;; =================================================================;
