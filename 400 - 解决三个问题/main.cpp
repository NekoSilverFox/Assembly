
// ADD EAX, [EBX + 4 * ECX + 4] �Ļ�������ʲô
// 0202H ��Ӧ��ָ����ʲô
// ִ��ָ��SAR, SHR, ROR ��A00Ah�£��ᷢ��ʲô

int main()
{

	__asm
	{
		call q1

		mov eax, 4c00h
		int 21h

		// ===========================================
		// q1
		q1:	push ax
				ADD EAX, [EBX + 4 * ECX + 4]
				pop ax
				ret
		// ===========================================
	}

	return 0;
}