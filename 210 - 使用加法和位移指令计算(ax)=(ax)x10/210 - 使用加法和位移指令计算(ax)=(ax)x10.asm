; 210 - 使用加法和位移指令计算(ax)=(ax)x10
; ====================================================

; 提示：(ax)*10 = (ax)*2 + (ax)*8
; ====================================================
assume cs:codesg

codesg segment
start:		mov ax, 1
		shl ax, 1
		mov dx, ax

		mov ax ,1
		mov cl, 3	; 当位移大于1时，必须使用cl进行保存位移
		shl ax, cl

		add ax, dx

		mov ax, 4c00h
		int 21h
codesg ends
end start
