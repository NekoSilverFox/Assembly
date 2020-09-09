
// ADD EAX, [EBX + 4 * ECX + 4] 的机器码是什么
// 0202H 对应的指令是什么
// 执行指令SAR, SHR, ROR 在A00Ah下，会发生什么

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