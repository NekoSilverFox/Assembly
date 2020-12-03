// 参考资料：http ://c.biancheng.net/view/3826.html
#include <iostream>
#include <conio.h>
#include <float.h>

void commFADD()
{
    float a, b, c;

    std::cout << "Enter 3 (float) number:\n";
    std::cout << "A : "; std::cin >> a;
    std::cout << "B : "; std::cin >> b;
    std::cout << "C : "; std::cin >> c;
    std::cout << std::endl << a << " + " << b << " + " << c << " = ";
    __asm
    {
        /*
        * 9B DB E3 - FINIT
        * 检查未决的无掩码浮点异常之后初始化 FPU。C0、C1、C2、C3 清除为 0。（将 FPU 控制字设置为 037Fh，即屏蔽（隐藏）了所有浮点异常）
        * Инициализируйте FPU после проверки на наличие неразрешенных аномалий с плавающей точкой без маски
        *
        * DB E3 - FNINIT - 初始化 FPU，而不检查未决的无掩码浮点异常
        */
        finit

        /*
        * FLD（加载浮点数值）指令将浮点操作数复制到 FPU 堆栈栈顶（称为 ST(0)）。
        * 操作数可以是 32 位、64 位、80 位的内存操作数（REAL4、REAL8、REAL10）或另一个 FPU 寄存器：
        * FLD - Копирование операндов с плавающей точкой в верхнюю часть стека FPU (называется ST(0))
        */
        fld a       // ST(0) = a
        fld b       // ST(0) = b,  ST(1) = a  执行第二条 FLD 时，TOP 减 1，这使得之前标记为 ST(0) 的堆栈元素变为了 ST(1)。
        fadd       // 如果 FADD 没有操作数，则 ST(0)与 ST(1)相加，结果暂存在 ST(l)。然后 ST(0) 弹出堆栈，把加法结果保留在栈顶。
        fstp a     // FSTP（保存浮点值并将其出栈）指令将 ST(0) 的值复制到内存并将 ST(0) 弹出堆栈

        fld a
        fld c
        fadd
        fstp a
    }

    std::cout << a << std::endl << std::endl;
}


void commFDIV()
{
    float a = 5;
    float b = 0;
    int ctrl = 0x027B;  // 0000 0010 0111 1011

    std::cout << a << " /  " << b << " = ";
    //short dd;
    __asm
    {
        finit
        fstcw ctrl

        and ctrl, 0xffb  // 0000 1111e 1111e 1011b

        fldcw ctrl // 屏蔽浮点异常 - Аномалия плавающей точки щита

        fld a
        fld b
        fdiv
        fstp a
    }

    std::cout << a << std::endl << std::endl;
}

void main()
{
    system("chcp 65001 && cls");

    //commFADD();
    std::cout << "==================================" << std::endl;
    std::cout << ">>> Div on 0 :" << std::endl;
    commFDIV();
}