; 105 - 通过jcxz对0的检测完成对内存段中字符串大小写转换【二】
; =================================================================
; 
; =================================================================
; 编程：将data段中的字符串转换为大写
; =================================================================

assume cs:codesg, ds:datasg

; =================================================================

datasg segment
		db 'word', 0
		db 'unix', 0
		db 'wind', 0
		db 'good', 0
datasg ends

; =================================================================


codesg segment
start:			mov ax, datasg
			mov ds, ax
			
			mov cx, 4
			mov di, 0

	loop_row:	push cx		; 因为call中用到了cx，会造成寄存器冲突，所以在下一语句前先push，用到的时候再pop 取出来

			call capital
			inc di
			pop cx		; pop 取出来

			loop loop_row
			
			mov ax, 4c00h
			int 21h


	; --------------------------- 子程序 ---------------------------
	; 说明：将字符串转换为大写，该字符串以零结尾
	; 参数：字符串首地址：ds:[di], (di) = 0
	; 结果：直接更改对应内存单元内容
	capital:	mov ch, 0
			mov cl, ds:[di]
			jcxz return
			and byte ptr ds:[di], 11011111B
			inc di
			jmp capital
	return:		ret

codesg ends
end start

; =================================================================;



