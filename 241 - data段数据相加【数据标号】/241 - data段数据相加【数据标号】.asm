; 241 - data段数据相加【数据标号】
; ======================================================

; 下面的程序段中a处的8个数据累加，结果存放在b处的双字中，补全程序

; P289
; ======================================================
assume cs:codesg, ds:datasg
; ======================================================
datasg segment
	a db 1,2,3,4,5,6,7,8
	b dw 0
datasg ends


codesg segment


	start:	mov ax, datasg
		mov ds, ax

		mov si, 0
		mov cx, 8
	
	s:	mov al, a[si]
		mov ah, 0
		add b, ax
		inc si
		loop s

		mov ax, 4c00h
		int 21h
codesg ends
end start
