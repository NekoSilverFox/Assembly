;  ������� �Ĺ����ǽ���mov ax, 4COOH��֮ǰ��ָ��Ƶ� 0:200 ������ȫ�����ϼ����ԣ�����

assume cs:code

code segment
		mov ax, cs
		mov ds, ax
		mov ax, 0020H
		mov es, ax		;ע���� es  ���� ex������
		mov bx, 0
		mov cx, 17H

s:		mov al, ds:[bx]
		mov es:[bx], al
		inc bx
		loop s

		mov ax, 4C00H
		int 21H

code ends

end
		

