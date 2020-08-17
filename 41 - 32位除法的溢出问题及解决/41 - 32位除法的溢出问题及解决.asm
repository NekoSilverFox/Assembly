; 41 - 32位除法的溢出问题及解决
; =================================================================

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
start:		mov ax ,stack
		mov ss, ax
		mov sp, 128

		mov ax, data
		mov ds, ax

		mov bx, 0

		mov ax, ds:[bx + 0]	; 参数：被除数低16位	L
		mov dx, ds:[bx + 2]	; 参数：被除数高16位	H
		mov cx, 10		; 参数：除数		M
					; 公式：X/N = int(H/N)*65536 + [rem(H/N)*65536+L]/N
		mov bp, ax		; 用bp暂存了低16位
		
		call divdw
		

		mov ax, 4c00h
		int 21h


	
	; -------------------------------------
	; 32位除法运算
	; 名称：divdw
	; 功能：进行不会溢出的除法运算，被除数为dword型，除数为word型，结果为dword型
	; 参数：(ax) = dword 型数据的低16位
	; 	(dx) = dword 型数据的高16位
	;	(cx) = 除数

	; 返回：(ax) = 结果的低16位
	;	(dx) = 结果的高16位
	;	(cx) = 余数
	;
	; 应用举例：j计算100 0000 / 10 (F4240H / 0AH)
	; 
	; 给出一个公式：
	; X: 被除数	范围：[0, FFFF FFFF]
	; N: 除数	范围：[0, FFFF]
	; H: X高16位	范围：[0, FFFF]
	; L: X低16位	范围：[0, FFFF]
	; int(): 描述性运算符，取商，比如：int(38/10)=3
	; rem(): 描述性运算符，取余数，比如：rem(38/10)=8
	; 
	; 公式：X/N = int(H/N)*65536 + [rem(H/N)*65536+L]/N
	; 
	divdw:	
		
		; 先计算int(H/N)*65536
		mov ax, dx
		mov dx, 0
		div cx			; int(H/N) --> dx	dx = rem(H/N)*65536+L
		
		push ax

		mov ax, bp		; L

		div cx			; ax = [rem(H/N)*65536+L]/N --> 得到的商	cx = 余数

		mov cx, dx

		pop dx
		
		ret
	
	
code ends

end start
