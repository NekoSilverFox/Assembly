; 260 - 接收用户键盘输入
; ======================================================

; P303

; 接收用户键盘输入，输入“r”，将屏幕上的字符设置为红色；输入“g”，将屏幕上的字符设置为绿色；输入“b”，将屏幕上的字符设置为蓝色

; ======================================================

; 功能编号：0（ah读取）
; 
; mov ah, 0
; int 16h
; 读取的 扫描码送入 ah，ASCII码送入 al
; ======================================================
assume cs:codesg, ss:stacksg
; ======================================================
stacksg segment stack
	db 128 dup (0)
stacksg ends
; ======================================================
codesg segment
start:		mov ax, stacksg
		mov ss, ax
		mov sp, 128

		mov ah, 0
		int 16h

		mov ah, 1
		cmp al, 'r'
		je red

		cmp al, 'g'
		je green

		cmp al, 'b'
		je blue

		jmp _ret

	red:	shl ah, 1
	green:	shl ah, 1
	blue:	mov bx, 0b800H
		mov es, bx
		mov bx, 1
		mov cx, 2000

	s:	and byte ptr es:[bx], 11110000B		; 将低位字节（前景属性）全设为0
		or es:[bx], ah
		add bx, 2
		loop s

	_ret:	mov ax, 4c00h
		int 21h
		
		; =============================================
		; 效果：因为int 16h的地方是从缓冲区读取，所以在输入对应字符以后才会才会执行
		; 否则程序一直处于等待状态

codesg ends
end start
