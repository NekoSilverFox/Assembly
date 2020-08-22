; 200 - 端口小实验
; ===========================================
assume cs:codesg

codesg segment
start:		in al, 20h	; 从 20h 端口读取一个字节
		out 20h, al	; 向 20h 端口写入一个字节

	;	in bl, 20h	ERROR

	;	in al, 3f8h	ERROR
		mov dx, 3f8h
		in al, dx
		out dx, al
codesg ends
end start
