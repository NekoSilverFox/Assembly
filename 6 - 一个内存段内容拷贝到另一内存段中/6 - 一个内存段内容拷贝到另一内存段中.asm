; 6 - 一个内存段内容拷贝到另一内存段中
; ===================================================================
; 编程技巧：
;			ds寄存器 --> 数据从哪里来
;			es寄存器 --> 数据到哪里去（es也是一个数据寄存器）
; ===================================================================
; 题目：将 FFFF:0 ~ FFFF:F 内存单元中的内容拷贝到 0:200 ~ 0:20F中

assume cs:codesg

codesg segment
		mov ax, 0FFFFH	; 设置 ds寄存器 --> 数据从哪里来
		mov ds, ax

		mov ax, 20H		; 设置 es 寄存器 --> 数据到哪里去
		mov es, ax

		mov ax, 0 		; 进行清零及初始化
		mov bx, 0
		mov cx, 16		; 别忘了对 cx 进行初始化

cpData:	mov al, ds:[bx]
		mov es:[bx], al
		inc bx
		loop cpData

codesg ends

end