; 200 - 端口小实验
; ===========================================
assume cs:codesg

codesg segment
start:		in al, 20h
		out 20h, al

	;	in bl, 20h	ERROR

	;	in al, 3f8h	ERROR
		mov dx, 3f8h
		in al, dx
		out dx, al
codesg ends
end start
