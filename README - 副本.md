<p align="center">
 <img width="100px" src="https://github.com/NekoSilverFox/NekoSilverfox/blob/master/icons/silverfox.svg" align="center" alt="Assembly" />
 <h1 align="center">Assembly</h2>
 <p align="center"><b>⚡ 亲手编写基于王爽老师《汇编语言》的300个汇编程序例程</b></p>
</p>

<div align=center>

 [![License](https://img.shields.io/badge/license-Apache%202.0-brightgreen)](LICENSE)

<div align=left>

---

In this folder, I recorded notes and codes for learning assembly language in the summer vacation of 2020. :P

注：部分代码及练习基于王爽《汇编语言》第三版，具体题目及要求请见书中



文件夹编号说明：

其中，为了避免文件夹命名及编号混乱：【预留空位】指的是为以后复习或者相关新项目所预留出来的编号。

---

|      |      |
| ---- | ---- |
|      |      |
|      |      |
|      |      |
|      |      |
|      |      |
|      |      |
|      |      |
|      |      |
|      |      |
|      |      |
|      |      |
|      |      |
|      |      |
|      |      |
|      |      |
|      |      |
|      |      |
|      |      |
|      |      |
|      |      |
|      |      |
|      |      |
|      |      |
|      |      |
|      |      |
|      |      |
|      |      |
|      |      |
|      |      |

​		



​		



​	



​	



​	



​	



​	



​	



​	



​	



​	



 	



​	



​	



​	

​	



​	

​	



​	

​	



​	

​	



​	



​	

​	





​	





​	





​	

​	



​	

​	



​	



​	



​	



​	



​	



​	



​	



​	



​	



​	



​	



​	



​	



---

编程小技巧：
将ds与si配合使用
将es与di配合使用	<--- 虽然es和si可以配合使用，但是介于后面涉及的课程及指令，不建议使用 ds:di,、es:si ！！

在对程序分段时，如果遇到寄存器冲突，可以先将冲突的寄存器push到栈中，需要时再pop出来

如果合理的使用db, dw, dd ==> 看操作的寄存器，比如：操作的寄存器为16位，则应该用dw

如果参数过多，要处理的数据使用较多的寄存器，那么可以先将数据进行结构化处理再进行编写代码，这样可以更好的处理数据

将字符串显示在屏幕上（B800H）时，一定要注意将存放属性的高位字节写入数据，否则会造成无法显示
将字符串显示在屏幕上（B800H）时，先输出余数，在对ax中的商是否为零进行判断，否则会造成以零为结尾的数值无法显示

将int型数值转换为string字符串时，在进行除10取余时，每显示完一个字符，记得将储存高位字节的dx清零

在编写子程序时，可在程序开头处将程序中用到的寄存器进行push，在ret前再进行pop，这样就不用考虑是否会影响到程序外的寄存器（注意push和pop的顺序）
