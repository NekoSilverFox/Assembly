;8 - 通过有限制令将内存中输入数据
; ===================================================================
; 编程技巧：
;			ds寄存器 --> 数据从哪里来
;			es寄存器 --> 数据到哪里去（es也是一个数据寄存器）
; ===================================================================
; 题目：
;		向内存0:200 ~ 0:23F 依次传递数据 0 ~ 63(3FH) ; 字节型数据
;		程序只能用小于 9 条指令，包括：
;		mov ax, 4COOH
;		int 21H

assume cs:codesg

codesg segment
	
		mov ax, 20H
		mov es, ax
	
		mov bx, 0
		mov cx, 40H ; 注意：这里是40而不是3F，因为0 ~ 63(3FH)有40个数
	
movData:mov es:[bx], bx
		inc bx
		loop movData
	
		mov ax, 4C00H
		int 21H

codesg ends

end