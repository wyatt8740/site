;
; PS/2 to PC-9801 Keybaord Adaptor 'GKA-AT98' Ver1.43
;  1997 Programmed by m.sawada/magonote honpo
;   (101/104/AX/106/109/HHK�L�[�{�[�h�Ή�)
;
; LAST UPDATE:2004/5/30��
;
;  IBM�L�[�{�[�h�R�}���h���M�Ή�,CAPS/KANA/NUMLOCK LED,�R���p�N�g��
;  KANA/CAP�o�O�C��,PAUSE KEY�R�[�h�Ή�,NUMLOCK�Ή�,ACER�L�[�{�[�h�Ή�
;�@PAUSE�L�[��STOP�L�[�Ɋ��蓖�āAXFER,NFER�̊��蓖�Ă��C��
;  �Ή�����R�}���h RESET/KEYBOARD-TYPE/LED�ɑΉ�
;  PC98��WIN95����R�}���h�Ή���(��̃R�}���h�ł���9Ch�ɂ�FAh��ԓ�)
;�@WIN95�L�[�Ή�,��������0FAh���M,scroll rock=help�L�[���蓖��
;�@���s�[�g���@��PC98�����ɏC���B(���ݸޔ񏀋�,�J�n0.5mS,make-break��30mS)
;�@���Z�b�g���L�[���͎b��Ή�(���Ѿ�ı����ƭ��ɓ���Ȃ����̖��)(2/4)
;�@NUMLOCK�L�[������R�����͂����o�O���C���B(2/4)
;  NUMLOCK�L�[������END�L�[��ROLLUP���A�T�C������Ȃ��o�O���C��(2/5)
;  ���s�[�g�����Ńu���C�N�R�[�h�𑗂�Ȃ��o�O���C��(2/7)
;  ���s�[�g�����ōŏ��̃��C�N����500mS��Ƀu���C�N�R�[�h�𑗂�(2/7)
;  �V�X�e���Z�b�g�A�b�v,���j�^���g���؂�ւ��Ή��B(2/8)
;�@�d�������シ���Ƀ��Z�b�g����ƁA�L�[��������ċN�����Ȃ��o�O���C��(2/10)
;�@�ϊ����s�R�[�h�𔻒f���Ȃ��o�O���C���B(02/17)
;�@EXCODE�̃L�[�ϊ����[�`�����P�B�e�[�u����300h�ֈړ�(100h���E�΍�)(02/17)
;  �f�o�b�O�}�V��CPU�����㼽�Ѿ�ı����ƭ��ɓ���Ȃ��Ȃ�����Q���C��(03/03)
;�@I/O�f�[�^��SCSI�{�[�h�̾�ı��߂͂Ȃ�ƁA�L�[����3�����炵���̂ŁA
;�@�Ƃ��Ƃ������L�[���s�[�g�ɑΉ�����������Ȃ��Ȃ�Ή��J�n�B
;�@�Ǘ��e�[�u�������Ŏb��Ή��E�f�o�b�O��(05/24)
;�@���m�ɂ͕����L�[���s�[�g�ł͂Ȃ��A���Z�b�g���O�܂ŉ�����Â��Ă���
;�@�L�[��̃o�b�t�@�����O�ƍđ��M���s��������ǉ�����(05/26)
;�@PC98�L�[�{�[�h�̓��Z�b�g��ɉ�����Ă���L�[���đ��M�ł���悤���B
;�@���������[�`���̉��P(POR�Ȃ�)�A���M���[�`���̉��P(�L�[�v���Z�X�҂�)(05/26)
;�@E0h����n�܂�R�[�h���o�b�t�@�����O����悤���P(05/26)
;�@���C�N�^�u���C�N���R���p�N�g��(E0�R�[�h�����ʉ�)(05/30)
;�@GRAPH,SHIFT�L�[�̃��s�[�g�}�~(06/01)
;�@�L�[�{�[�h�R�}���h�������Ă����ꍇ�͖�������(06/11)
;�@CAPS,KANA,NUMLOCK�V�t�g,LED���������P,SHFLG���[�N�p�~(06/11)
;�@IBM�L�[�{�[�h��M���[�`�����P�X�g�b�v�r�b�g��N���b�N������܂ő҂�(6/12)
;�@���s�[�gON/OFF�R�}���h�Ή���,NT�Ή��܂�(7/3)
;�@���������[�`���̉��P(�^�C�}�����ׂĂȂ�����)(8/14)
;�@�^�C�}#0���g�p�ł���悤�ɂ���(8/14)
;�@���m�̉���R�}���h��M���A���Z�b�g�����M�L�[���������FAh������(8/18)
;�@LED����R�}���h�����삵�Ȃ��s����C����(8/21)
;�@�L�[�{�[�h�^�C�v�R�}���h�̉����̕s����C����(8/21)
;�@PC98�{�̂�LED����ł��邩���肷��悤�ɂ���,����ł��Ȃ��ꍇ�̓A�_�v�^����
;�@���䂷��悤�ɂ���(8/21)
;�@�J�[�\�����s�[�g�R�}���h�ɂ��Ă͎������Ȃ����߁A���ǐ��퉞���̂�(8/27)
;�@XFER,NFER���t�ɂȂĂ����̂ŏC��(8/29)
;�@INS,CAPS,CTRL,���ȃL�[�̃��s�[�g��}�~(8/29)
;�@���������[�`���̃^�C�}�𕜊��B���삵�Ȃ��L�[�{�[�h�����������߁B(9/10)
;�@���������[�`���̕s��������BINTFLAG�������������B(9/13)
;�@���������[�`�������P�B�d����������FFh(�I�[�o�[����)���̃R�[�h�𑗂��Ă���
;�@�L�[�{�[�h�����邽�߁ABAT�I���R�[�h��M�����g���C(10��)����悤�ɂ���(9/17)
;�@���Z�b�g���L�[�đ��M������ύX�B�L�[�o�b�t�@�N���A,���M�Ԋu1mS->30mS(9/22)
;  �v���O�����̖��ʂ��Ȃ��ă������̃t���[�G���A���L����(9/28)
;�@PAUSE�L�[MAKE�`BREAK�Ԃ̃E�G�C�g��30mS�ɂ���(9/28)
;�@�t���O(BRK,INTFLAG,BRKF,RPTF)�̃r�b�g���Ńt���[�G���A���L����(9/28)
;�@�L�[�{�[�h����̓���R�[�h�������ȗ������ăt���[�G���A���L����(9/28)
;�@�t���O(CAPS,KANA,NUMLOCK)���r�b�g�����ăt���[�G���A���L����(9/29)
;  �L�[���s�[�gMAKE,BREAK�Ԋu���C������AUTOREPEAT���~�܂�̂�h�~(10/21)
;�@���荞�ݏ���PUSH/POP���[�`��STATUS�����A����Ȃ��s����C��(98/4/9)
;�@����R�}���h:�L�[�{�[�h�^�C�v������ύX��,FAh,A0h,80h�����ɂ���(6/2)
;�@���Z�b�g�R�}���h�ŃL�[��Ԃ̑��M�����Ȃ��悤�ɂ���(6/3)
;  ���M��READY�M�����݂ĉ���R�}���h����M���Ȃ����Ƃ�����̂��C��(6/9)
;�@IBMKEYTX���C��(9.8304MHz�����ɕs����ł�)����(8/1)
;�@JCC��AX�L�[�{�[�h�Ŏ�M�Ɏ��s���邱�Ƃ�����̂�IBMKEYRX���C��(8/12)
;  PAGE UP = ROLL DOWN,PAGE DOWN = ROLL UP,END=ROLL DOWN�Ƃ���(11/7)
;  98����R�}���h�̊��荞�ݎ�M����|�[�����O�֕ύX���ȃ�������(7/6)
;  98��M/���M,PS2��M/���M���ꕔ�ύX�A�R�����g���C��(7/6)
;  �L�[�ϊ��e�[�u�������ʃA�h���X���֋l�߂ăt���[�G���A���m��(7/6)
;  ASCII/JIS/AX�ŋ��ʃ\�[�X��,�ύX��KB_TYPE�̒l��ύX����(7/6)
;  (AX�L�[�{�[�h�̏ꍇ���ȏ�����LED�r�b�g�A�T�C�����قȂ�̂Œ���)
;  �R�X�g�_�E���p�ɃV�X�e���N���b�N��6.144MHz/10MHz����I�ׂ�悤�ɂ��邽��
;  SEND98,RX98KEY�����ꂼ��2�p�ӂ����B�܂��^�C�~���O�̔��������s����(7/12)
;  PAGE UP,DOWN�A�T�C�����\�[�X���x���Ő؂�ւ�����悤�ɂ���(2000/1/15)
;
;  ���삵�Ȃ��L�[�{�[�h(SCORPIUS 98A)�ɑΉ������B(2000/2/7)
;  ���̃L�[�{�[�h��POR���ɑ��M���֎~���Ă����AAh�𑗂��Ă��Ȃ��B
;  ���̂��Ƃ���APOR����̗l�X�ȃp�^�[���ȑΉ����邽�߁A�d����������
;  �菇���ȉ��̂悤�ɕύX�����B����͑���GKA�V���[�Y�ւ����f�����B
;
;   1. �d�����������CLK,DATA=HIGH�ŃL�[�{�[�h���͑��M�ɂ��Ă����B
;   2. POR�I����BAT�����R�[�h�̎�M��3�񎎂݂Ď���悭��M�ł���
;      �ꍇ�́A���̏����֐i�ށB���x�����݂Ă��߂ȏꍇ�̓G���[�\���㎟�̏�����
;   3. �L�[�{�[�h�փ��Z�b�g�R�}���h�𑗐M����B
;   4. BAT�����R�[�h�̎�M�����݂�B��M�ł����ꍇ�͏��������������B
;      ���x�����݂Ă��߂ȏꍇ�̓G���[�\��(LED�_��)���Ă����~�����ɑ��s�B
;
;  NOPx2=GOTO $+1�ƒu�������ăR�[�h�T�C�Y���k��(2/7)
;  �e���L�[����END/PAGE UP/DOWN�L�[�ɂ��Ă��A�T�C���̓���ւ���K�p(2/7)
;  ���[�N�G���A�̐����A�R�[�h�T�C�Y���k��(2/26)
;  �L�[�{�[�h��������BAT�����R�[�h��M�񐔂�1��݂̂Ƃ���(3/1)
;
;  `,~(�`���_)������ʂ�ɓ��͂ł���悤��SHIFT���ɃL�[�R�[�h�����ւ���
;  ���悤�ɂ���(KEY_EXCHG�Ŏw��)(3/1)
;  @,^����ւ��Ő��SHIFT������ƃL�[�����C�N���ꂽ�܂܂ɂȂ�̂��C��(3/1)
;  ���@�\�͈ˑR�Ƃ��Č듮�삷�邱�Ƃ����茻���_�ł̎g�p�͐������Ȃ�(3/2)
;
;  �ꕔ�R�����g�C��(3/27)
;  PFU Happy Hacking Keyboard�ɑΉ�(4/4)
;  �p��/CAPS�L�[��CTRL�L�[�֊��蓖�Ă���悤�ɂ���(4/4)
;  �S�p/���p -> XFER���蓖��(2001/2/3)
;  �R�����g�̑啝�ȏ�������(2003/3/19)
;  ����d�l:NFER,CAPS,���Ȃ�SHIFT�����Ȃ���݂̂ő���ɑΉ�(3/21)
;
; �L�[�{�[�h����R�}���h�Ή��̉��P
;  1.���s�[�g���x�R�}���h(9Ch)�ɐ��퉞������悤�ɂ����B���x�w��͖���(3/22)
;  2.LED��ԕԓ��R�}���h(9Dh+60h)�ɑΉ�,LED���[�N�����ꕔ�ύX(3/22)
;  3.�����ȊO�̃R�}���h�ɑ΂��Ă͉������Ȃ��悤�ɂ���(3/22)
;  *��L1-3�ύX�ɂ��WindowsNT�N�����ɒ�~����s������P���ꂽ(3/22)
;
;  �\�[�X����CONFIG/IDLOC��ݒ肷��悤�ɂ���(4/12)
;  MPLAB�W���C���N���[�h�t�@�C�����g�p����悤�ɂ���(4/12)
;  ����d�l:SHIFT LOCK����CAPS�L�[�݂̂�CTRL�L�[�ɂȂ�(6/11)
;  PLUS PCB(I/O Direction����)�Ή�(12/4)
;  PIC16F628�Ή�(2004/5/30)
;
; Make Options
;
#DEFINE KB_TYPE		2	; �L�[�{�[�h 0=101/104 1=AX 2=106/109 3=HHK
#DEFINE CAPS_ASSIGN	0	; �p��/CAPS���蓖�� 0=CAPS 1=CTRL
#DEFINE SYS_CLK		1	; �V�X�e���N���b�N 0=6.144MHz 1=10MHz
#DEFINE ROLL		0	; PAGE UP/DW�A�T�C��0=PD-RD,PU-RU 1=PD-RU,PU-RD
#DEFINE KEY_EXCHG	0	; @,^ KEY EXCHAGE with SHIFT 0=Not 1=Excange
#DEFINE SHIFT_LOCK	0	; SHIFT���b�N 0=OFF 1=ON(SHIFT+CAPS/����/NFER)
#DEFINE CAPS_CTRL	0	; SHIFT���b�N��CAPS�L�[���蓖�� 0=CAPS 1=CTRL
#DEFINE	MODEL		0	; 0=ORIGINAL/COMMON-PCB 1=PLUS PCB
#DEFINE	DEV		1	; 0=PIC16F84A 1=PIC16F628
;
	RADIX		DEC
;
; DEVICE SELECT
;
	;
	; PIC16F84A
	;
	IF DEV == 0
	PROCESSOR	16F84A
	INCLUDE		"P16F84A.INC"
	__CONFIG _CP_OFF & _WDT_OFF & _HS_OSC & _PWRTE_ON
	__IDLOCS	H'0000'
	CONSTANT	RAMADR = 0Ch
	ENDIF
	;
	; PIC16F628
	;
	IF DEV == 1
	PROCESSOR	16F628
	INCLUDE		"P16F628.INC"
	__CONFIG _CP_OFF & _WDT_OFF & _HS_OSC & _PWRTE_ON & _BODEN_ON & _LVP_OFF
	__IDLOCS	H'0000'
	CONSTANT	RAMADR = 20h
	ENDIF
;
; Bit�\�L�̒�`
;
B0		EQU	0
B1		EQU	1
B2		EQU	2
B3		EQU	3
B4		EQU	4
B5		EQU	5
B6		EQU	6
B7		EQU	7
;
; ���[�N�G���A���蓖��
;
	CBLOCK	RAMADR
	WAIT0
	WAIT1
	WAIT2
	PC98_DATA	; PC-9801�L�[�{�[�h����M�f�[�^
	PS2_DATA	; PS/2�L�[�{�[�h����M�f�[�^
	LOOP		; ���[�v�J�E���^1
	LOOP2		; ���[�v�J�E���^2
	WORK		; �ėp���[�N
	PTCNT		; �p���e�B�r�b�g�J�E���^

	SYSFLG		; B0:SHIFT�t���O 0=OFF 1=ON
			; B1:Break�t���O 0=OFF 1=Break
			; B2:����R�}���h��M�t���O 1=Recieved
			; B3:�L�[��Break�t���O 0=Break 1=�܂�Make
			; B4:���s�[�g1=�����L�[��������Â��Ă���
			; B5:CAPS�t���O 0=OFF 1=ON
			; B6:���ȃt���O 0=OFF 1=ON
			; B7:NumLock�t���O 0=OFF 1=ON
	SYSFLG2		; B0:@,^����ւ������t���O 1=����ւ���
			; B1:SHIFT-Break�t���O 1=Break

	LEDDATA		; PS/2�L�[�{�[�h��LED�f�[�^
	ETC		; �ėp���[�N
	BKEY		; �O�񉟂��ꂽ�L�[�R�[�h�i98�R�[�h�j
	KBF_BGN		; �đ��M�o�b�t�@�J�n�A�h���X(1Ah�`1A+KBF_LEN)
	LEDDATA98	; PC98 LED DATA
	ENDC
;
; �e��ݒ�l
;
KBF_LEN		EQU	3	; �đ��M�L�[�o�b�t�@�T�C�Y
DELAYT		EQU	4  	; �����ԃE�G�C�g(500ms)
BATOK		EQU	0AAh	; BAT�����R�[�h
BAT_RTY_NUM	EQU	1	; BAT�����R�[�h��M���g���C��
ERR_DSP_NUM	EQU	3	; �L�[�{�[�h�G���[LED�_�ŉ�
;
; ����̃s�����蓖��
;
	;
	; �I���W�i��/����PCB(2001)
	;
	IF MODEL == 0
RB_DIR		EQU	11101011B	; ORG/COMMON PCB
PINIT_DATA	EQU	00010100B	; ORG/COMMON PCB
#DEFINE	STATUS_LED	PORTB,B4	; ORG/COMMON PCB
#DEFINE	DATA_OUT	PORTA,B0	; ORG/COMMON PCB
#DEFINE	CLK_OUT		PORTA,B1	; ORG/COMMON PCB
#DEFINE	DATA_IN		PORTA,B2	; ORG/COMMON PCB
#DEFINE	CLK_IN		PORTA,B3	; ORG/COMMON PCB
	ENDIF
	;
	; TeamPlusPCB(GKA-68ATmk2)
	;
	IF MODEL == 1
RB_DIR		EQU	01111011B	; PLUS PCB
PINIT_DATA	EQU	10000100B	; PLUS PCB
#DEFINE	STATUS_LED	PORTB,B7	; PLUS PCB
#DEFINE	DATA_OUT	PORTA,B2	; PLUS PCB
#DEFINE	CLK_OUT		PORTA,B3	; PLUS PCB
#DEFINE	DATA_IN		PORTA,B2	; PLUS PCB
#DEFINE	CLK_IN		PORTA,B3	; PLUS PCB
	ENDIF
	;
	; �S�����
	;
DATA_BIT	EQU	2		; PS/2 DATA(IN) PORT
CLK_BIT		EQU	3		; PS/2 CLK(IN) PORT
;
; I/O Direction Controle
;
DATA_PORT_IN MACRO
        BSF	STATUS,RP0              ;OPTION and TRISx are in upper data page
	BSF	TRISA,DATA_BIT		;Output change
        BCF     STATUS,RP0              ;Select page 0
	ENDM
DATA_PORT_OUT MACRO
        BSF	STATUS,RP0              ;OPTION and TRISx are in upper data page
	BCF	TRISA,DATA_BIT		;Input change
        BCF     STATUS,RP0              ;Select page 0
	ENDM
CLK_PORT_IN MACRO
        BSF     STATUS,RP0              ;OPTION and TRISx are in upper data page
	BSF	TRISA,CLK_BIT		;Output change
        BCF     STATUS,RP0              ;Select page 0
	ENDM
CLK_PORT_OUT MACRO
        BSF     STATUS,RP0              ;OPTION and TRISx are in upper data page
	BCF	TRISA,CLK_BIT		;Input change
        BCF     STATUS,RP0              ;Select page 0
	ENDM
;
; �X�^�[�g�A�b�v
;
	ORG	0h
START
	BSF	STATUS,RP0	; SELECT PAGE 1
	MOVLW	11111100B	; PORT A SETUP
				;   B0=DATA(OUT)
				;   B1=CLK (OUT)
				;   B2=DATA(IN)
				;   B3=CLK (IN)
	MOVWF	TRISA		; SET PORT A

	MOVLW	RB_DIR		; PORT B SETUP
				;   B0=RST(IN)
				;   B1=RDY(IN)
				;   B2=RXD(OUT)
				;   B3=RTY(IN)
				;   B4=LED(OUT)
	MOVWF	TRISB		; SET PORT B
	;
	; �^�C�}0,�����݊֌W������
	;
	BCF	STATUS,RP0	; SELECT PAGE 0
	CLRWDT			; �E�H�b�`�h�b�O�^�C�}���N���A
	CLRF	TMR0		; TMR0���e�N���A
	BSF	STATUS,RP0	; SELECT PAGE 1
	MOVLW	10000110B
				; RB�v���A�b�v����
				; INT���荞�݃G�b�W=����������
				; �^�C�}�N���b�N=1/4OSC(648nS)
				; �v���X�P�[��:TMR0
				; �v���X�P�[��������:1/128(82.944uS/6.144MHz)
				;                         (51.2uS/10MHz)
	MOVWF	OPTION_REG	; OPTION���W�X�^�ݒ�
	BCF	STATUS,RP0	; SELECT PAGE 0
	;
	; ANALOG COMPARATOR(16F62x)
	;
	IF DEV == 1
	MOVLW	00000111B	; RA = DIGITAL I/O PORT
	MOVWF	CMCON
	ENDIF

	CLRF	TMR0		; TMR0���e�N���A
	CALL	INITALIZE	; ���[�N������,PS/2�L�[�{�[�h�N���`�F�b�N
	CALL	KBRESET		; PS/2�L�[�{�[�h���Z�b�g
;
;�@���C�����[�v
; PS/2�L�[�{�[�h PC98�L�[�{�[�h�ϊ�����
;
MAIN
	BCF	SYSFLG,B1	; Clear Break Flag
	CALL	CLKDATABIT_HIGH
PORT_CHK
	BTFSS	PORTB,B0	; ����R�}���h��M?
	GOTO	DOWN98COM
	BTFSC	DATA_IN		; PS/2�f�[�^��M?
	GOTO	PORT_CHK
	BCF	STATUS_LED	; ����R�}���h�󂯕t��LED����
	CALL	IBMKEYRX	; PS/2�L�[�{�[�h��M����
	MOVF	PS2_DATA,0	; �L�[�{�[�h����̓���R�[�h����
	XORLW	0F0h		; Break�R�[�h?
	BTFSS	STATUS,B2
	GOTO	SP_CODE
	BSF	SYSFLG,B1	; Set Break Flag
	CALL	IBMKEYRX	; �����ꂽ�L�[�R�[�h��ǂ�
	GOTO	IT98
SP_CODE
	MOVF	PS2_DATA,0
	SUBLW	0E2h		; E2h�ȏゾ������CARRY=0(���Z���ʕ�)
	BTFSS	STATUS,B0
	GOTO	MAIN		; ����R�[�h(AAh,FFh��)�Ȃ疳��
	MOVF	PS2_DATA,1
	BTFSC	STATUS,B2	; 00h(�I�[�o�[����)�Ȃ疳��
	GOTO	MAIN
	;
	; �V�t�g�ɉe������Ȃ��L�[��Make/Break����
	;
IT98
	MOVF	PS2_DATA,0
	XORLW	0E0h
	BTFSC	STATUS,B2	; E0h�Ŏn�܂�L�[�R�[�h�H
	GOTO	IT98EXCODE	;  Yes. E0h�R�[�h������
	MOVF	PS2_DATA,0
	XORLW	0E1h
	BTFSC	STATUS,B2	; E1h(PAUSE)?
	GOTO	PAUSE_KEY0	;  Yes. PAUSE�L�[����
	BTFSC	SYSFLG,B7	; NumLock Flag?
	GOTO	IT98NNUM	;  No. �ʏ폈����

	MOVF	PS2_DATA,0	; �ȉ�NumLock�L�[�V�t�g���̏���
	SUBLW	68h
	BTFSC	STATUS,B0	; 69h�ȏ�? CARRY=0(���Z���ʕ�)
	GOTO	IT98NNUM	;  No. NumLock�L�[�ΏۊO
	MOVF	PS2_DATA,0
	SUBLW	7Dh
	BTFSS	STATUS,B0	; 7Eh�ȏ�? CARRY=0(���Z���ʕ�)
	GOTO	IT98NNUM	;  No. NumLock�L�[�ΏۊO
	MOVLW	69h		; �L�[�R�[�h�␳�p�I�t�Z�b�g�l
	SUBWF	PS2_DATA,0	; �I�t�Z�b�g�����i��)PS2_DATA=PS2_DATA-W
	CALL	CNVNUM		; PS/2��NumLock�L�[�V�t�g����PS/2�R�[�h�ϊ�
	GOTO	IT98STORE
IT98NNUM
	MOVF	PS2_DATA,0	; W=PS/2�L�[�R�[�h
	CALL	CNVITO98	; PS/2��98�R�[�h�ϊ� W=PC98�L�[�R�[�h
IT98STORE
	MOVWF	PC98_DATA
	XORLW	0FFh
	BTFSC	STATUS,B2
	GOTO	MAIN		; �R�[�h�ϊ����s
	;
	; �`���_������ʂ���͂ł���悤SHIFT���ɃL�[�R�[�h����ւ���
	;
	IF KEY_EXCHG == 1
	MOVF	PC98_DATA,0	; SHIFT Make?
	XORLW	70h
	BTFSC	STATUS,B2
	GOTO	SHIFT

	BTFSS	SYSFLG,B0	; SHIFT Flag?
	GOTO	CHKSHIFT
	MOVF	PC98_DATA,0
	XORLW	0Ch		; ^ KEY?
	BTFSC	STATUS,B2
	GOTO	KEY_EX1
	MOVF	PC98_DATA,0
	XORLW	1Ah		; @ KEY?
	BTFSC	STATUS,B2
	GOTO	KEY_EX2
	GOTO	KEY_EXCLR	; �ΏۊO�L�[�Ȃ����ւ����t���O�N���A
KEY_EX1
	MOVLW	1Ah
	GOTO	KEY_EX3
KEY_EX2
	MOVLW	0Ch
KEY_EX3
	MOVWF	PC98_DATA	; ����ւ����R�[�h�𑗐M���[�N�փZ�b�g
	BSF	SYSFLG2,B0	; ����ւ����t���O�Z�b�g
				; SHIFT��@,^�L�[���O�ɕ����ꂽ�ꍇ��@,^�L�[
				; �����C�N���ꂽ�܂܂ɂȂ�̂�h��!
	BTFSS	SYSFLG,B1	; �u���C�N?
	GOTO	CHKSHIFT
KEY_EXCLR
	BCF	SYSFLG2,B0	; ����ւ����t���O�N���A
	BTFSS	SYSFLG2,B1	; SHIFT�L�[�͊��Ƀu���C�N���ꂽ?
	GOTO	CHKSHIFT
	BCF	SYSFLG,B0	; ���ꂽ�Ȃ�SHIFT�t���O���N���A
	BCF	SYSFLG2,B1	; SHIFT�u���C�N�t���O���N���A
	ENDIF
	;
	; �V�t�g��Ԃ��`�F�b�N����LED�𐧌䂷��
	; (����R�}���h�̂Ȃ����@��p�����܂�)
	;
CHKSHIFT
	IF SHIFT_LOCK == 1	; SHIFT���b�N����
	MOVF	PC98_DATA,0
	XORLW	70h
	BTFSC	STATUS,B2	; SHIFT Make?
	GOTO	SHIFT2		;  Yes.
SHIFTLK_NFER
	MOVF	PC98_DATA,0
	XORLW	51h
	BTFSS	STATUS,B2	; NFER Make?
	GOTO	SHIFTLK_CAPS	;  No.
	BTFSS	SYSFLG,B0	; SHIFT Flag?
	GOTO	MAIN		;  No.
	MOVLW	70h		; SHIFT break
	MOVWF	PC98_DATA
	BSF	PC98_DATA,B7	; Break�R�[�h������
	CALL	SEND98		; Break�R�[�h�𑗐M
	CALL	WAIT1MS
	MOVLW	51h		; NFER�R�[�h�𕜋A
	MOVWF	PC98_DATA
	GOTO	CHKSHIFT2
SHIFTLK_CAPS
	MOVF	PC98_DATA,0
	XORLW	71h
	BTFSS	STATUS,B2	; CAPS Make?
	GOTO	SHIFTLK_KANA	;  No.
	BTFSS	SYSFLG,B0	; SHIFT Flag?
	IF CAPS_CTRL == 1
	GOTO	EXC_CAPS_CTRL	;  No. Exchange CAPS - CTRL
	ELSE
	GOTO	MAIN		;  No.
	ENDIF

	MOVLW	70h		; SHIFT break
	MOVWF	PC98_DATA
	BSF	PC98_DATA,B7	; Break�R�[�h������
	CALL	SEND98		; Break�R�[�h�𑗐M
	CALL	WAIT1MS
	MOVLW	71h		; CAPS�R�[�h�𕜋A
	MOVWF	PC98_DATA
	GOTO	CHKSHIFT2
SHIFTLK_KANA
	MOVF	PC98_DATA,0
	XORLW	72h
	BTFSS	STATUS,B2	; ���� Make?
	GOTO	CHKSHIFT2	;  No.
	BTFSS	SYSFLG,B0	; SHIFT Flag?
	GOTO	MAIN		;  No.
	MOVLW	70h		; SHIFT break
	MOVWF	PC98_DATA
	BSF	PC98_DATA,B7	; Break�R�[�h������
	CALL	SEND98		; Break�R�[�h�𑗐M
	CALL	WAIT1MS
	MOVLW	72h		; ���ȃR�[�h�𕜋A
	MOVWF	PC98_DATA
	ENDIF
CHKSHIFT2
	MOVF	PC98_DATA,0
	XORLW	071h
	BTFSC	STATUS,B2	; CAPS Make?
	GOTO	CAPS		;  Yes.

	IF KB_TYPE == 2		; 106/109�̂��ȃL�[����
	MOVF	PS2_DATA,0
	XORLW	13h
	BTFSC	STATUS,B2	; KANA Make?
	GOTO	KANA		;  Yes.
	ENDIF

	MOVF	PS2_DATA,0
	XORLW	77h
	BTFSC	STATUS,B2	; NumLock Make?
	GOTO	NUMLOCK		;  Yes.
	GOTO	IT98NRM		; Make/Break������
	;
	;  CAPS�L�[��LED����
	;
CAPS
	BTFSC	SYSFLG,B1
	GOTO	CAPKANA_BRK

	MOVF	BKEY,0		; CAPS�L�[�̓��s�[�g�����Ȃ�
	XORWF	PC98_DATA,0
	BTFSC	STATUS,B2	; Repeat?
	GOTO	MAIN		;  Yes.

	BTFSC	SYSFLG,B5	; CAPS Flag?
	GOTO	CAPOFF		;  Yes.
CAPON
	CALL	CAP_ON
	BSF	SYSFLG,B5	; Set CAPS Flag
	GOTO	IT98MK		; Make������
CAPOFF
	CALL	CAP_OFF
	BCF	SYSFLG,B5	; Clear CAPS Flag
	GOTO	IT98BR2		; Break������
CAPKANA_BRK
	MOVLW	0FFh
	MOVWF	BKEY		; Clear Before KeyCode
	GOTO	MAIN
	;
	; ���ȃL�[�̏���
	;
KANA
	BTFSC	SYSFLG,B1	; Break Flag?
	GOTO	CAPKANA_BRK 	;  Yes.

	MOVF	BKEY,0		; ���ȃL�[�̓��s�[�g�����Ȃ�
	XORWF	PC98_DATA,0
	BTFSC	STATUS,B2	; Repeat?
	GOTO	MAIN		;  Yes.

	BTFSC	SYSFLG,B6	; ����Flag?
	GOTO	KANAOFF		;  Yes.
KANAON
	CALL	KANA_ON		; �A�_�v�^����LED���䂷��
	BSF	SYSFLG,B6	; Set ���� Flag
	GOTO	IT98MK		; Make������
KANAOFF
	CALL	KANA_OFF	; �A�_�v�^����LED���䂷��
	BCF	SYSFLG,B6	; Clear ���� Flag
	GOTO	IT98BR2		; Break������
	;
	; NumLock�L�[��LED�̏���
	;
NUMLOCK
	BTFSC	SYSFLG,B1	; Break Flag?
	GOTO	MAIN		;  Yes.
	BTFSC	SYSFLG,B7	; NumLockFlag?
	GOTO	NUMOFF		;  Yes.
NUMON
	CALL	NUM_ON		; NumLock LED ON
	GOTO	MAIN
NUMOFF
	CALL	NUM_OFF		; NumLock LED OFF
	GOTO	MAIN
	;
	; SHIFT�L�[�̃t���O����(@,^�̃L�[����ւ������p)
	;
SHIFT
	IF KEY_EXCHG == 1
	BTFSC	SYSFLG,B1	; Break Flag?
	GOTO	SHIFTOFF
SHIFTON
	BSF	SYSFLG,B0	; Set SHIFT Flag
	BCF	SYSFLG2,B1	; Clear SHIFT-Break Flag
	GOTO	IT98NRM		; Make/Break������
SHIFTOFF
	BSF	SYSFLG2,B1	; Set SHIFT-Break Flag
	BTFSS	SYSFLG2,B0	; @,^�L�[������ւ���?
	BCF	SYSFLG,B0	;  No. Clear SHIFT Flag
	GOTO	IT98NRM		; Make/Break������
	ENDIF
	;
	; SHIFT�L�[�̃t���O����(SHIFT���b�N�@�\)
	;
SHIFT2
	IF SHIFT_LOCK == 1
	BTFSC	SYSFLG,B1	; SHIFT Flag?
	GOTO	SHIFT2OFF	;  Yes.
SHIFT2ON
	BSF	SYSFLG,B0	; Set SHIFT Flag
	GOTO	IT98NRM		; Make/Break������
SHIFT2OFF
	BCF	SYSFLG,B0	; Clear SHIFT Flag
	GOTO	IT98NRM		; Make/Break������
	ENDIF
	;
	; SHIFT���b�N��CAPS�L�[�݂̂�CTRL�L�[�����蓖�Ă�
	;
EXC_CAPS_CTRL
	MOVLW	74h		; CTRL�R�[�h(PC-98)
	MOVWF	PC98_DATA
	;
	; Make/Break����
	;
IT98NRM
	BTFSC	SYSFLG,B1	; Break?
	GOTO	IT98BR		;  Yes.Break���M������
	GOTO	IT98MK		;  No. Make���M������
	;
	; E0h�Ŏn�܂�L�[�̏���
	;
IT98EXCODE			; E0h�R�[�hMake/Break����
	BCF	SYSFLG,B1
	CALL	IBMKEYRX
	MOVF	PS2_DATA,0
	XORLW	0F0h		; BreakCode?
	BTFSS	STATUS,B2
	GOTO	IT98EX
	BSF	SYSFLG,B1	; Set Break Flag
	CALL	IBMKEYRX	; BreakCode��M
	;
	; E0h�Ŏn�܂�L�[�ƃV�t�g��Ԃ̉e�����󂯂�L�[�̏���
	;
IT98EX
	MOVF	PS2_DATA,0
	XORLW	12h		; �V�t�g�ENumLock?
	BTFSC	STATUS,B2
	GOTO	MAIN		; �����Ȃ玟�̃L�[��ǂ�
	MOVF	PS2_DATA,0
	XORLW	59h		; �E�V�t�g?
	BTFSC	STATUS,B2
	GOTO	MAIN		; �����Ȃ玟�̃L�[��ǂ�
	;
	; E0h�R�[�h��Make/Break����
	;
	CALL	IT98CNV1	; PS/2��PC98�L�[�R�[�h�ϊ�
	MOVWF	PC98_DATA
	XORLW	0FFH		; �R�[�h�ϊ����s?
	BTFSC	STATUS,B2
	GOTO	MAIN		; �ϊ����s�����̂łȂɂ����Ȃ�
	;
	; AX�L�[�{�[�h�u���ȁv�L�[����
	;
	IF KB_TYPE == 1
	MOVF	PS2_DATA,0
	XORLW	14h		; ���ȃL�[���C�N?
	BTFSC	STATUS,B2
	GOTO	KANA
	ENDIF

	BTFSC	SYSFLG,B1	; Break Flag?
	GOTO	IT98BR
	;
	; �N�����̃L�[�񑗐M�p����(�V�X�e���Z�b�g�A�b�v���j���[���ւ̑Ή�)
	;  1�L�[���s�[�g�������L�[�̃��s�[�g��Ԃ���
	;  ���肵�L�[�̃o�b�t�@�����O���s��
	;
IT98MK				; 1�L�[���s�[�g�̃o�b�t�@�����O
	MOVF	PC98_DATA,0	; �O��Ɠ���Make�R�[�h�Ȃ烊�s�[�g����
	XORWF	BKEY,0
	BTFSC	STATUS,B2
	GOTO	IT_RPT1		; �ʏ��Make������
	BTFSC	SYSFLG,B3	; �L�[�������ꂽ���t���O�𒲂ׂ�
	GOTO	IT_RPT2		; �L�[��������ĂȂ���΃o�b�t�@�����O������
	GOTO	IT98MK_2	; �ʏ�Make������
IT_RPT1
	MOVF	PC98_DATA,0	; ***�ʏ�̂P�L�[���s�[�g����***
	MOVWF	BKEY
	CALL	KEY_RPT		; �L�[���o�b�t�@�֏�������

	MOVF	PC98_DATA,0
	XORLW	73h		; GRAPH�L�[�̓��s�[�g�����Ȃ�
	BTFSC	STATUS,B2
	GOTO	RPT_CANCEL

	MOVF	PC98_DATA,0
	XORLW	74h		; CTRL�L�[�̓��s�[�g�����Ȃ�
	BTFSC	STATUS,B2
	GOTO	RPT_CANCEL

	MOVF	PC98_DATA,0
	XORLW	38h		; INS�L�[�̓��s�[�g�����Ȃ�
	BTFSC	STATUS,B2
	GOTO	RPT_CANCEL

	MOVF	PC98_DATA,0
	XORLW	70h		; SHIFT�L�[�̓��s�[�g�����Ȃ�
	BTFSC	STATUS,B2
	GOTO	RPT_CANCEL

	CALL	NRM_RPT		; �ʏ탊�s�[�g���������s
RPT_CANCEL
	BSF	SYSFLG,B4	; ���s�[�g���t���O��ݒ�
	GOTO	MAIN
IT_RPT2				; ***���������L�[���s�[�g�p����***
	MOVF	PC98_DATA,0	; �����Make�R�[�h���Ăяo��
	MOVWF	ETC		; �����ETC�֕ۑ�
	MOVF	BKEY,0		; �O���Make�R�[�h���o�b�t�@�֏������ނ���
	MOVWF	PC98_DATA	; �f�[�^�o�b�t�@�֏�������
	CALL	KEY_RPT		; ***�L�[�o�b�t�@�����O�������Ăяo��***
	MOVF	ETC,0		; �ۑ�Make�R�[�h��߂�
	MOVWF	PC98_DATA
IT98MK_2			; �ʏ��Make����
	BSF	SYSFLG,B3	; �L�[��Break�t���O�Z�b�g
	MOVF	PC98_DATA,0	; Make�R�[�h��ۑ�
	MOVWF	BKEY
	CALL	SEND98		; PC98����Make�R�[�h�𑗂�
	GOTO	MAIN
IT98BR
	BCF	SYSFLG,B3	; ����Break���ꂽ�̂Ńt���O���N���A����
	BCF	SYSFLG,B4	; ���s�[�g�t���O���N���A����
	CALL	KBF_BRK2	; ***���s�[�g�I��������***
	MOVLW	0FFh		; ���g�p�L�[�R�[�h
	MOVWF	BKEY		; �O��L�[�N���A
IT98BRK
	BSF	PC98_DATA,B7	; PC98����Break�R�[�h�𑗂�
	CALL	SEND98
	GOTO	MAIN
IT98BR2
	BCF	SYSFLG,B3	; ����Break���ꂽ�̂Ńt���O���N���A
	BCF	SYSFLG,B4	; ���s�[�g�t���O���N���A
	CALL	KBF_BRK2	; ***���s�[�g�I��������***
	BCF	PC98_DATA,B7
	MOVF	PC98_DATA,0
	MOVWF	BKEY
	GOTO	IT98BRK
	;
	; �ʏ�̃��s�[�g����
	;
NRM_RPT
	BSF	PC98_DATA,B7	; Break�R�[�h������
	CALL	SEND98		; BReak�R�[�h�𑗐M
	CALL	WAIT100US
	CALL	WAIT100US
	CALL	WAIT100US
	CALL	WAIT100US
	MOVF	BKEY,0
	ANDLW	01111111B	; Make�R�[�h������
	CALL	SEND98W		; Break�R�[�h�𑗐M
	CALL	WAIT10MS
	RETURN
;
; WAIT FOR 30ms
;
WAIT30MS
	MOVLW	30		; ���s�[�gMake-Break�Ԋu=30ms
	MOVWF	LOOP
WAIT30MSL
	CALL	WAIT1MS
	DECFSZ	LOOP,1
	GOTO	WAIT30MSL
	RETURN
;
; WAIT FOR 10ms
;
WAIT10MS
	MOVLW	10
	MOVWF	LOOP
WAIT10MSL
	CALL	WAIT1MS
	DECFSZ	LOOP,1
	GOTO	WAIT10MSL
	RETURN
;
; �N�����L�[�񑗐M�p�o�b�t�@�����O�������[�`��
; �@�@�\�F�����ꂽ�܂܂ɂȂ��Ă���L�[���C�N�R�[�h���o�b�t�@�֏�������
;
KEY_RPT
	MOVLW	KBF_LEN
	MOVWF	LOOP		; �L�[�o�b�t�@�T�C�Y�����[�v���[�N�ɃZ�b�g
	MOVLW	KBF_BGN
	MOVWF	FSR		; �L�[�o�b�t�@�J�n�A�h���X��FSR�ɃZ�b�g
KEY_SEA				; �L�[�o�b�t�@���ɓ����R�[�h������Ώ������f
	MOVF	PC98_DATA,0
	XORWF	INDF,0
	BTFSC	STATUS,B2
	RETURN
	INCF	FSR,1
	DECFSZ	LOOP,1
	GOTO	KEY_SEA

	MOVLW	KBF_LEN
	MOVWF	LOOP		; �L�[�o�b�t�@�̃T�C�Y�����[�v���[�N�ɃZ�b�g
	MOVLW	KBF_BGN
	MOVWF	FSR		; �L�[�o�b�t�@�J�n�A�h���X��FSR�ɃZ�b�g
KBF_SCAN1			; �L�[�o�b�t�@�𒲂ׂċ󂪂���Ȃ烊�s�[�g
				; Make�R�[�h����������
	MOVF	INDF,0		; �ԐڃA�h���b�V���O�ŃL�[�o�b�t�@�Q��
	XORLW	0FFh		; �Q�Ƃ����o�b�t�@�̓��e��FFh?
	BTFSC	STATUS,B2	; �L�[�o�b�t�@��?
	GOTO	KBF_WRI		; �L�[�o�b�t�@�̋󂫂𔭌������珑�����݂�
	INCF	FSR,1		; �L�[�o�b�t�@�|�C���^+1
	DECFSZ	LOOP,1
	GOTO	KBF_SCAN1
	RETURN			; �L�[�o�b�t�@�t���Ȃ̂Ŗ���
KBF_WRI				; �L�[�o�b�t�@�󂫂ɃL�[�R�[�h����������
	MOVF	PC98_DATA,0	; ���͂��ꂽMake�R�[�h���Ăяo��
	MOVWF	INDF		; ���̃L�[�R�[�h���o�b�t�@�󂫂ɏ�������
	RETURN
;
; �N�����L�[��đ��M����(GRAPH+(1)(2),HELP���̂���)
;�@�@�\:�o�b�t�@���ɗ��܂����L�[�R�[�h�̑��M�������s��
;
KBF_RPT
	MOVLW	KBF_LEN
	MOVWF	LOOP2
	MOVLW	KBF_BGN
	MOVWF	FSR
KBF_RPTL
	MOVF	INDF,0		; �L�[�o�b�t�@���Q��
	XORLW	0FFh
	BTFSC	STATUS,B2	; �L�[�o�b�t�@���g�p?
	GOTO	KBF_NULL	; ���̃o�b�t�@�̏�����
	CALL	WAIT30MS	; 30ms�҂�
	MOVF	INDF,0
	ANDLW	01111111B	; Make�R�[�h������
	CALL	SEND98W		; Make�R�[�h�𑗐M
KBF_NULL
	INCF	FSR,1		; �Q�Ɨp�o�b�t�@�|�C���^���X�V
	DECFSZ	LOOP2,1
	GOTO	KBF_RPTL
	MOVLW	KBF_LEN
	MOVWF	LOOP2
	MOVLW	KBF_BGN
	MOVWF	FSR
	CALL	KBF_BRK2
	BCF	SYSFLG,B4
	RETURN			; ���ׂẴo�b�t�@�����I��
;
; �N�����L�[��đ��M����(GRAPH+(1)(2),HELP���̂���)
;  �@�\:�L�[�o�b�t�@�������ׂď�������
;
KBF_BRK2
	MOVLW	KBF_LEN		; �o�b�t�@�T�C�Y�����[�v���[�N�ɐݒ�
	MOVWF	LOOP
	MOVLW	KBF_BGN		; �o�b�t�@�J�n�A�h���X��FSR�ɐݒ�
	MOVWF	FSR
KBF_SCAN3
	MOVLW	0FFh
	MOVWF	INDF		; �L�[�o�b�t�@�N���A
	INCF	FSR,1		; �L�[�o�b�t�@�|�C���^+1
	DECFSZ	LOOP,1
	GOTO	KBF_SCAN3
	RETURN
;
; PAUSE�L�[�̃��C�N�R�[�h��������
;
PAUSE_KEY0
	MOVLW	7		; 8�o�C�g�����Ă���̂Ŏc��7�o�C�g����M
	MOVWF	ETC
	CALL	PAUSE_DAMMY
	MOVLW	60h		; Pause�L�[��STOP�L�[�Ɋ��蓖�Ă�
	CALL	SEND98W		; Pause�L�[��Break�R�[�h�𔭐����Ȃ��̂�
				; ��O��������B
	CALL	WAIT30MS	; Break����܂�30ms�҂�
	MOVLW	11100000B	; STOP�L�[��Break�R�[�h������
	CALL	SEND98W		; Break�R�[�h�𑗐M
	GOTO	MAIN
;
;  ���������[�`��(�|�[�g�̏�Ԑݒ�,POR�`BAT�����R�[�h��M,�ϐ�������)
;
INITALIZE
	CLRF	SYSFLG
	CLRF	SYSFLG2
	CLRF	LEDDATA
	CLRF	LEDDATA98
	CLRF	PORTA		; DATA & CLK = High
	MOVLW	PINIT_DATA
				; PC98�� RXD�M��=High
				; �������J�n LED�_��
	MOVWF	PORTB
	MOVLW	BAT_RTY_NUM
	MOVWF	ETC
BAT_RTY
	CALL	IBMKEYRX	; BAT����(AAh)����M
	MOVF	PS2_DATA,0
	XORLW	BATOK		; ����I��?
	BTFSC	STATUS,B2
	GOTO	BAT_CHK_OK
	DECFSZ	ETC,1
	GOTO	BAT_RTY
	CALL	ERROR1		; BAT��M�G���[��\��!
BAT_CHK_OK
	BCF	STATUS_LED	; �������I�� LED����
	CLRF	PC98_DATA
	CLRF	PS2_DATA
	MOVLW	0FFh
	MOVWF	BKEY		; �O��L�[�R�[�h�𖳌��R�[�h�ɏ�����

	MOVLW	KBF_LEN
	MOVWF	LOOP
	MOVLW	KBF_BGN
	MOVWF	FSR
KBF_CLR
	MOVLW	0FFh		; �L�[�o�b�t�@���g�p�f�[�^
	MOVWF	INDF		; �L�[�o�b�t�@�𖢎g�p�ɂ���
	INCF	FSR,1
	DECFSZ	LOOP,1
	GOTO	KBF_CLR
	RETURN
;
; �L�[�{�[�h��{�@�\�����̃G���[��LED�_�łɂ���ĕ\��
;
ERROR1
	CALL	CLKDATABIT_HIGH ; CLK & DATA=High
	MOVLW	ERR_DSP_NUM
	MOVWF	WORK
ERROR_DSP_LOOP
	BSF	STATUS_LED
	CALL	DELAY
	CALL	DELAY
	BCF	STATUS_LED
	CALL	DELAY
	CALL	DELAY
	DECFSZ	WORK,1
	GOTO	ERROR_DSP_LOOP
	RETURN
;
;  PC-9801�L�[�f�[�^���M���[�`��(19.2kbps���M)
;
SEND98W
	MOVWF	PC98_DATA	; W=���M�f�[�^�̎��̃G���g��
SEND98
	;
	; �V�X�e���N���b�N=6.144MHz
	;
	IF SYS_CLK == 0
	BTFSC	PORTB,B1	; PC98 Ready?
	GOTO	SEND98
	CLRF	PTCNT		; ParityBitCounter = 0
	MOVLW	8
	MOVWF	LOOP
	BCF	PORTB,B2	; StartBit=Low
	GOTO	$+1
	GOTO	$+1
	NOP			; StartBit Low�`3.906us�҂�
SENDLOOP
	CALL	WAIT45US	; 45.57us
	RRF	PC98_DATA,1
	BTFSC	STATUS,B0	; ���M�r�b�g����
	GOTO	BITHIGH
	NOP
	BCF	PORTB,B2	; DataLine=Low�����܂�3.906us
	GOTO	BITWAIT
BITHIGH
	BSF	PORTB,B2	; DataLine=High
	INCF	PTCNT,1		; ParityBitCoubter +1
	NOP
BITWAIT
	DECFSZ	LOOP,1
	GOTO 	SENDLOOP	; �����܂łł����3.906us������
				; �܂�A1LOOP=3.906x2+45.57=53.382us
	CALL	WAIT45US	; 45.57us�҂�
	CALL	WAIT5US		; 5.208us�҂�
	BTFSC	PTCNT,B0	; �p���e�B�r�b�g����
	GOTO	PARITYOFF
	BSF	PORTB,B2	; ParityBit = High �����܂�1.953us
				; �v45.57uS+5.208us+1.953us=52.731us
	GOTO	BITWAIT2
PARITYOFF
	BCF	PORTB,B2	; ParityBit=Low
	NOP
BITWAIT2
	CALL	WAIT45US
	CALL	WAIT5US		; �����܂�45.57us+5.208us+1.302us=52.08us
	BSF	PORTB,B2	; StopBit=High
	CALL	WAIT45US
	CALL	WAIT5US
	GOTO	$+1		; �����܂�52.08us
	RETURN
CHECKEND
	BTFSC	PORTB,B1	; PC-9801 Rready?
	GOTO	CHECKEND
	RETURN
	ENDIF
	;
	; 98���M:�N���b�N=10MHz�̏ꍇ
	;
	IF SYS_CLK == 1		; �V�X�e���N���b�N=10MHz
	BTFSC	PORTB,B1	; PC98 Ready?
	GOTO	SEND98
	CLRF	PTCNT		; ParityBitCounter = 0
	MOVLW	8
	MOVWF	LOOP
	BCF	PORTB,B2	; StartBit=Low
SENDLOOP
	GOTO	$+1
	GOTO	$+1
	GOTO	$+1		; �v2.4us
	CALL	WAIT45US	; 46us
	RRF	PC98_DATA,1	; ���M�f�[�^��Carry�փV�t�g
	BTFSC	STATUS,B0	; ���M�r�b�g0/1����
	GOTO	BITHIGH
	BCF	PORTB,B2	; DataLine=Low
	GOTO	BITWAIT
BITHIGH
	BSF	PORTB,B2	; DataLine=High
	INCF	PTCNT,1		; ParityBitCoubter +1
BITWAIT
	DECFSZ	LOOP,1
	GOTO 	SENDLOOP	; RRF�`�����܂ł�3.6us������
				; 1LOOP=2.4+3.6+46=52us
	CALL	WAIT45US	; 46us�҂�
	CALL	WAIT5US		; 5.2us�҂�
MAKE_PARITY			; �����܂�51.2us
	BTFSC	PTCNT,B0	; �p���e�B�r�b�g����
	GOTO	PARITY_OFF
PARITY_ON
	BSF	PORTB,B2	; ParityBit=High
	GOTO	BITWAIT2
PARITY_OFF
	BCF	PORTB,B2	; ParityBit=Low
	NOP
BITWAIT2
	CALL	WAIT45US
	CALL	WAIT5US		; PARITY_ON����1.6(0.8)+46+5.2=52.8/52us
	BSF	PORTB,B2	; StopBit = High
	CALL	WAIT45US
	CALL	WAIT5US
	GOTO	$+1		; �����܂�52us
	RETURN
CHECKEND
	BTFSC	PORTB,B1	; PC-9801 Rready?
	GOTO	CHECKEND
	RETURN
	ENDIF
;
; PC-9801����R�}���h��M���[�`��(19.2kbps��M)

RX98KEY
	;
	; �V�X�e���N���b�N=6.144MHz
	;
	IF SYS_CLK == 0
	BTFSC	PORTB,B0	; SB���������肩�炱���ւ�6�`8us���x������
	GOTO	RX98KEY		; �X�^�[�g�r�b�g��҂�
	GOTO	$+1
	NOP
	MOVLW	0FFh		; PC-98 KeyData = FFh
	MOVWF	PC98_DATA
	MOVLW	8
	MOVWF	LOOP2		; �����܂ł�5.859us
	CALL	WAIT10US	; 11.718us
				; �T���v�����O�̂��߃X�^�[�g�r�b�g�����܂ő҂�
	BTFSS	PORTB,B0	; �r�b�g���オ���Ă�����m�C�Y�Ɣ��f���߂�
	GOTO	RX98KEY_OK
	BCF	SYSFLG,B2
	RETURN			; abort RX98KEY
RX98KEY_OK			; �����܂�5.859+11.718+1.304+7=25.881us
	CALL	WAIT45US	; 45.570us�@��������52us�҂�
	CALL	WAIT5US		; 5.208us
	GOTO	$+1		; 45.570us+5.208+1.302us=52.08us�҂ƃr�b�g����
RX98LOOP			; �ǂݍ��݃��[�v
	RRF	PC98_DATA,1
	BTFSS	PORTB,B0
	GOTO	RX98BITL
RX98BITH
	BSF	PC98_DATA,B7	; DataBit=High
	GOTO	RX98END
RX98BITL
	BCF	PC98_DATA,B7	; DataBit=Low
	NOP
RX98END				; RXLOOP���炱���܂�6�N���b�N3.906us
	CALL	WAIT45US
	DECFSZ	LOOP2,1
	GOTO	RX98LOOP	; 1LOOP=3.906us+45.57us+1.953us=51.429us
	CALL	WAIT45US	; Wait for ParityBit
	CALL	WAIT5US
	GOTO	$+1		; �v52.08usS�҂�
	CALL	WAIT5US		; ���S�̂��ߑ҂�
	RETURN			; Not Wait for StopBit
	ENDIF
	;
	; 98��M:�N���b�N=10MHz�̏ꍇ
	;
	IF SYS_CLK == 1		; �V�X�e���N���b�N=10MHz
	BTFSC	PORTB,B0	; SB���������肩�炱���ւ�4�`5us������
	GOTO	RX98KEY		; �X�^�[�g�r�b�g��҂�
	NOP
	MOVLW	0FFh		; PC-98 KeyData = FFh
	MOVWF	PC98_DATA
	MOVLW	8
	MOVWF	LOOP2		; �����܂ł�2.8us
	CALL	WAIT5US		; 11.2+5.2=16.4us
	CALL	WAIT10US
				; �T���v�����O�̂��߃X�^�[�g�r�b�g�����܂ő҂�
	BTFSS	PORTB,B0	; �r�b�g���オ���Ă�����m�C�Y�Ɣ��f���߂�
	GOTO	RX98KEY_OK
	BCF	SYSFLG,B2
	RETURN			; abort RX98KEY
RX98KEY_OK			; �����܂ł̎���2.8+16.4+0.8+4.5(��)=24.5us
	CALL	WAIT45US	; 46us�@��������52us�҂�
	CALL	WAIT5US		; 5.2us
RX98LOOP			; 1�r�b�g��M���[�v
	GOTO	$+1		; 0.8us 46+5.2+0.8=52us�҂ƃr�b�g����
	RRF	PC98_DATA,1
	BTFSS	PORTB,B0
	GOTO	RX98BITL
RX98BITH
	BSF	PC98_DATA,B7	; DataBit=High
	GOTO	RX98END
RX98BITL
	BCF	PC98_DATA,B7	; DataBit=Low
	NOP
RX98END				; RXLOOP���炱���܂�8�T�C�N��=3.2us
	CALL	WAIT45US
	GOTO	$+1
	DECFSZ	LOOP2,1
	GOTO	RX98LOOP	; 1LOOP=3.2us+46us+2.8us=52us
	CALL	WAIT45US	; Wait for ParityBit
	CALL	WAIT5US
	GOTO	$+1		; �v52us�҂�
	CALL	WAIT5US		; ���S�̂��ߑ҂�
	RETURN			; Not Wait for StopBit
	ENDIF
;
; PS/2�L�[�{�[�h���M���[�`��
;
IBMKEYTXW
	MOVWF	PS2_DATA	; W=���M�f�[�^�G���g��
IBMKEYTX
	CLRF	PTCNT		; ParityCounter = 0 
	MOVLW	8
	MOVWF	LOOP
	CALL	CLKBIT_LOW	; CLK=Low(60uS�ȏ�)
	CALL	DATABIT_LOW	; DATA=Low
	CALL	WAIT100US
	CALL	CLKBIT_HIGH	; CLK=High
	CALL	WAIT5US
IMTLP2
	CALL	WAITCLK_LOW	; CLK=Low�܂ő҂��ăf�[�^�r�b�g���M
	CALL	WAIT10US
	RRF	PS2_DATA,1	; ���M�f�[�^���V�t�g���ăL�����[�֓����
	BTFSC	STATUS,B0	; �f�[�^0/1�𔻒肷��
	GOTO	IMTBIT_HI
	CALL	DATABIT_LOW	; DATA=0(Low)
	GOTO	IMTEND
IMTBIT_HI
	CALL	DATABIT_HIGH	; DATA=1(High)
	INCF	PTCNT,1		; ParityCounter +1
IMTEND
	CALL	WAITCLK_HI	; CLK=High�܂ő҂�
	DECFSZ	LOOP,1
	GOTO	IMTLP2

	CALL	WAITCLK_LOW	; CLK=Low�܂ő҂�
	CALL	WAIT10US
	BTFSC	PTCNT,B0
	GOTO	IMT_PARITYOFF
	CALL	DATABIT_HIGH	; ParityBit=High
	GOTO	IMTSTOP
IMT_PARITYOFF
	CALL	DATABIT_LOW	; ParityBit=Low
IMTSTOP
	CALL	WAITCLK_HI	; CLK=High�܂ő҂�
	CALL	WAITCLK_LOW	; CLK=Low�܂ő҂�
	CALL	WAIT10US

	CALL	DATABIT_HIGH	; StopBit=High
	CALL	WAITCLK_HI	; CLK=High�܂ő҂�
	CALL	WAITCLK_LOW	; �L�[�{�[�h������M�������m�F
	CALL	WAITCLK_HI
WAIT_KEYPS			; �L�[�{�[�h���̎�M�������I���܂ő҂�
	BTFSS	DATA_IN		; DataLine�𒲂ׂ�
	GOTO	WAIT_KEYPS
	CALL	CLKBIT_LOW	; CLK��Low�ɂ��ăL�[�{�[�h���M�s�ɂ���
	RETURN
;
; PS/2�L�[�{�[�h��M���[�`��
;
IBMKEYRX
	CALL	CLKDATABIT_HIGH	; CLK & DATA=High�ŃL�[�{�[�h���M�Ƃ���
	CLRF	PS2_DATA
	MOVLW	8
	MOVWF	LOOP
STARTBIT_LOW
	BTFSC	DATA_IN		; Wait for StartBit
	GOTO	STARTBIT_LOW
	CALL	WAITCLK_LOW	; DataLine�̌�ClockLine�����邽��
	CALL	WAITCLK_HI
IKRL1
	RRF	PS2_DATA,1
	CALL	WAITCLK_LOW	; CLK=Low�ɂȂ�̂�҂�
	CALL	WAIT5US
	BTFSC	DATA_IN		; DataBit�𒲂ׂ�
	GOTO	IKRBIT_HIGH
	BCF	PS2_DATA,B7	; DataBit=0(Low)
	GOTO	IKREND
IKRBIT_HIGH
	BSF	PS2_DATA,B7	; DataBit=1(High)
IKREND
	CALL	WAITCLK_HI	; CLK=High�ɂȂ�܂ő҂�
	DECFSZ	LOOP,1
	GOTO	IKRL1
	CALL	WAITCLK_LOW	; ParityBit��CLK=Low�ɂȂ�̂�҂�
	CALL	WAITCLK_HI	; CLK=High�ɂȂ�̂ő҂�
	CALL	WAITCLK_LOW	; StopBit��CLK=Low�ɂȂ�̂�҂�
	CALL	WAITCLK_HI	; CLK=High�ɂȂ�̂ő҂�
;	CALL	WAITCLK_LOW
	CALL	CLKBIT_LOW	; CLK=Low�ɂ��ăL�[�{�[�h���M���֎~����
	RETURN
;
; PC98�L�[�{�[�h����R�}���h����
;
DOWN98COM
	CALL	RX98KEY
	BCF	SYSFLG,B2	; ����R�}���h��M�t���O�N���A
	BSF	STATUS_LED	; ����R�}���h�����󂯕t��LED�\��

	MOVF	PC98_DATA,0
	XORLW	00h		; �L�[�{�[�h���Z�b�g�R�}���h?
	BTFSC	STATUS,B2
	GOTO	DOWN_RESET

	MOVF	PC98_DATA,0
	XORLW	9Fh		; �L�[�{�[�h�^�C�v����R�}���h?
	BTFSC	STATUS,B2	; (LED���\�t�g����ł���L�[�{�[�h��?)
	GOTO	DOWN_KEYTYPE

	MOVF	PC98_DATA,0
	XORLW	9Dh		; �L�[�{�[�hLED����R�}���h?
	BTFSC	STATUS,B2
	GOTO	DOWN_LED

	MOVF	PC98_DATA,0
	XORLW	9Ch		; ���s�[�g���x�R�}���h?
	BTFSC	STATUS,B2
	GOTO	RPT_SPEED

	BTFSS	SYSFLG,B4	; �ȉ����Z�b�g���̃V�X�e���Z�b�g�A�b�v
				; ���j���[�����N�������邽�߂Ƀ��Z�b�g���O
	GOTO	MAIN		; �ɉ����Â����Ă����L�[��𑗐M���邽
	CALL	KBF_RPT		; �߂̏���
	GOTO	MAIN
	;
	; ����I���R�[�h��98�֑���
	;
SENDFA				; �R�}���h����I���R�[�h�𑗂�
	MOVLW	0FAh
	CALL	SEND98W
	RETURN
	;
	; �L�[�{�[�h���Z�b�g�R�}���h
	;
DOWN_RESET
	CALL	KBRESET2	; PS/2�L�[�{�[�h�̃��Z�b�g�͂��Ȃ�
	GOTO	MAIN
	;
	; �L�[�{�[�h�^�C�v�R�}���h
	;  �\�t�g����ł���L�[�{�[�h�ł��邱�Ƃ��V�X�e���֕ԓ�����
	;
DOWN_KEYTYPE
	CALL	SENDFA		; ����I���R�[�h�̂ݑ��M
	CALL	WAIT100US
	MOVLW	0A0h		; A0h,80h��2�o�C�g�𑗐M
	CALL	SEND98W
	CALL	WAIT100US
	MOVLW	80h
	CALL	SEND98W
	GOTO	MAIN
	;
	; �I�[�g���s�[�g���x�R�}���h
	;
RPT_SPEED
	CALL	SENDFA
	CALL	RX98KEY		; Recieve RepeatSpeed
	CALL	SENDFA
	GOTO	MAIN
	;
	; �L�[�{�[�hLED����R�}���h
	;  CAPS,����LED�𐧌䂷��
	;
DOWN_LED
	CALL	SENDFA
	CALL	RX98KEY		; LED����R�[�h����M����
	MOVF	PC98_DATA,0
	MOVWF	LEDDATA98	; Save LEDDATA(98)
	XORLW	60h
	BTFSC	STATUS,B2	; Response LED Status to Host?
	GOTO	DOWN_LED2	;  Yes. Send LED Status to 98

	BCF	LEDDATA,B2	; CapsLockLED OFF
	BTFSC	PC98_DATA,B2	; CAPS LED�_��?
	BSF	LEDDATA,B2	;  Yes. CapsLockLED ON

	IF KB_TYPE == 1
	BCF	LEDDATA,B3	; AX�L�[�{�[�h����LED OFF
	ELSE
	BCF	LEDDATA,B0	; ScrollLockLED OFF
	ENDIF
	BTFSC	PC98_DATA,B3	; ���� LED�_��?
	IF KB_TYPE == 1
	BSF	LEDDATA,B3	;  Yes. AX�L�[�{�[�h����LED ON
	ELSE
	BSF	LEDDATA,B0	;  Yes. ScrollLockLED ON
	ENDIF

	CALL	IBMLED
	CALL	SENDFA
	GOTO	MAIN
DOWN_LED2			; Send LED Status to 98
	MOVF	LEDDATA98,0
	CALL	SEND98W
	CALL	WAIT100US
	CALL	SENDFA
	GOTO	MAIN
;
; �R�[�hE0h�V�t�g�Ȃ��L�[�R�[�hPC98�L�[�R�[�h�ϊ����[�`��
;
IT98CNV1:
	MOVF	PS2_DATA,0
	XORLW	11h
	BTFSC	STATUS,B2
	GOTO	KEY62		; ALT(R)

	MOVF	PS2_DATA,0
	XORLW	14h
	BTFSC	STATUS,B2
	GOTO	KEY64		; CTRL(R)

	MOVF	PS2_DATA,0
	XORLW	5Ah
	BTFSC	STATUS,B2
	GOTO	KEY108		; ENTER(TEN)

	MOVF	PS2_DATA,0
	XORLW	4Ah
	BTFSC	STATUS,B2
	GOTO	KEY95		; /(TEN)

	MOVF	PS2_DATA,0
	XORLW	1Fh
	BTFSC	STATUS,B2
	GOTO	KEYLW		; ��WIN

	MOVF	PS2_DATA,0
	XORLW	27h
	BTFSC	STATUS,B2
	GOTO	KEYRW		; �EWIN

	MOVF	PS2_DATA,0
	XORLW	2Fh
	BTFSC	STATUS,B2
	GOTO	KEYAP		; �A�v��
	MOVF	PS2_DATA,0

	MOVF	PS2_DATA,0	; (��)SUBLW�͒l-W���W�X�^
	SUBLW	68h		; 69h�ȏゾ��CARRY=0�i���Z���ʕ��j
				; (��)PIC�ł͌��Z��CARRY=0�� CARRY=1���ł���!
	BTFSC	STATUS,B0
	RETLW	0FFh		; CARRY=1����68h�ȉ��Ȃ̂Ŏ��s
	MOVF	PS2_DATA,0
	SUBLW	7Eh		; 7Fh�ȏゾ��CARRY=0�i���Z���ʕ��j
	BTFSS	STATUS,B0
	RETLW	0FFh		; CARRY=0����7Fh�ȏ�Ȃ̂Ŏ��s
	MOVLW	69h		; �L�[�R�[�h�␳�p�I�t�Z�b�g�l
	SUBWF	PS2_DATA,0	; �I�t�Z�b�g�����(���jPS2_DATA=PS2_DATA - W
	GOTO	EXCODE697E	; 300h����̕ϊ����[�`���ցi100h���E�΍�)
	;
	; 69h�ȉ���E0�R�[�h�ϊ�
	;
KEYRW
	RETLW	77h		; Windows(L)�L�[(98)
KEYLW
	RETLW	78h		; Windows(R)�L�[(98)
KEYAP
	RETLW	79h		; �A�v���P�[�V�����L�[(98)

KEY62
	IF KB_TYPE == 0 | KB_TYPE == 1
	RETLW	35h		; ALT(R) -> XFER(98) 101/104/AX
	ELSE
	RETLW	73h		; ALT(R) -> GRAPH(98) 106/104/HHK
	ENDIF
KEY64
	IF KB_TYPE == 0
	RETLW	51h		; CTRL(R) -> NFER(98) 101/104
	ENDIF
	IF KB_TYPE == 1
	RETLW	72h		; ����(AX) -> ����(98) AX
	ENDIF
	IF KB_TYPE == 2 | KB_TYPE == 3
	RETLW	74h		; CTRL(R) -> CTRL(98) 106/109/HHK
	ENDIF
KEY95
	RETLW	41h		; /(TEN98)
KEY108
	RETLW	1Ch		; ENTER -> RETURN(98)
;
; PS/2�L�[�{�[�h���������[�`��
;
KBRESET
	MOVLW	0FFh		; RESET�R�}���h���M
	CALL	IBMKEYTXW
	CALL	IBMKEYRX	; ACK��M
	CALL	WAIT100US
	CALL	IBMKEYRX	; BAT�����R�[�h�̎�M�����݂�
	MOVF	PS2_DATA,0
	XORLW	BATOK		; BAT����?
	BTFSS	STATUS,B2
	CALL	ERROR1		; �L�[�{�[�h�G���[
KBRESET2			; RESET�R�}���h(���Ԃ�������)�Ȃ��G���g��
	BCF	SYSFLG,B5	; LED���[�N������
	BCF	SYSFLG,B6
	CLRF	LEDDATA
	CLRF	LEDDATA98
	MOVLW	0F3h		; �^�C�v�}�e�B�b�N���[�g��ݒ肷��
	CALL	IBMKEYTXW
	CALL	IBMKEYRX
	MOVLW	20h		; �^�C�v�}�e�B�b�N�f�[�^
	CALL	IBMKEYTXW
	CALL	IBMKEYRX
;
; NumLock LED����
;
NUM_ON
				; NumLock LED��_��
	BSF	SYSFLG,B7
	BSF	LEDDATA,B1
	GOTO	IBMLED
NUM_OFF
	BCF	SYSFLG,B7
	BCF	LEDDATA,B1
	GOTO	IBMLED
;
; CAPS LED����
;
CAP_ON
	BSF	LEDDATA,B2
	GOTO	IBMLED
CAP_OFF
	BCF	LEDDATA,B2
	GOTO	IBMLED
;
; ����LED����
;
KANA_ON
	IF KB_TYPE == 1
	BSF	LEDDATA,B3	; AX�L�[�{�[�h����LED
	ELSE
	BSF	LEDDATA,B0	; ScrollLock LED
	ENDIF
	GOTO	IBMLED
KANA_OFF
	IF KB_TYPE == 1
	BCF	LEDDATA,B3	; AX�L�[�{�[�h����LED
	ELSE
	BCF	LEDDATA,B0	; ScrollLock LED
	ENDIF
;
; PS/2�L�[�{�[�h��LED�𐧌䂷��
;
IBMLED
	MOVLW	0EDh
	CALL	IBMKEYTXW
	CALL	IBMKEYRX
	MOVF	LEDDATA,0
	CALL	IBMKEYTXW
	CALL	IBMKEYRX
	RETURN
;
; CLK=High�܂ő҂��[�`��
;
WAITCLK_HI
	BTFSS	CLK_IN
	GOTO	WAITCLK_HI
	RETURN
;
; CLK=Low�܂ő҂��[�`��
;
WAITCLK_LOW
	BTFSC	CLK_IN
	GOTO	WAITCLK_LOW
	RETURN
;
; PS/2�M�����x������ with I/O Direction Controle
;  High: I/O Pin=Input
;  Low:  I/O Pin=Output & Logic 0
;
CLKBIT_HIGH			; *** CLK = High ***
	IF MODEL == 1
	CLK_PORT_IN
	RETURN
	ELSE
	BCF	CLK_OUT
	RETURN
	ENDIF
CLKBIT_LOW			; *** CLK = Low  ***
	IF MODEL == 1
	CLK_PORT_OUT
        BCF	CLK_OUT
	RETURN
	ELSE
	BSF	CLK_OUT
	RETURN
	ENDIF
DATABIT_HIGH			; *** DATA = High ***
	IF MODEL == 1
	DATA_PORT_IN
	RETURN
	ELSE
	BCF	DATA_OUT
	RETURN
	ENDIF
DATABIT_LOW			; *** DATA = Low  ***
	IF MODEL == 1
	DATA_PORT_OUT
        BCF	DATA_OUT
	RETURN
	ELSE
	BSF	DATA_OUT
	RETURN
	ENDIF
CLKDATABIT_HIGH			; *** DATA & CLK = High ***
	IF MODEL == 1
        BSF	STATUS,RP0	; OPTION and TRISx are in upper data page
	BSF	TRISA,DATA_BIT	; Output change
	BSF	TRISA,CLK_BIT	; Output change
        BCF	STATUS,RP0	; Select page 0
	RETURN
	ELSE
	BCF	DATA_OUT
	BCF	CLK_OUT
	RETURN
	ENDIF
;
;  100uS WAIT���[�`��
; (6.144MHz:82.944us+3.255us+5.208x2=96.615us)
; (10.00MHz:51.2usx2+1.6uS=104uS)
;
WAIT100US
	CLRF	TMR0
WL1
	IF SYS_CLK == 0		; �V�X�e���N���b�N=6.144MHz
	MOVLW	1
	ENDIF
	IF SYS_CLK == 1		; �V�X�e���N���b�N=10MHz
	MOVLW	2
	ENDIF
	SUBWF	TMR0,0
	BTFSS	STATUS,B0
	GOTO	WL1
	IF SYS_CLK == 0		; �V�X�e���N���b�N=6.144MHz
	CALL	WAIT10US
	CALL	WAIT10US
	ENDIF
	RETURN
;
; 45uS WAIT���[�`��
; (6.144MHz:CALL+SUB+RET = 45.570uS)
; (10.00MHz:CALL+SUB+RET = 46.000uS
;
WAIT45US
	IF SYS_CLK == 0		; �V�X�e���N���b�N=6.144MHz
	MOVLW	21		; 1
	ENDIF
	IF SYS_CLK == 1
	MOVLW	36		; �V�X�e���N���b�N=10MHz
	ENDIF
	MOVWF	WAIT0		; 1
WL2
	DECFSZ	WAIT0,1		; 1
	GOTO	WL2		; 2
	NOP			; 1
	RETURN			; 2
;
; 5us WAIT���[�`��
; (CLK=6.144MHz:CALL+SUB+RET = 5.208uS)
; (CLK=10.00MHz:CALL+SUB+RET = 5.200uS)
;
WAIT5US
	IF SYS_CLK == 0		; �V�X�e���N���b�N=6.144MHz
	GOTO	$+1
	GOTO	$+1
	ENDIF
	IF SYS_CLK == 1		; �V�X�e���N���b�N=10MHz
	GOTO	$+1
	GOTO	$+1
	GOTO	$+1
	GOTO	$+1
	NOP
	ENDIF
	RETURN
;
; 10us WAIT���[�`��
; (CLK=6.144MHz:CALL+SUB+RET = 11.718us)
; (CLK=10.00MHz:CALL+SUB+RET = 11.200us)
;
WAIT10US
	CALL	WAIT5US
	CALL	WAIT5US
	RETURN
;
; �����ԃ^�C�}�[(��500mS)
;
DELAY
	MOVLW	5
	MOVWF	WAIT1
DELAY1
	IF SYS_CLK == 0		; �V�X�e���N���b�N=6.144MHz
	MOVLW	100
	ENDIF
	IF SYS_CLK == 1		; �V�X�e���N���b�N=10MHz
	MOVLW	98
	ENDIF
	MOVWF	WAIT2
DELAY2
	CALL	WAIT1MS
	DECFSZ	WAIT2,1
	GOTO	DELAY2
	DECFSZ	WAIT1,1
	GOTO	DELAY1
	RETURN
;
; 1mS�^�C�}�[
;
WAIT1MS
	CLRF	TMR0
WAIT1MS1
	IF SYS_CLK == 0		; �V�X�e���N���b�N=6.144MHz
	MOVLW	12
	ENDIF
	IF SYS_CLK == 1		; �V�X�e���N���b�N=10MHz
	MOVLW	20
	ENDIF
	SUBWF	TMR0,0
	BTFSS	STATUS,B0
	GOTO	WAIT1MS1
	RETURN
;
; E0�R�[�h69h�`7Eh�܂ł̕ϊ����[�`��
;
	ORG 335h
EXCODE697E
	MOVWF	WORK
	MOVLW	3
	MOVWF	PCLATH
	MOVF	WORK,0
	ADDWF	PCL,1

	IF ROLL == 1		; PAGE�L�[�A�T�C��
	RETLW	37h		; 69 END -> ROLL DOWN(�t)
	ELSE
	RETLW	36h		; 68 END -> ROLL UP(�ʏ�)
	ENDIF

	RETLW	0FFh		; 6A xx
	RETLW	3Bh		; 6B LEFT
	RETLW	3Eh		; 6C HOME
	RETLW	0FFh		; 6D xx
	RETLW	0FFh		; 6E xx
	RETLW	0FFh		; 6F xx
	RETLW	38h		; 70 INSERT
	RETLW	39h		; 71 DELETE
	RETLW	3Dh		; 72 DOWN
	RETLW	0FFh		; 73 xx
	RETLW	3Ch		; 74 RIGHT
	RETLW	3Ah		; 75 UP
	RETLW	0FFh		; 76 xx
	RETLW	0FFh		; 77 xx
	RETLW	0FFh		; 78 xx
	RETLW	0FFh		; 79 xx

	IF ROLL == 1		; PAGE�L�[�A�T�C��
	RETLW	36h		; 7A PAGE DOWN -> ROLL UP(�t)
	ELSE
	RETLW	37h		; 7A PAGE DOWN -> ROLL DOWN(�ʏ�)
	ENDIF

	RETLW	0FFh		; 7B xx
	RETLW	61h		; 7C PRINT SCREEN

	IF ROLL == 1		; PAGE�L�[�A�T�C��
	RETLW	37h		; 7D PAGE UP -> ROLL DOWN(�t)
	ELSE
	RETLW	36h		; 7D PAGE UP -> ROLL UP(�ʏ�)
	ENDIF
PAUSE_KEY1			; 7E PAUSE + CTRL Make�R�[�h
	MOVLW	5		; 5�o�C�g�����Ă��邽�ߎc��4�o�C�g����M
	MOVWF	ETC
	CALL	PAUSE_DAMMY
	MOVLW	84h		; ���̂�CTRL��Break�R�[�h���o�Ȃ��̂�
				; �����98����Break�R�[�h���o��
	CALL	SEND98W
	RETLW	0FFh
PAUSE_DAMMY
	CALL	IBMKEYRX
	DECFSZ	ETC,1
	GOTO	PAUSE_DAMMY
	RETLW	0FFh
;
; PS/2�L�[�R�[�h����PC98�L�[�R�[�h�ϊ����[�`��
;
CNVITO98
	MOVWF	WORK
	SUBLW	83h		; 84h�ȏゾ������CARRY��0(��)
	BTFSC	STATUS,B0
	GOTO	CNVITO98OK	; �L�[�R�[�h����Ȃ̂ŕϊ�������
	RETLW	0FFh		; �L�[�R�[�h�ϊ��G���[
CNVITO98OK
	MOVLW	3
	MOVWF	PCLATH
	MOVF	WORK,0
	ADDWF	PCL,1
	RETLW	0FFh		; 00 xx
	RETLW	6Ah		; 01 F9
	RETLW	0FFh		; 02 xx
	RETLW	66h		; 03 F5
	RETLW	64h		; 04 F3
	RETLW	62h		; 05 F1
	RETLW	63h		; 06 F2
	RETLW	53h		; 07 F12
	RETLW	0FFh		; 08 xx
	RETLW	6Bh		; 09 F10
	RETLW	69h		; 0A F8
	RETLW	67h		; 0B F7
	RETLW	65h		; 0C F4
	RETLW	0Fh		; 0D TAB

	IF KB_TYPE == 0 | KB_TYPE == 1 | KB_TYPE == 3
	RETLW	0Dh		; 0E '/~(101/104/AX/HHK) -> \
	ELSE
	RETLW	35h		; 0E ���p/�S�p(106/109)
	ENDIF

	RETLW	0FFh		; 0F xx
	RETLW	0FFh		; 10 xx
	RETLW	73h		; 11 Alt
	RETLW	70h		; 12 Shift(L)
	RETLW	72h		; 13 ����
	RETLW	74h		; 14 Ctrl
	RETLW	10h		; 15 Q
	RETLW	01h		; 16 1
	RETLW	51h		; 17 xx (AX:���ϊ�) -> NFER
	RETLW	0FFh		; 18 xx
	RETLW	0FFh		; 19 xx
	RETLW	29h		; 1A Z
	RETLW	1Eh		; 1B S
	RETLW	1Dh		; 1C A
	RETLW	11h		; 1D W
	RETLW	02h		; 1E 2
	RETLW	034h		; 1F xx (AX:�ϊ�) -> �X�y�[�X
	RETLW	0FFh		; 20 xx
	RETLW	2Bh		; 21 C
	RETLW	2Ah		; 22 X
	RETLW	1Fh		; 23 D
	RETLW	12h		; 24 E
	RETLW	04h		; 25 4
	RETLW	03h		; 26 3
	RETLW	78h		; 27 xx (AX:AX�L�[) -> Windows(L)�L�[
	RETLW	0FFh		; 28 xx
	RETLW	34h		; 29 Space
	RETLW	2Ch		; 2A V
	RETLW	20h		; 2B F
	RETLW	14h		; 2C T
	RETLW	13h		; 2D R
	RETLW	05h		; 2E 5
	RETLW	0FFh		; 2F xx
	RETLW	0FFh		; 30 xx
	RETLW	2Eh		; 31 N
	RETLW	2Dh		; 32 D
	RETLW	22h		; 33 H
	RETLW	21h		; 34 G
	RETLW	15h		; 35 Y
	RETLW	06h		; 36 6
	RETLW	0FFh		; 37 xx
	RETLW	0FFh		; 38 xx
	RETLW	0FFh		; 39 xx
	RETLW	2Fh		; 3A M
	RETLW	23h		; 3B J
	RETLW	16h		; 3C U
	RETLW	07h		; 3D 7
	RETLW	08h		; 3E 8
	RETLW	0FFh		; 3F xx
	RETLW	0FFh		; 40 xx
	RETLW	30h		; 41 ,
	RETLW	24h		; 42 K
	RETLW	17h		; 43 I
	RETLW	18h		; 44 O
	RETLW	0Ah		; 45 0
	RETLW	09h		; 46 9
	RETLW	0FFh		; 47 xx
	RETLW	0FFh		; 48 xx
	RETLW	31h		; 49 .
	RETLW	32h		; 4A /
	RETLW	25h		; 4B L
	RETLW	26h		; 4C ;
	RETLW	19h		; 4D P
	RETLW	0Bh		; 4E -
	RETLW	0FFh		; 4F xx
	RETLW	0FFh		; 50 xx
	RETLW	33h		; 51 BackSlash
	RETLW	27h		; 52 :
	RETLW	0FFh		; 53 xx
	RETLW	1Ah		; 54 @
	RETLW	0Ch		; 55 ^
	RETLW	0FFh		; 56 xx
	RETLW	0FFh		; 57 xx

	IF CAPS_ASSIGN == 0	; CAPS/�p���L�[�̃A�T�C��
	RETLW	71h		; 58 �p��/CapsLock -> CAPS
	ELSE
	RETLW	74h		; 58 �p��/CapsLock -> CTRL
	ENDIF

	RETLW	70h		; 59 Shift(R)
	RETLW	1Ch		; 5A Return
	RETLW	1Bh		; 5B [
	RETLW	0FFh		; 5C xx
	RETLW	28h		; 5D ]
	RETLW	0FFh		; 5E
	RETLW	0FFh		; 5F xx
	RETLW	0FFh		; 60 xx
	RETLW	033h		; 61 (�\��) (AX:_ -> _ )
	RETLW	0FFh		; 62 xx
	RETLW	0FFh		; 63 xx
	RETLW	035h		; 64 �ϊ�
	RETLW	0FFh		; 65 xx
	RETLW	0Eh		; 66 BS
	RETLW	051h		; 67 ���ϊ�
	RETLW	0FFh		; 68 xx
	RETLW	4Ah		; 69 1(TEN)
	RETLW	0Dh		; 6A \
	RETLW	46h		; 6B 4(TEN)
	RETLW	42h		; 6C 7(TEN)
	RETLW	0FFh		; 6D xx
	RETLW	0FFh		; 6E xx
	RETLW	0FFH		; 6F xx
	RETLW	04Eh		; 70 0(TEN)
	RETLW	50h		; 71 .(TEN)
	RETLW	4Bh		; 72 2(TEN)
	RETLW	47h		; 73 5(TEN)
	RETLW	48h		; 74 6(TEN)
	RETLW	43h		; 75 8(TEN)
	RETLW	00h		; 76 Esc
	RETLW	0FEh		; 77 NumLock
	RETLW	52h		; 78 F11
	RETLW	49h		; 79 +(TEN)
	RETLW	4Ch		; 7A 3(TEN)
	RETLW	40h		; 7B -(TEN)
	RETLW	45h		; 7C *(TEN)
	RETLW	44h		; 7D 9(TEN)
	RETLW	3Fh		; 7E ScrollLock(=>HELP)
	RETLW	0FFh		; 7F xx
	RETLW	0FFh		; 80 xx
	RETLW	0FFh		; 81 xx
	RETLW	0FFh		; 82 xx
	RETLW	068h		; 83 F7
;
; PS/2��NumLock�L�[�V�t�gPS/2�L�[�R�[�h�ϊ��e�[�u��
;
CNVNUM
	MOVWF	WORK
	MOVLW	3
	MOVWF	PCLATH
	MOVF	WORK,0
	ADDWF	PCL,1

	IF ROLL == 1		; PAGE�L�[�A�T�C��
	RETLW	37h		; 69 1(TEN)End -> ROLL DOWN(�t)
	ELSE
	RETLW	36h		; 69 1(TEN)End -> ROLL UP(�ʏ�)
	ENDIF

	RETLW	0Dh		; 6A \
	RETLW	3Bh		; 6B 4(TEN) -> LEFT
	RETLW	3Eh		; 6C 7(TEN) -> HOME
	RETLW	0FFh		; 6D xx
	RETLW	0FFh		; 6E xx
	RETLW	0FFH		; 6F xx
	RETLW	038h		; 70 0(TEN) -> INS
	RETLW	39h		; 71 .(TEN) -> DEL
	RETLW	3Dh		; 72 2(TEN) -> DOWN
	RETLW	0FFh		; 73 5(TEN)
	RETLW	3Ch		; 74 6(TEN) -> RIGHT
	RETLW	3Ah		; 75 8(TEN) -> UP
	RETLW	00h		; 76 Esc
	RETLW	0FEh		; 77 NumLock
	RETLW	52h		; 78 F11
	RETLW	49h		; 79 +(TEN)

	IF ROLL == 1		; PAGE�L�[�A�T�C��
	RETLW	36h		; 7A 3(TEN)PageDown -> ROLL UP(�t)
	ELSE
	RETLW	37h		; 7A 3(TEN)PageDown -> ROLL DOWN(�ʏ�)
	ENDIF

	RETLW	40h		; 7B -(TEN)
	RETLW	45h		; 7C *(TEN)

	IF ROLL == 1		; PAGE�L�[�A�T�C��
	RETLW	37h		; 7D 9(TEN)PageUp -> ROLL DOWN(�t)
	ELSE
	RETLW	36h		; 7D 9(TEN)PageUp -> ROLL UP(�ʏ�)
	ENDIF

	END
