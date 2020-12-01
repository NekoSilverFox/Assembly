#include <iostream>
#include <bitset>

#if 0

  Задания по теме ПОДПРОГРАММЫ :
  1. 算数左/右移 - Напишите фрагмент программы на встроенном ассемблере - сдвига арифметического вправо(влево).
  2. 逻辑左/右移 - Напишите фрагмент программы на встроенном ассемблере. Сдвиг логический вправо(влево).
  3. 循环左/右移 - Напишите фрагмент программы на встроенном ассемблере. Сдвиг циклический вправо(влево).
  4. 双字递增 - Напишите фрагмент программы на ассемблере - инкремент двойного слова. Сравните Ваш способ с тем, как это делает компилятор.
  5. 双字递减 - Напишите фрагмент программы на ассемблере - декремент двойного слова. Посмотрите, как это делает компилятор.
  6. 改变双字符号 - Напишите фрагмент программы на ассемблере - смена знака двойного слова.
  7. 双字加法 - Напишите фрагмент программы на ассемблере - сложение двух двойных слов.
  8. 双字比较 - Напишите фрагмент программы на ассемблере - сравнение двух двойных слов.
  9. 双字乘法 - Напишите фрагмент программы на ассемблере - умножение двух двойных слов.

#endif
void printLine()
{
	std::cout << "\n\033[33m========================================================================================\033[0m\n\n";
}
// 1. 算数左/右移 - Напишите фрагмент программы на встроенном ассемблере - сдвига арифметического вправо(влево).
void arithmeticShift()
{
	std::cout << "1. Напишите фрагмент программы на встроенном ассемблере. Сдвиг арифметического вправо(влево)" << std::endl;
	int tmp;
	__asm
	{
		mov eax, 00000000000000000000000000000010B
		mov tmp, eax
	}

	for (int i = 1; i < 5; ++i)
	{
		std::cout << " Число 00000000000000000000000000000010 | сдвига арифметического влево " << i << " bit --> ЧИСЛО = ";
		__asm
		{
			mov eax, tmp
			shl eax, 1
			mov tmp, eax
		}
		std::cout << std::bitset<sizeof(unsigned int) * 8>(tmp) << std::endl;
	}

	std::cout << std::endl;
	__asm
	{
		mov eax, 00000000000000000000000000010000B
		mov tmp, eax
	}

	for (int i = 1; i < 5; ++i)
	{
		std::cout << " Число 00000000000000000000000000010000 | сдвига арифметического вправо " << i << " bit --> ЧИСЛО = ";
		__asm
		{
			mov eax, tmp
			shr eax, 1
			mov tmp, eax
		}
		std::cout << std::bitset<sizeof(unsigned int) * 8>(tmp) << std::endl;
	}
}



// 2. 逻辑左/右移 - Напишите фрагмент программы на встроенном ассемблере. Сдвиг логический вправо(влево).
void logicalShift()
{
	std::cout << "2. Напишите фрагмент программы на встроенном ассемблере. Сдвиг логический вправо(влево)" << std::endl;

	int tmp;
	__asm
	{
		mov eax, 10000000000000000000000000000010B
		mov tmp, eax
	}

	for (int i = 1; i < 5; ++i)
	{
		std::cout << " Число 10000000000000000000000000000010 | сдвига логический влево " << i << " bit --> ЧИСЛО = ";
		__asm
		{
			mov eax, tmp
			sal eax, 1
			mov tmp, eax
		}
		std::cout << std::bitset<sizeof(unsigned int) * 8>(tmp) << std::endl;
	}

	std::cout << std::endl;

	__asm
	{
		mov eax, 10000000000000000000000000010000B
		mov tmp, eax
	}

	for (int i = 1; i < 5; ++i)
	{
		std::cout << " Число 10000000000000000000000000010000 | сдвига логический вправо " << i << " bit --> ЧИСЛО = ";
		__asm
		{
			mov eax, tmp
			sar eax, 1
			mov tmp, eax
		}
		std::cout << std::bitset<sizeof(unsigned int) * 8>(tmp) << std::endl;
	}
}



// 3. 循环左/右移 - Напишите фрагмент программы на встроенном ассемблере. Сдвиг циклический вправо(влево).
void circularShift()
{
	std::cout << "3. Напишите фрагмент программы на встроенном ассемблере. Сдвиг циклический вправо(влево)" << std::endl;

	int tmp;
	__asm
	{
		mov eax, 11000000000000000000000000111110B
		mov tmp, eax
	}

	for (int i = 1; i < 6; ++i)
	{
		std::cout << " Число 11000000000000000000000000111110 | Сдвиг циклический влево " << i << " bit --> ЧИСЛО = ";
		__asm
		{
			mov eax, tmp
			rol eax, 1
			mov tmp, eax
		}
		std::cout << std::bitset<sizeof(unsigned int) * 8>(tmp) << std::endl;
	}

	std::cout << std::endl;
	__asm
	{
		mov eax, 11000000000000000000000000111110B
		mov tmp, eax
	}

	for (int i = 1; i < 6; ++i)
	{
		std::cout << " Число 11000000000000000000000000111110 | Сдвиг циклический вправо " << i << " bit --> ЧИСЛО = ";
		__asm
		{
			mov eax, tmp
			ror eax, 1
			mov tmp, eax
		}
		std::cout << std::bitset<sizeof(unsigned int) * 8>(tmp) << std::endl;
	}
}

// 4. 双字递增 - Напишите фрагмент программы на ассемблере - инкремент двойного слова.Сравните Ваш способ с тем, как это делает компилятор.
void DDIncremental()
{
	std::cout << "4. Напишите фрагмент программы на ассемблере - инкремент двойного слова.Сравните Ваш способ с тем, как это делает компилятор" << std::endl;
	__asm mov ax, 0
	__asm mov dx, 0
	int val = 0;

	/*
	** DD:
	** High 16 bit --> DX
	** Low 16 bit ---> AX
	*/
	__asm mov dx, 0
	__asm mov ax, 0FFFFH

	__asm
	{
		add ax, 1
		adc dx, 0
		mov bx, ax
		mov ax, dx
		shl eax, 16
		mov ax, bx
		mov val, eax
	}
	std::cout << "Пример >>>  inc ffff\033[31mH \033[0m" << std::endl
				  << "Ответ  >>>  " << std::hex << val << "\033[31mH \033[0m" << std::endl;
}


// 5. 双字递减 - Напишите фрагмент программы на ассемблере - декремент двойного слова.Посмотрите, как это делает компилятор.
void DDDescending()
{
	std::cout << "5. Напишите фрагмент программы на ассемблере - декремент двойного слова.Посмотрите, как это делает компилятор" << std::endl;
	__asm mov ax, 0
	__asm mov dx, 0
	int val = 0;

	/*
	** DD:
	** High 16 bit --> DX
	** Low 16 bit ---> AX
	*/
	__asm mov dx, 1
	__asm mov ax, 0

	__asm
	{
		sub ax, 1
		sbb dx, 0
		mov bx, ax
		mov ax, dx
		shl eax, 16
		mov ax, bx
		mov val, eax
	}
	std::cout << "Пример >>>  dec 10000\033[31mH \033[0m" << std::endl
		<< "Ответ  >>>  " << std::hex << val << "\033[31mH \033[0m" << std::endl;
}


// 6. 改变双字符号 - Напишите фрагмент программы на ассемблере - смена знака двойного слова.
void changeDDSign(int val)
{
	std::cout << "6. Напишите фрагмент программы на ассемблере - смена знака двойного слова" << std::endl;

	std::cout << "The value \033[32mbefore\033[0m changing the sign >>> VAL = \033[31m" << std::dec << val << "\033[0m\n";

	__asm
	{
		mov eax, val
		mov bx, ax
		shr eax, 16
		not ax
		not bx
		add bx, 1
		adc ax, 0
		shl eax, 16
		mov ax, bx
		mov val, eax
	}
	std::cout << "The value \033[32mafter\033[0m  changing the sign >>> VAL = \033[31m" << (signed int)val << "\033[0m\n";
	std::cout << std::endl;
}


// 7. 双字加法 - Напишите фрагмент программы на ассемблере - сложение двух двойных слов.
void DDAddition(int l_val, int r_val)
{
	std::cout << "7. Напишите фрагмент программы на ассемблере - сложение двух двойных слов" << std::endl;
	int ans;
	__asm
	{
		mov eax, l_val
		mov bx, ax
		shr eax, 16

		mov edx, r_val
		mov cx, dx
		shr edx, 16

		add cx, bx
		adc dx, ax
		shl edx, 16
		mov dx, cx
		mov ans, edx
	}

	std::cout << "Пример >>> " << l_val << " + " << r_val << " = \033[31m" << ans << "\033[0m" <<std::endl;
	std::cout << std::endl;

}

// 8. 双字比较 - Напишите фрагмент программы на ассемблере - сравнение двух двойных слов.
void DDComparison(int l_val, int r_val)
{
	std::cout << "8. Напишите фрагмент программы на ассемблере - сравнение двух двойных слов" << std::endl;
	std::cout << "Compare " << l_val << " and " << r_val << " >>> Answer: ";
	int ans = -1;

	__asm
	{
		mov eax, l_val
		mov bx, ax
		shr eax, 16 // high 16 bit --> ax      low 16 bit --> bx

		mov edx, r_val
		mov cx, dx
		shr edx, 16 // high 16 bit --> dx     low 16 bit --> cx

		cmp ax, dx
		jb _smaller
		ja _bigger
		je _compareAgain

		_smaller:
		mov ans, 0
		jmp _retCompare

		_bigger:
		mov ans, 2
		jmp _retCompare

		_compareAgain:
		cmp bx, cx
		jb _smaller
		ja _bigger
		mov ans, 1


		_retCompare:
		nop
	}

	if (ans == 0)
	{
		std::cout << "\033[31m" << l_val << " < " << r_val << "\033[0m" << std::endl;
	}
	else if (ans == 1)
	{
		std::cout << "\033[31m" << l_val << " = " << r_val << "\033[0m" << std::endl;
	}
	else if (ans == 2)
	{
		std::cout << "\033[31m" << l_val << " > " << r_val << "\033[0m" << std::endl;
	}
	else
	{
		std::cout << "\033[31m---Error answer---\033[0m" << std::endl;
	}
	std::cout << std::endl;

}

// 9. 双字乘法 - Напишите фрагмент программы на ассемблере - умножение двух двойных слов.
void DDMultiplication(int l_val, int r_val)
{
	std::cout << "9. Напишите фрагмент программы на ассемблере - умножение двух двойных слов" << std::endl;
	int ans_1, ans_2;
	__asm
	{
		/*
		** multiplies DX:AX x CX:BX
		** returns 64 bit product in DX:AX:CX:BX
		*/
		mov edx, l_val
		mov ax, dx
		shr edx, 16

		mov ecx, r_val
		mov bx, cx
		shr ecx, 16

		mov      si, dx
		mov      di, ax
		mul      bx
		push     ax
		push     dx

		mov      ax, si
		mul      bx
		pop      bx
		add      ax, bx
		adc      dx, 0
		push     ax
		mov      bx, dx

		mov      ax, di
		mul      cx
		pop      di
		add      di, ax
		push     di
		mov      di, 0
		adc      bx, dx
		adc      di, 0

		mov      ax, si
		mul      cx
		add      ax, bx
		adc      dx, di
		pop      cx
		pop      bx

		// ** returns 64 bit product in DX:AX:CX:BX
		push ax
		push bx
		push cx
		push dx

		mov bx, dx
		shl ebx, 16
		mov bx, ax
		mov ans_1, ebx

		pop dx
		pop cx
		pop bx
		pop ax

		mov edx, 0
		mov dx, cx
		shl edx, 16
		mov dx, bx
		mov ans_2, edx
	}

	std::cout << "Пример >>> " << l_val << " * " << r_val << " = \033[31m" << ans_1 << ans_2 << "\033[0m" << std::endl;
	std::cout << std::endl;

}

int main()
{
	system("chcp 65001 && cls");
	printLine();

	arithmeticShift();
	printLine();

	logicalShift();
	printLine();

	circularShift();
	printLine();

	std::cout << "\033[34m 4 5 6 7 8 9 Реализовано с помощью двух 16-битных регистров\033[0m" << std::endl << std::endl << std::endl;

	DDIncremental();
	printLine();

	DDDescending();
	printLine();

	changeDDSign(12345678);
	changeDDSign(-87654321);
	printLine();

	DDAddition(1234, 4321);
	DDAddition(200003, 300007);
	printLine();

	DDComparison(654321, 111111);
	DDComparison(555555, 555555);
	DDComparison(123456, 545664);

	printLine();

	DDMultiplication(8, 9);
	DDMultiplication(12345, 2);
	DDMultiplication(53498, 19568);
	printLine();

	return 0;
}