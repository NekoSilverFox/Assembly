; 117 - 设计一简化版的再次优化编写
; =================================================================

; =================================================================
assume cs:code, ds:data, ss:stack
; =================================================================
data segment
		db	'1975','1976','1977','1978','1979','1980','1981','1982','1983'
		db	'1984','1985','1986','1987','1988','1989','1990','1991','1992'
		db	'1993','1994','1995'
		;以上是表示21年的21个字符串 year


		dd	16,22,382,1356,2390,8000,16000,24486,50065,9749,14047,19751
		dd	34598,59082,80353,11830,18430,27590,37530,46490,59370
		;以上是表示21年公司总收入的21个dword数据	sum

		dw	3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
		dw	1154,1443,1525,1780
data ends
; =================================================================
table segment
	        		;0123456789ABCDEF
		db	21 dup ('year summ ne ?? ')
		
table ends
; =================================================================
stack segment stack
		db	128 dup (0)
stack ends
; =================================================================
code segment
start:		mov ax, stack
		mov ss, ax
		mov sp, 128
		
		call clear_screen
		
		call input_table

		call output_table

		mov ax, 4c00H
		int 21H

	; ------------- 清屏 -------------
	clear_screen:	mov ax, 0B800H
			mov es, ax
			mov si ,0
			
			mov ax, 0700H
			mov cx, 2000

		_clearScreen:	mov es:[si], ax
				add si, 2
				loop _clearScreen

			ret

	; ------------- 将数据重新存放在table段中 -------------
	input_table:	mov ax, data
			mov ds, ax
			mov di, 0

			mov ax, table
			mov es, ax
			mov si, 0
			
			mov cx, 21

		_inputTable:	push di
				add di, di
				add di, di

	        		;0123456789ABCDEF
	;	db	21 dup ('year summ ne ?? ')

				push ds:[di + 0]	; year
				pop es:[si + 0]
				push ds:[di + 2]
				pop es:[si + 2]

				mov ax, ds:[di + 54H]	; summ
				mov dx, ds:[di + 56H]
				
				pop di		; 将di重置
				push di
				add di, di
				mov bx, ds:[di + 0A8H]	; (bx) = ne

				mov es:[si + 5], ax
				mov es:[si + 7], dx	
				mov es:[si + 0AH], bx

				div bx
			
				mov es:[si + 0DH], ax
				
				pop di		; 在此重置di
				inc di
				add si, 16

			loop _inputTable	

			ret				
			

	; ------------- 输出打印 整理好的数据 -------------
	output_table:	mov ax, table
			mov ds, ax
			mov di, 0

			mov ax, 0B800H
			mov es, ax
			mov si, 160 * 3		; 空出三行

			mov cx, 21

		_outputTable:	call show_year
				call show_summ
				call show_en
				call show_average
				add di, 16
				add si, 160
				loop _outputTable

				ret
			ret

	; ------------- 输出打印 year -------------
	show_year:	push ax
			push cx
			push ds
			push es
			push di
			push si

			mov cx, 4
			add si, 2 * 3
			
			mov ah, 00000111B
	
		_oneYear:	mov al, ds:[di]
				mov es:[si], ax
				add si, 2
				inc di
				loop _oneYear
			
			pop si
			pop di
			pop es
			pop ds
			pop cx
			pop ax
			ret


	; --------------- short_div ---------------
	short_div:	push ax
			push cx
			push dx
			push ds
			push es
			push di
			push si

		_shortDiv:	mov cx, 10
				div cx
				mov dh, 00000111B
				add dl, 30H	; 数字 + 30H 转换为对应的ACSII码字符
				mov es:[si], dx
				mov cx, ax
				jcxz _retDiv
				mov dx, 0	; <<<======================== 一定记得将dx归零，因为再次进行32位除法是dx中保存了高16位，不清零将导致又变成了其他的除法
				sub si, 2
				jmp _shortDiv


		_retDiv:pop si
			pop di
			pop es
			pop ds
			pop dx
			pop cx
			pop ax
			ret

	; ------------- 输出打印 summ -------------
	show_summ:	push ax
			push ds
			push di
			push si

			mov ax, ds:[di + 5]
			mov dx, ds:[di + 7]

			add si, 20 * 2

			call short_div	; 计算的符号
			
			pop si
			pop di
			pop ds
			pop ax
			ret

	; ------------- 输出打印 en -------------
	show_en:	push ax
			push ds
			push di
			push si

			mov ax, ds:[di + 10]
			mov dx, 0

			add si, 30 * 2

			call short_div	; 计算的符号
			
			pop si
			pop di
			pop ds
			pop ax
			ret
		
	; ------------- 输出打印 average -------------
	show_average:	push ax
			push ds
			push di
			push si

			mov ax, ds:[di + 13]
			mov dx, 0

			add si, 40 * 2

			call short_div	; 计算的符号
			
			pop si
			pop di
			pop ds
			pop ax
			ret
	
code ends

end start

