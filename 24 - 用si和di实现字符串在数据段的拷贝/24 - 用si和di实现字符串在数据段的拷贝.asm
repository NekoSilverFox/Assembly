; 24 - 用si和di实现字符串在数据段的拷贝

; =================================================================
; 用si和di实现字符串‘welcome to masm!’复制到它后面的数据区中
; =================================================================

; si 和 di 其实就是和bx作用差不多的寄存器，一般用作偏移地址
; 但是 si 和 di 寄存器不能拆分成一个高位和一个低位寄存器！
; =================================================================

assume cs:codesg, ds:datasg

datasg segment
				db 'welcome to masm!'
				db '................'
datasg ends

;===================================

codesg segment
start:			mov ax, datasg
				mov ds, ax
				mov si, 0		; 习惯：数据从哪里来
				mov di, 0		; 习惯：数据到哪里去
				mov cx, 8

cpString:		mov ax, ds:[si]
				mov ds:[di + 16], ax
				add si, 2
				add di, 2
				loop cpString
codesg ends

end start