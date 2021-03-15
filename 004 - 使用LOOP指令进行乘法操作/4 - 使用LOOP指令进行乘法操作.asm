; 4 - 使用LOOP指令进行乘法操作
; 使用LOOP计算	256 x 132

assume cs:codesg

codesg segment

		mov ax, 0
		mov cx, 132

loopCode:		add ax, 256
		LOOP loopCode

codesg ends

end