; 41 - dupαָ��
; =================================================================
;	dupαָ�
;	db/dw/dd �ظ��Ĵ��� dup (�ظ��� �ֽ���/����/˫��������)
; =================================================================

assume cs:codesg, ds:datasg, ss:stacksg

datasg segment
		db 20 dup ('b')
		dw 10 dup ('w')
		dd 5 dup ('d')

		db 5 dup ('123abc')
		dw 5 dup ('14')		; masm5֧��dw��dd������ַ���Ԫ�������2��!!!!!!!
		dd 5 dup ('8x')		; �������ڴ���dd���ǻ�ռ4���ֽڣ�dwռ2���ֽ�!!!!!
datasg ends

; ----------------------------------------------------------------

stacksg segment
		dw 128 dup ('+')
stacksg ends

; ----------------------------------------------------------------

codesg segment
start:		mov ax, datasg
		mov ds, ax

		mov ax, stacksg
		mov ss, ax
		mov sp, 257

codesg ends
end start
