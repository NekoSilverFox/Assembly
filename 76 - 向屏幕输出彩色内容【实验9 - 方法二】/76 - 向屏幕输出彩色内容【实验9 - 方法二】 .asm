; 76 - 向屏幕输出彩色内容【实验9 - 方法二】 

; =================================================================
; 要求: 在屏幕中间分别显示绿色、绿底红色、白底蓝色字符串“welcome to masm!”
; =================================================================

assume cs:codesg, ds:datasg, es:colorsg

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

;stacksg segment
;		dw 48 dup (0)
;stacksg ends

; =================================================================

codesg segment

		; 数据从哪里来
start:		mov ax, datasg
		mov ds, ax

		mov ax, colorsg
		mov es, ax

		mov di, 1
		mov si, 0

		; 先将ds段中的高位都加上属性
		mov cx, 3

loop3:		mov dx, cx
		mov cx, 16
		mov ah, es:[si]

	loopRow:	mov ds:[di], ah
			add di, 2
			loop loopRow

		;dec dx
		inc si
		mov cx, dx
		loop loop3

; ====================================================================

		; 数据又从哪里来
		mov di, 0

		; 数据到哪里去
		mov ax, 0B800H
		mov es, ax
 		mov bx, 160 * 12 + 64

		mov cx, 3

mov3:		mov dx, cx
		mov cx, 16

	movRow:		mov ax, ds:[di]
			mov es:[bx], ax
			add di, 2
			add bx, 2
			loop movRow
		
		;dec dx
		mov cx, dx
		add bx, 160 - 32	
		loop mov3
		
		mov ax, 4c00h
		int 21h


codesg ends

end start

