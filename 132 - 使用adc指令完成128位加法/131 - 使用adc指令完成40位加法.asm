; 131 - 使用adc指令完成40位加法
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
		dw	1111H,2222H,3333H,4444H,5555H,6666H,7777H,8888H
		dw	1111H,2222H,3333H,4444H,5555H,6666H,7777H,2H
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
		mov si, 0
		mov di, 16
		
		call add128

		mov ax, 4c00h
		int 21h


		; -------------------------------------------
		; 名称：add128
		; 计算 128位加法
		; 参数：因为数据128位，所以需要8个字单元
		;	ds:si 指向存储单元的第一个数的内存空间
		;	ds:di 指向储存单元的第二个数的内存空间
		; 	结果放在第一个数的内存空间中
		add128:	push ax
			push cx
			push ds
			push di
			push si
			
			sub ax, ax	; ************ 将CF设置为0 ************ 勿忘！！！
			
			mov cx, 8

		_add128:	mov ax, ds:[si]
				adc ax, ds:[di]
				mov ds:[si], ax
			
				inc si
				inc si
				inc di
				inc di
				loop _add128
			pop si
			pop di
			pop ds
			pop cx
			pop ax
			ret


	
	
code ends

end start
