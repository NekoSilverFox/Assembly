; 41 - dup伪指令
; =================================================================
;	dup伪指令：
;	db/dw/dd 重复的次数 dup (重复的 字节型/字型/双字型数据)
; =================================================================

assume cs:codesg, ds:datasg, ss:stacksg

datasg segment
		db 20 dup ('b')
		dw 10 dup ('w')
		dd 5 dup ('d')

		db 5 dup ('123abc')
		dw 5 dup ('14')		; masm5支持dw与dd定义的字符串元素最多有2个!!!!!!!
		dd 5 dup ('8x')		; 但是在内存中dd还是会占4个字节，dw占2个字节!!!!!
datasg ends

; ----------------------------------------------------------------

stacksg segment
		dw 128 dup ('+')
stacksg ends

; ----------------------------------------------------------------

codesg segment
start:		mov ax, datasg
		mov ds, ax

		mov ax, stacksg
		mov ss, ax
		mov sp, 257

codesg ends
end start
