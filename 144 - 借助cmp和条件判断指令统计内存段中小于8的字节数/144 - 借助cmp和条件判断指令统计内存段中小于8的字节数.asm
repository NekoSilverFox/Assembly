; 144 - 借助cmp和条件判断指令统计内存段中小于8的字节数
; =================================================================
; cmp 通过减法影响标志寄存器，然后再用相应的判断指令即可完成通过条件跳转
; 
; 具体为什么此处不做说明，详见 P225
; 
; je = 
; jne !=
; jb <
; jnb >=
; ja >
; jna <=
; 
; =================================================================
assume cs:code, ss:stack, ds:data
; =================================================================
data segment
		db	8,11,8,1,8,5,63,38
data ends
; =================================================================
stack segment stack
		db	128 dup (0)
stack ends
; =================================================================
code segment
start:		mov ax, stack
		mov ss, ax
		mov sp, 128

		mov ax, data
		mov ds, ax
		mov bx, 0		; print to first byte in data segment
		mov ax, 0		; Tne counter
		mov cx, 8		; loop 8 times

		s:	cmp byte ptr ds:[bx], 8
			jnb next	; 判断不小于要比直接判断小于等于的代码量和逻辑要好
			inc ax
		next:	inc bx
			loop s

		mov ax, 4c00h
		int 21h
	
code ends

end start
