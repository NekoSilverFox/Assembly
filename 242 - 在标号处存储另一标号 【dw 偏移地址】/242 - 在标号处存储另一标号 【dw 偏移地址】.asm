; 242 - 在标号处存储另一标号 【dw 偏移地址】
; ======================================================

; P290

; ======================================================

; 感悟：可以把这种用标号的使用看做成 C/C++ 中的数组

; ======================================================
assume cs:codesg, ds:datasg

datasg segment
	a db 1,2,3,4,5,6,7,8,9
	b dw 0
	c dw a, b	; <=============因为是 dw ，所以储存的是a，b的【偏移地址】
datasg ends

codesg segment
start:		mov ax, datasg
		mov ds, ax

		nop
		nop

codesg ends
end start
