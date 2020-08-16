; ===================================================
; 123 - 数据-字符串-显示【设计一】
; ===================================================
assume cs:code,ds:data,ss:stack

data segment


		db	'1975','1976','1977','1978','1979','1980','1981','1982','1983'
		db	'1984','1985','1986','1987','1988','1989','1990','1991','1992'
		db	'1993','1994','1995'
		;以上是表示21年的21个字符串 year


		dd	16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
		dd	345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
		;以上是表示21年公司总收入的21个dword数据	sum

		dw	3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
		dw	11542,14430,15257,17800



data ends


table segment
				;0123456789ABCDEF
		db	21 dup ('year summ ne ?? ')
table ends

stack segment stack
	db	128 dup (0)
stack ends


string segment
	
	db	10 dup ('0'),0,0,0

string ends


code segment

	start:	mov ax,stack
		mov ss,ax
		mov sp,128



		call input_table
		call clear_screen
		call output_table
		


		mov ax,4C00H
		int 21H



;=========================================================
clear_screen:
		mov bx,0B800H
		mov es,bx

		mov bx,0
		mov dx,0700H
		mov cx,2000

clearScreen:	mov es:[bx],dx
		add bx,2
		loop clearScreen

		ret
;=========================================================
output_table:	call init_reg_outputTable


		mov cx,21
		mov si,0		;ds:[si]
		mov di,160*3
		mov bx,9		;string[9]
		
outputTable:	call show_year	
		call show_sum
		call show_employee
		call show_average
		add di,160
		add si,16
		loop outputTable


		ret



;=========================================================
show_average:	push ax
		push bx
		push cx
		push dx
		push ds
		push es
		push si
		push di


		mov ax,ds:[si+13]
		mov dx,0

		call isShortDiv


		call init_reg_showString


		add di,40*2
				;0123456789ABCDEF
;		db	21 dup ('year summ ne ?? ')
		call show_string


		pop di
		pop si
		pop es
		pop ds
		pop dx
		pop cx
		pop bx
		pop ax
		ret
		
;=========================================================
show_employee:	push ax
		push bx
		push cx
		push dx
		push ds
		push es
		push si
		push di


		mov ax,ds:[si+10]
		mov dx,0

		call isShortDiv


		call init_reg_showString


		add di,23*2
				;0123456789ABCDEF
;		db	21 dup ('year summ ne ?? ')
		call show_string


		pop di
		pop si
		pop es
		pop ds
		pop dx
		pop cx
		pop bx
		pop ax
		ret
;=========================================================
show_sum:	push ax
		push bx
		push cx
		push dx
		push ds
		push es
		push si
		push di


		mov ax,ds:[si+5]
		mov dx,ds:[si+7]

		call isShortDiv


		call init_reg_showString


		add di,10*2
				;0123456789ABCDEF
;		db	21 dup ('year summ ne ?? ')
		call show_string


		pop di
		pop si
		pop es
		pop ds
		pop dx
		pop cx
		pop bx
		pop ax
		ret


;=========================================================
show_string:	push cx
		push ds
		push es
		push si
		push di

showString:	mov cx,0
		mov cl,ds:[si]
		jcxz showStringRet
		mov es:[di],cl
		add di,2
		inc si
		jmp showString		

showStringRet:	pop di
		pop si
		pop es
		pop ds
		pop cx
		ret
;=========================================================
init_reg_showString:
		mov si,bx

		mov bx,string
		mov ds,bx

		mov bx,0B800H
		mov es,bx

		ret
;=========================================================
isShortDiv:	mov cx,dx
		jcxz shortDiv	
		push ax
		mov bp,sp
		mov cx,10
		call long_div				;	ip	ax
		add sp,2
		add cl,30H
		mov es:[bx],cl
		dec bx
		jmp isShortDiv


shortDivRet:	ret


;=========================================================
long_div:	
		mov ax,dx
		mov dx,0
		div cx
		push ax
		mov ax,ss:[bp+0]
		div cx
		mov cx,dx
		pop dx

		ret
;=========================================================
shortDiv:	mov cx,10
		div cx
		add dx,30H
		mov es:[bx],dl
		mov cx,ax
		jcxz shortDivRet
		dec bx
		mov dx,0
		jmp shortDiv
;=========================================================
show_year:	push bx
		push cx
		push ds
		push es
		push si
		push di

		mov bx,0B800H
		mov es,bx
		
		mov cx,4

		add di,3*2

		
showYear:	mov dl,ds:[si]
		mov es:[di],dl
		inc si
		add di,2
		loop showYear

		pop di
		pop si
		pop es
		pop ds
		pop cx
		pop bx
		ret
;=========================================================
init_reg_outputTable:
		mov bx,table
		mov ds,bx
	
		mov bx,string
		mov es,bx

		ret
;=========================================================
input_table:	call init_reg_intputTable
		
		mov si,0
		mov di,21*4*2			;ds:[si]	ds:[di]		es:[bx]
		mov bx,0

		mov cx,21


inputTable:	push ds:[si+0]
		pop es:[bx+0]
		push ds:[si+2]
		pop es:[bx+2]
			

		mov ax,ds:[si+21*4]
		mov dx,ds:[si+21*4+2]
		mov es:[bx+5],ax
		mov es:[bx+7],dx

		push ds:[di+0]
		pop es:[bx+10]

		div word ptr es:[bx+10]

		mov es:[bx+13],ax

				;0123456789ABCDEF
;		db	21 dup ('year summ ne ?? ')

		add si,4
		add di,2
		add bx,16


		loop inputTable			


		ret


;=========================================================
init_reg_intputTable:
		mov bx,data
		mov ds,bx

		mov bx,table
		mov es,bx

		ret



code ends



end start


