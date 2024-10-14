;
; PC-9801 to PS/2 Keyboard Adaptor 'GKA-98AT' Ver1.28
;  1998 Programmed by m.sawada/magonote honpo
;
;  LAST UPDATE 2003/12/8��
;
; KEY1M���x�[�X�ɊJ���J�n(4/9)
; �⏕���u��PS/2���M�E��M���[�`����ǉ���(4/17)
; ��{����(AT�F��,�L�[�ϊ�)���\�ɂȂ���(7/13)
; CAPS,���Ȃ�PC98�p�������O���Ďg�p�\�ɂ���(10/29)
; PC-98�ł�CAPS,���Ȃ̓g�O�������M/B�R�[�h�𑗂邽�߁A�Ή�(11/26)
; F7�L�[�͂Ȃ�ƃr�b�g7��1�Ȃ̂�E0h���肪�듮�삷�邽�ߗ�O�őΉ�(12/8)
; LED����R�}���h��肱�ڂ�����̂���CAPS,���ȃu���C�N�R�[�h��x��
; ���M����悤�ɃJ�E���^��݂����B(12/17)
; LED��Ԃ�TMR0�Ŗ�1.1s�Ԋu�ōĐݒ���s���悤�ɂ���(1/7)
; Windows�L�[,Aplication�L�[�ɑΉ�(1/8)
; SOYO/5EMM�ŉ���LED�s���PS/2����R�}���h��LED��������Ȃ�(2/1)
; GA686BX����LED�s���CAPS,���ȃu���C�N���M�E�G�C�g��110mS�ɐݒ�(2/1)
; SOYO/5EMM�d��ON����~��98�L�[�{�[�h��M��StartBit�^�C���A�E�g��ǉ�(2/1)
; ���と98�L�[�{�[�h��M�G���[���ɂ�MAIN�֕��A(2/1)
; LED��ԍĐݒ�Ԋu��1.0s�ɒ���(2/1)
; PS/2���M�X�^�[�g�r�b�g?�N���b�N�����オ��Ԋu35us��70us�ɕύX(2/1)
; �L�[�̎�肱�ڂ���LED�Đݒ�͉���R�}���h,CAPS,���ȃu���C�N��0.5s�̂�(2/2)
; �L�[���s�[�g��~�R�}���h�ɂăL�[�{�[�h���s�[�g��~(3/29)
; ���s�[�g�����@�\�ǉ�(�f�B���C�A�^�C�v�}�e�B�b�N�ʂɐݒ�\)(3/30)
; ThinkPAD220�ɂăL�[�̎�肱�ڂ��������������߁A�^�C�v�}�e�b�N�𐧌�(4/7)
; ���s�[�g������ϊ����Ȃ����L�[�{�[�h���[�h�A���s�[�g��PS/2�݊��ɂł���
; �V�L�[�{�[�h���[�h��؂�ւ��\�ɂ��AEEROM�ɋL���ł���悤�ɂ���(4/7)
; �V�E���L�[�{�[�h���[�h��CTRL+SHIFT+GRPAH(ALT)�Ő؂�ւ���悤�ɂ���(4/7)
; E0h,F0h�Ȃǂ̃v���t�B�N�X�ƃR�[�h���M�Ԋu��4mS�Ƃ���
;
; *AIR���ؑ֊�V���[�g�J�b�g��肱�ڂ��΍��PS2�f�o�C�X���M���[�`������(5/11)
;  1.�N���b�NHIGH���Ԃ��Œ�ł�10us�m�ۂ���悤�ɂ����B
;  2.�N���b�N�����44us�Ɖ��������B
;  3.�N���b�N�ƃX�^�[�g�r�b�g�̊Ԋu��10US�J�����B
;  4.�p���e�B�E�X�g�b�v�r�b�g�̃^�C�~���O�𐳂����C�������B
; *THINKPAD220�̂悤�ȒᑬPC�œ��͕�����������΍�
;  1.���M���̃N���b�NHIGH���ԂɃ��C�����Ď���LOW�����o���čđ��M��������(5/11)
;
; �L�[�{�[�h���[�h�̈Ⴂ�ɂ��d���������ƃ��[�h�؂�ւ����쎞��LED�\������
; �悤�ɂ����B�����[�h:ON��OFF �V���[�h:ON��OFF��ON��OFF (5/21)
; PS/2����^�C�~���O����(���MT2����=20us,CLK-Hi/Low����=40us)(5/25)
; PS/2�đ��M�R�}���h�����ł����ƒ��O�̑��M�f�[�^�𑗂�悤�ɏC��(5/26)
; �V�L�[�{�[�h�œd���ē������Ȃ��Ă����L�[�{�[�h���[�h���g�p���邽�߁A
; �؂�ւ����Ƀ��s�[�g�ĊJ�R�}���h9Ch,51h�𑗂�悤�ɂ���(5/26)
; AIR����PC�؂�ւ���̃L�[����Ƌ�������̂Ń��[�h�؂�ւ��L�[�A�T�C����
; �ύX����(���p/�S�p+CTRL+SHIFT)(5/26)
; �e���L�["="�L�[���t���L�[���̃R�[�h���g�����M�ł���悤�ɂ���(6/21)
; ���p/�S�p��ESC�̃A�T�C�������ւ��ASTOP=���p/�S�p,ESC=ESC�Ƃ���(8/16)
; ����ɔ����A���[�h�؂�ւ���ESC+CTRL+SHIFT)�ƂȂ���(8/16)
; Windows�L�[�t���̃L�[�{�[�h�𔻕ʂ���Win95�L�[��L���ɂ���(9/23)
; Ctrl+Pause,PrintScreen�̃R�[�h���o�͂���悤�ɂ���(10/11)
; Shift/Ctrl/Alt+PrintScreen�̃R�[�h�������������������s���œ���(10/11)
;
; DIGITAL WAVE��D-BOARD�ɑΉ��B�����I�u�W�F�N�g�w��ɂ��ALED����OFF,
; ALT+�J�i=SHIFT+�J�i(Make-Break),ALT+ESC=�J�i(Make-Break),KB���[�h�ݒ�OFF
; �ȏ�̐ݒ�ƂȂ�(10/14)
;
; NEC mobioNX MB-12C�p�̑΍�(11/30)
; �����̓L�[�{�[�h�R�}���h�ȊO�̃R�}���h�𑗐M���ăL�[�{�[�h���đ��v��(FEh)
; ��Ԃ��Ă��邩���`�F�b�N���Ă���B���ꂪ�p�X���Ȃ��ƊO���L�[�{�[�h��F��
; ���Ȃ��B�܂��A�V�X�e������L�[�{�[�h�ւ̃R�}���h���M���ɃN���b�NLow���Ԃ�
; 300us�ȏ㑱�����Ƃ����邽�߁A����ɑΉ����邽�ߊĎ��^�C���A�E�g���Ԃ�500us
; �ȏ�m�ۂ����B����ɂ���Ċ����}�������F���ł���悤�ɂȂ����B
; 
; ROLL UP/DOWN�̃A�T�C�����\�[�X��œ���ւ�����悤�ɂ����B(2000/1/15)
; `,~(�`���_)������ʂ�ɓ��͂ł���悤��SHIFT���ɃL�[�R�[�h�����ւ���
; ���悤�ɂ���(�\�[�X�Ŏw��)(2/29)
; NOPx2 = GOTO $+1�ɒu�������ăR�[�h�T�C�Y�k��(3/1)
; �f�o�b�O�pLED�\����#DEFINE��ON/OFF����悤�ɂ���(3/1)
; D-BOARD�Ή��ɂāAALT(DB)+ESC,ESC�̃A�T�C�����t�������̂ŏC��(3/15)
;
; PS/2�s����d���}�V���΍�(���Z�b�gIC+KB�d���R���g���[����H�p�R�[�h)(4/27)
; �������:���Z�b�gIC�ɂ��VCC�������PIC���X�^�[�g���A���̌��
;          PC98�L�[�{�[�h�̓d����I/O�|�[�g����Tr�𐧌䂵ON�ɂ���B
;          ����Œ����Ԃ̕s����d���ɂ����Ă�PIC�̊m���ȃX�^�[�g��
;          PC98�L�[�{�[�h�̃n���O�A�b�v��h�����Ƃ��ł���B
; *�e�X�g����PC�ł�PC-98�L�[�{�[�h�d��ON���ɂ�VCC��0.5V���x�ቺ���邽��
;  ���Z�b�g���o�d����4.0V���x���]�܂����B4.5V���ƍă��Z�b�g����������B
;   (���Z�b�gIC�ɎO�HM62022���g�p)
;  �������d������|�[�g(RB5)�̏�Ԃ͕ێ�(Low)����邽��CALL DELAY�ɂ��
;  �҂����Ԃ݂̂��������邪�A���Z�b�g�M����Low�̊Ԃ�PIC�̃|�[�g�d�����ϓ�
;  ���邽��(�n�C�E�C���s�[�_���X?)�d���g�`���K�i��ɂȂ艘���Ȃ�B
;  ���ꂢ�ȓd��ON�g�`����������ɂ̓��Z�b�g���o�d����4.0V���x�ɂ��čă��Z�b�g
;  ���������K�v������B(4/27)
;
;  �L�[��������LED����������悤�ɂ���(5/12)
;  ThinkPad220�{�̓d���X�C�b�`�œd����������ƔF������Ȃ����Ƃ�����(9/18)
;  Windows�L�[�L�����ɉESHIFT�L�[�������Ȃ��s����C��(9/19)
;
;  Windows�L�[�t���L�[�{�[�h���胋�[�`���҂����Ԃ�505->300ms�ɒZ�k���A
;  ThinkPad220�{�̃X�C�b�`�ł̓d�������ŔF������Ȃ��s��ɑΉ�(9/19)
;
;  PrintScreen��O���������������ɔ[�܂����̂Ńf�t�H���g�L���ɂ���(9/19)
;  10MHz����Win95�L�[����Ɏ��s����s����C��(10/30)
;  ���Z�b�g�R�}���h��LED�����ׂď�������悤�ɂ���(2002/11/22)
;  (���d�L��PC�ɂēd��OFF����LED���_�������܂܂ɂȂ�s��΍�)
;  MPLAB�W���C���N���[�h�t�@�C���ɐ؂�ւ�(2003/4/12)
;  �\�[�X����CONFIG BIT��ݒ肷��悤�ɂ���(4/12)
;  D-Board�w�莞��WindowsKey�ݒ肪OFF�ɂȂ�悤�ɂ���(7/13)
;  �L�[�{�[�h�G�~�����[�^���[�h(98�L�[�{�[�h����)�ɑΉ�(7/13)
;  �L�[�{�[�h���Z�b�g��H���䏈��(KB_POR)�폜(12/2)
;  TeamPlusPCB(I/O direction����)�Ή�(LED�̂�Bit4/JDM Writer)(12/3)
;  �������s���̂��߃^�C�}���[�`�������ʉ����ďȃ�������(12/3)
;  �E�G�C�g���[�`�������ʉ����Ĕ��������폜���ȃ�������(12/4)
;  PLUS PCB���l�����ăX�^�[�g��PortA�o�̓��b�`��Low(0)�ɂ���(12/4)
;
;	RADIX		DEC
;	PROCESSOR	16F84A
;	INCLUDE		"P16F84A.INC"
;	__CONFIG _CP_OFF & _WDT_OFF & _HS_OSC & _PWRTE_ON
;	__IDLOCS	H'0001'
	RADIX		DEC
	PROCESSOR	16F648A
	INCLUDE		"P16F648A.INC"
	__CONFIG _CP_OFF & _WDT_OFF & _HS_OSC & _PWRTE_ON & _MCLRE_ON & _LVP_OFF
	__IDLOCS	H'0001'
;
; �����I�u�W�F�N�g�ݒ�
;
#DEFINE	SYS_CLK 	1	; �V�X�e���N���b�N 0=6.144MHz 1=10MHz
#DEFINE	PRINTSCREEN	1	; PrintScreen��O 0=���� 1=�L��
#DEFINE	D_BOARD		0	; D-Board�Ή� 0=PC-98KB 1=D-Board
#DEFINE LED_CTRL	1	; 98KEYBOARD LED CONTROLE 0=Disable 1=Enable
#DEFINE WIN95KEY_CHK	1	; Windows95KEY CHECK 0=Diasable 1=Enable
#DEFINE ROLL		0	; PAGE ASSIGN 0=PageUp->R.DOWN PageDown->R.UP
				;             1=PageUP->R.UP PageDown->R.Down
#DEFINE KEY_EXCHG	1	; KEY EXCHAGE+SHIFT 0=Not 1=Excange
#DEFINE DEBUG		0	; DEBUG LED 0=���� 1=�L��
#DEFINE WIN95KB_DEBUG	0	; 98KB Windows�L�[�Ή��f�o�b�O���Ɏg�p��������
#DEFINE	KB_EMU		0	; KEYBAORD EMULATOR MODE 1=Enable(NO KEYBAORD)
#DEFINE	MODEL		0	; 0=ORIGINAL/COMMON-PCB 1=PLUS PCB
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
; ���[�N�G���A�̊��蓖��
;
WAIT0		EQU	20h
WAIT1		EQU	21h
WAIT2		EQU	22h
PC98_DATA	EQU	23h	; PC98 TX/RX DATA
PS2_DATA	EQU	24h	; PS/2 TX/RX DATA
LOOP		EQU	25h	; LOOP COUNTER
TIMEF0		EQU	26h
TIMEF1		EQU	27h
TIMEF2		EQU	28h
WORK		EQU	29h
PTCNT		EQU	2Ah	; PARITY BIT COUNTER
TOC		EQU	2Bh	; �^�C���A�E�g�p�J�E���^
PS2_KEYCODE	EQU	2Ch	; �ϊ������pPS/2�L�[�f�[�^

SYSFLG		EQU	2Dh	; B0:LED�Đݒ�t���O0=�K�v�Ȃ� 1=�ݒ�v��
				; B1:�u���C�N�t���O 0=MAKE 1=BREAK
				; B2:CAPS M/B�L�[�R�[�h�t���O 1=PRESS
				; B3:���� M/B�L�[�R�[�h�t���O 1=PRESS
				; B4:���s�[�g����p 0=BREAKED 1=MAKED
				; B5:KB MODE 0=OLD 1=NEW KEYBOARD
				; B6: N/A
				; B7:NumLock�t���O 0=Not 1=NUMLOCK

SYSFLG2		EQU	2Eh	; B0:KB-MODE CTRL  1=BREAK
				; B1:KB-MODE SHIFT 1=BREAK
				; B2:KB-MODE GRAPH 1=BREAK
				; B3:CTRL  0=BREAK 1=MAKE
				; B4:SHIFT 0=BREAK 1=MAKE
				; B5:ALT   0=BREAK 1=MAKE
				; B6:ALT(D) 0=BREAK 1=MAKE
				; B7: N/A

LEDDATA		EQU	2Fh	; IBM KEYBOARD LED DATA
LOOP2		EQU	30h	; LOOP COUNTER (FOR INTRRUPT)
ETC		EQU	31h	; �ėp���[�N
ETC1		EQU	32h	; �ėp���[�N
BKEY		EQU	33h	; �O�񉟂��ꂽ�L�[�i�X�W�R�[�h�j
LED_SETCNT	EQU	34h	; LED�Đݒ�J�E���^
BRK_SETCNT	EQU	35h	; ����,CAPS�u���C�N�R�[�h���M�J�E���^
RX98_TOC	EQU	36h	; PC98��M�^�C���A�E�g�J�E���^
KEYREP_CNT	EQU	37h	; �I�[�g���s�[�g�J�E���^
E_ADR		EQU	38h	; EEPROM�A�N�Z�X�A�h���X
PS2_DBAK	EQU	39h	; ���O�ɑ��M���ꂽPS/2�f�[�^
;
; �e��ݒ�l
;
RX98_TMO	EQU	10	; �^�C���A�E�g����(x1mS)
DELAYT		EQU	4  	; DELAY TIME 505mS
TOC_MAX		EQU	100	; PS/2�N���b�N�Ď��^�C���A�E�g����(x 5us?)
	;
	; �V�X�e���N���b�N=6.144MHz
	;
	IF SYS_CLK == 0
LED_CNT		EQU	24	; LED�Đݒ�J�E���g�l500ms(x21.2ms)
BRK_CNT		EQU	5	; CAPS,���ȃu���C�N���M�҂�����100ms(x21.2ms)
REP_DELAY	EQU	24	; ���s�[�g�f�B���C����500ms(x21.2ms)
REP_TYPEMATIC	EQU	1	; ���s�[�g�^�C�v�}�e�b�N����30ms(1x21.2ms)
	ENDIF
	;
	; �V�X�e���N���b�N=10MHz
	;
	IF SYS_CLK == 1
LED_CNT		EQU	38	; LED�Đݒ�J�E���g�l500ms(x13.1ms)
BRK_CNT		EQU	8	; CAPS,���ȃu���C�N���M�҂�����100ms(x13.1ms)
REP_DELAY	EQU	38	; ���s�[�g�f�B���C����500ms(x13.1ms)
REP_TYPEMATIC	EQU	2	; ���s�[�g�^�C�v�}�e�b�N����30ms(x13.1ms)
	ENDIF

MODE_KEY1	EQU	00h	; ���[�h�؂�ւ��L�[1 �S�p/���p
MODE_KEY2	EQU	74h	; ���[�h�؂�ւ��L�[1 CTRL
MODE_KEY3	EQU	70h	; ���[�h�؂�ւ��L�[1 SHIFT
EQU_WAIT	EQU	4	; �e���L�["="���M�R�[�h�ԃE�G�C�g(mS)
;
; PS/2�V�X�e�����L�[�{�[�h�R�}���h
;
PS2S_DEFAULT_DISABLE	EQU	0F5h	; �d��������Ԃő�����~���ҋ@/ACK
PS2S_ECHO		EQU	0EEh	; �f�f�p/EEh
PS2S_ENABLE		EQU	0F4h	; �o���ޯ̧�������è����~������/ACK
PS2S_ID_READ		EQU	0F2h	; ID�ǂ݂���/ACK,ID-H,ID-L
PS2S_RESEND		EQU	0FEh	; �đ��M�v��/���O�̃o�C�g
PS2S_RESET		EQU	0FFh	; ���Z�b�g�Ǝ��Ȑf�f/ACK
PS2S_SCANCODE		EQU	0F0h	; �����R�[�h/F0,ACK,OPT,ACK(CODE)
PS2S_ALL_TYPEMATIC	EQU	0F7h	; �S�L�[�������è���ɂ���/ACK
PS2S_ALL_MAKEBREAK	EQU	0F8h	; �S�L�[�����C�N/�u���C�N�ɂ���/ACK
PS2S_ALL_MAKE		EQU	0F9h	; �S�L�[�����C�N�ɂ���/ACK
PS2S_ALL_TMB		EQU	0FAh	; �S�L�[�������è��,Ҳ�,��ڲ���/ACK
PS2S_SET_DEFAULT	EQU	0F6h	; �d��������Ԃő����p��/ACK
PS2S_SET_KEYTYPEMATIC	EQU	0FBh	; �X�̃L�[�������è��/ACK
PS2S_SET_KEYMAKEBREAK	EQU	0FCh	; �X�̃L�[�����C�N/�u���C�N��/ACK
PS2S_SET_KEYMAKE	EQU	0FDh	; �X�̃L�[�����C�N��/ACK
PS2S_SR_STATUS_INDI	EQU	0EDh	; �L�[�{�[�hLED�ݒ�/ACK,ACK
PS2S_SET_TM_RATE	EQU	0F3h	; �����è��ڰĂ�ݒ�/ACK,ACK
;
; PS/2�L�[�{�[�h���V�X�e���R�}���h
;
PS2D_ACK		EQU	0FAh	; ACK����
PS2D_BAT_OK		EQU	0AAh	; BAT����I��
PS2D_BAT_BAD		EQU	0FCh	; BAT��Q�A������~
PS2D_BERAK_PRIFIX	EQU	0F0h	; ScanCode2/3�̃u���C�N�R�[�h
PS2D_ECHO		EQU	0EEh	; �G�R�[�R�}���h�ɑ΂��ĕԂ�
PS2D_KEYBOARD_ID1H	EQU	83h	; ���ް��ID�ݷ��t��ID(HIGH)
PS2D_KEYBOARD_ID1L	EQU	0ABh	; ���ް��ID�ݷ��t��ID(LOW)
PS2D_KEYBOARD_ID2H	EQU	84h	; ���ް��ID�ݷ��Ȃ�ID(HIGH)
PS2D_KEYBPARD_ID2L	EQU	0ABh	; ���ް��ID�ݷ��Ȃ�ID(LOW)
PS2D_OVERRUN1		EQU	00h	; ���ޯ̧���ӂꂽ�Ƃ��Ō�ɕt��
PS2D_OVERRUN2		EQU	0FFh	; ���ޯ̧���ӂꂽ�Ƃ��Ō�ɕt��
PS2D_RESEND		EQU	0FEh	; �f�[�^�̍đ��M
;
; ��ʐݒ�
;
	;
	; �I���W�i��PCB/����PCB(2001)
	;
	IF MODEL == 0
RB_DIR		EQU	11100100B	; ORG/COMMON PCB
PINIT_DATA	EQU	11111101B	; ORG/COMMON PCB
#DEFINE	STATUS_LED	PORTB,B4	; ORG/COMMON PCB
#DEFINE	DATA_OUT	PORTA,B0	; ORG/COMMON PCB
#DEFINE	CLK_OUT		PORTA,B1	; ORG/COMMON PCB
#DEFINE	DATA_IN		PORTA,B2	; ORG/COMMON PCB
#DEFINE	CLK_IN		PORTA,B3	; ORG/COMMON PCB
	ENDIF
	;
	; TeamPlus PCB(GKA-68ATmk2)
	;
	IF MODEL == 1
RB_DIR		EQU	01110100B	; PLUS PCB
PINIT_DATA	EQU	11111101B	; PLUS PCB
#DEFINE	STATUS_LED	PORTB,B7	; PLUS PCB
#DEFINE	DATA_OUT	PORTA,B2	; PLUS PCB
#DEFINE	CLK_OUT		PORTA,B3	; PLUS PCB
#DEFINE	DATA_IN		PORTA,B2	; PLUS PCB
#DEFINE	CLK_IN		PORTA,B3	; PLUS PCB
	ENDIF
	;
	; �SPCB����
	;
DATA_BIT	EQU	2		; PS/2 DATA(IN) PORT
CLK_BIT		EQU	3		; PS/2 CLK(IN) PORT
;
; I/O Signal Direction Controle
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
	ORG	00h

        CLRF    PORTA           ; @Chg
        MOVLW   0x07            ; @Chg �R���p���[�^OFF
        MOVWF   CMCON           ; @Chg �f�B�W�^��I/O�Ƃ��Ē�`

	BSF	STATUS,RP0	; SELECT PAGE 1
	MOVLW	000001100B	; PORT A(PC-AT SIDE) SETUP
				;   B0=DATA(OUT)
				;   B1=CLK(OUT)
				;   B2=DATA(IN)
				;   B3=CLK(IN)
	MOVWF	TRISA		; SET PORT A

	MOVLW	RB_DIR		; PORT B(PC-9801 KB SIDE) SETUP
				;   B0=RST(OUT) / RST(OUT)
				;   B1=RDY(OUT) / RDY(OUT)
				;   B2=RXD(IN)  / RXD(IN)
				;   B3=RTY(OUT) / RTY(OUT)
				;   B4=LED(OUT) / N.C.(IN)
				;   B7=N.C.(IN) / LED(OUT)
	MOVWF	TRISB		; SET PORT B

				; �^�C�}0,�����݊֌W������
	BCF	STATUS,RP0	; SELECT PAGE 0
	CLRF	INTCON
	CLRWDT			; �E�H�b�`�h�b�O�^�C�}���N���A
	CLRF	TMR0		; TMR0���e�N���A
	BSF	STATUS,RP0	; SELECT PAGE 1
	MOVLW	00000110B
				; RB�v���A�b�v�L��
				; INT���荞�݃G�b�W=����������
				; �^�C�}�N���b�N=1/4OSC(651ns/400ns)
				; �v���X�P�[��:TMR0
				; �v���X�P�[��������:1/128(82.944us/51.2us)
	MOVWF	OPTION_REG	; OPTION���W�X�^�ݒ�
	BCF	STATUS,RP0	; SELECT PAGE 0
	CLRF	TMR0		; TMR0���e�N���A
	;
	; ������
	;
INITALIZE
	CLRF	PORTA		; DATA & CLK = High
	CALL	CLKDATABIT_HIGH	; DATA & CLK = High
	MOVLW	PINIT_DATA	; B0:*RST=High / *RST=High
				; B1:*RDY=Low / *RDY=Low
				; B2: RXD(IN) / RXD(IN)
				; B3:*RTY=High / *RTY=High
				; B4: LED=ON / N.C.(IN)
				; B7: N.C.(IN) / LED=ON
	MOVWF	PORTB

	CLRF	SYSFLG		; SYSTEM�t���O�N���A
	CLRF	SYSFLG2
	CLRF	PC98_DATA
	CLRF	PS2_DATA
	CLRF	LEDDATA
	CLRF	KEYREP_CNT
	MOVLW	BRK_CNT
	MOVWF	BRK_SETCNT	; CAPS,���ȃu���C�N���M�x���J�E���^

	IF WIN95KEY_CHK == 1 & D_BOARD == 0 & KB_EMU == 0
	CALL	KB_WIN95	; �ڑ�����Ă���L�[�{�[�h�𔻕ʂ���
	CALL	KB_SET		; EE�ݒ�l����V/���L�[�{�[�h���[�h�ݒ�
	ENDIF

	MOVLW	0AAh		; �V�X�e����BAT OK�R�[�h�𑗐M
	CALL	PS2D_TX0
;
;�@���C�����[�v
; PC98�L�[�{�[�h��PS/2�ϊ�����
;
MAIN
	CLRF	TMR0
	BCF	INTCON,B2	; TMR0 Overflow�t���O�N���A
	MOVLW	LED_CNT
	MOVWF	LED_SETCNT	; LED�Đݒ�J�E���^1��ݒ�

	CALL	CLKDATABIT_HIGH	; CLK & DATA=High�Ŗ{�̑��M�Ƃ���
	BTFSC	SYSFLG,B2
	GOTO	SENDSYS
	BTFSC	SYSFLG,B3
	GOTO	SENDSYS
	BCF	PORTB,B1	; RDY=0,PC98�L�[�{�[�h����̑��M������
SENDSYS
	BTFSS	DATA_IN		; �V�X�e���f�[�^���M?
	GOTO	PS2_DOWNCMD
	BTFSC	SYSFLG,B2
	GOTO	KANA_CAPS_REIGAI
	BTFSC	SYSFLG,B3
	GOTO	KANA_CAPS_REIGAI
	BTFSS	PORTB,B2	; PC98�L�[�{�[�h�X�^�[�g�r�b�g?
	GOTO	PC982PS2
	;
	; PC98�L�[�{�[�h�͓Ǝ���LED���䂷�邽�ߒ���I��LED��Ԃ�ݒ�
	;
LED_RESET
	BTFSS	INTCON,B2	; TMR0�I�[�o�[�t���[?
				; (6.144MHz=21.23ms,10MHz=13.1072ms)
	GOTO	SENDSYS
	BCF	INTCON,B2	; TMR0 Overflow�t���O�N���A
	BTFSS	SYSFLG,B5	; �L�[�{�[�h����
	GOTO	LED_RESET2	; ���L�[�{�[�h�̓��s�[�g�ϊ����Ȃ�
	BTFSS	SYSFLG,B4	; �L�[���C�N?
	GOTO	LED_RESET2
	INCF	KEYREP_CNT,1	; ���s�[�g����J�E���^+1
	MOVF	KEYREP_CNT,0	; W=���s�[�g����J�E���g
	XORLW	REP_DELAY	; ���s�[�g���Ă���?
	BTFSS	STATUS,B2
	GOTO	LED_RESET2	; ���s�[�g���Ă���
AUTO_REPEAT
	BSF	PORTB,B1	; RDY=1
	MOVF	BKEY,0
	MOVWF	PC98_DATA
	BCF	SYSFLG,B1	; �u���C�N�t���O���N���A
	MOVLW	REP_DELAY - REP_TYPEMATIC
	MOVWF	KEYREP_CNT
	GOTO	MAKE_REPEAT
LED_RESET2
	DECFSZ	LED_SETCNT,1	; LED�Đݒ�J�E���^1�i��-1
	GOTO	SENDSYS
	MOVLW	LED_CNT
	MOVWF	LED_SETCNT	; LED�Đݒ�J�E���^1��ݒ�
	BTFSS	SYSFLG,B0	; LED�Đݒ�v������?
	GOTO	MAIN
	BCF	SYSFLG,B0	; LED�Đݒ�v�����N���A
	MOVLW	00010000B
	XORWF	PORTB,1
	IF LED_CTRL == 0 | D_BOARD == 1 | KB_EMU == 1
	GOTO	MAIN		; LED�ݒ肵�Ȃ�
	ELSE
	GOTO	KEYBOARD_LED_SET ; �L�[�{�[�h��LED�ݒ���s��
	ENDIF
	;
	; CAPS,���ȗp��O����(MAKE - BREAK)
	;
KANA_CAPS_REIGAI
	BTFSS	INTCON,B2	; TMR0�I�[�o�[�t���[?(5.308mS)
	GOTO	SENDSYS
	BCF	INTCON,B2
	DECFSZ	BRK_SETCNT,1	; �u���C�N�R�[�h���M�J�E���^
	GOTO	SENDSYS
	MOVLW	BRK_CNT
	MOVWF	BRK_SETCNT
	BSF	SYSFLG,B0	; LED�Đݒ�v���t���O�𗧂Ă�
	BCF	SYSFLG,B2	; CAPS M/B�t���O�N���A
	BCF	SYSFLG,B3	; ���� M/B�t���O�N���A
				; CAPS,���Ȃ̓g�O������(M/B)�Ȃ̂ŁA
	GOTO	NRM_BREAK	; GKA-98AT����110mS��Ɏ����������邽�߁A
				; ���R�������ςȂ��͕s�\!
	;
	; PC98��PS/2�ϊ�(���s�[�g���䓙)�J�n
	;
PC982PS2
	BCF	STATUS_LED	; LED OFF
	BCF	SYSFLG,B4	; ���C�N�t���O�N���A
	BCF	SYSFLG,B1	; �u���C�N�R�[�h�t���O���N���A
	MOVLW	0FFh
	MOVWF	BKEY		; �O��L�[�R�[�h�𖳌��R�[�h�ɏ�����
	CALL	RX98KEY		; PC98����L�[�f�[�^����M����
	BTFSC	STATUS,B0	; PC98��M�G���[?
	GOTO	MAIN
	BTFSS	PC98_DATA,B7	; �u���C�N�R�[�h?
	GOTO	MAKE_CODE
	BSF	SYSFLG,B1	; �u���C�N�R�[�h�t���O�𗧂Ă�
	CLRF	KEYREP_CNT	; ���s�[�g����J�E���^�N���A
	GOTO	MAKE_REPEAT
	;
	; �ʏ�make����(���s�[�g����J�n)
	;
MAKE_CODE
	BSF	SYSFLG,B4	; ���C�N�t���O�Z�b�g(���͑҂��Ƌ�ʂ��邽��)
	CLRF	KEYREP_CNT	; ���s�[�g����J�E���^�N���A
	;
	; ���s�[�g������
	;
MAKE_REPEAT
	BCF	PC98_DATA,B7	; BIT7=0
	;
	; F7�L�[��O����
	;
	MOVF	PC98_DATA,0
	XORLW	68h		; F7?(PS/2:83h)
	BTFSS	STATUS,B2
	GOTO	CHK_PAUSECODE
	MOVLW	83h		; F7����(!)7�r�b�g�ڂ�1�Ȃ̂ŗ�O����
	MOVWF	PS2_KEYCODE
	BTFSC	SYSFLG,B1	; make/break�����I��
	GOTO	NRM_BREAK
	GOTO	NRM_MAKE
	;
	; Pause�L�[�̗�O����
	;
CHK_PAUSECODE
	MOVF	PC98_DATA,0
	XORLW	55h
	BTFSC	STATUS,B2
	GOTO	F14_KEY		; F14(VF4) -> Pause
	;
	; COPY�L�[(PrintScreen)�̗�O����
	;
CHK_COPYCODE
	MOVF	PC98_DATA,0
	XORLW	61h
	BTFSC	STATUS,B2
	GOTO	COPY_KEY	; COPY -> PrintScreen
	;
	; PS/2�L�[�{�[�h�̃V�t�g��Ԃɂ���O�����p�t���O�ݒ�
	; CTRL�L�[�`�F�b�N
	;
CHK_CTRL
	MOVF	PC98_DATA,0
	XORLW	74h
	BTFSC	STATUS,B2
	CALL	CTRL_KEY
	;
	; SHIFT�L�[�`�F�b�N
	;
	MOVF	PC98_DATA,0
	XORLW	70h
	BTFSC	STATUS,B2
	CALL	SHIFT_KEY
	;
	; GRAPH(ALT)�L�[�`�F�b�N
	;
	MOVF	PC98_DATA,0
	XORLW	73h
	BTFSC	STATUS,B2
	CALL	GRAPH_KEY
	;
	; ALT(D-BOARD)�L�[�`�F�b�N
	;
	IF D_BOARD == 1
	MOVF	PC98_DATA,0
	XORLW	79h		; ALT(D-BOARD)?
	BTFSC	STATUS,B2
	CALL	DB_ALT_KEY
	BTFSS	SYSFLG2,B6	; ALT(D-BOARD) MAKE?
	GOTO	CHK_CAPSCODE
	MOVF	PC98_DATA,1
	BTFSS	STATUS,B2	; ALT + ESC?
	GOTO	CHK_CAPSCODE
	BTFSC	SYSFLG,B1	; ESC BREAK?
	GOTO	MAIN		; �u���C�N�R�[�h�͖�������
	MOVLW	72h		; ���͂��J�i�ɒu��������
	MOVWF	PC98_DATA
	BSF	SYSFLG,B3	; ���ȃL�[�������ꂽ
	BCF	SYSFLG,B4	; ���̃L�[�̓��s�[�g�����Ȃ�
	GOTO	KCC98TOPS2
	ENDIF
	;
	; CAPS�L�[�̗�O����
	;
CHK_CAPSCODE
	MOVF	PC98_DATA,0	; PC-9801 CAPS�L�[�p�t���O�ݒ�
	XORLW	71h		; CAPS�������ꂽ?
	BTFSS	STATUS,B2
	GOTO	CHK_KANACODE
	BSF	SYSFLG,B2	; CAPS�L�[�������ꂽ
	BCF	SYSFLG,B4	; ���̃L�[�̓��s�[�g�����Ȃ�
	GOTO	KCC98TOPS2
	;
	; ���ȃL�[�̗�O����
	;
CHK_KANACODE
	MOVF	PC98_DATA,0	; PC-9801 ���ȃL�[�p�t���O�ݒ�
	XORLW	72h		; ���Ȃ������ꂽ?
	BTFSS	STATUS,B2
	GOTO	CHK_TENEQU
	BSF	SYSFLG,B3	; ���ȃL�[�������ꂽ
	BCF	SYSFLG,B4	; ���̃L�[�̓��s�[�g�����Ȃ�
	IF D_BOARD == 1
	BTFSS	SYSFLG2,B6	; D-BOARD ALT MAKE?
	GOTO	KCC98TOPS2
	GOTO	SHIFT_KANA_KEY
	ELSE
	GOTO	KCC98TOPS2
	ENDIF
	;
	; �e���L�[��"="�L�[��O����
	;
CHK_TENEQU
	MOVF	PC98_DATA,0
	XORLW	4Dh		; �e���L�[����"="?
	BTFSC	STATUS,B2
	GOTO	EQU_KEY		; "="�L�[��MAKE,BREAK����
	;
	; PC98��PS/2�L�[�R�[�h�ϊ�
	;
KCC98TOPS2
	MOVF	PC98_DATA,0
	CALL	CNV982AT	; AT�L�[�R�[�h�ɕϊ� BIT7=E0h�R�[�h�t���O
	MOVWF	PS2_KEYCODE	; �ϊ����ꂽ�f�[�^��ۑ�
	XORLW	0FFh
	BTFSC	STATUS,B2	; �ϊ����s?(0FFh=���s)
	GOTO	MAIN
	;
	; �`���_������ʂ���͂ł���悤SHIFT���ɃL�[�R�[�h����ւ���
	;
	IF KEY_EXCHG == 1
	BTFSS	SYSFLG2,B4	; SHIFT���C�N?
	GOTO	MAKEBREAK
	MOVF	PS2_KEYCODE,0
	XORLW	55h		; ^ KEY?
	BTFSC	STATUS,B2
	GOTO	KEY_EX1
	MOVF	PS2_KEYCODE,0
	XORLW	54h		; @ KEY?
	BTFSC	STATUS,B2
	GOTO	KEY_EX2
	GOTO	MAKEBREAK
KEY_EX1
	MOVLW	54h
	GOTO	KEY_EXEND
KEY_EX2
	MOVLW	55h
KEY_EXEND
	MOVWF	PS2_KEYCODE
	ENDIF
	;
	; �L�[make/break����
	;
MAKEBREAK
	BTFSC	SYSFLG,B2	; CAPS�L�[�������ꂽ(CAPS�̓g�O������)
	GOTO	MAKE		; M/B�Ɋւ炸MAKE������
	BTFSC	SYSFLG,B3	; ���ȃL�[�������ꂽ(���Ȃ̓g�O������)
	GOTO	MAKE		; M/B�Ɋւ炸MAKE������
	BTFSC	SYSFLG,B1	; MAKE/BREAK�����I��
	GOTO	BREAK
	;
	; �L�[make����(E0h���肠��)	
	;
MAKE
	BTFSS	PS2_KEYCODE,B7	; E0h�R�[�h?
	GOTO	NRM_MAKE
	MOVLW	0E0h		; �g���R�[�h���M
	CALL	PS2D_TX0
	MOVLW	4
	CALL	WAITNMS
	BCF	PS2_KEYCODE,B7	; E0����r�b�g���N���A����
NRM_MAKE
	MOVF	PC98_DATA,0
	MOVWF	BKEY
	MOVF	PS2_KEYCODE,0
	CALL	PS2D_TX0	; PS/2�L�[�R�[�h���M
	GOTO	MAIN
	;
	; �L�[break����(E0h����L��)
	;
BREAK
	MOVF	PC98_DATA,0	; W=PC98�L�[�R�[�h
	XORLW	MODE_KEY1	; ���[�h�L�[1?
	BTFSS	STATUS,B2
	GOTO	BRK_CODE1
	BSF	SYSFLG2,B0	; SET FLAG
	GOTO	BRK_E0_CHK
BRK_CODE1
	MOVF	PC98_DATA,0
	XORLW	MODE_KEY2	; ���[�h�L�[2?
	BTFSS	STATUS,B2
	GOTO	BRK_CODE2
	BSF	SYSFLG2,B1	; SET FLAG
	GOTO	BRK_E0_CHK
BRK_CODE2
	MOVF	PC98_DATA,0
	XORLW	MODE_KEY3	; ���[�h�L�[3?
	BTFSS	STATUS,B2
	GOTO	BRK_CODE_CLR
	BSF	SYSFLG2,B2	; SET FLAG
	GOTO	BRK_E0_CHK
BRK_CODE_CLR
	MOVLW	11111000B
	ANDWF	SYSFLG2,1
BRK_E0_CHK
	BTFSS	PS2_KEYCODE,B7	; E0h�R�[�h?
	GOTO	NRM_BREAK
	MOVLW	0E0h		; �g���R�[�h���M
	CALL	PS2D_TX_WAIT
	BCF	PS2_KEYCODE,B7	; E0����r�b�g���N���A����
NRM_BREAK
	MOVLW	0F0h		; �u���C�N�R�[�hPrifix���M
	CALL	PS2D_TX0
	MOVLW	4
	CALL	WAITNMS
	MOVF	PS2_KEYCODE,0
	CALL	PS2D_TX0
	;
	; �L�[�{�[�h���[�h�؂�ւ�����
	;
	IF D_BOARD == 1
	GOTO	MAIN
	ELSE
	MOVF	SYSFLG2,0	; ���[�h�L�[�����ׂĉ����ꂽ?
	ANDLW	00000111B
	XORLW	00000111B
	BTFSS	STATUS,B2
	GOTO	MAIN
	MOVLW	11111000B
	ANDWF	SYSFLG2,1
	;
	; �V�E���L�[�{�[�h���[�h��؂�ւ���
	;
MODE_SELECTOR
	MOVLW	0
	CALL	EE_READ
	XORLW	1
	BTFSC	STATUS,B2
	GOTO	SEL_KM2
	MOVLW	0
	CALL	EE_READ
	XORLW	2
	BTFSC	STATUS,B2
	GOTO	SEL_KM1
	GOTO	MAIN
SEL_KM1
	MOVLW	0
	MOVWF	E_ADR
	MOVLW	1
	CALL	EE_WRITE
	CALL	KB_SET
	GOTO	MAIN
SEL_KM2
	MOVLW	0
	MOVWF	E_ADR
	MOVLW	2
	CALL	EE_WRITE
	CALL	KB_SET
	GOTO	MAIN
	ENDIF
	;
	;�@�J�i�L�[����(�x���u���C�N�t���O�Z�b�g,D-BOARD��)
	;
SHIFT_KANA_KEY			; SHIFT+���ȃR�[�h���M
	IF D_BOARD == 1
	BCF	SYSFLG,B3	; ���ȃL�[�̒x���u���C�N�͎~�߂�(!)
	MOVLW	12h		; SHIFT�L�[������
	CALL	PS2D_TX_WAIT2
	MOVLW	13h		; �J�i�L�[������
	CALL	PS2D_TX_WAIT2
	MOVLW	0F0h		; �u���C�N�R�[�hPrifix
	CALL	PS2D_TX_WAIT2
	MOVLW	13h		; �J�i�L�[�𗣂�
	CALL	PS2D_TX_WAIT2
	MOVLW	0F0h		; �u���C�N�R�[�hPrifix
	CALL	PS2D_TX_WAIT2
	MOVLW	12h		; SHIFT�L�[�𗣂�
	CALL	PS2D_TX_WAIT2
	GOTO	MAIN
	ENDIF
	;
	; F14�L�[(Pause)����
	;
F14_KEY
	BTFSC	SYSFLG,B1	; �u���C�N�R�[�h?
	GOTO	MAIN		; PAUSE�̓u���C�N�R�[�h���Ȃ�
	BTFSC	SYSFLG2,B3	; CTRL?
	GOTO	PAUSE_CTRL_KEY
	MOVLW	0E1h
	CALL	PS2D_TX_WAIT
	MOVLW	14h
	CALL	PS2D_TX_WAIT
	MOVLW	77h
	CALL	PS2D_TX_WAIT
	MOVLW	0E1h
	CALL	PS2D_TX_WAIT
	MOVLW	0F0h
	CALL	PS2D_TX_WAIT
	MOVLW	014h
	CALL	PS2D_TX_WAIT
	MOVLW	0F0h
	CALL	PS2D_TX_WAIT
	MOVLW	77h
	CALL	PS2D_TX_WAIT
	GOTO	MAIN
PAUSE_CTRL_KEY
	MOVLW	0E0h
	CALL	PS2D_TX_WAIT
	MOVLW	7Eh
	CALL	PS2D_TX_WAIT
	MOVLW	0E0h
	CALL	PS2D_TX_WAIT
	MOVLW	0F0h
	CALL	PS2D_TX_WAIT
	MOVLW	07Eh
	CALL	PS2D_TX_WAIT
	GOTO	MAIN
	;
	; COPY�L�[(PrintScreen)����
	;
COPY_KEY
	IF PRINTSCREEN == 1
	BTFSC	SYSFLG2,B0	; CTRL?
	GOTO	COPY_KEY_CTRL
	BTFSC	SYSFLG2,B1	; SHIFT?
	GOTO	COPY_KEY_CTRL
	BTFSC	SYSFLG2,B2	; ALT?
	GOTO	COPY_KEY_ALT
	ENDIF

	BTFSC	SYSFLG,B1
	GOTO	COPY_KEY_BRK
	MOVLW	0E0h
	CALL	PS2D_TX_WAIT
	MOVLW	12h
	CALL	PS2D_TX_WAIT
	MOVLW	0E0h
	CALL	PS2D_TX_WAIT
	MOVLW	7Ch
	CALL	PS2D_TX_WAIT
	GOTO	MAIN
COPY_KEY_BRK
	MOVLW	0E0h
	CALL	PS2D_TX_WAIT
	MOVLW	0F0h
	CALL	PS2D_TX_WAIT
	MOVLW	7Ch
	CALL	PS2D_TX_WAIT
	MOVLW	0E0h
	CALL	PS2D_TX_WAIT
	MOVLW	0F0h
	CALL	PS2D_TX_WAIT
	MOVLW	012h
	CALL	PS2D_TX_WAIT
	GOTO	MAIN
	IF PRINTSCREEN == 1
COPY_KEY_CTRL
	BTFSC	SYSFLG,B1
	GOTO	COPY_KEY_CTRL_BRK
	MOVLW	0E0h
	CALL	PS2D_TX_WAIT
	MOVLW	07Ch
	CALL	PS2D_TX_WAIT
	GOTO	MAIN
COPY_KEY_CTRL_BRK
	MOVLW	0E0h
	CALL	PS2D_TX_WAIT
	MOVLW	0F0h
	CALL	PS2D_TX_WAIT
	MOVLW	7Ch
	CALL	PS2D_TX_WAIT
	GOTO	MAIN
COPY_KEY_ALT
	BTFSC	SYSFLG,B1
	GOTO	COPY_KEY_ALT_BRK
	MOVLW	84h
	CALL	PS2D_TX_WAIT
	GOTO	MAIN
COPY_KEY_ALT_BRK
	MOVLW	0F0h
	CALL	PS2D_TX_WAIT
	MOVLW	84h
	CALL	PS2D_TX_WAIT
	GOTO	MAIN
	ENDIF
	;
	; �e���L�[��"="�L�[�̗�O����
	;
EQU_KEY
	BTFSC	SYSFLG,B1	; BREAK?
	GOTO	EQU_BRK
	MOVLW	12h		; SHIFT�L�[������
	CALL	PS2D_TX_WAIT2
	MOVLW	4Eh		; �t���L�[��-/=������
	CALL	PS2D_TX_WAIT2
	MOVLW	0F0h		; �u���C�N�R�[�hPrifix
	CALL	PS2D_TX_WAIT2
	MOVLW	12h		; SHIFT�L�[����
	CALL	PS2D_TX_WAIT2
	MOVLW	4Dh		; ���s�[�g�����̂���
	MOVWF	BKEY
	GOTO	MAIN
EQU_BRK
	MOVLW	0F0h
	CALL	PS2D_TX_WAIT2
	MOVLW	4Eh
	CALL	PS2D_TX_WAIT2
	GOTO	MAIN
	;
	; CTRL�L�[�`�F�b�N
	;
CTRL_KEY
	BTFSC	SYSFLG,B1	; BREAK?
	GOTO	CTRL_KEY_BRK
	BSF	SYSFLG2,B3	; SET CTRL FLAG
	RETURN
CTRL_KEY_BRK
	BCF	SYSFLG2,B3	; CLR CTRL FLAG
	RETURN
	;
	; SHIFT�L�[�`�F�b�N
	;
SHIFT_KEY
	BTFSC	SYSFLG,B1	; BREAK?
	GOTO	SHIFT_KEY_BRK
	BSF	SYSFLG2,B4	; SET SHIFT FLAG
	RETURN
SHIFT_KEY_BRK
	BCF	SYSFLG2,B4	; CLR SHIFT FLAG
	RETURN
	;
	; GRAPH(ALT)�L�[�`�F�b�N
	;
GRAPH_KEY
	BTFSC	SYSFLG,B1	; BREAK?
	GOTO	GRAPH_KEY_BRK
	BSF	SYSFLG2,B5	; SET ALT FLAG
	RETURN
GRAPH_KEY_BRK
	BCF	SYSFLG2,B5	; CLR ALT FLAG
	RETURN
	;
	; ALT(D-BOARD)�L�[�`�F�b�N
	;
DB_ALT_KEY
	IF D_BOARD == 1
	BTFSC	SYSFLG,B1	; BREAK?
	GOTO	DB_ALT_KEY_BRK
	BSF	SYSFLG2,B6	; SET ALT FLAG
	RETURN
DB_ALT_KEY_BRK
	BCF	SYSFLG2,B6	; CLR ALT FLAG
	RETURN
	ENDIF
;
; PS/2����R�}���h����
; (PS/2�f�o�C�X�G�~�����[�V��������)
;
PS2_DOWNCMD
	BSF	PORTB,B1		; RDY=1,PC98�L�[�{�[�h����̑��M���֎~
	BSF	STATUS_LED		; ����R�}���h��MLED�_��
	CALL	PS2D_RX			; �V�X�e������̃f�[�^����M
	BTFSC	STATUS,B0		; ��M����?
	GOTO	SENDSYS			; PS/2�f�[�^��M�^�C���A�E�g
	MOVF	PS2_DATA,0		; ��M�f�[�^
	CALL	WAIT100US

	MOVF	PS2_DATA,0
	XORLW	PS2S_DEFAULT_DISABLE	; �f�t�H���g�ҋ@
	BTFSC	STATUS,B2
	GOTO	PS2_ACKOK		; ACK�����̂�

	MOVF	PS2_DATA,0
	XORLW	PS2S_ECHO		; �G�R�[?
	BTFSC	STATUS,B2
	GOTO	PS2_SYS_ECHO

	MOVF	PS2_DATA,0
	XORLW	PS2S_ENABLE		; �ޯ̧,�����è����~������
	BTFSC	STATUS,B2
	GOTO	PS2_ACKOK		; ACK�����̂�

	MOVF	PS2_DATA,0
	XORLW	PS2S_ID_READ		; �L�[�{�[�hID
	BTFSC	STATUS,B2
	GOTO	PS2_SYS_KEYID

	MOVF	PS2_DATA,0
	XORLW	PS2S_RESEND		; �đ�
	BTFSC	STATUS,B2
	GOTO	PS2_SYS_RESEND

	MOVF	PS2_DATA,0
	XORLW	PS2S_RESET		; ���Z�b�g
	BTFSC	STATUS,B2
	GOTO	PS2_SYS_RESET

	MOVF	PS2_DATA,0
	XORLW	PS2S_SCANCODE		; �����R�[�h�w��
	BTFSC	STATUS,B2
	GOTO	PS2_SYS_SCANCODE

	MOVF	PS2_DATA,0
	XORLW	PS2S_ALL_TYPEMATIC	; �S�L�[�^�C�v�}�e�B�b�N
	BTFSC	STATUS,B2
	GOTO	PS2_ACKOK		; ACK�����̂�

	MOVF	PS2_DATA,0
	XORLW	PS2S_ALL_MAKEBREAK	; �S�L�[���C�N�u���C�N
	BTFSC	STATUS,B2
	GOTO	PS2_ACKOK		; ACK�����̂�

	MOVF	PS2_DATA,0
	XORLW	PS2S_ALL_MAKE		; �S�L�[���C�N
	BTFSC	STATUS,B2
	GOTO	PS2_ACKOK		; ACK�����̂�

	MOVF	PS2_DATA,0
	XORLW	PS2S_ALL_TMB		; �S�L�[T/M/B
	BTFSC	STATUS,B2
	GOTO	PS2_ACKOK		; ACK�����̂�

	MOVF	PS2_DATA,0
	XORLW	PS2S_SET_DEFAULT	; �d��������Ԃő���
	BTFSC	STATUS,B2
	GOTO	PS2_ACKOK		; ACK�����̂�

	MOVF	PS2_DATA,0
	XORLW	PS2S_SR_STATUS_INDI	; �L�[�{�[�hLED�ݒ�
	BTFSC	STATUS,B2
	GOTO	PS2_SYS_LED

	MOVF	PS2_DATA,0
	XORLW	PS2S_SET_TM_RATE	; �^�C�v�}�e�B�b�N���[�g��ݒ�
	BTFSC	STATUS,B2
	GOTO	PS2_SYS_TYPEMATIC

	MOVLW	0FEh
	CALL	PS2D_TX0
	GOTO	MAIN
;
; PS/2�R�}���hACK���M
;
PS2_ACK
	MOVLW	PS2D_ACK	; ACK�R�[�h
	CALL	PS2D_TX_WAIT
	RETURN
PS2_ACKOK
	CALL	PS2_ACK
	GOTO	MAIN
PS2_SYS_RESET			; ����:ACK+500mS+BAT�I���R�[�h
	CALL	PS2_ACK
	CALL	DELAY		; 500mS�ҋ@
	MOVLW	PS2D_BAT_OK	; BAT�I���R�[�h
	CALL	PS2D_TX_WAIT
	CLRF	LEDDATA		; LED ALL OFF
	GOTO	KEYBOARD_LED_SET
PS2_SYS_ECHO			; ����:EEh
	MOVLW	PS2D_ECHO
	CALL	PS2D_TX0
	GOTO	MAIN
PS2_SYS_KEYID			; ����:ACK+ID(L)+ID(H)
	CALL	PS2_ACK
	MOVLW	PS2D_KEYBOARD_ID1L
	CALL	PS2D_TX_WAIT
	MOVLW	PS2D_KEYBOARD_ID1H
	CALL	PS2D_TX_WAIT
	GOTO	MAIN
PS2_SYS_RESEND			; ����:���O�̃f�[�^
	MOVF	PS2_DBAK,0	; W=���O�̃f�[�^
	CALL	PS2D_TX0
	CALL	PS2_ACK
	GOTO	MAIN
PS2_SYS_LED
	CALL	PS2_ACK		; ����:ACK+OPT+ACK
GET_LED
	CALL	PS2D_RX
	BTFSC	STATUS,B0	; ��M����?
	GOTO	GET_LED		; PS/2�f�[�^��M�^�C���A�E�g
	MOVF	PS2_DATA,0
	MOVWF	LEDDATA		; LED�f�[�^�ۑ�
	CALL	WAIT100US
	CALL	PS2_ACK
	BSF	SYSFLG,B0	; LED�Đݒ�v���t���O�𗧂Ă�
	GOTO	MAIN
KEYBOARD_LED_SET
	IF LED_CTRL == 0 | D_BOARD == 1
	GOTO	MAIN		; D-BOARD�Ȃ�LED���삵�Ȃ�!
	ELSE
	MOVLW	70h		; CLEAR LED WORK
	MOVWF	ETC
	BTFSC	LEDDATA,B1	; NUMLOCK LED ON?
	BSF	ETC,B3		; ����LED -> NUMLOCK LED
	BTFSC	LEDDATA,B2	; CAPS LED ON?
	BSF	ETC,B2		; CAPS LED -> CAPSLOCK LED
	MOVLW	9Dh		; PC98 LED�R�}���h
	CALL	SEND98		; PC98�L�[�{�[�h�փR�}���h���M
	CALL	RX98KEY		; ����(FAh)��M
	MOVLW	5		; WAIT 5mS
	CALL	WAITNMS
	BCF	PORTB,B1	; RDY=0
	MOVLW	102		; WAIT 102mS
	CALL	WAITNMS
	MOVF	ETC,0
	CALL	SEND98		; PC98�L�[�{�[�h��LED�f�[�^���M
	CALL	RX98KEY		; ����(FAh)��M
	GOTO	MAIN
	ENDIF
PS2_SYS_SCANCODE		; ����:ACK+�R�[�h�w��+ACK+���݂̃R�[�h
	CALL	PS2_ACK
	CALL	PS2D_RX		; recieve option code
	CALL	PS2_ACK
	MOVF	PS2_DATA,0
	XORLW	00h		; current keycode-set get?
	BTFSS	STATUS,B2
	GOTO	MAIN
	MOVLW	02h		; return codeset 02 to System
	CALL	PS2D_TX0
	GOTO	MAIN
PS2_SYS_TYPEMATIC		; ����:ACK+OPT+ACK
	CALL	PS2_ACK
	CALL	PS2D_RX
	CALL	PS2_ACK
	GOTO	MAIN
;
; EEROM�̐ݒ肩��L�[�{�[�h�̓��샂�[�h��ݒ�
;
KB_SET
	BCF	SYSFLG,B1
	BCF	SYSFLG,B4
	MOVLW	0
	CALL	EE_READ
	XORLW	1
	BTFSC	STATUS,B2
	GOTO	KB_MODE1
	MOVLW	0
	CALL	EE_READ
	XORLW	2
	BTFSC	STATUS,B2
	GOTO	KB_MODE2
KB_DEFAULT_SET			; �K��l�ȊO�Ȃ烂�[�h1�ɐݒ�
	MOVLW	0
	MOVWF	E_ADR
	MOVLW	1
	CALL	EE_WRITE
;
; ���L�[�{�[�h�p�̓��샂�[�h��ݒ�
;  LED ON -> OFF
;
KB_MODE1
	BCF	SYSFLG,B5	; KEYBOARD = OLD
	BSF	PORTB,B1	; RDY=1,PC98�L�[�{�[�h����̑��M���֎~
	BSF	STATUS_LED	; LED ON
	CALL	DELAY
	BCF	STATUS_LED	; LED OFF
	CALL	DELAY
	MOVLW	100		; WAIT 100mS
	CALL	WAITNMS
	MOVLW	9Ch		; ���s�[�g�J�n�R�}���h1�o�C�g�ڑ��M
	CALL	SEND98
	CALL	RX98KEY		; ����(FAh)��M
	MOVLW	5		; WAIT 5mS
	CALL	WAITNMS
	BCF	PORTB,B1	; RDY=0
	MOVLW	100		; WAIT 100mS
	CALL	WAITNMS
	MOVLW	51h		; ���s�[�g�J�n�R�}���h2�o�C�g�ڑ��M
	CALL	SEND98
	CALL	RX98KEY		; ����(FAh)��M
	RETURN
;
; �V�L�[�{�[�h�p�̓��샂�[�h��ݒ�
; (PC-98�L�[�{�[�h�����s�[�g�֎~�ɂ���)
;  LED ON -> OFF -> ON -> OFF 
;
KB_MODE2
	BSF	STATUS_LED	; LED ON
	BSF	SYSFLG,B5	; KEYBOARD = NEW
	BSF	PORTB,B1	; RDY=1,PC98�L�[�{�[�h����̑��M���֎~
	CALL	DELAY
	BCF	STATUS_LED	; LED OFF
	CALL	DELAY
	BSF	STATUS_LED	; LED ON
	MOVLW	100		; WAIT 100mS
	CALL	WAITNMS
	MOVLW	9Ch		; ���s�[�g�֎~�R�}���h1�o�C�g�ڑ��M
	CALL	SEND98
	CALL	RX98KEY		; ����(FAh)��M
	MOVLW	5		; WAIT 5mS
	CALL	WAITNMS
	BCF	PORTB,B1	; RDY=0
	MOVLW	100		; WAIT 100mS
	CALL	WAITNMS
	MOVLW	70h		; ���s�[�g�֎~�R�}���h2�o�C�g�ڑ��M
	CALL	SEND98
	CALL	RX98KEY		; ����(FAh)��M
	MOVLW	255
	CALL	WAITNMS
	BCF	STATUS_LED	; LED OFF
	RETURN
;
; �ڑ�����Ă���WIN95�L�[�{�[�h�𔻕ʂ��A95�L�[�{�[�h�Ȃ�
; Windows�L�[,�A�v���P�[�V�����L�[��L���ɂ���
;
KB_WIN95
	MOVLW	200		; �L�[�{�[�h�R�}���h�󂯕t���L����҂�
	CALL	WAITNMS
	MOVLW	190		; 200ms + 190ms = �v390ms�̊ԑ҂�
	CALL	WAITNMS
	BSF	PORTB,B1	; RDY=1,PC98�L�[�{�[�h����̑��M���֎~

	IF WIN95KB_DEBUG == 1	; Windosw95�L�[�{�[�h�f�o�b�O�p
	MOVLW	96h		; �L�[�{�[�h�^�C�v���M
	CALL	SEND98
	CALL	RX98KEY		; ����(FAh)��M
	BTFSC	STATUS,B0
	RETURN
	CALL	RX98KEY		; 1�o�C�g�ڎ�M
	BTFSC	STATUS,B0
	RETURN
	CALL	RX98KEY		; 2�o�C�g�ڎ�M
	BTFSC	STATUS,B0
	RETURN
	MOVLW	5		; WAIT 5ms
	CALL	WAITNMS
	BCF	PORTB,B1	; RDY=0

	MOVLW	100		; WAIT 100ms
	CALL	WAITNMS
	ENDIF

	MOVLW	95h		; Win�L�[�L���R�}���h1�o�C�g�ڑ��M
	CALL	SEND98
	CALL	RX98KEY		; ����(FAh)��M
	BTFSC	STATUS,B0
	GOTO	KB_WIN95_ABT

	MOVLW	5		; WAIT 5ms
	CALL	WAITNMS
	BCF	PORTB,B1	; RDY=0

	MOVLW	100		; WAIT 100ms
	CALL	WAITNMS
	MOVLW	03h		; Win�L�[�L���R�}���h2�o�C�g�ڑ��M
	CALL	SEND98
	CALL	RX98KEY		; ����(FAh)��M
KB_WIN95_ABT
	MOVLW	5		; WAIT 5ms
	CALL	WAITNMS
	BCF	PORTB,B1	; RDY=0
	RETURN
;
; �f�o�b�O�p�L�[����
;
	IF WIN95KB_DEBUG == 1	; �f�o�b�O�p�L�[���̓��[�`��
CHK_W95_TEST
	BCF	PORTB,B1	; RDY=0,PC98�L�[�{�[�h����̑��M������
CHK_W95_LOOP
	BTFSC	PORTB,B2	; PC98�L�[�{�[�h�X�^�[�g�r�b�g?
	GOTO	CHK_W95_LOOP
	CALL	RX98KEY
	GOTO	CHK_W95_TEST
	ENDIF
;
;  PC-9801�L�[�f�[�^���M���[�`��(19.2kbps/8bit/Stop1bit/odd)
;   W = SEND DATA
;
SEND98
	IF KB_EMU == 1		; KEYBAORD EMULATOR MODE?
	RETURN
	ENDIF

	MOVWF	PC98_DATA
	BSF	PORTB,B1	; RDY=1
	CALL	WAIT45US
	;
	; 98���M:�N���b�N=6.144MHz
	;
	IF SYS_CLK == 0		; CLK=6.144MHz
	CLRF	PTCNT		; ParityBitCounter = 0
	MOVLW	8
	MOVWF	LOOP
	BCF	PORTB,B0	; StartBit=Low
	GOTO	$+1
	GOTO	$+1
	NOP			; StartBit Low?3.906us�҂�
SENDLOOP
	CALL	WAIT45US	; 45.57us
	RRF	PC98_DATA,1
	BTFSC	STATUS,B0	; ���M�r�b�g����
	GOTO	BITHIGH
	NOP
	BCF	PORTB,B0	; DataLine=Low�����܂�3.906us
	GOTO	BITWAIT
BITHIGH
	BSF	PORTB,B0	; DataLine=High
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
	BSF	PORTB,B0	; ParityBit = High �����܂�1.953us
				; �v45.57us+5.208us+1.953us=52.731us
	GOTO	BITWAIT2
PARITYOFF
	BCF	PORTB,B0	; ParityBit = Low
	NOP
BITWAIT2
	CALL	WAIT45US
	CALL	WAIT5US		; �����܂�45.57us+5.208us+1.302us=52.08us
	BSF	PORTB,B0	; StopBit = High
	CALL	WAIT45US
	CALL	WAIT5US
	GOTO	$+1		; �����܂�52.08us
	BCF	PORTB,B1	; RDY=0
	CALL	WAIT45US
	RETURN
	ENDIF
	;
	; 98���M:�N���b�N=10MHz�̏ꍇ
	;
	IF SYS_CLK == 1		; �N���b�N=10MHz
	CLRF	PTCNT		; ParityBitCounter = 0
	MOVLW	8
	MOVWF	LOOP
	BCF	PORTB,B0	; StartBit=Low
SENDLOOP
	GOTO	$+1
	GOTO	$+1
	GOTO	$+1
	CALL	WAIT45US	; 46us
	RRF	PC98_DATA,1	; ���M�f�[�^��Carry�փV�t�g
	BTFSC	STATUS,B0	; ���M�r�b�g0/1����
	GOTO	BITHIGH
	BCF	PORTB,B0	; DataLine=Low
	GOTO	BITWAIT
BITHIGH
	BSF	PORTB,B0	; DataLine=High
	INCF	PTCNT,1		; ParityBitCoubter +1
BITWAIT
	DECFSZ	LOOP,1
	GOTO 	SENDLOOP	; RRF?�����܂ł�3.6us������
				; 1LOOP=2.4+3.6+46=52us
	CALL	WAIT45US	; 46us�҂�
	CALL	WAIT5US		; 5.2us�҂�
MAKE_PARITY			; �����܂�51.2us
	BTFSC	PTCNT,B0	; �p���e�B�r�b�g����
	GOTO	PARITY_OFF
PARITY_ON
	BSF	PORTB,B0	; ParityBit = High
	GOTO	BITWAIT2
PARITY_OFF
	BCF	PORTB,B0	; ParityBit = Low
	NOP
BITWAIT2
	CALL	WAIT45US
	CALL	WAIT5US		; PARITY_ON����1.6(0.8)+46+5.2=52.8/52us
	BSF	PORTB,B0	; StopBit = High
	CALL	WAIT45US
	CALL	WAIT5US
	GOTO	$+1		; �����܂�52us
	BCF	PORTB,B1	; RDY=0
	CALL	WAIT45US
	RETURN
	ENDIF
;
; PC-9801����R�}���h��M���[�`��(19.2kbps��M)

RX98KEY
	IF KB_EMU == 1		; KEYBAORD EMULATOR MODE?
	RETURN
	ENDIF
	;
	; 98��M:�N���b�N=6.144MHz
	;
	IF SYS_CLK == 0
	BCF	PORTB,B1	; RDY=0,PC98�L�[�{�[�h���M����
	MOVLW	RX98_TMO	; �N���b�NLow�^�C���A�E�g
	MOVWF	RX98_TOC
	CLRF	TMR0
RX98_SBWAIT
	BTFSS	PORTB,B2	; �X�^�[�g�r�b�gLow?
	GOTO	RX98_START
	MOVLW	12		; 1LOOP=1mS(84.944us x 12)
	SUBWF	TMR0,0
	BTFSS	STATUS,B0
	GOTO	RX98_SBWAIT
	CLRF	TMR0
	DECFSZ	RX98_TOC,1
	GOTO	RX98_SBWAIT
	BSF	STATUS,B0	; �G���[(CARRY=1)
	RETURN
RX98_START
	IF DEBUG == 1
	BSF	STATUS_LED	; Debug LED
	ENDIF

	GOTO	$+1
	NOP
	MOVLW	0FFh		; PC-98 KeyData = FFh
	MOVWF	PC98_DATA
	MOVLW	8
	MOVWF	LOOP2		; �����܂ł�5.859us
	CALL	WAIT10US	; 11.718us

	IF DEBUG == 1
	BCF	STATUS_LED	; Debug LED
	ENDIF
				; �T���v�����O�̂��߃X�^�[�g�r�b�g�����܂ő҂�
	BTFSS	PORTB,B2	; �r�b�g���オ���Ă�����m�C�Y�Ɣ��f���߂�
	GOTO	RX98KEY_OK
	BCF	SYSFLG,B2
	RETURN			; abort RX98KEY
RX98KEY_OK			; �����܂�5.859+11.718+1.304+7=25.881us
	CALL	WAIT45US	; 45.570us�@��������52us�҂�
	CALL	WAIT5US		; 5.208us
	GOTO	$+1		; 45.570us+5.208+1.302us=52.08us�҂�1BIT����
RX98LOOP			; �ǂݍ��݃��[�v
	IF DEBUG == 1
	BSF	STATUS_LED	; Debug LED
	ENDIF

	RRF	PC98_DATA,1
	BTFSS	PORTB,B2
	GOTO	RX98BITL
RX98BITH
	BSF	PC98_DATA,B7	; DataBit = High
	GOTO	RX98END
RX98BITL
	BCF	PC98_DATA,B7	; DataBit = Low
	NOP
RX98END				; RXLOOP���炱���܂�6�N���b�N3.906us
	IF DEBUG == 1
	BCF	STATUS_LED	; Debug LED
	ENDIF

	CALL	WAIT45US
	DECFSZ	LOOP2,1
	GOTO	RX98LOOP	; 1LOOP=3.906us+45.57us+1.953us=51.429us
	CALL	WAIT45US	; Wait for ParityBit
	CALL	WAIT5US
	GOTO	$+1		; �v52.08us�҂�
	CALL	WAIT5US		; ���S�̂��ߑ҂�
RX98DHWAIT
	BTFSS	PORTB,B2
	GOTO	RX98DHWAIT
RX98RDY
	CALL	WAIT45US
	BSF	PORTB,B1	; RDY=1�L�[�{�[�h�Ƀf�[�^��M��ʒm
	CALL	WAIT45US
	MOVF	PC98_DATA,0
	BCF	STATUS,B0	; ��M�I��(CARRY=0)
	RETURN			; �X�g�b�v�r�b�g�͓ǂ܂Ȃ��Ŗ߂�
	ENDIF
	;
	; 98��M:�N���b�N=10MHz�̏ꍇ
	;
	IF SYS_CLK == 1
	BCF	PORTB,B1	; RDY=0,PC98�L�[�{�[�h���M����
	MOVLW	RX98_TMO	; �N���b�NLow�^�C���A�E�g
	MOVWF	RX98_TOC
	CLRF	TMR0
RX98_SBWAIT
	BTFSS	PORTB,B2	; �X�^�[�g�r�b�gLow?
	GOTO	RX98_START
	MOVLW	12		; 1LOOP=1mS(84.944us x 12)
	SUBWF	TMR0,0
	BTFSS	STATUS,B0
	GOTO	RX98_SBWAIT
	CLRF	TMR0
	DECFSZ	RX98_TOC,1
	GOTO	RX98_SBWAIT
	BSF	STATUS,B0	; �G���[(CARRY=1)
	RETURN
RX98_START
	IF DEBUG == 1
	BSF	STATUS_LED	; Debug LED
	ENDIF

	NOP
	MOVLW	0FFh		; PC-98 KeyData = FFh
	MOVWF	PC98_DATA
	MOVLW	8
	MOVWF	LOOP2		; �����܂ł�2.8us
	CALL	WAIT5US		; 11.2+5.2=16.4us
	CALL	WAIT10US
				; �T���v�����O�̂��߃X�^�[�g�r�b�g�����܂ő҂�
	BTFSS	PORTB,B2	; �r�b�g���オ���Ă�����m�C�Y�Ɣ��f���߂�
	GOTO	RX98KEY_OK
	BCF	SYSFLG,B2
	RETURN			; abort RX98KEY
RX98KEY_OK			; �����܂ł̎���2.8+16.4+0.8+4.5(��)=24.5us
	IF DEBUG == 1
	BCF	STATUS_LED	; Debug LED
	ENDIF

	CALL	WAIT45US	; 46us�@��������52us�҂�
	CALL	WAIT5US		; 5.2us
RX98LOOP			; 1�r�b�g��M���[�v
	GOTO	$+1		; 0.8us
				; 46+5.2+0.8=52us�҂�BIT����
	IF DEBUG == 1
	BSF	STATUS_LED	; Debug LED
	ENDIF

	RRF	PC98_DATA,1
	BTFSS	PORTB,B2
	GOTO	RX98BITL
RX98BITH
	BSF	PC98_DATA,B7	; DataBit = High
	GOTO	RX98END
RX98BITL
	BCF	PC98_DATA,B7	; DataBit = Low
	NOP
RX98END				; RXLOOP���炱���܂�8�T�C�N��=3.2us
	IF DEBUG == 1
	BCF	STATUS_LED	; Debug LED
	ENDIF

	CALL	WAIT45US
	GOTO	$+1
	DECFSZ	LOOP2,1
	GOTO	RX98LOOP	; 1LOOP=3.2us+46us+2.8us=52us
	CALL	WAIT45US	; Wait for ParityBit
	CALL	WAIT5US
	GOTO	$+1		; �v52us�҂�
	CALL	WAIT5US		; ���S�̂��ߑ҂�
RX98DHWAIT
	BTFSS	PORTB,B2
	GOTO	RX98DHWAIT
RX98RDY
	CALL	WAIT45US
	BSF	PORTB,B1	; RDY=1�L�[�{�[�h�Ƀf�[�^��M��ʒm
	CALL	WAIT45US
	MOVF	PC98_DATA,0
	BCF	STATUS,B0	; ��M�I��(CARRY=0)
	RETURN			; �X�g�b�v�r�b�g�͓ǂ܂Ȃ��Ŗ߂�
	ENDIF
;
; PS/2�f�o�C�X���f�[�^��M���[�`��
;  �@�\�FPC�{�̂���̃f�[�^���L�[�{�[�h�^�}�E�X���Ŏ�M����B
;
PS2D_RX
	CLRF	PS2_DATA	; �f�[�^�N���A
	MOVLW	8
	MOVWF	LOOP
PS2D_RX_STARTBIT
	BTFSC	DATA_IN		; �X�^�[�g�r�b�g�҂�
	GOTO	PS2D_RX_STARTBIT
	MOVLW	TOC_MAX		; �N���b�NLow�^�C���A�E�g
	MOVWF	TOC
PS2D_RX_CLKLOW
	BTFSC	CLK_IN		; �V�X�e�������N���b�N��Low�ɂ��Ă���?
	GOTO	PS2D_RX_START
	CALL	WAIT5US
	DECFSZ	TOC,1
	GOTO	PS2D_RX_CLKLOW
	GOTO	PS2D_ABT
PS2D_RX_START
	CALL	WAIT40US	; �N���b�NHigh����
PS2D_RX_LOOP
	CALL	CLKBIT_LOW	; �N���b�N=Low
	CALL	WAIT40US	; �N���b�NLow����
	CALL	CLKBIT_HIGH	; �N���b�N=High
	CALL	WAIT5US
	BTFSS	CLK_IN		; �V�X�e�����N���b�N��Low�ɂ��Ă���?
	GOTO	PS2D_ABT	; �V�X�e�����f�[�^���M�𒆎~
	RRF	PS2_DATA,1
	CALL	WAIT5US		; �f�[�^�̓N���b�N��High����1us�Ŋm��
	BTFSC	DATA_IN		; �f�[�^�r�b�g�𒲂ׂ�
	GOTO	PS2D_RX_HIGH
	BCF	PS2_DATA,B7	; �f�[�^�r�b�g=0
	GOTO	PS2D_RX_NEXT
PS2D_RX_HIGH
	BSF	PS2_DATA,B7	; �f�[�^�r�b�g=1
PS2D_RX_NEXT
	CALL	WAIT20US	; �N���b�NHigh���Ԃ�40us�ɒ���
	CALL	WAIT5US
	DECFSZ	LOOP,1
	GOTO	PS2D_RX_LOOP

	CALL	WAIT40US	; 8th�N���b�NHigh����
	CALL	CLKBIT_LOW	; 9th�N���b�N=Low
	CALL	WAIT40US	; 9th�N���b�NLow����
	CALL	CLKBIT_HIGH	; 9th�N���b�N=High�p���e�B�r�b�g��M

	CALL	WAIT40US	; 9th�N���b�NHigh����
	CALL	CLKBIT_LOW	; 10th�N���b�N=Low
	CALL	WAIT40US	; 10th�N���b�NLow����
	CALL	CLKBIT_HIGH	; 10th�N���b�N=High�X�g�b�v�r�b�g��M

	CALL	WAIT20US	; 10th�N���b�NHigh����
	CALL	DATABIT_LOW	; �f�[�^=Low,�V�X�e���Ƀf�[�^��M��ʒm
	CALL	WAIT20US
	CALL	CLKBIT_LOW	; 11th�N���b�N=Low
	CALL	WAIT20US	; 11th�N���b�NLow����
	CALL	CLKBIT_HIGH	; 11th�N���b�N=High
	CALL	DATABIT_HIGH	; �f�[�^=High,�V�X�e���Ƀf�[�^��M��ʒm

	BCF	STATUS,B0	; ��M����:Carry=0
	IF DEBUG == 1
	BCF	STATUS_LED
	ENDIF
	RETURN
;
; PS/2���M�E��M�������~:Carry=1
;
PS2D_ABT
	CALL	WAIT5US
	CLRF	PS2_DATA
	BSF	STATUS,B0	; CARRY=1
	RETURN
;
; PS/2�L�[�{�[�h�^�f�[�^���M���[�`��
;�@�@�\�F�L�[�{�[�h����PC�{�̂փf�[�^�𑗐M����B
;
PS2D_TX_WAIT
	CALL	PS2D_TX0
	CALL	WAIT100US
	RETURN
PS2D_TX_WAIT2
	CALL	PS2D_TX0
	MOVLW	EQU_WAIT
	CALL	WAITNMS
	RETURN
PS2D_TX0
	MOVWF	PS2_DATA
	MOVWF	PS2_DBAK	; ���M�f�[�^��ۑ����Ă���
PS2D_TX
	CALL	WAIT5US
	BTFSS	CLK_IN		; �N���b�NHigh?
	GOTO	PS2D_TX		; Low�Ȃ�L�[�{�[�h�֎~�Ȃ̂ŏ������~
	BTFSS	DATA_IN		; �f�[�^High?
	GOTO	PS2D_TX		; Low�Ȃ�V�X�e�����M�Ȃ̂ŏ������~
	CALL	WAIT10US
	CLRF	PTCNT		; �p���e�B�J�E���^���Z�b�g
	MOVLW	8
	MOVWF	LOOP
	CALL	DATABIT_LOW	; �f�[�^Low(�X�^�[�g�r�b�g)
	CALL	WAIT100US
	CALL	CLKBIT_LOW	; �f�[�^���Z�b�g�����̂ŃN���b�NLow
	CALL	WAIT40US	; T3�N���b�NLow����30?50us
PS2D_TX_LOOP
	CALL	CLKBIT_HIGH	; �f�[�^���Z�b�g����O�ɃN���b�NHigh
	CALL	WAIT20US	; T2���Ԃ̈ꕔ(30?50us)
	BTFSC	CLK_IN		; �f�[�^���M���~?
	GOTO	PS2D_TX_CONT	; �f�[�^���M�p��

; �V�X�e�����ɂ���đ��M�����f���ꂽ�f�[�^���đ��M
	CALL	DATABIT_HIGH	; �f�[�^���C��=HI
	CALL	WAIT10US	; �đ��M�܂�10us�ҋ@����
	MOVF	PS2_DBAK,0	; W=���M�f�[�^
	GOTO	PS2D_TX0
PS2D_TX_CONT
	RRF	PS2_DATA,1	; ���M�f�[�^���V�t�g���ăL�����[�֓����
	BTFSC	STATUS,B0	; �f�[�^0/1�𔻒肷��
	GOTO	PS2D_TX_HIGH
	CALL	DATABIT_LOW	; �f�[�^�r�b�g=LOW
	GOTO	PS2D_TX_NEXT
PS2D_TX_HIGH
	CALL	DATABIT_HIGH	; �f�[�^�r�b�g=HI
	INCF	PTCNT,1		; �p���e�B�J�E���^+1
PS2D_TX_NEXT
	CALL	WAIT20US	; T4���Ԃ�������܂ł̎c�莞�Ԃ�҂�
	CALL	CLKBIT_LOW	; �f�[�^���Z�b�g�����̂ŃN���b�NLow
	CALL	WAIT40US	; T3�N���b�NLow����30?50us
	DECFSZ	LOOP,1
	GOTO	PS2D_TX_LOOP
PS2D_TX_PARITY
	CALL	CLKBIT_HIGH	; �p���e�B�Z�b�g����O��9th�N���b�NHigh
	CALL	WAIT20US	; T2����
	BTFSC	PTCNT,B0	; �p���e�B�r�b�g�����
	GOTO	PS2D_TX_PARIOFF
	CALL	DATABIT_HIGH	; �p���e�B�r�b�g=HI
	GOTO	PS2D_TX_STOP
PS2D_TX_PARIOFF
	CALL	DATABIT_LOW	; �p���e�B�r�b�g=LOW
PS2D_TX_STOP
	CALL	WAIT20US	; T4���Ԃ�������܂ő҂�
	CALL	CLKBIT_LOW	; 10th�N���b�NLow
	CALL	WAIT40US	; T3�N���b�NLow����
	CALL	CLKBIT_HIGH	; �X�g�b�v�r�b�g�O��10th�N���b�NHigh
	CALL	WAIT20US	; T2����
	CALL	DATABIT_HIGH	; �X�g�b�v�r�b�g���Z�b�g����
	CALL	WAIT20US	; T4���Ԃ�������܂ő҂�
	CALL	CLKBIT_LOW	; 11th�N���b�NLow
	CALL	WAIT40US	; T3�N���b�NLow����
	CALL	CLKBIT_HIGH	; 11th�N���b�NHigh
	BCF	STATUS,B0	; ���M����:Carry=0
	RETURN
;
; �N���b�N=High�܂ő҂�
;
WAITCLK_HI
	BTFSS	CLK_IN
	GOTO	WAITCLK_HI
	RETURN
;
; �N���b�N=Low�܂ő҂�
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
; DATA EEPROM WRITE
;  IN: E_ADR=ADDRESS W=DATA
;
;EE_WRITE
;	BCF	STATUS,RP0	; PAGE 0
;	MOVWF	EEDATA
;	MOVF	E_ADR,0
;	MOVWF	EEADR
;	BSF	STATUS,RP0	; PAGE 1
;	BSF	EECON1,B2	; WRITE ENABLE
;	MOVLW	55h		; EEPROM WRITE 1st PASSWORD 1
;	MOVWF	EECON2
;	MOVLW	0AAh		; EEPROM WRITE 2nd PASSWORD 2
;	MOVWF	EECON2
;	BSF	EECON1,B1	; WR BEGIN WRITE
;WAIT_EEW
;	BTFSC	EECON1,B1	; WAIT FOR WRITING
;	GOTO	WAIT_EEW
;	BCF	STATUS,RP0	; PAGE 0
;	RETURN
;
;
; DATA EEPROM READ
; IN: W=EEPROM ADDRESS OUT: W=EEPROM DATA
;
;EE_READ
;	BCF	STATUS,RP0	; PAGE 0
;	MOVWF	EEADR		; SET ADDRESS
;	BSF	STATUS,RP0	; PAGE 1
;	BSF	EECON1,B0	; READ BEGIN
;WAIT_EER
;	BTFSC	EECON1,B0	; WAIT FOR READING
;	GOTO	WAIT_EER
;	BCF	STATUS,RP0	; PAGE 0
;	MOVF	EEDATA,0
;	RETURN
EE_WRITE
	BSF	STATUS,RP0	; PAGE 1
	MOVWF	EEDATA
	BCF	STATUS,RP0	; PAGE 0
	MOVF	E_ADR,0
	BSF	STATUS,RP0	; PAGE 1
	MOVWF	EEADR
	BSF	EECON1,B2	; WRITE ENABLE
	MOVLW	55h		; EEPROM WRITE 1st PASSWORD 1
	MOVWF	EECON2
	MOVLW	0AAh		; EEPROM WRITE 2nd PASSWORD 2
	MOVWF	EECON2
	BSF	EECON1,B1	; WR BEGIN WRITE
WAIT_EEW
	BTFSC	EECON1,B1	; WAIT FOR WRITING
	GOTO	WAIT_EEW
	BCF	STATUS,RP0	; PAGE 0
	RETURN

; DATA EEPROM READ
; IN: W=EEPROM ADDRESS OUT: W=EEPROM DATA
;
EE_READ
	BCF	STATUS,RP0	; PAGE 0
	BSF	STATUS,RP0	; PAGE 1
	MOVWF	EEADR		; SET ADDRESS
	BSF	EECON1,B0	; READ BEGIN
WAIT_EER
	BTFSC	EECON1,B0	; WAIT FOR READING
	GOTO	WAIT_EER
	MOVF	EEDATA,0
	BCF	STATUS,RP0	; PAGE 0
	RETURN


;
;  100us WAIT���[�`��
; (6.144MHz:82.944us+3.255us+5.208x2=96.615us)
; (10.00MHz:51.2usx2+1.6us=104us)
;
WAIT100US
	CLRF	TMR0
WL1
	IF SYS_CLK == 0		; CLK=6.144MHz
	MOVLW	1
	ENDIF
	IF SYS_CLK == 1		; CLK=10MHz
	MOVLW	2
	ENDIF
	SUBWF	TMR0,0
	BTFSS	STATUS,B0
	GOTO	WL1
	IF SYS_CLK == 0		; CLK=6.144MHz
	CALL	WAIT20US
	ENDIF
	RETURN
;
; 45us WAIT���[�`��
; (6.144MHz:CALL+SUB+RET = 45.570us)
; (10.00MHz:CALL+SUB+RET = 46.000us
;
WAIT45US
	IF SYS_CLK == 0		; CLK=6.144MHz
	MOVLW	21		; 1
	ENDIF
	IF SYS_CLK == 1
	MOVLW	36		; CLK=10MHz
	ENDIF
	MOVWF	WAIT0		; 1
WL2
	DECFSZ	WAIT0,1		; 1
	GOTO	WL2		; 2
	NOP			; 1
	RETURN			; 2
;
; 5us WAIT���[�`��
; (CLK=6.144MHz:CALL+SUB+RET = 5.208us)
; (CLK=10.00MHz:CALL+SUB+RET = 5.200us)
;
WAIT5US
	IF SYS_CLK == 0		; CLK=6.144MHz
	NOP
WAIT5USS			; shortwait for PS/2 timming adjust
	GOTO	$+1
	NOP
	ENDIF
	IF SYS_CLK == 1		; CLK=10MHz
	GOTO	$+1
WAIT5USS			; shortwait for PS/2 timming adjust
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
; 20us WAIT���[�`��
;
WAIT20US
	CALL	WAIT10US
	CALL	WAIT10US
	RETURN
;
; 35us WAIT���[�`��
;
WAIT35US
	CALL	WAIT20US
	CALL	WAIT10US
	CALL	WAIT5US
	RETURN
;
; 40us WAIT���[�`��
;
WAIT40US
	CALL	WAIT20US
	CALL	WAIT20US
	RETURN
;
; �����ԃ^�C�}�[(��500ms)
;
DELAY
	MOVLW	5
	MOVWF	TIMEF0
DELAY1
	MOVLW	100
	MOVWF	TIMEF1
DELAY2
	CALL	WAIT1MS
	DECFSZ	TIMEF1,1
	GOTO	DELAY2
	DECFSZ	TIMEF0,1
	GOTO	DELAY1
	RETURN
;
; N x 1ms WAIT
;
WAITNMS
	MOVWF	ETC1
WAITNMS_LOOP
	CALL	WAIT1MS
	DECFSZ	ETC1,1
	GOTO	WAITNMS_LOOP
	RETURN
;
; 1ms�^�C�}�[
;
WAIT1MS
	CLRF	TMR0
WAIT1MS1
	IF SYS_CLK == 0		; CLK=6.144MHz
	MOVLW	12
	ENDIF
	IF SYS_CLK == 1		; CLK=10MHz
	MOVLW	20
	ENDIF
	SUBWF	TMR0,0
	BTFSS	STATUS,B0
	GOTO	WAIT1MS1
	RETURN
;
; PC98�L�[�R�[�h����PS/2�ւ̃R�[�h�ϊ����[�`��
;
	ORG	377h
CNV982AT
	MOVWF	WORK
	SUBLW	7Eh		; 7Fh�ȏゾ������CARRY��0(��)
	BTFSC	STATUS,B0
	GOTO	CNV982AT_OK	; �L�[�R�[�h����Ȃ̂ŕϊ�������
	RETLW	0FFh		; �L�[�R�[�h�ϊ��G���[
CNV982AT_OK
	MOVLW	3
	MOVWF	PCLATH
	MOVF	WORK,0
	ADDWF	PCL,1
	RETLW	76h		; 00 ESC -> ESC
	RETLW	16h		; 01 1!
	RETLW	1Eh		; 02 2"
	RETLW	26h		; 03 3#
	RETLW	25h		; 04 4$
	RETLW	2Eh		; 05 5%
	RETLW	36h		; 06 6&
	RETLW	3Dh		; 07 7'
	RETLW	3Eh		; 08 8(
	RETLW	46h		; 09 9)
	RETLW	45h		; 0A 0
	RETLW	4Eh		; 0B -=
	RETLW	55h		; 0C ^~
	RETLW	6Ah		; 0D \|
	RETLW	66h		; 0E BS
	RETLW	0Dh		; 0F TAB
	RETLW	15h		; 10 Q
	RETLW	1Dh		; 11 W
	RETLW	24h		; 12 E
	RETLW	2Dh		; 13 R
	RETLW	2Ch		; 14 T
	RETLW	35h		; 15 Y
	RETLW	3Ch		; 16 U
	RETLW	43h		; 17 I
	RETLW	44h		; 18 O
	RETLW	4Dh		; 19 P
	RETLW	54h		; 1A @
	RETLW	5Bh		; 1B [
	RETLW	5Ah		; 1C RETURN
	RETLW	1Ch		; 1D A
	RETLW	1Bh		; 1E S
	RETLW	23h		; 1F D
	RETLW	2Bh		; 20 F
	RETLW	34h		; 21 G
	RETLW	33h		; 22 H
	RETLW	3Bh		; 23 J
	RETLW	42h		; 24 K
	RETLW	4Bh		; 25 L
	RETLW	4Ch		; 26 ;
	RETLW	52h		; 27 :
	RETLW	5Dh		; 28 ]
	RETLW	1Ah		; 29 Z
	RETLW	22h		; 2A X
	RETLW	21h		; 2B C
	RETLW	2Ah		; 2C V
	RETLW	32h		; 2D B
	RETLW	31h		; 2E N
	RETLW	3Ah		; 2F M
	RETLW	41h		; 30 ,
	RETLW	49h		; 31 .
	RETLW	4Ah		; 32 /
	RETLW	51h		; 33 _
	RETLW	29h		; 34 SPACE
	RETLW	64h		; 35 XFER -> �ϊ�

	IF ROLL == 1		; PAGE�L�[�A�T�C��
	RETLW	11111101B	; 36 ROLL UP -> PAGE UP(�t)
	ELSE
	RETLW	11111010B	; 36 ROLL UP -> PAGE DOWN(�ʏ�)
	ENDIF

	IF ROLL == 1
	RETLW	11111010B	; 37 ROLL DOWN -> PAGE DOWN(�t)
	ELSE
	RETLW	11111101B	; 37 ROLL DOWN -> PAGE UP(�ʏ�)
	ENDIF

	RETLW	11110000B	; 38 INS
	RETLW	11110001B	; 39 DEL
	RETLW	11110101B	; 3A ��
	RETLW	11101011B	; 3B ��
	RETLW	11110100B	; 3C ��
	RETLW	11110010B	; 3D ��
	RETLW	11101100B	; 3E CLR/HOME
	RETLW	11101001B	; 3F HELP -> END
	RETLW	7Bh		; 40 - (TEN)
	RETLW	11001010B	; 41 / (TEN)
	RETLW	6Ch		; 42 7 (TEN)
	RETLW	75h		; 43 8 (TEN)
	RETLW	7Dh		; 44 9 (TEN)
	RETLW	7Ch		; 45 * (TEN)
	RETLW	6Bh		; 46 4 (TEN)
	RETLW	73h		; 47 5 (TEN)
	RETLW	74h		; 48 6 (TEN)
	RETLW	79h		; 49 + (TEN)
	RETLW	69h		; 4A 1 (TEN)
	RETLW	72h		; 4B 2 (TEN)
	RETLW	7Ah		; 4C 3 (TEN)
	RETLW	0FFh		; 4D = (TEN) -> = (��O����)
	RETLW	70h		; 4E 0 (TEN)
	RETLW	41h		; 4F , (TEN) -> ,
	RETLW	71h		; 50 . (TEN)
	RETLW	67h		; 51 NFER -> ���ϊ�
	RETLW	78h		; 52 F11
	RETLW	07h		; 53 F12
	RETLW	7Eh		; 54 F13 -> SCROLL LOCK
	RETLW	0FFh		; 55 F14 -> PAUSE
	RETLW	77h		; 56 F15 -> NUMLOCK
	RETLW	0FFh		; 57 
	RETLW	0FFh		; 58 
	RETLW	0FFh		; 59 
	RETLW	0FFh		; 5A 
	RETLW	0FFh		; 5B 
	RETLW	0FFh		; 5C 
	RETLW	0FFh		; 5D 
	RETLW	11101100B	; 5E HOME(PC-98XA�̂�)
	RETLW	0FFh		; 5F 
	RETLW	0Eh		; 60 STOP -> ���p/�S�p
	RETLW	0FFh		; 61 COPY -> PRINT SCREEN
	RETLW	05h		; 62 F1
	RETLW	06h		; 63 F2
	RETLW	04h		; 64 F3
	RETLW	0Ch		; 65 F4
	RETLW	03h		; 66 F5
	RETLW	0Bh		; 67 F6
	RETLW	83h		; 68 F7
	RETLW	0Ah		; 69 F8
	RETLW	01h		; 6A F9
	RETLW	09h		; 6B F10
	RETLW	0FFh		; 6C 
	RETLW	0FFh		; 6D 
	RETLW	0FFh		; 6E 
	RETLW	0FFH		; 6F 
	RETLW	12h		; 70 SHIFT -> SHIFT(L)
	RETLW	58h		; 71 CAPS
	RETLW	13h		; 72 ����
	RETLW	11h		; 73 GRAPH -> ALT(L)
	RETLW	14h		; 74 CTRL -> CTRL(L)
	RETLW	0FFh		; 75
	RETLW	0FFh		; 76
	RETLW	10011111B	; 77 WIN(L)
	RETLW	10100111B	; 78 WIN(R)

	IF D_BOARD == 1
	RETLW	0FFh		; 79 ALT(D-BOARD)
	ELSE
	RETLW	10101111B	; 79 APLICATION
	ENDIF

	RETLW	0FFh		; 7A
	RETLW	0FFh		; 7B
	RETLW	0FFh		; 7C
	RETLW	59h		; 7D SHIFT -> SHIFT(R) (WIN�L�[�L����)
	RETLW	0FFh		; 7E
	RETLW	0FFh		; 7F
	END
