;  下面程序 的功能是将“mov ax, 4COOH”之前的指令复制到 0:200 处，补全程序，上级调试，跟踪

assume cs:code

code segment
		mov ax, cs
		mov ds, ax
		mov ax, 0020H
		mov es, ax		;注意是 es  不是 ex！！！
		mov bx, 0
		mov cx, 17H

s:		mov al, ds:[bx]
		mov es:[bx], al
		inc bx
		loop s

		mov ax, 4C00H
		int 21H

code ends

end
		

