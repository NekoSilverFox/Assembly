; 112 - 整理内存段中的数据【设计一 简化版】
; =================================================================
; 
; =================================================================
assume cs:code,ds:data,ss:stack

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

table segment

	        	;0123456789ABCDEF
	db	21 dup ('year summ ne ?? ')
		
table ends

stack segment stack
	db	128 dup (0)
stack ends



code segment

	start:	mov ax,stack
		mov ss,ax
		mov sp,128

		call input_table

		mov ax,4C00H
		int 21H



	; ---------------------------------------------
	; 组织内存段中的数据像table段一样
	; 输入：datasg
	; 输出：数据安排好的table段中内容
	input_table:	push ax
			push bx
			push cx
			push dx
			push si
			push di
			push bp
			
			
			
			mov ax, data
			mov ds, ax
			mov di, 0

			mov ax, table
			mov es, ax
			mov si, 0
			
			mov cx, 21

	_inout_table:	call mul_4	; 因为 年份 和 收入都保存在 4 个内存单元中，所以di要乘以4，结果保存在bp中

			mov dx, 0
			mov ax, 16
			mul si
			push si		; 将si - 行号暂存
			mov si, ax
			
			
			mov ax, ds:[bp + 0]	; 将 年份 移动到table段中固定位置
			mov es:[si + 0], ax
			mov ax, ds:[bp + 2]
			mov es:[si + 2], ax

			mov ax, ds:[bp + 84]	; 将 收入 移动到table段中固定位置
			mov dx, ds:[bp + 86]
			mov es:[si + 5], ax
			mov es:[si + 7], dx

			mov bx, di		; 将 入数、平均收入 移动到table段中固定位置
			add bx, di
			mov bx, ds:[bx + 168] ; A8 = 168
			mov es:[si + 10], bx	; 移动 人数 到table段
			div bx
			mov es:[si + 13], ax	; 移 动收 到table段

			pop si
			inc di
			inc si
			

			loop _inout_table

			
			pop bp
			pop di
			pop si
			pop dx
			pop cx
			pop bx
			pop ax
			ret

	; -----------------------------------------
	; 将di的值乘以4，并存放在bp中
	; in: di
	; out: bp = di * 4
	mul_4:		mov bp, di
			add bp, di
			add bp, di
			add bp, di
			ret


	; -----------------------------------------

code ends



end start



