; 111 - 将数据直接显示在屏幕上
; =================================================================
; 
; =================================================================
; 复习一下32位除法：
	; 除数为16位，被除数为32位
	; DX 存放高16位，AX 存放低16位

	; 结果的存储：
	; AX --> 商，DX --> 余数


; 将内存中的数字转换为ASCII码： + 30

; （AX）= 0 也就是商 == 0，意味着除法结束了

; =================================================================

assume cs:codesg, ds:datasg, ss:stacksg

; =================================================================

datasg segment
		dw 7895
datasg ends

; =================================================================

stacksg segment
		db 128 dup (0)
stacksg ends

; =================================================================


codesg segment
start:			mov ax, datasg
			mov ds, ax
			mov di, 0

			mov ax, stacksg
			mov ss, ax
			mov sp, 128
			
			call short_div
			
			mov ax, 4c00h
			int 21h

	; ------------------ 将数据直接显示在屏幕上 ------------------
	; 输入：ds:[di]
	; 输出：屏幕

	short_div:	push ax
			push bx
			push cx
			push dx	
			push es
			push si

			mov ax, 0B800H
			mov es, ax
			mov si, 160 * 10 + 40 * 2
			
			
			mov ax, ds:[di]
	jmp_div:	mov dx, 0
			mov bx, 10
			div bx
			mov cx, dx
			jcxz return_div
			add cx, 30H
			mov ch, 00001010B	; <--- 注意，这里要对文字的属性进行设置，否则按内存中原来的进行设置，可能导致无法显示的问题
			mov es:[si], cx
			;mov word ptr es:[si + 1], 00000100B
			sub si, 2
			jmp jmp_div

	return_div:	pop si
			pop es
			pop dx
			pop cx
			pop bx
			pop ax

			ret

codesg ends
end start

; =================================================================;



