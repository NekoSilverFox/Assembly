; 36 - 八位除法div
; =================================================================
; 除法操作：div

; 如果除数为8位
;	ax - 储存被除数		16÷3=5...1	（16-被除数，3-除数，5-商，1余数）

; 8位除法运算结果的存放
; 	al - 储存 商
; 	ah - 储存 余数
; =================================================================

assume cs:codesg, ds:datasg

datasg segment
				dw 3
datasg ends

; -------------------------

codesg segment
start:			mov ax, datasg
				mov ds, ax
				
				mov ax, 16
				mov bl, 3
			;	div bl				; 【例一】 执行后在debug中查看al和ah中的值！

				div byte ptr ds:[0]	; 【例二】 使用ds段中的数据作为除数

codesg ends

end start