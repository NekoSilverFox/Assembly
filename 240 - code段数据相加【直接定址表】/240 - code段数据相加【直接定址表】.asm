; 240 - code段数据相加【直接定址表】
; ======================================================

; 下面的程序段中a处的8个数据累加，结果存放在b处的双字中，补全程序

; P289
; ======================================================
assume cs:codesg

codesg segment
	a dw 1,2,3,4,5,6,7,8
	b dd 0

	start:	mov si, 0
		mov cx, 8
	
	s:	mov ax, a[si]
		add word ptr b[0], ax
		adc word ptr b[2], 0
		add si, 2
		loop s

		mov ax, 4c00h
		int 21h
codesg ends
end start
