
;CodeVisionAVR C Compiler V3.12 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega128
;Program type           : Application
;Clock frequency        : 7.372800 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 1024 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega128
	#pragma AVRPART MEMORY PROG_FLASH 131072
	#pragma AVRPART MEMORY EEPROM 4096
	#pragma AVRPART MEMORY INT_SRAM SIZE 4096
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x100

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU RAMPZ=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU XMCRA=0x6D
	.EQU XMCRB=0x6C

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0100
	.EQU __SRAM_END=0x10FF
	.EQU __DSTACK_SIZE=0x0400
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _B_position=R4
	.DEF _B_position_msb=R5
	.DEF _R_position=R6
	.DEF _R_position_msb=R7
	.DEF _key=R9
	.DEF _i=R10
	.DEF _i_msb=R11
	.DEF _j=R12
	.DEF _j_msb=R13
	.DEF __lcd_x=R8

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

;REGISTER BIT VARIABLES INITIALIZATION
__REG_BIT_VARS:
	.DW  0x0000

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0,0x0,0x0,0x0

_0x4DA:
	.DB  0x1F,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x1F,0x0,0x1F,0x0,0x0,0x0,0x0,0x0
	.DB  0x1F,0x0,0x1F,0x0,0x1F,0x0,0x0,0x0
	.DB  0x1F,0x0,0x1F,0x0,0x1F,0x0,0x1F,0x0
	.DB  0x1F,0x11,0x1F,0x0,0x4,0x4,0x1F
_0x4DB:
	.DB  0x1E,0x11,0x11,0x1E,0x11,0x11,0x1E,0x0
	.DB  0x10,0x10,0x10,0x10,0x10,0x10,0x1F,0x0
	.DB  0x11,0x11,0x11,0x11,0x11,0x11,0xE,0x0
	.DB  0x1F,0x10,0x10,0x1F,0x10,0x10,0x1F,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x15,0x15,0x15,0x15,0x15,0x1F,0xA,0x0
	.DB  0xE,0x4,0x4,0x4,0x4,0x4,0xE,0x0
	.DB  0x11,0x19,0x19,0x15,0x13,0x13,0x11
_0x4DC:
	.DB  0x1E,0x11,0x11,0x1E,0x14,0x12,0x11,0x0
	.DB  0x1F,0x10,0x10,0x1F,0x10,0x10,0x1F,0x0
	.DB  0x1E,0x11,0x11,0x11,0x11,0x13,0x1E,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x15,0x15,0x15,0x15,0x15,0x1F,0xA,0x0
	.DB  0xE,0x4,0x4,0x4,0x4,0x4,0xE,0x0
	.DB  0x11,0x19,0x19,0x15,0x13,0x13,0x11
_0x2020060:
	.DB  0x1
_0x2020000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0
_0x2040003:
	.DB  0x80,0xC0

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  0x02
	.DW  __REG_BIT_VARS*2

	.DW  0x04
	.DW  0x04
	.DW  __REG_VARS*2

	.DW  0x27
	.DW  _user_font1
	.DW  _0x4DA*2

	.DW  0x3F
	.DW  _blue_win
	.DW  _0x4DB*2

	.DW  0x3F
	.DW  _red_win
	.DW  _0x4DC*2

	.DW  0x01
	.DW  __seed_G101
	.DW  _0x2020060*2

	.DW  0x02
	.DW  __base_y_G102
	.DW  _0x2040003*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30
	STS  XMCRB,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,LOW(__SRAM_START)
	LDI  R27,HIGH(__SRAM_START)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

	OUT  RAMPZ,R24

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x500

	.CSEG
;#include <mega128.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif
;#include <delay.h>
;#include <stdio.h>
;#include <stdlib.h>
;#include <alcd.h>
;
;#define button PINC.0
;
;int B_position = 0, R_position = 0;
;
;#include "./library/Ygoal.c"
;#ifndef _Ygoal_
;#define _Ygoal_
;
;int goal(int B_position, int R_position)
; 0000 000B {

	.CSEG
_goal:
; .FSTART _goal
;   int goal = 0;
;
;   if(B_position > 44 || (B_position > 20 && B_position < 30))
	CALL SUBOPT_0x0
;	B_position -> Y+4
;	R_position -> Y+2
;	goal -> R16,R17
	SBIW R26,45
	BRGE _0x4
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	SBIW R26,21
	BRLT _0x5
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	SBIW R26,30
	BRLT _0x4
_0x5:
	RJMP _0x3
_0x4:
;   {
;      goal = 1;
	__GETWRN 16,17,1
;      PORTA.0 = 1;
	CALL SUBOPT_0x1
;      PORTA.1 = 1;
;      PORTA.2 = 1;
;      PORTA.3 = 1;
;      PORTA.4 = 1;
;      PORTA.5 = 1;
;      PORTA.6 = 1;
;      PORTA.7 = 1;
;   }
;   if(R_position > 44 || (R_position > 20 && R_position < 30))
_0x3:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,45
	BRGE _0x19
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,21
	BRLT _0x1A
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,30
	BRLT _0x19
_0x1A:
	RJMP _0x18
_0x19:
;   {
;      goal = 2;
	__GETWRN 16,17,2
;      PORTB.0 = 1;
	CALL SUBOPT_0x2
;      PORTB.1 = 1;
;      PORTB.2 = 1;
;      PORTB.3 = 1;
;      PORTB.4 = 1;
;      PORTB.5 = 1;
;      PORTB.6 = 1;
;      PORTB.7 = 1;
;   }
;   return goal;
_0x18:
	RJMP _0x20C0004
;}
; .FEND
;#endif
;#include "./library/throw.c"
;#ifndef _throw_
;#define _throw_
;
;int throw_once_more(int overlap, int yoot)
; 0000 000C {
_throw_once_more:
; .FSTART _throw_once_more
;   int more = 0;
;
;   if(overlap == 1)
	CALL SUBOPT_0x0
;	overlap -> Y+4
;	yoot -> Y+2
;	more -> R16,R17
	SBIW R26,1
	BREQ _0x54C
;   {
;      more++;
;   }
;   else if(yoot == 4 || yoot == 5)
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,4
	BREQ _0x30
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,5
	BRNE _0x2F
_0x30:
;   {
;      more++;
_0x54C:
	__ADDWRN 16,17,1
;   }
;
;   return more;
_0x2F:
	RJMP _0x20C0004
;}
; .FEND
;#endif
;#include "./library/Ycount.c"
;#ifndef _Ycount_
;#define _Ycount_
;
;int count()
; 0000 000D {
_count:
; .FSTART _count
	PUSH R15
;   int cnt = 0;
;   int time = 0;
;   bit yoot_array1;
;   bit yoot_array2;
;   bit yoot_array3;
;   bit yoot_array4;
;
;   while(1)
	CALL __SAVELOCR4
;	cnt -> R16,R17
;	time -> R18,R19
;	yoot_array1 -> R15.0
;	yoot_array2 -> R15.1
;	yoot_array3 -> R15.2
;	yoot_array4 -> R15.3
	__GETWRN 16,17,0
	__GETWRN 18,19,0
_0x32:
;   {
;      if((PINC & 0x01) != 0x01)
	IN   R30,0x13
	ANDI R30,LOW(0x1)
	CPI  R30,LOW(0x1)
	BRNE _0x34
;         break;
;      time++;
	__ADDWRN 18,19,1
;   }
	RJMP _0x32
_0x34:
;
;   srand(time);
	MOVW R26,R18
	CALL _srand
;
;   yoot_array1 = rand()%2;
	CALL SUBOPT_0x3
	BLD  R15,0
;   delay_ms(1);
	CALL SUBOPT_0x4
;   yoot_array2 = rand()%2;
	BLD  R15,1
;   delay_ms(1);
	CALL SUBOPT_0x4
;   yoot_array3 = rand()%2;
	BLD  R15,2
;   delay_ms(1);
	CALL SUBOPT_0x4
;   yoot_array4 = rand()%2;
	BLD  R15,3
;
;   cnt = yoot_array1 + yoot_array2 + yoot_array3 + yoot_array4;
	LDI  R30,0
	SBRC R15,0
	LDI  R30,1
	LDI  R31,0
	MOVW R26,R30
	LDI  R30,0
	SBRC R15,1
	LDI  R30,1
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	LDI  R30,0
	SBRC R15,2
	LDI  R30,1
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	LDI  R30,0
	SBRC R15,3
	LDI  R30,1
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	MOVW R16,R30
;
;   return cnt;
	CALL __LOADLOCR4
	ADIW R28,4
	POP  R15
	RET
;}
; .FEND
;#endif
;#include "./library/key.c"
;#ifndef _key_
;#define _key_
;
;unsigned char key;
;bit key_flag = 0;
;
;char key_in(void)
; 0000 000E {
_key_in:
; .FSTART _key_in
;    char buf = 0;
;
;    if((PINC & 0x01) != 0x01)
	ST   -Y,R17
;	buf -> R17
	LDI  R17,0
	IN   R30,0x13
	ANDI R30,LOW(0x1)
	CPI  R30,LOW(0x1)
	BREQ _0x36
;    {
;       //key in ok
;        buf = (PINC & 0x01);
	IN   R30,0x13
	ANDI R30,LOW(0x1)
	MOV  R17,R30
;        key_flag = 1;
	SET
	BLD  R2,0
;
;        while((PINC & 0x01) != 0x01)
_0x37:
	IN   R30,0x13
	ANDI R30,LOW(0x1)
	CPI  R30,LOW(0x1)
	BREQ _0x39
;        {
;             delay_ms(1);
	LDI  R26,LOW(1)
	LDI  R27,0
	CALL _delay_ms
;        }
	RJMP _0x37
_0x39:
;        delay_ms(2);
	LDI  R26,LOW(2)
	LDI  R27,0
	CALL _delay_ms
;    }
;
;    return buf;
_0x36:
	MOV  R30,R17
	LD   R17,Y+
	RET
;}
; .FEND
;
;void key_chk(void)
;{
_key_chk:
; .FSTART _key_chk
;    key_flag = 0;
	CLT
	BLD  R2,0
;
;    switch(key)
	MOV  R30,R9
	LDI  R31,0
;    {
;        case 0x01:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x3C
;            count();
	RCALL _count
;        break;
;    }
_0x3C:
;}
	RET
; .FEND
;#endif
;#include "./library/loc.c"
;#ifndef _loc_
;#define _loc_
;
;int location(int yoot,int slot)
; 0000 000F {
_location:
; .FSTART _location
;   int l_slot = 0;
;
;   if(slot == 5)//말길1
	CALL SUBOPT_0x5
;	yoot -> Y+4
;	slot -> Y+2
;	l_slot -> R16,R17
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,5
	BRNE _0x3E
;   {
;      l_slot = slot + yoot + 25;
	CALL SUBOPT_0x6
	ADIW R30,25
	RJMP _0x54D
;   }
;
;   else if(slot == 10)//말길2
_0x3E:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,10
	BRNE _0x40
;   {
;      if(yoot == 3)
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	SBIW R26,3
	BRNE _0x41
;      {
;         l_slot = 33;
	__GETWRN 16,17,33
;      }
;      else
	RJMP _0x42
_0x41:
;         l_slot = slot + yoot + 30;
	CALL SUBOPT_0x6
	ADIW R30,30
	MOVW R16,R30
;   }
_0x42:
;   else if(slot == 41 || slot == 42)
	RJMP _0x43
_0x40:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,41
	BREQ _0x45
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,42
	BRNE _0x44
_0x45:
;   {
;      if(slot + yoot == 43)
	CALL SUBOPT_0x7
	SBIW R26,43
	BRNE _0x47
;      {
;         l_slot = 33;
	__GETWRN 16,17,33
;      }
;      if(slot == 41 && yoot == 1)
_0x47:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,41
	BRNE _0x49
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	SBIW R26,1
	BREQ _0x4A
_0x49:
	RJMP _0x48
_0x4A:
;      {
;        l_slot = 42;
	__GETWRN 16,17,42
;      }
;      else
	RJMP _0x4B
_0x48:
;         l_slot = slot + yoot - 1;
	CALL SUBOPT_0x7
	SBIW R26,1
	MOVW R16,R26
;   }
_0x4B:
;
;   else if(slot == 33)//말길 중앙
	RJMP _0x4C
_0x44:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,33
	BRNE _0x4D
;   {
;      l_slot = slot + yoot + 9;
	CALL SUBOPT_0x6
	ADIW R30,9
	RJMP _0x54D
;   }
;   else if(slot >= 31 && slot <= 35)
_0x4D:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,31
	BRLT _0x50
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,36
	BRLT _0x51
_0x50:
	RJMP _0x4F
_0x51:
;   {
;      if(slot + yoot > 35)
	CALL SUBOPT_0x7
	SBIW R26,36
	BRLT _0x52
;      {
;         l_slot = slot + yoot - 20;
	CALL SUBOPT_0x7
	SBIW R26,20
	MOVW R16,R26
;      }
;      else
	RJMP _0x53
_0x52:
;         l_slot = slot + yoot;
	CALL SUBOPT_0x6
	MOVW R16,R30
;   }
_0x53:
;
;   else
	RJMP _0x54
_0x4F:
;      l_slot = slot + yoot; //슬롯 연산 끝
	CALL SUBOPT_0x6
_0x54D:
	MOVW R16,R30
;
;   return l_slot;
_0x54:
_0x4C:
_0x43:
	RJMP _0x20C0004
;}
; .FEND
;#endif
;#include "./library/loc2.c"
;#ifndef _loc2_
;#define _loc2_
;
;int location2(int yoot,int slot, int o_slot)
; 0000 0010 {
_location2:
; .FSTART _location2
;   int l_slot = 0;
;
;   if(slot == 42)
	CALL SUBOPT_0x0
;	yoot -> Y+6
;	slot -> Y+4
;	o_slot -> Y+2
;	l_slot -> R16,R17
	SBIW R26,42
	BRNE _0x55
;   {
;      l_slot = 33;
	__GETWRN 16,17,33
;   }
;
;   else if(slot == 33)  // 말길 중앙
	RJMP _0x56
_0x55:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	SBIW R26,33
	BRNE _0x57
;   {
;      if(o_slot == 5 || o_slot == 31 || o_slot == 32)
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,5
	BREQ _0x59
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,31
	BREQ _0x59
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,32
	BRNE _0x58
_0x59:
;        l_slot = 34;
	__GETWRN 16,17,34
;      else
	RJMP _0x5B
_0x58:
;        l_slot = 43;
	__GETWRN 16,17,43
;   }
_0x5B:
;
;   else
	RJMP _0x5C
_0x57:
;    l_slot = slot + yoot;  //슬롯 연산 끝
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ADD  R30,R26
	ADC  R31,R27
	MOVW R16,R30
;
;   return l_slot;
_0x5C:
_0x56:
	MOVW R30,R16
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,8
	RET
;}
; .FEND
;#endif
;#include "./library/Ystep.c"
;#ifndef _Ystep_
;#define _Ystep_
;
;void step(int B_slot,int R_slot)
; 0000 0011 {
_step:
; .FSTART _step
;   switch(B_slot)
	ST   -Y,R27
	ST   -Y,R26
;	B_slot -> Y+2
;	R_slot -> Y+0
	LDD  R30,Y+2
	LDD  R31,Y+2+1
;   {
;      case 0 :
	SBIW R30,0
	BRNE _0x60
;         PORTA.0 = 1;
	CALL SUBOPT_0x1
;         PORTA.1 = 1;
;         PORTA.2 = 1;
;         PORTA.3 = 1;
;         PORTA.4 = 1;
;         PORTA.5 = 1;
;         PORTA.6 = 1;
;         PORTA.7 = 1;
;         PORTC.3 = 0;
	CBI  0x15,3
;         break;
	RJMP _0x5F
;      case 1 :
_0x60:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x73
;         PORTA.0 = 0;
	CBI  0x1B,0
;         PORTA.1 = 0;
	CALL SUBOPT_0x8
;         PORTA.2 = 0;
;         PORTA.3 = 0;
;         PORTA.4 = 1;
;         PORTA.5 = 1;
;         PORTA.6 = 1;
;         PORTA.7 = 1;
;         PORTC.3 = 1;
;         break;
	RJMP _0x5F
;      case 2 :
_0x73:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x86
;         PORTA.0 = 1;
	SBI  0x1B,0
;         PORTA.1 = 0;
	CALL SUBOPT_0x8
;         PORTA.2 = 0;
;         PORTA.3 = 0;
;         PORTA.4 = 1;
;         PORTA.5 = 1;
;         PORTA.6 = 1;
;         PORTA.7 = 1;
;         PORTC.3 = 1;
;         break;
	RJMP _0x5F
;      case 3 :
_0x86:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x99
;         PORTA.0 = 0;
	CBI  0x1B,0
;         PORTA.1 = 1;
	CALL SUBOPT_0x9
;         PORTA.2 = 0;
;         PORTA.3 = 0;
;         PORTA.4 = 1;
;         PORTA.5 = 1;
;         PORTA.6 = 1;
;         PORTA.7 = 1;
;         PORTC.3 = 1;
;         break;
	RJMP _0x5F
;      case 4 :
_0x99:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0xAC
;         PORTA.0 = 1;
	SBI  0x1B,0
;         PORTA.1 = 1;
	CALL SUBOPT_0x9
;         PORTA.2 = 0;
;         PORTA.3 = 0;
;         PORTA.4 = 1;
;         PORTA.5 = 1;
;         PORTA.6 = 1;
;         PORTA.7 = 1;
;         PORTC.3 = 1;
;         break;
	RJMP _0x5F
;      case 5 :
_0xAC:
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0xBF
;         PORTA.0 = 0;
	CBI  0x1B,0
;         PORTA.1 = 0;
	CALL SUBOPT_0xA
;         PORTA.2 = 1;
;         PORTA.3 = 0;
;         PORTA.4 = 1;
;         PORTA.5 = 1;
;         PORTA.6 = 1;
;         PORTA.7 = 1;
;         PORTC.3 = 1;
;         break;
	RJMP _0x5F
;         //1줄 끝
;
;      case 6 :
_0xBF:
	CPI  R30,LOW(0x6)
	LDI  R26,HIGH(0x6)
	CPC  R31,R26
	BRNE _0xD2
;         PORTA.0 = 1;
	SBI  0x1B,0
;         PORTA.1 = 0;
	CALL SUBOPT_0xA
;         PORTA.2 = 1;
;         PORTA.3 = 0;
;         PORTA.4 = 1;
;         PORTA.5 = 1;
;         PORTA.6 = 1;
;         PORTA.7 = 1;
;         PORTC.3 = 1;
;         break;
	RJMP _0x5F
;      case 7 :
_0xD2:
	CPI  R30,LOW(0x7)
	LDI  R26,HIGH(0x7)
	CPC  R31,R26
	BRNE _0xE5
;         PORTA.0 = 0;
	CBI  0x1B,0
;         PORTA.1 = 1;
	CALL SUBOPT_0xB
;         PORTA.2 = 1;
;         PORTA.3 = 0;
;         PORTA.4 = 1;
;         PORTA.5 = 1;
;         PORTA.6 = 1;
;         PORTA.7 = 1;
;         PORTC.3 = 1;
;         break;
	RJMP _0x5F
;      case 8 :
_0xE5:
	CPI  R30,LOW(0x8)
	LDI  R26,HIGH(0x8)
	CPC  R31,R26
	BRNE _0xF8
;         PORTA.0 = 1;
	SBI  0x1B,0
;         PORTA.1 = 1;
	CALL SUBOPT_0xB
;         PORTA.2 = 1;
;         PORTA.3 = 0;
;         PORTA.4 = 1;
;         PORTA.5 = 1;
;         PORTA.6 = 1;
;         PORTA.7 = 1;
;         PORTC.3 = 1;
;         break;
	RJMP _0x5F
;      case 9 :
_0xF8:
	CPI  R30,LOW(0x9)
	LDI  R26,HIGH(0x9)
	CPC  R31,R26
	BRNE _0x10B
;         PORTA.0 = 0;
	CBI  0x1B,0
;         PORTA.1 = 0;
	CALL SUBOPT_0xC
;         PORTA.2 = 0;
;         PORTA.3 = 1;
;         PORTA.4 = 1;
;         PORTA.5 = 1;
;         PORTA.6 = 1;
;         PORTA.7 = 1;
;         PORTC.3 = 1;
;         break;
	RJMP _0x5F
;      case 10 :
_0x10B:
	CPI  R30,LOW(0xA)
	LDI  R26,HIGH(0xA)
	CPC  R31,R26
	BRNE _0x11E
;         PORTA.0 = 1;
	SBI  0x1B,0
;         PORTA.1 = 0;
	CALL SUBOPT_0xC
;         PORTA.2 = 0;
;         PORTA.3 = 1;
;         PORTA.4 = 1;
;         PORTA.5 = 1;
;         PORTA.6 = 1;
;         PORTA.7 = 1;
;         PORTC.3 = 1;
;         break;
	RJMP _0x5F
;            //2줄끝
;
;      case 11 :
_0x11E:
	CPI  R30,LOW(0xB)
	LDI  R26,HIGH(0xB)
	CPC  R31,R26
	BRNE _0x131
;         PORTA.0 = 0;
	CBI  0x1B,0
;         PORTA.1 = 1;
	CALL SUBOPT_0xD
;         PORTA.2 = 0;
;         PORTA.3 = 1;
;         PORTA.4 = 1;
;         PORTA.5 = 1;
;         PORTA.6 = 1;
;         PORTA.7 = 1;
;         PORTC.3 = 1;
;         break;
	RJMP _0x5F
;      case 12 :
_0x131:
	CPI  R30,LOW(0xC)
	LDI  R26,HIGH(0xC)
	CPC  R31,R26
	BRNE _0x144
;         PORTA.0 = 1;
	SBI  0x1B,0
;         PORTA.1 = 1;
	CALL SUBOPT_0xD
;         PORTA.2 = 0;
;         PORTA.3 = 1;
;         PORTA.4 = 1;
;         PORTA.5 = 1;
;         PORTA.6 = 1;
;         PORTA.7 = 1;
;         PORTC.3 = 1;
;         break;
	RJMP _0x5F
;      case 13 :
_0x144:
	CPI  R30,LOW(0xD)
	LDI  R26,HIGH(0xD)
	CPC  R31,R26
	BRNE _0x157
;         PORTA.0 = 0;
	CBI  0x1B,0
;         PORTA.1 = 0;
	CALL SUBOPT_0xE
;         PORTA.2 = 1;
;         PORTA.3 = 1;
;         PORTA.4 = 1;
;         PORTA.5 = 1;
;         PORTA.6 = 1;
;         PORTA.7 = 1;
;         PORTC.3 = 1;
;         break;
	RJMP _0x5F
;      case 14 :
_0x157:
	CPI  R30,LOW(0xE)
	LDI  R26,HIGH(0xE)
	CPC  R31,R26
	BRNE _0x16A
;         PORTA.0 = 1;
	SBI  0x1B,0
;         PORTA.1 = 0;
	CALL SUBOPT_0xE
;         PORTA.2 = 1;
;         PORTA.3 = 1;
;         PORTA.4 = 1;
;         PORTA.5 = 1;
;         PORTA.6 = 1;
;         PORTA.7 = 1;
;         PORTC.3 = 1;
;         break;
	RJMP _0x5F
;      case 15 :
_0x16A:
	CPI  R30,LOW(0xF)
	LDI  R26,HIGH(0xF)
	CPC  R31,R26
	BRNE _0x17D
;         PORTA.0 = 0;
	CBI  0x1B,0
;         PORTA.1 = 1;
	CALL SUBOPT_0xF
;         PORTA.2 = 1;
;         PORTA.3 = 1;
;         PORTA.4 = 1;
;         PORTA.5 = 1;
	SBI  0x1B,5
;         PORTA.6 = 1;
	SBI  0x1B,6
;         PORTA.7 = 1;
	SBI  0x1B,7
;         PORTC.3 = 1;
	SBI  0x15,3
;         break;
	RJMP _0x5F
;         //3줄끝
;
;      case 16 :
_0x17D:
	CPI  R30,LOW(0x10)
	LDI  R26,HIGH(0x10)
	CPC  R31,R26
	BRNE _0x190
;         PORTA.0 = 1;
	CALL SUBOPT_0x10
;         PORTA.1 = 1;
;         PORTA.2 = 1;
;         PORTA.3 = 1;
;         PORTA.4 = 0;
;         PORTA.5 = 0;
	CBI  0x1B,5
;         PORTA.6 = 0;
	CBI  0x1B,6
;         PORTA.7 = 0;
	CBI  0x1B,7
;         PORTC.3 = 1;
	SBI  0x15,3
;         break;
	RJMP _0x5F
;      case 17 :
_0x190:
	CPI  R30,LOW(0x11)
	LDI  R26,HIGH(0x11)
	CPC  R31,R26
	BRNE _0x1A3
;         PORTA.0 = 1;
	SBI  0x1B,0
;         PORTA.1 = 1;
	CALL SUBOPT_0xF
;         PORTA.2 = 1;
;         PORTA.3 = 1;
;         PORTA.4 = 1;
;         PORTA.5 = 0;
	CBI  0x1B,5
;         PORTA.6 = 0;
	CBI  0x1B,6
;         PORTA.7 = 0;
	CBI  0x1B,7
;         PORTC.3 = 1;
	SBI  0x15,3
;         break;
	RJMP _0x5F
;      case 18 :
_0x1A3:
	CPI  R30,LOW(0x12)
	LDI  R26,HIGH(0x12)
	CPC  R31,R26
	BRNE _0x1B6
;         PORTA.0 = 1;
	CALL SUBOPT_0x10
;         PORTA.1 = 1;
;         PORTA.2 = 1;
;         PORTA.3 = 1;
;         PORTA.4 = 0;
;         PORTA.5 = 1;
	SBI  0x1B,5
;         PORTA.6 = 0;
	CBI  0x1B,6
;         PORTA.7 = 0;
	CBI  0x1B,7
;         PORTC.3 = 1;
	SBI  0x15,3
;         break;
	RJMP _0x5F
;      case 19 :
_0x1B6:
	CPI  R30,LOW(0x13)
	LDI  R26,HIGH(0x13)
	CPC  R31,R26
	BRNE _0x1C9
;         PORTA.0 = 1;
	SBI  0x1B,0
;         PORTA.1 = 1;
	CALL SUBOPT_0xF
;         PORTA.2 = 1;
;         PORTA.3 = 1;
;         PORTA.4 = 1;
;         PORTA.5 = 1;
	SBI  0x1B,5
;         PORTA.6 = 0;
	CBI  0x1B,6
;         PORTA.7 = 0;
	CBI  0x1B,7
;         PORTC.3 = 1;
	SBI  0x15,3
;         break;
	RJMP _0x5F
;      case 20 :
_0x1C9:
	CPI  R30,LOW(0x14)
	LDI  R26,HIGH(0x14)
	CPC  R31,R26
	BRNE _0x1DC
;         PORTA.0 = 1;
	CALL SUBOPT_0x10
;         PORTA.1 = 1;
;         PORTA.2 = 1;
;         PORTA.3 = 1;
;         PORTA.4 = 0;
;         PORTA.5 = 0;
	CBI  0x1B,5
;         PORTA.6 = 1;
	SBI  0x1B,6
;         PORTA.7 = 0;
	CBI  0x1B,7
;         PORTC.3 = 1;
	SBI  0x15,3
;         break;
	RJMP _0x5F
;         //4줄끝
;
;      case 31 :
_0x1DC:
	CPI  R30,LOW(0x1F)
	LDI  R26,HIGH(0x1F)
	CPC  R31,R26
	BRNE _0x1EF
;         PORTA.0 = 1;
	SBI  0x1B,0
;         PORTA.1 = 1;
	CALL SUBOPT_0xF
;         PORTA.2 = 1;
;         PORTA.3 = 1;
;         PORTA.4 = 1;
;         PORTA.5 = 0;
	CBI  0x1B,5
;         PORTA.6 = 1;
	SBI  0x1B,6
;         PORTA.7 = 0;
	CBI  0x1B,7
;         PORTC.3 = 1;
	SBI  0x15,3
;         break;
	RJMP _0x5F
;      case 32 :
_0x1EF:
	CPI  R30,LOW(0x20)
	LDI  R26,HIGH(0x20)
	CPC  R31,R26
	BRNE _0x202
;         PORTA.0 = 1;
	CALL SUBOPT_0x10
;         PORTA.1 = 1;
;         PORTA.2 = 1;
;         PORTA.3 = 1;
;         PORTA.4 = 0;
;         PORTA.5 = 1;
	SBI  0x1B,5
;         PORTA.6 = 1;
	SBI  0x1B,6
;         PORTA.7 = 0;
	CBI  0x1B,7
;         PORTC.3 = 1;
	SBI  0x15,3
;         break;
	RJMP _0x5F
;      case 33 :
_0x202:
	CPI  R30,LOW(0x21)
	LDI  R26,HIGH(0x21)
	CPC  R31,R26
	BRNE _0x215
;         PORTA.0 = 1;
	SBI  0x1B,0
;         PORTA.1 = 1;
	CALL SUBOPT_0xF
;         PORTA.2 = 1;
;         PORTA.3 = 1;
;         PORTA.4 = 1;
;         PORTA.5 = 1;
	SBI  0x1B,5
;         PORTA.6 = 1;
	SBI  0x1B,6
;         PORTA.7 = 0;
	CBI  0x1B,7
;         PORTC.3 = 1;
	SBI  0x15,3
;         break;
	RJMP _0x5F
;      case 34 :
_0x215:
	CPI  R30,LOW(0x22)
	LDI  R26,HIGH(0x22)
	CPC  R31,R26
	BRNE _0x228
;         PORTA.0 = 1;
	CALL SUBOPT_0x10
;         PORTA.1 = 1;
;         PORTA.2 = 1;
;         PORTA.3 = 1;
;         PORTA.4 = 0;
;         PORTA.5 = 0;
	CBI  0x1B,5
;         PORTA.6 = 0;
	CBI  0x1B,6
;         PORTA.7 = 1;
	SBI  0x1B,7
;         PORTC.3 = 1;
	SBI  0x15,3
;         break;
	RJMP _0x5F
;      case 35 :
_0x228:
	CPI  R30,LOW(0x23)
	LDI  R26,HIGH(0x23)
	CPC  R31,R26
	BRNE _0x23B
;         PORTA.0 = 1;
	SBI  0x1B,0
;         PORTA.1 = 1;
	CALL SUBOPT_0xF
;         PORTA.2 = 1;
;         PORTA.3 = 1;
;         PORTA.4 = 1;
;         PORTA.5 = 0;
	CBI  0x1B,5
;         PORTA.6 = 0;
	CBI  0x1B,6
;         PORTA.7 = 1;
	SBI  0x1B,7
;         PORTC.3 = 1;
	SBI  0x15,3
;         break;
	RJMP _0x5F
;         //5줄끝
;
;      case 41 :
_0x23B:
	CPI  R30,LOW(0x29)
	LDI  R26,HIGH(0x29)
	CPC  R31,R26
	BRNE _0x24E
;         PORTA.0 = 1;
	CALL SUBOPT_0x10
;         PORTA.1 = 1;
;         PORTA.2 = 1;
;         PORTA.3 = 1;
;         PORTA.4 = 0;
;         PORTA.5 = 1;
	SBI  0x1B,5
;         PORTA.6 = 0;
	CBI  0x1B,6
;         PORTA.7 = 1;
	SBI  0x1B,7
;         PORTC.3 = 1;
	SBI  0x15,3
;         break;
	RJMP _0x5F
;      case 42 :
_0x24E:
	CPI  R30,LOW(0x2A)
	LDI  R26,HIGH(0x2A)
	CPC  R31,R26
	BRNE _0x261
;         PORTA.0 = 1;
	SBI  0x1B,0
;         PORTA.1 = 1;
	CALL SUBOPT_0xF
;         PORTA.2 = 1;
;         PORTA.3 = 1;
;         PORTA.4 = 1;
;         PORTA.5 = 1;
	SBI  0x1B,5
;         PORTA.6 = 0;
	CBI  0x1B,6
;         PORTA.7 = 1;
	SBI  0x1B,7
;         PORTC.3 = 1;
	SBI  0x15,3
;         break;
	RJMP _0x5F
;      case 43 :
_0x261:
	CPI  R30,LOW(0x2B)
	LDI  R26,HIGH(0x2B)
	CPC  R31,R26
	BRNE _0x274
;         PORTA.0 = 1;
	CALL SUBOPT_0x10
;         PORTA.1 = 1;
;         PORTA.2 = 1;
;         PORTA.3 = 1;
;         PORTA.4 = 0;
;         PORTA.5 = 0;
	CBI  0x1B,5
;         PORTA.6 = 1;
	SBI  0x1B,6
;         PORTA.7 = 1;
	SBI  0x1B,7
;         PORTC.3 = 1;
	SBI  0x15,3
;         break;
	RJMP _0x5F
;      case 44 :
_0x274:
	CPI  R30,LOW(0x2C)
	LDI  R26,HIGH(0x2C)
	CPC  R31,R26
	BRNE _0x29A
;         PORTA.0 = 1;
	SBI  0x1B,0
;         PORTA.1 = 1;
	CALL SUBOPT_0xF
;         PORTA.2 = 1;
;         PORTA.3 = 1;
;         PORTA.4 = 1;
;         PORTA.5 = 0;
	CBI  0x1B,5
;         PORTA.6 = 1;
	SBI  0x1B,6
;         PORTA.7 = 1;
	SBI  0x1B,7
;         PORTC.3 = 1;
	SBI  0x15,3
;         break;
;            //6줄끝
;      default :
_0x29A:
;         break;
;   }
_0x5F:
;
;   switch(R_slot)
	LD   R30,Y
	LDD  R31,Y+1
;   {
;      case 0 :
	SBIW R30,0
	BRNE _0x29E
;         PORTB.0 = 1;
	CALL SUBOPT_0x2
;         PORTB.1 = 1;
;         PORTB.2 = 1;
;         PORTB.3 = 1;
;         PORTB.4 = 1;
;         PORTB.5 = 1;
;         PORTB.6 = 1;
;         PORTB.7 = 1;
;         PORTC.4 = 0;
	CBI  0x15,4
;         break;
	RJMP _0x29D
;      case 1 :
_0x29E:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x2B1
;         PORTB.0 = 0;
	CBI  0x18,0
;         PORTB.1 = 0;
	CALL SUBOPT_0x11
;         PORTB.2 = 0;
;         PORTB.3 = 0;
;         PORTB.4 = 1;
;         PORTB.5 = 1;
;         PORTB.6 = 1;
;         PORTB.7 = 1;
;         PORTC.4 = 1;
;         break;
	RJMP _0x29D
;      case 2 :
_0x2B1:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x2C4
;         PORTB.0 = 1;
	SBI  0x18,0
;         PORTB.1 = 0;
	CALL SUBOPT_0x11
;         PORTB.2 = 0;
;         PORTB.3 = 0;
;         PORTB.4 = 1;
;         PORTB.5 = 1;
;         PORTB.6 = 1;
;         PORTB.7 = 1;
;         PORTC.4 = 1;
;         break;
	RJMP _0x29D
;      case 3 :
_0x2C4:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x2D7
;         PORTB.0 = 0;
	CBI  0x18,0
;         PORTB.1 = 1;
	CALL SUBOPT_0x12
;         PORTB.2 = 0;
;         PORTB.3 = 0;
;         PORTB.4 = 1;
;         PORTB.5 = 1;
;         PORTB.6 = 1;
;         PORTB.7 = 1;
;         PORTC.4 = 1;
;         break;
	RJMP _0x29D
;      case 4 :
_0x2D7:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x2EA
;         PORTB.0 = 1;
	SBI  0x18,0
;         PORTB.1 = 1;
	CALL SUBOPT_0x12
;         PORTB.2 = 0;
;         PORTB.3 = 0;
;         PORTB.4 = 1;
;         PORTB.5 = 1;
;         PORTB.6 = 1;
;         PORTB.7 = 1;
;         PORTC.4 = 1;
;         break;
	RJMP _0x29D
;      case 5 :
_0x2EA:
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0x2FD
;         PORTB.0 = 0;
	CBI  0x18,0
;         PORTB.1 = 0;
	CALL SUBOPT_0x13
;         PORTB.2 = 1;
;         PORTB.3 = 0;
;         PORTB.4 = 1;
;         PORTB.5 = 1;
;         PORTB.6 = 1;
;         PORTB.7 = 1;
;         PORTC.4 = 1;
;         break;
	RJMP _0x29D
;         //1줄 끝
;
;      case 6 :
_0x2FD:
	CPI  R30,LOW(0x6)
	LDI  R26,HIGH(0x6)
	CPC  R31,R26
	BRNE _0x310
;         PORTB.0 = 1;
	SBI  0x18,0
;         PORTB.1 = 0;
	CALL SUBOPT_0x13
;         PORTB.2 = 1;
;         PORTB.3 = 0;
;         PORTB.4 = 1;
;         PORTB.5 = 1;
;         PORTB.6 = 1;
;         PORTB.7 = 1;
;         PORTC.4 = 1;
;         break;
	RJMP _0x29D
;      case 7 :
_0x310:
	CPI  R30,LOW(0x7)
	LDI  R26,HIGH(0x7)
	CPC  R31,R26
	BRNE _0x323
;         PORTB.0 = 0;
	CBI  0x18,0
;         PORTB.1 = 1;
	CALL SUBOPT_0x14
;         PORTB.2 = 1;
;         PORTB.3 = 0;
;         PORTB.4 = 1;
;         PORTB.5 = 1;
;         PORTB.6 = 1;
;         PORTB.7 = 1;
;         PORTC.4 = 1;
;         break;
	RJMP _0x29D
;      case 8 :
_0x323:
	CPI  R30,LOW(0x8)
	LDI  R26,HIGH(0x8)
	CPC  R31,R26
	BRNE _0x336
;         PORTB.0 = 1;
	SBI  0x18,0
;         PORTB.1 = 1;
	CALL SUBOPT_0x14
;         PORTB.2 = 1;
;         PORTB.3 = 0;
;         PORTB.4 = 1;
;         PORTB.5 = 1;
;         PORTB.6 = 1;
;         PORTB.7 = 1;
;         PORTC.4 = 1;
;         break;
	RJMP _0x29D
;      case 9 :
_0x336:
	CPI  R30,LOW(0x9)
	LDI  R26,HIGH(0x9)
	CPC  R31,R26
	BRNE _0x349
;         PORTB.0 = 0;
	CBI  0x18,0
;         PORTB.1 = 0;
	CALL SUBOPT_0x15
;         PORTB.2 = 0;
;         PORTB.3 = 1;
;         PORTB.4 = 1;
;         PORTB.5 = 1;
;         PORTB.6 = 1;
;         PORTB.7 = 1;
;         PORTC.4 = 1;
;         break;
	RJMP _0x29D
;      case 10 :
_0x349:
	CPI  R30,LOW(0xA)
	LDI  R26,HIGH(0xA)
	CPC  R31,R26
	BRNE _0x35C
;         PORTB.0 = 1;
	SBI  0x18,0
;         PORTB.1 = 0;
	CALL SUBOPT_0x15
;         PORTB.2 = 0;
;         PORTB.3 = 1;
;         PORTB.4 = 1;
;         PORTB.5 = 1;
;         PORTB.6 = 1;
;         PORTB.7 = 1;
;         PORTC.4 = 1;
;         break;
	RJMP _0x29D
;            //2줄끝
;
;      case 11 :
_0x35C:
	CPI  R30,LOW(0xB)
	LDI  R26,HIGH(0xB)
	CPC  R31,R26
	BRNE _0x36F
;         PORTB.0 = 0;
	CBI  0x18,0
;         PORTB.1 = 1;
	CALL SUBOPT_0x16
;         PORTB.2 = 0;
;         PORTB.3 = 1;
;         PORTB.4 = 1;
;         PORTB.5 = 1;
;         PORTB.6 = 1;
;         PORTB.7 = 1;
;         PORTC.4 = 1;
;         break;
	RJMP _0x29D
;      case 12 :
_0x36F:
	CPI  R30,LOW(0xC)
	LDI  R26,HIGH(0xC)
	CPC  R31,R26
	BRNE _0x382
;         PORTB.0 = 1;
	SBI  0x18,0
;         PORTB.1 = 1;
	CALL SUBOPT_0x16
;         PORTB.2 = 0;
;         PORTB.3 = 1;
;         PORTB.4 = 1;
;         PORTB.5 = 1;
;         PORTB.6 = 1;
;         PORTB.7 = 1;
;         PORTC.4 = 1;
;         break;
	RJMP _0x29D
;      case 13 :
_0x382:
	CPI  R30,LOW(0xD)
	LDI  R26,HIGH(0xD)
	CPC  R31,R26
	BRNE _0x395
;         PORTB.0 = 0;
	CBI  0x18,0
;         PORTB.1 = 0;
	CALL SUBOPT_0x17
;         PORTB.2 = 1;
;         PORTB.3 = 1;
;         PORTB.4 = 1;
;         PORTB.5 = 1;
;         PORTB.6 = 1;
;         PORTB.7 = 1;
;         PORTC.4 = 1;
;         break;
	RJMP _0x29D
;      case 14 :
_0x395:
	CPI  R30,LOW(0xE)
	LDI  R26,HIGH(0xE)
	CPC  R31,R26
	BRNE _0x3A8
;         PORTB.0 = 1;
	SBI  0x18,0
;         PORTB.1 = 0;
	CALL SUBOPT_0x17
;         PORTB.2 = 1;
;         PORTB.3 = 1;
;         PORTB.4 = 1;
;         PORTB.5 = 1;
;         PORTB.6 = 1;
;         PORTB.7 = 1;
;         PORTC.4 = 1;
;         break;
	RJMP _0x29D
;      case 15 :
_0x3A8:
	CPI  R30,LOW(0xF)
	LDI  R26,HIGH(0xF)
	CPC  R31,R26
	BRNE _0x3BB
;         PORTB.0 = 0;
	CBI  0x18,0
;         PORTB.1 = 1;
	CALL SUBOPT_0x18
;         PORTB.2 = 1;
;         PORTB.3 = 1;
;         PORTB.4 = 1;
;         PORTB.5 = 1;
	SBI  0x18,5
;         PORTB.6 = 1;
	SBI  0x18,6
;         PORTB.7 = 1;
	SBI  0x18,7
;         PORTC.4 = 1;
	SBI  0x15,4
;         break;
	RJMP _0x29D
;         //3줄끝
;
;      case 16 :
_0x3BB:
	CPI  R30,LOW(0x10)
	LDI  R26,HIGH(0x10)
	CPC  R31,R26
	BRNE _0x3CE
;         PORTB.0 = 1;
	CALL SUBOPT_0x19
;         PORTB.1 = 1;
;         PORTB.2 = 1;
;         PORTB.3 = 1;
;         PORTB.4 = 0;
;         PORTB.5 = 0;
	CBI  0x18,5
;         PORTB.6 = 0;
	CBI  0x18,6
;         PORTB.7 = 0;
	CBI  0x18,7
;         PORTC.4 = 1;
	SBI  0x15,4
;         break;
	RJMP _0x29D
;      case 17 :
_0x3CE:
	CPI  R30,LOW(0x11)
	LDI  R26,HIGH(0x11)
	CPC  R31,R26
	BRNE _0x3E1
;         PORTB.0 = 1;
	SBI  0x18,0
;         PORTB.1 = 1;
	CALL SUBOPT_0x18
;         PORTB.2 = 1;
;         PORTB.3 = 1;
;         PORTB.4 = 1;
;         PORTB.5 = 0;
	CBI  0x18,5
;         PORTB.6 = 0;
	CBI  0x18,6
;         PORTB.7 = 0;
	CBI  0x18,7
;         PORTC.4 = 1;
	SBI  0x15,4
;         break;
	RJMP _0x29D
;      case 18 :
_0x3E1:
	CPI  R30,LOW(0x12)
	LDI  R26,HIGH(0x12)
	CPC  R31,R26
	BRNE _0x3F4
;         PORTB.0 = 1;
	CALL SUBOPT_0x19
;         PORTB.1 = 1;
;         PORTB.2 = 1;
;         PORTB.3 = 1;
;         PORTB.4 = 0;
;         PORTB.5 = 1;
	SBI  0x18,5
;         PORTB.6 = 0;
	CBI  0x18,6
;         PORTB.7 = 0;
	CBI  0x18,7
;         PORTC.4 = 1;
	SBI  0x15,4
;         break;
	RJMP _0x29D
;      case 19 :
_0x3F4:
	CPI  R30,LOW(0x13)
	LDI  R26,HIGH(0x13)
	CPC  R31,R26
	BRNE _0x407
;         PORTB.0 = 1;
	SBI  0x18,0
;         PORTB.1 = 1;
	CALL SUBOPT_0x18
;         PORTB.2 = 1;
;         PORTB.3 = 1;
;         PORTB.4 = 1;
;         PORTB.5 = 1;
	SBI  0x18,5
;         PORTB.6 = 0;
	CBI  0x18,6
;         PORTB.7 = 0;
	CBI  0x18,7
;         PORTC.4 = 1;
	SBI  0x15,4
;         break;
	RJMP _0x29D
;      case 20 :
_0x407:
	CPI  R30,LOW(0x14)
	LDI  R26,HIGH(0x14)
	CPC  R31,R26
	BRNE _0x41A
;         PORTB.0 = 1;
	CALL SUBOPT_0x19
;         PORTB.1 = 1;
;         PORTB.2 = 1;
;         PORTB.3 = 1;
;         PORTB.4 = 0;
;         PORTB.5 = 0;
	CBI  0x18,5
;         PORTB.6 = 1;
	SBI  0x18,6
;         PORTB.7 = 0;
	CBI  0x18,7
;         PORTC.4 = 1;
	SBI  0x15,4
;         break;
	RJMP _0x29D
;         //4줄끝
;
;      case 31 :
_0x41A:
	CPI  R30,LOW(0x1F)
	LDI  R26,HIGH(0x1F)
	CPC  R31,R26
	BRNE _0x42D
;         PORTB.0 = 1;
	SBI  0x18,0
;         PORTB.1 = 1;
	CALL SUBOPT_0x18
;         PORTB.2 = 1;
;         PORTB.3 = 1;
;         PORTB.4 = 1;
;         PORTB.5 = 0;
	CBI  0x18,5
;         PORTB.6 = 1;
	SBI  0x18,6
;         PORTB.7 = 0;
	CBI  0x18,7
;         PORTC.4 = 1;
	SBI  0x15,4
;         break;
	RJMP _0x29D
;      case 32 :
_0x42D:
	CPI  R30,LOW(0x20)
	LDI  R26,HIGH(0x20)
	CPC  R31,R26
	BRNE _0x440
;         PORTB.0 = 1;
	CALL SUBOPT_0x19
;         PORTB.1 = 1;
;         PORTB.2 = 1;
;         PORTB.3 = 1;
;         PORTB.4 = 0;
;         PORTB.5 = 1;
	SBI  0x18,5
;         PORTB.6 = 1;
	SBI  0x18,6
;         PORTB.7 = 0;
	CBI  0x18,7
;         PORTC.4 = 1;
	SBI  0x15,4
;         break;
	RJMP _0x29D
;      case 33 :
_0x440:
	CPI  R30,LOW(0x21)
	LDI  R26,HIGH(0x21)
	CPC  R31,R26
	BRNE _0x453
;         PORTB.0 = 1;
	SBI  0x18,0
;         PORTB.1 = 1;
	CALL SUBOPT_0x18
;         PORTB.2 = 1;
;         PORTB.3 = 1;
;         PORTB.4 = 1;
;         PORTB.5 = 1;
	SBI  0x18,5
;         PORTB.6 = 1;
	SBI  0x18,6
;         PORTB.7 = 0;
	CBI  0x18,7
;         PORTC.4 = 1;
	SBI  0x15,4
;         break;
	RJMP _0x29D
;      case 34 :
_0x453:
	CPI  R30,LOW(0x22)
	LDI  R26,HIGH(0x22)
	CPC  R31,R26
	BRNE _0x466
;         PORTB.0 = 1;
	CALL SUBOPT_0x19
;         PORTB.1 = 1;
;         PORTB.2 = 1;
;         PORTB.3 = 1;
;         PORTB.4 = 0;
;         PORTB.5 = 0;
	CBI  0x18,5
;         PORTB.6 = 0;
	CBI  0x18,6
;         PORTB.7 = 1;
	SBI  0x18,7
;         PORTC.4 = 1;
	SBI  0x15,4
;         break;
	RJMP _0x29D
;      case 35 :
_0x466:
	CPI  R30,LOW(0x23)
	LDI  R26,HIGH(0x23)
	CPC  R31,R26
	BRNE _0x479
;         PORTB.0 = 1;
	SBI  0x18,0
;         PORTB.1 = 1;
	CALL SUBOPT_0x18
;         PORTB.2 = 1;
;         PORTB.3 = 1;
;         PORTB.4 = 1;
;         PORTB.5 = 0;
	CBI  0x18,5
;         PORTB.6 = 0;
	CBI  0x18,6
;         PORTB.7 = 1;
	SBI  0x18,7
;         PORTC.4 = 1;
	SBI  0x15,4
;         break;
	RJMP _0x29D
;         //5줄끝
;
;      case 41 :
_0x479:
	CPI  R30,LOW(0x29)
	LDI  R26,HIGH(0x29)
	CPC  R31,R26
	BRNE _0x48C
;         PORTB.0 = 1;
	CALL SUBOPT_0x19
;         PORTB.1 = 1;
;         PORTB.2 = 1;
;         PORTB.3 = 1;
;         PORTB.4 = 0;
;         PORTB.5 = 1;
	SBI  0x18,5
;         PORTB.6 = 0;
	CBI  0x18,6
;         PORTB.7 = 1;
	SBI  0x18,7
;         PORTC.4 = 1;
	SBI  0x15,4
;         break;
	RJMP _0x29D
;      case 42 :
_0x48C:
	CPI  R30,LOW(0x2A)
	LDI  R26,HIGH(0x2A)
	CPC  R31,R26
	BRNE _0x49F
;         PORTB.0 = 1;
	SBI  0x18,0
;         PORTB.1 = 1;
	CALL SUBOPT_0x18
;         PORTB.2 = 1;
;         PORTB.3 = 1;
;         PORTB.4 = 1;
;         PORTB.5 = 1;
	SBI  0x18,5
;         PORTB.6 = 0;
	CBI  0x18,6
;         PORTB.7 = 1;
	SBI  0x18,7
;         PORTC.4 = 1;
	SBI  0x15,4
;         break;
	RJMP _0x29D
;      case 43 :
_0x49F:
	CPI  R30,LOW(0x2B)
	LDI  R26,HIGH(0x2B)
	CPC  R31,R26
	BRNE _0x4B2
;         PORTB.0 = 1;
	CALL SUBOPT_0x19
;         PORTB.1 = 1;
;         PORTB.2 = 1;
;         PORTB.3 = 1;
;         PORTB.4 = 0;
;         PORTB.5 = 0;
	CBI  0x18,5
;         PORTB.6 = 1;
	SBI  0x18,6
;         PORTB.7 = 1;
	SBI  0x18,7
;         PORTC.4 = 1;
	SBI  0x15,4
;         break;
	RJMP _0x29D
;      case 44 :
_0x4B2:
	CPI  R30,LOW(0x2C)
	LDI  R26,HIGH(0x2C)
	CPC  R31,R26
	BRNE _0x4D8
;         PORTB.0 = 1;
	SBI  0x18,0
;         PORTB.1 = 1;
	CALL SUBOPT_0x18
;         PORTB.2 = 1;
;         PORTB.3 = 1;
;         PORTB.4 = 1;
;         PORTB.5 = 0;
	CBI  0x18,5
;         PORTB.6 = 1;
	SBI  0x18,6
;         PORTB.7 = 1;
	SBI  0x18,7
;         PORTC.4 = 1;
	SBI  0x15,4
;         break;
;            //6줄끝
;      default :
_0x4D8:
;         break;
;   }
_0x29D:
;}
	RJMP _0x20C0003
; .FEND
;#endif
;#include "./library/com.c"
;#ifndef _com_
;#define _com_
;
;int combine(int B_position, int R_position)
; 0000 0012 {
_combine:
; .FSTART _combine
;   int overlap = 0;
;
;   if(B_position == R_position)
	CALL SUBOPT_0x5
;	B_position -> Y+4
;	R_position -> Y+2
;	overlap -> R16,R17
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CP   R30,R26
	CPC  R31,R27
	BRNE _0x4D9
;      overlap = 1;
	__GETWRN 16,17,1
;
;   return overlap;
_0x4D9:
_0x20C0004:
	MOVW R30,R16
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,6
	RET
;}
; .FEND
;#endif
;#include "./library/text.c"
;#ifndef _text_
;#define _text_
;
;
;unsigned char user_font1[5][8] = {
;    0x1F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // 도
;    0x1F, 0x00, 0x1F, 0x00, 0x00, 0x00, 0x00, 0x00, // 개
;    0x1F, 0x00, 0x1F, 0x00, 0x1F, 0x00, 0x00, 0x00, // 걸
;    0x1F, 0x00, 0x1F, 0x00, 0x1F, 0x00, 0x1F, 0x00, // 윷
;    0x1F, 0x11, 0x1F, 0x00, 0x04, 0x04, 0x1F, 0x00, // 모
;    };

	.DSEG
;
;unsigned char blue_win[8][8] = {
;    0x1E, 0x11, 0x11, 0x1E, 0x11, 0x11, 0x1E, 0x00, // B
;    0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x1F, 0x00, // L
;    0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x0E, 0x00, // U
;    0x1F, 0x10, 0x10, 0x1F, 0x10, 0x10, 0x1F, 0x00, // E
;    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //
;    0x15, 0x15, 0x15, 0x15, 0x15, 0x1F, 0x0A, 0x00, // W
;    0x0E, 0x04, 0x04, 0x04, 0x04, 0x04, 0x0E, 0x00, // I
;    0x11, 0x19, 0x19, 0x15, 0x13, 0x13, 0x11, 0x00, // N
;    };
;
;unsigned char red_win[8][8] = {
;    0x1E, 0x11, 0x11, 0x1E, 0x14, 0x12, 0x11, 0x00, // R
;    0x1F, 0x10, 0x10, 0x1F, 0x10, 0x10, 0x1F, 0x00, // E
;    0x1E, 0x11, 0x11, 0x11, 0x11, 0x13, 0x1E, 0x00, // D
;    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //
;    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //
;    0x15, 0x15, 0x15, 0x15, 0x15, 0x1F, 0x0A, 0x00, // W
;    0x0E, 0x04, 0x04, 0x04, 0x04, 0x04, 0x0E, 0x00, // I
;    0x11, 0x19, 0x19, 0x15, 0x13, 0x13, 0x11, 0x00, // N
;    };
;
;
;
;int i, j, k;
;
;void text(int yoot, int goal)
; 0000 0013 {

	.CSEG
_text:
; .FSTART _text
;    if(goal == 0){  // 나온 윷을 Character LCD에 출력
	ST   -Y,R27
	ST   -Y,R26
;	yoot -> Y+2
;	goal -> Y+0
	LD   R30,Y
	LDD  R31,Y+1
	SBIW R30,0
	BREQ PC+2
	RJMP _0x4DD
;        lcd_init(1);
	LDI  R26,LOW(1)
	CALL _lcd_init
;
;        switch(yoot)
	LDD  R30,Y+2
	LDD  R31,Y+2+1
;        {
;            case 1:  // 도
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x4E1
;                for(i = 0; i < 8; i++)
	CLR  R10
	CLR  R11
_0x4E3:
	CALL SUBOPT_0x1A
	BRGE _0x4E4
;                {
;                    lcd_write_byte(0x40 + i, user_font1[0][i]);
	MOV  R30,R10
	SUBI R30,-LOW(64)
	ST   -Y,R30
	LDI  R26,LOW(_user_font1)
	LDI  R27,HIGH(_user_font1)
	CALL SUBOPT_0x1B
;                    delay_us(10);
;                }
	MOVW R30,R10
	ADIW R30,1
	MOVW R10,R30
	RJMP _0x4E3
_0x4E4:
;                break;
	RJMP _0x4E0
;            case 2:  // 개
_0x4E1:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x4E5
;                for(i = 0; i < 8; i++)
	CLR  R10
	CLR  R11
_0x4E7:
	CALL SUBOPT_0x1A
	BRGE _0x4E8
;                {
;                    lcd_write_byte(0x40 + i, user_font1[1][i]);
	MOV  R30,R10
	SUBI R30,-LOW(64)
	ST   -Y,R30
	__POINTW1MN _user_font1,8
	CALL SUBOPT_0x1C
;                    delay_us(10);
;                }
	MOVW R30,R10
	ADIW R30,1
	MOVW R10,R30
	RJMP _0x4E7
_0x4E8:
;                break;
	RJMP _0x4E0
;            case 3:  // 걸
_0x4E5:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x4E9
;                for(i = 0; i < 8; i++)
	CLR  R10
	CLR  R11
_0x4EB:
	CALL SUBOPT_0x1A
	BRGE _0x4EC
;                {
;                    lcd_write_byte(0x40 + i, user_font1[2][i]);
	MOV  R30,R10
	SUBI R30,-LOW(64)
	ST   -Y,R30
	__POINTW1MN _user_font1,16
	CALL SUBOPT_0x1C
;                    delay_us(10);
;                }
	MOVW R30,R10
	ADIW R30,1
	MOVW R10,R30
	RJMP _0x4EB
_0x4EC:
;                break;
	RJMP _0x4E0
;            case 4:  // 윷
_0x4E9:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x4ED
;                for(i = 0; i < 8; i++)
	CLR  R10
	CLR  R11
_0x4EF:
	CALL SUBOPT_0x1A
	BRGE _0x4F0
;                {
;                    lcd_write_byte(0x40 + i, user_font1[3][i]);
	MOV  R30,R10
	SUBI R30,-LOW(64)
	ST   -Y,R30
	__POINTW1MN _user_font1,24
	CALL SUBOPT_0x1C
;                    delay_us(10);
;                }
	MOVW R30,R10
	ADIW R30,1
	MOVW R10,R30
	RJMP _0x4EF
_0x4F0:
;                break;
	RJMP _0x4E0
;            case 5:  // 모
_0x4ED:
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0x4E0
;                for(i = 0; i < 8; i++)
	CLR  R10
	CLR  R11
_0x4F3:
	CALL SUBOPT_0x1A
	BRGE _0x4F4
;                {
;                    lcd_write_byte(0x40 + i, user_font1[4][i]);
	MOV  R30,R10
	SUBI R30,-LOW(64)
	ST   -Y,R30
	__POINTW1MN _user_font1,32
	CALL SUBOPT_0x1C
;                    delay_us(10);
;                }
	MOVW R30,R10
	ADIW R30,1
	MOVW R10,R30
	RJMP _0x4F3
_0x4F4:
;                break;
;        }
_0x4E0:
;        lcd_gotoxy(0,0);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	CALL _lcd_gotoxy
;        lcd_putchar(0);
	LDI  R26,LOW(0)
	CALL _lcd_putchar
;    }
;    else{  // 승자를 Character LCD에 출력
	RJMP _0x4F5
_0x4DD:
;        lcd_init(8);
	LDI  R26,LOW(8)
	CALL _lcd_init
;
;        for(i = 0; i < 8; i++)
	CLR  R10
	CLR  R11
_0x4F7:
	CALL SUBOPT_0x1A
	BRLT PC+2
	RJMP _0x4F8
;        {
;            if(goal == 1){  // blue win
	LD   R26,Y
	LDD  R27,Y+1
	SBIW R26,1
	BRNE _0x4F9
;                lcd_write_byte(0x40 + i, blue_win[0][i]); delay_us(10);
	MOV  R30,R10
	SUBI R30,-LOW(64)
	ST   -Y,R30
	LDI  R26,LOW(_blue_win)
	LDI  R27,HIGH(_blue_win)
	CALL SUBOPT_0x1B
;                lcd_write_byte(0x48 + i, blue_win[1][i]); delay_us(10);
	MOV  R30,R10
	SUBI R30,-LOW(72)
	ST   -Y,R30
	__POINTW1MN _blue_win,8
	CALL SUBOPT_0x1C
;                lcd_write_byte(0x50 + i, blue_win[2][i]); delay_us(10);
	MOV  R30,R10
	SUBI R30,-LOW(80)
	ST   -Y,R30
	__POINTW1MN _blue_win,16
	CALL SUBOPT_0x1C
;                lcd_write_byte(0x58 + i, blue_win[3][i]); delay_us(10);
	MOV  R30,R10
	SUBI R30,-LOW(88)
	ST   -Y,R30
	__POINTW1MN _blue_win,24
	CALL SUBOPT_0x1C
;                lcd_write_byte(0x60 + i, blue_win[4][i]); delay_us(10);
	MOV  R30,R10
	SUBI R30,-LOW(96)
	ST   -Y,R30
	__POINTW1MN _blue_win,32
	CALL SUBOPT_0x1C
;                lcd_write_byte(0x68 + i, blue_win[5][i]); delay_us(10);
	MOV  R30,R10
	SUBI R30,-LOW(104)
	ST   -Y,R30
	__POINTW1MN _blue_win,40
	CALL SUBOPT_0x1C
;                lcd_write_byte(0x70 + i, blue_win[6][i]); delay_us(10);
	MOV  R30,R10
	SUBI R30,-LOW(112)
	ST   -Y,R30
	__POINTW1MN _blue_win,48
	CALL SUBOPT_0x1C
;                lcd_write_byte(0x78 + i, blue_win[7][i]); delay_us(10);
	MOV  R30,R10
	SUBI R30,-LOW(120)
	ST   -Y,R30
	__POINTW1MN _blue_win,56
	RJMP _0x54E
;            }
;            else{  // red win
_0x4F9:
;                lcd_write_byte(0x40 + i, red_win[0][i]); delay_us(10);
	MOV  R30,R10
	SUBI R30,-LOW(64)
	ST   -Y,R30
	LDI  R26,LOW(_red_win)
	LDI  R27,HIGH(_red_win)
	CALL SUBOPT_0x1B
;                lcd_write_byte(0x48 + i, red_win[1][i]); delay_us(10);
	MOV  R30,R10
	SUBI R30,-LOW(72)
	ST   -Y,R30
	__POINTW1MN _red_win,8
	CALL SUBOPT_0x1C
;                lcd_write_byte(0x50 + i, red_win[2][i]); delay_us(10);
	MOV  R30,R10
	SUBI R30,-LOW(80)
	ST   -Y,R30
	__POINTW1MN _red_win,16
	CALL SUBOPT_0x1C
;                lcd_write_byte(0x58 + i, red_win[3][i]); delay_us(10);
	MOV  R30,R10
	SUBI R30,-LOW(88)
	ST   -Y,R30
	__POINTW1MN _red_win,24
	CALL SUBOPT_0x1C
;                lcd_write_byte(0x60 + i, red_win[4][i]); delay_us(10);
	MOV  R30,R10
	SUBI R30,-LOW(96)
	ST   -Y,R30
	__POINTW1MN _red_win,32
	CALL SUBOPT_0x1C
;                lcd_write_byte(0x68 + i, red_win[5][i]); delay_us(10);
	MOV  R30,R10
	SUBI R30,-LOW(104)
	ST   -Y,R30
	__POINTW1MN _red_win,40
	CALL SUBOPT_0x1C
;                lcd_write_byte(0x70 + i, red_win[6][i]); delay_us(10);
	MOV  R30,R10
	SUBI R30,-LOW(112)
	ST   -Y,R30
	__POINTW1MN _red_win,48
	CALL SUBOPT_0x1C
;                lcd_write_byte(0x78 + i, red_win[7][i]); delay_us(10);
	MOV  R30,R10
	SUBI R30,-LOW(120)
	ST   -Y,R30
	__POINTW1MN _red_win,56
_0x54E:
	ADD  R30,R10
	ADC  R31,R11
	LD   R26,Z
	CALL _lcd_write_byte
	__DELAY_USB 25
;            }
;        }
	MOVW R30,R10
	ADIW R30,1
	MOVW R10,R30
	RJMP _0x4F7
_0x4F8:
;        lcd_gotoxy(0,0);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	CALL _lcd_gotoxy
;        for(i = 0; i < 8; i++)
	CLR  R10
	CLR  R11
_0x4FC:
	CALL SUBOPT_0x1A
	BRGE _0x4FD
;        {
;            lcd_putchar(i);
	MOV  R26,R10
	CALL _lcd_putchar
;        }
	MOVW R30,R10
	ADIW R30,1
	MOVW R10,R30
	RJMP _0x4FC
_0x4FD:
;    }
_0x4F5:
;}
_0x20C0003:
	ADIW R28,4
	RET
; .FEND
;
;#endif
;
;void main(void)
; 0000 0016 {
_main:
; .FSTART _main
; 0000 0017    int turn = 0, yoot = 0, once = 1;
; 0000 0018    int o_B_position, o_R_position;
; 0000 0019    bit overlap=1;
; 0000 001A    int move_count;  // 말이 한 번에 이동하던 것을 1칸씩 이동하게함
; 0000 001B    bit start_flag = 1;
; 0000 001C 
; 0000 001D    DDRA = 0xff;
	SBIW R28,6
;	turn -> R16,R17
;	yoot -> R18,R19
;	once -> R20,R21
;	o_B_position -> Y+4
;	o_R_position -> Y+2
;	overlap -> R15.0
;	move_count -> Y+0
;	start_flag -> R15.1
	LDI  R30,LOW(3)
	MOV  R15,R30
	__GETWRN 16,17,0
	__GETWRN 18,19,0
	__GETWRN 20,21,1
	LDI  R30,LOW(255)
	OUT  0x1A,R30
; 0000 001E    DDRB = 0xff;
	OUT  0x17,R30
; 0000 001F    DDRC = 0x1f;
	LDI  R30,LOW(31)
	OUT  0x14,R30
; 0000 0020 
; 0000 0021    PORTA.0 = 1;
	CALL SUBOPT_0x1
; 0000 0022    PORTA.1 = 1;
; 0000 0023    PORTA.2 = 1;
; 0000 0024    PORTA.3 = 1;
; 0000 0025    PORTA.4 = 1;
; 0000 0026    PORTA.5 = 1;
; 0000 0027    PORTA.6 = 1;
; 0000 0028    PORTA.7 = 1;
; 0000 0029 
; 0000 002A    PORTB.0 = 1;
	CALL SUBOPT_0x2
; 0000 002B    PORTB.1 = 1;
; 0000 002C    PORTB.2 = 1;
; 0000 002D    PORTB.3 = 1;
; 0000 002E    PORTB.4 = 1;
; 0000 002F    PORTB.5 = 1;
; 0000 0030    PORTB.6 = 1;
; 0000 0031    PORTB.7 = 1;
; 0000 0032 
; 0000 0033    PORTC.1 = 0;
	CBI  0x15,1
; 0000 0034    PORTC.2 = 1;
	SBI  0x15,2
; 0000 0035    PORTC.3 = 0;
	CBI  0x15,3
; 0000 0036    PORTC.4 = 0;
	CBI  0x15,4
; 0000 0037 
; 0000 0038    PORTD = 0xf7;
	LDI  R30,LOW(247)
	OUT  0x12,R30
; 0000 0039 
; 0000 003A while(goal(B_position,R_position)==0)
_0x526:
	CALL SUBOPT_0x1D
	SBIW R30,0
	BREQ PC+2
	RJMP _0x528
; 0000 003B     {
; 0000 003C        if(once == 0)
	MOV  R0,R20
	OR   R0,R21
	BRNE _0x529
; 0000 003D        {
; 0000 003E           if(turn == 0)
	MOV  R0,R16
	OR   R0,R17
	BRNE _0x52A
; 0000 003F               turn = 1;
	__GETWRN 16,17,1
; 0000 0040           else
	RJMP _0x52B
_0x52A:
; 0000 0041               turn = 0;
	__GETWRN 16,17,0
; 0000 0042 
; 0000 0043           once = 1;
_0x52B:
	__GETWRN 20,21,1
; 0000 0044 
; 0000 0045           continue;
	RJMP _0x526
; 0000 0046        }
; 0000 0047        else
_0x529:
; 0000 0048        {
; 0000 0049           if(turn == 0)
	MOV  R0,R16
	OR   R0,R17
	BRNE _0x52D
; 0000 004A           {
; 0000 004B              PORTC.1 = 0;
	CBI  0x15,1
; 0000 004C              PORTC.2 = 1;
	SBI  0x15,2
; 0000 004D           }
; 0000 004E           else
	RJMP _0x532
_0x52D:
; 0000 004F           {
; 0000 0050              PORTC.1 = 1;
	SBI  0x15,1
; 0000 0051              PORTC.2 = 0;
	CBI  0x15,2
; 0000 0052           }
_0x532:
; 0000 0053 
; 0000 0054           key = key_in();
	RCALL _key_in
	MOV  R9,R30
; 0000 0055           if(key_flag == 1)
	SBRC R2,0
; 0000 0056               key_chk();
	RCALL _key_chk
; 0000 0057 
; 0000 0058           yoot = count();
	RCALL _count
	MOVW R18,R30
; 0000 0059 
; 0000 005A           if(yoot == 0)
	MOV  R0,R18
	OR   R0,R19
	BRNE _0x538
; 0000 005B              yoot = 5;
	__GETWRN 18,19,5
; 0000 005C 
; 0000 005D           text(yoot, goal(B_position,R_position));
_0x538:
	ST   -Y,R19
	ST   -Y,R18
	CALL SUBOPT_0x1D
	MOVW R26,R30
	RCALL _text
; 0000 005E 
; 0000 005F           once--;
	__SUBWRN 20,21,1
; 0000 0060        }
; 0000 0061 
; 0000 0062 
; 0000 0063        if(turn == 0)  // B turn
	MOV  R0,R16
	OR   R0,R17
	BRNE _0x539
; 0000 0064        {
; 0000 0065           o_B_position = B_position;
	__PUTWSR 4,5,4
; 0000 0066 
; 0000 0067           for(move_count = yoot; move_count > 0; move_count--)
	__PUTWSR 18,19,0
_0x53B:
	LD   R26,Y
	LDD  R27,Y+1
	CALL __CPW02
	BRGE _0x53C
; 0000 0068           {
; 0000 0069              if(start_flag == 1)
	SBRS R15,1
	RJMP _0x53D
; 0000 006A                 B_position = location(1, B_position);
	CALL SUBOPT_0x1E
	MOVW R26,R4
	RCALL _location
	RJMP _0x54F
; 0000 006B              else
_0x53D:
; 0000 006C                 B_position = location2(1, B_position, o_B_position);
	CALL SUBOPT_0x1E
	ST   -Y,R5
	ST   -Y,R4
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	RCALL _location2
_0x54F:
	MOVW R4,R30
; 0000 006D              step(B_position, R_position);
	CALL SUBOPT_0x1F
; 0000 006E              delay_ms(500);
; 0000 006F              start_flag = 0;
; 0000 0070           }
	LD   R30,Y
	LDD  R31,Y+1
	SBIW R30,1
	ST   Y,R30
	STD  Y+1,R31
	RJMP _0x53B
_0x53C:
; 0000 0071 
; 0000 0072           overlap = combine(B_position, R_position);
	CALL SUBOPT_0x20
; 0000 0073 
; 0000 0074           if(overlap == 1)
	SBRS R15,0
	RJMP _0x53F
; 0000 0075              R_position = 0;
	CLR  R6
	CLR  R7
; 0000 0076 
; 0000 0077           step(B_position, R_position);
_0x53F:
	RJMP _0x550
; 0000 0078           start_flag = 1;
; 0000 0079        }
; 0000 007A        else  // R turn
_0x539:
; 0000 007B        {
; 0000 007C           o_R_position = R_position;
	__PUTWSR 6,7,2
; 0000 007D 
; 0000 007E           for(move_count = yoot; move_count > 0; move_count--)
	__PUTWSR 18,19,0
_0x542:
	LD   R26,Y
	LDD  R27,Y+1
	CALL __CPW02
	BRGE _0x543
; 0000 007F           {
; 0000 0080              if(start_flag == 1)
	SBRS R15,1
	RJMP _0x544
; 0000 0081                 R_position = location(1, R_position);
	CALL SUBOPT_0x1E
	MOVW R26,R6
	RCALL _location
	RJMP _0x551
; 0000 0082              else
_0x544:
; 0000 0083                 R_position = location2(1, R_position, o_R_position);
	CALL SUBOPT_0x1E
	ST   -Y,R7
	ST   -Y,R6
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RCALL _location2
_0x551:
	MOVW R6,R30
; 0000 0084              step(B_position, R_position);
	CALL SUBOPT_0x1F
; 0000 0085              delay_ms(500);
; 0000 0086              start_flag = 0;
; 0000 0087           }
	LD   R30,Y
	LDD  R31,Y+1
	SBIW R30,1
	ST   Y,R30
	STD  Y+1,R31
	RJMP _0x542
_0x543:
; 0000 0088 
; 0000 0089           overlap = combine(B_position, R_position);
	CALL SUBOPT_0x20
; 0000 008A 
; 0000 008B           if(overlap == 1)
	SBRS R15,0
	RJMP _0x546
; 0000 008C              B_position = 0;
	CLR  R4
	CLR  R5
; 0000 008D 
; 0000 008E           step(B_position, R_position);
_0x546:
_0x550:
	ST   -Y,R5
	ST   -Y,R4
	MOVW R26,R6
	RCALL _step
; 0000 008F           start_flag = 1;
	SET
	BLD  R15,1
; 0000 0090        }
; 0000 0091 
; 0000 0092        once = throw_once_more(overlap, yoot);
	LDI  R30,0
	SBRC R15,0
	LDI  R30,1
	LDI  R31,0
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R18
	RCALL _throw_once_more
	MOVW R20,R30
; 0000 0093 
; 0000 0094        delay_ms(10);
	LDI  R26,LOW(10)
	LDI  R27,0
	CALL _delay_ms
; 0000 0095     }
	RJMP _0x526
_0x528:
; 0000 0096 
; 0000 0097     PORTC.1 = 0;
	CBI  0x15,1
; 0000 0098     PORTC.2 = 0;
	CBI  0x15,2
; 0000 0099 
; 0000 009A     text(yoot, goal(B_position,R_position));
	ST   -Y,R19
	ST   -Y,R18
	CALL SUBOPT_0x1D
	MOVW R26,R30
	RCALL _text
; 0000 009B }
	ADIW R28,6
_0x54B:
	RJMP _0x54B
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG

	.CSEG

	.DSEG

	.CSEG
_srand:
; .FSTART _srand
	ST   -Y,R27
	ST   -Y,R26
	LD   R30,Y
	LDD  R31,Y+1
	CALL __CWD1
	CALL SUBOPT_0x21
	RJMP _0x20C0002
; .FEND
_rand:
; .FSTART _rand
	LDS  R30,__seed_G101
	LDS  R31,__seed_G101+1
	LDS  R22,__seed_G101+2
	LDS  R23,__seed_G101+3
	__GETD2N 0x41C64E6D
	CALL __MULD12U
	__ADDD1N 30562
	CALL SUBOPT_0x21
	movw r30,r22
	andi r31,0x7F
	RET
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif

	.DSEG

	.CSEG
__lcd_write_nibble_G102:
; .FSTART __lcd_write_nibble_G102
	ST   -Y,R26
	IN   R30,0x12
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	LD   R30,Y
	ANDI R30,LOW(0xF0)
	OR   R30,R26
	OUT  0x12,R30
	__DELAY_USB 12
	SBI  0x12,2
	__DELAY_USB 12
	CBI  0x12,2
	__DELAY_USB 12
	RJMP _0x20C0001
; .FEND
__lcd_write_data:
; .FSTART __lcd_write_data
	ST   -Y,R26
	LD   R26,Y
	RCALL __lcd_write_nibble_G102
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R26,Y
	RCALL __lcd_write_nibble_G102
	__DELAY_USB 123
	RJMP _0x20C0001
; .FEND
_lcd_write_byte:
; .FSTART _lcd_write_byte
	ST   -Y,R26
	LDD  R26,Y+1
	RCALL __lcd_write_data
	SBI  0x12,0
	LD   R26,Y
	RCALL __lcd_write_data
	CBI  0x12,0
	RJMP _0x20C0002
; .FEND
_lcd_gotoxy:
; .FSTART _lcd_gotoxy
	ST   -Y,R26
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G102)
	SBCI R31,HIGH(-__base_y_G102)
	LD   R30,Z
	LDD  R26,Y+1
	ADD  R26,R30
	RCALL __lcd_write_data
	LDD  R8,Y+1
	LD   R30,Y
	STS  __lcd_y,R30
_0x20C0002:
	ADIW R28,2
	RET
; .FEND
_lcd_clear:
; .FSTART _lcd_clear
	LDI  R26,LOW(2)
	CALL SUBOPT_0x22
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
	CALL SUBOPT_0x22
	LDI  R30,LOW(0)
	STS  __lcd_y,R30
	MOV  R8,R30
	RET
; .FEND
_lcd_putchar:
; .FSTART _lcd_putchar
	ST   -Y,R26
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x2040005
	LDS  R30,__lcd_maxx
	CP   R8,R30
	BRLO _0x2040004
_0x2040005:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDS  R26,__lcd_y
	SUBI R26,-LOW(1)
	STS  __lcd_y,R26
	RCALL _lcd_gotoxy
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x20C0001
_0x2040004:
	INC  R8
	SBI  0x12,0
	LD   R26,Y
	RCALL __lcd_write_data
	CBI  0x12,0
	RJMP _0x20C0001
; .FEND
_lcd_init:
; .FSTART _lcd_init
	ST   -Y,R26
	IN   R30,0x11
	ORI  R30,LOW(0xF0)
	OUT  0x11,R30
	SBI  0x11,2
	SBI  0x11,0
	SBI  0x11,1
	CBI  0x12,2
	CBI  0x12,0
	CBI  0x12,1
	LD   R30,Y
	STS  __lcd_maxx,R30
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G102,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G102,3
	LDI  R26,LOW(20)
	LDI  R27,0
	CALL _delay_ms
	CALL SUBOPT_0x23
	CALL SUBOPT_0x23
	CALL SUBOPT_0x23
	LDI  R26,LOW(32)
	RCALL __lcd_write_nibble_G102
	__DELAY_USB 246
	LDI  R26,LOW(40)
	RCALL __lcd_write_data
	LDI  R26,LOW(4)
	RCALL __lcd_write_data
	LDI  R26,LOW(133)
	RCALL __lcd_write_data
	LDI  R26,LOW(6)
	RCALL __lcd_write_data
	RCALL _lcd_clear
_0x20C0001:
	ADIW R28,1
	RET
; .FEND

	.CSEG

	.CSEG

	.CSEG

	.DSEG
_user_font1:
	.BYTE 0x28
_blue_win:
	.BYTE 0x40
_red_win:
	.BYTE 0x40
__seed_G101:
	.BYTE 0x4
__base_y_G102:
	.BYTE 0x4
__lcd_y:
	.BYTE 0x1
__lcd_maxx:
	.BYTE 0x1

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x0:
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
	__GETWRN 16,17,0
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x1:
	SBI  0x1B,0
	SBI  0x1B,1
	SBI  0x1B,2
	SBI  0x1B,3
	SBI  0x1B,4
	SBI  0x1B,5
	SBI  0x1B,6
	SBI  0x1B,7
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x2:
	SBI  0x18,0
	SBI  0x18,1
	SBI  0x18,2
	SBI  0x18,3
	SBI  0x18,4
	SBI  0x18,5
	SBI  0x18,6
	SBI  0x18,7
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x3:
	CALL _rand
	LDI  R26,LOW(1)
	LDI  R27,HIGH(1)
	CALL __MANDW12
	CALL __BSTB1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x4:
	LDI  R26,LOW(1)
	LDI  R27,0
	CALL _delay_ms
	RJMP SUBOPT_0x3

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x5:
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
	__GETWRN 16,17,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x6:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x7:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADD  R26,R30
	ADC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x8:
	CBI  0x1B,1
	CBI  0x1B,2
	CBI  0x1B,3
	SBI  0x1B,4
	SBI  0x1B,5
	SBI  0x1B,6
	SBI  0x1B,7
	SBI  0x15,3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x9:
	SBI  0x1B,1
	CBI  0x1B,2
	CBI  0x1B,3
	SBI  0x1B,4
	SBI  0x1B,5
	SBI  0x1B,6
	SBI  0x1B,7
	SBI  0x15,3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xA:
	CBI  0x1B,1
	SBI  0x1B,2
	CBI  0x1B,3
	SBI  0x1B,4
	SBI  0x1B,5
	SBI  0x1B,6
	SBI  0x1B,7
	SBI  0x15,3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xB:
	SBI  0x1B,1
	SBI  0x1B,2
	CBI  0x1B,3
	SBI  0x1B,4
	SBI  0x1B,5
	SBI  0x1B,6
	SBI  0x1B,7
	SBI  0x15,3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xC:
	CBI  0x1B,1
	CBI  0x1B,2
	SBI  0x1B,3
	SBI  0x1B,4
	SBI  0x1B,5
	SBI  0x1B,6
	SBI  0x1B,7
	SBI  0x15,3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xD:
	SBI  0x1B,1
	CBI  0x1B,2
	SBI  0x1B,3
	SBI  0x1B,4
	SBI  0x1B,5
	SBI  0x1B,6
	SBI  0x1B,7
	SBI  0x15,3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xE:
	CBI  0x1B,1
	SBI  0x1B,2
	SBI  0x1B,3
	SBI  0x1B,4
	SBI  0x1B,5
	SBI  0x1B,6
	SBI  0x1B,7
	SBI  0x15,3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0xF:
	SBI  0x1B,1
	SBI  0x1B,2
	SBI  0x1B,3
	SBI  0x1B,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x10:
	SBI  0x1B,0
	SBI  0x1B,1
	SBI  0x1B,2
	SBI  0x1B,3
	CBI  0x1B,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x11:
	CBI  0x18,1
	CBI  0x18,2
	CBI  0x18,3
	SBI  0x18,4
	SBI  0x18,5
	SBI  0x18,6
	SBI  0x18,7
	SBI  0x15,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x12:
	SBI  0x18,1
	CBI  0x18,2
	CBI  0x18,3
	SBI  0x18,4
	SBI  0x18,5
	SBI  0x18,6
	SBI  0x18,7
	SBI  0x15,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x13:
	CBI  0x18,1
	SBI  0x18,2
	CBI  0x18,3
	SBI  0x18,4
	SBI  0x18,5
	SBI  0x18,6
	SBI  0x18,7
	SBI  0x15,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x14:
	SBI  0x18,1
	SBI  0x18,2
	CBI  0x18,3
	SBI  0x18,4
	SBI  0x18,5
	SBI  0x18,6
	SBI  0x18,7
	SBI  0x15,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x15:
	CBI  0x18,1
	CBI  0x18,2
	SBI  0x18,3
	SBI  0x18,4
	SBI  0x18,5
	SBI  0x18,6
	SBI  0x18,7
	SBI  0x15,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x16:
	SBI  0x18,1
	CBI  0x18,2
	SBI  0x18,3
	SBI  0x18,4
	SBI  0x18,5
	SBI  0x18,6
	SBI  0x18,7
	SBI  0x15,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x17:
	CBI  0x18,1
	SBI  0x18,2
	SBI  0x18,3
	SBI  0x18,4
	SBI  0x18,5
	SBI  0x18,6
	SBI  0x18,7
	SBI  0x15,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x18:
	SBI  0x18,1
	SBI  0x18,2
	SBI  0x18,3
	SBI  0x18,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x19:
	SBI  0x18,0
	SBI  0x18,1
	SBI  0x18,2
	SBI  0x18,3
	CBI  0x18,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x1A:
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	CP   R10,R30
	CPC  R11,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x1B:
	ADD  R26,R10
	ADC  R27,R11
	LD   R26,X
	CALL _lcd_write_byte
	__DELAY_USB 25
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 16 TIMES, CODE SIZE REDUCTION:87 WORDS
SUBOPT_0x1C:
	ADD  R30,R10
	ADC  R31,R11
	LD   R26,Z
	CALL _lcd_write_byte
	__DELAY_USB 25
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1D:
	ST   -Y,R5
	ST   -Y,R4
	MOVW R26,R6
	JMP  _goal

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1E:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x1F:
	ST   -Y,R5
	ST   -Y,R4
	MOVW R26,R6
	CALL _step
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	CALL _delay_ms
	CLT
	BLD  R15,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x20:
	ST   -Y,R5
	ST   -Y,R4
	MOVW R26,R6
	CALL _combine
	CALL __BSTB1
	BLD  R15,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x21:
	STS  __seed_G101,R30
	STS  __seed_G101+1,R31
	STS  __seed_G101+2,R22
	STS  __seed_G101+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x22:
	CALL __lcd_write_data
	LDI  R26,LOW(3)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x23:
	LDI  R26,LOW(48)
	CALL __lcd_write_nibble_G102
	__DELAY_USB 246
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x733
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__MULD12U:
	MUL  R23,R26
	MOV  R23,R0
	MUL  R22,R27
	ADD  R23,R0
	MUL  R31,R24
	ADD  R23,R0
	MUL  R30,R25
	ADD  R23,R0
	MUL  R22,R26
	MOV  R22,R0
	ADD  R23,R1
	MUL  R31,R27
	ADD  R22,R0
	ADC  R23,R1
	MUL  R30,R24
	ADD  R22,R0
	ADC  R23,R1
	CLR  R24
	MUL  R31,R26
	MOV  R31,R0
	ADD  R22,R1
	ADC  R23,R24
	MUL  R30,R27
	ADD  R31,R0
	ADC  R22,R1
	ADC  R23,R24
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	ADC  R22,R24
	ADC  R23,R24
	RET

__MANDW12:
	CLT
	SBRS R31,7
	RJMP __MANDW121
	RCALL __ANEGW1
	SET
__MANDW121:
	AND  R30,R26
	AND  R31,R27
	BRTC __MANDW122
	RCALL __ANEGW1
__MANDW122:
	RET

__CPW02:
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
	RET

__BSTB1:
	CLT
	TST  R30
	BREQ PC+2
	SET
	RET

__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

;END OF CODE MARKER
__END_OF_CODE:
