; 131 - 使用adc指令完成40位加法 P220
; =================================================================
; adc --> add carry (Cf)
; 
; adc是带进位加法指令，他利用了CF位上记录的进位值
; 
; 比如： adc ax, bx -->> (ax)=(ax)+(bx)+CF
; 
; 
; 
; =================================================================
assume cs:code, ds:data, ss:stack
; =================================================================
data segment
		dd	1000000
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
		
		; 计算 1E F000 1000H + 20 1000 1EF0H
		; 结果放在ax（最高16位），bx（次高16位），cx（低16位）中

		mov ax, 1000H
		mov bx, 0F000H
		mov cx, 1EH

		add ax, 1EF0H
		adc bx, 1000H
		adc cx, 20H


	
	
code ends

end start
