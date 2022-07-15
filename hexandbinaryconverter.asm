format PE console
include 'win32ax.inc'
;=======================================
section '
.code' code readable executable
;=======================================
start:
 
cinvoke printf,"Enter an integer from 0-255: ", 10
 
cinvoke scanf,"%d", Num
 
call BinStep1
 
call HexStep1
 
cinvoke printf, "%c%c",10,10
 
jmp start
BinStep1:
 
cinvoke printf, "%cBin: ", 10
 
mov [Count], 0
 
mov EAX, [Num] ;Must go through register to move 2 vars
 
mov [Temp], Eax
BinStep2:
 
mov EAX, [Temp]
 
and EAX, 128
 
jnz BinStep4
BinStep3:
 
cinvoke printf, "0"
 
jmp BinStep5
BinStep4:
 
cinvoke printf, "1"
BinStep5:
 
shl [Temp], 1
BinStep6: inc [Count]
BinStep7: cmp [Count], 8
 
jnz BinStep2
 
ret
HexStep1:
 
cinvoke printf, "%cHex: ", 10
 
mov EAX, [Num]
 
mov [Temp], EAX
HexStep2:
 
shr [Temp], 4
 
call PrintHexDigit
HexStep5: mov EAX, [Num]
mov [Temp], EAX
HexStep6: AND [Temp], 15
call PrintHexDigit
 
ret
PrintHexDigit:
 
cmp [Temp], 9
 
jg GreaterThan9
 
cinvoke printf, "%d", [Temp]
 
ret
GreaterThan9:
 
add [Temp], 55
 
cinvoke printf, "%c", [Temp]
 
ret
;=======================================
section '
.data' data readable writeable
;=======================================
Num 
dd 0
Count dd 0
Temp 
dd 0
;====================================
section '
.idata' import data readable
;====================================
library msvcrt,
'msvcrt.dll',kernel32,
'kernel32.dll'
import msvcrt,printf,
'printf',scanf,
'scanf',getch,
'
_getch'
