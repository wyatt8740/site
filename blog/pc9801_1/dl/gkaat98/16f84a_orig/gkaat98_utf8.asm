;
; PS/2 to PC-9801 Keybaord Adaptor 'GKA-AT98' Ver1.43
;  1997 Programmed by m.sawada/magonote honpo
;   (101/104/AX/106/109/HHKキーボード対応)
;
; LAST UPDATE:2004/5/30版
;
;  IBMキーボードコマンド送信対応,CAPS/KANA/NUMLOCK LED,コンパクト化
;  KANA/CAPバグ修正,PAUSE KEYコード対応,NUMLOCK対応,ACERキーボード対応
;　PAUSEキーをSTOPキーに割り当て、XFER,NFERの割り当てを修正
;  対応下りコマンド RESET/KEYBOARD-TYPE/LEDに対応
;  PC98のWIN95下りコマンド対応版(謎のコマンドである9ChにはFAhを返答)
;　WIN95キー対応,初期化時0FAh送信,scroll rock=helpキー割り当て
;　リピート方法をPC98準拠に修正。(ﾀｲﾐﾝｸﾞ非準拠,開始0.5mS,make-break間30mS)
;　リセット時キー入力暫定対応(ｼｽﾃﾑｾｯﾄｱｯﾌﾟﾒﾆｭｰに入れない等の問題)(2/4)
;　NUMLOCKキー押下時Rが入力されるバグを修正。(2/4)
;  NUMLOCKキー解除時ENDキーにROLLUPがアサインされないバグを修正(2/5)
;  リピート処理でブレイクコードを送らないバグを修正(2/7)
;  リピート処理で最初のメイクから500mS後にブレイクコードを送る(2/7)
;  システムセットアップ,モニタ周波数切り替え対応。(2/8)
;　電源投入後すぐにリセットすると、キーが押されて起動しないバグを修正(2/10)
;　変換失敗コードを判断しないバグを修正。(02/17)
;　EXCODEのキー変換ルーチン改善。テーブルを300hへ移動(100h境界対策)(02/17)
;  デバッグマシンCPU交換後ｼｽﾃﾑｾｯﾄｱｯﾌﾟﾒﾆｭｰに入れなくなった障害を修正(03/03)
;　I/Oデータ製SCSIボードのｾｯﾄｱｯﾌﾟはなんと、キー同時3個押しらしいので、
;　とうとう複数キーリピートに対応せざるをえなくなり対応開始。
;　管理テーブル方式で暫定対応・デバッグ中(05/24)
;　正確には複数キーリピートではなく、リセット直前まで押されつづけていた
;　キー列のバッファリングと再送信を行う処理を追加した(05/26)
;　PC98キーボードはリセット後に押されているキーを再送信できるようだ。
;　初期化ルーチンの改善(PORなど)、送信ルーチンの改善(キープロセス待ち)(05/26)
;　E0hから始まるコードもバッファリングするよう改善(05/26)
;　メイク／ブレイク部コンパクト化(E0コード部共通化)(05/30)
;　GRAPH,SHIFTキーのリピート抑止(06/01)
;　キーボードコマンドが送られてきた場合は無視する(06/11)
;　CAPS,KANA,NUMLOCKシフト,LED処理を改善,SHFLGワーク廃止(06/11)
;　IBMキーボード受信ルーチン改善ストップビット後クロック下がるまで待つ(6/12)
;　リピートON/OFFコマンド対応中,NT対応含む(7/3)
;　初期化ルーチンの改善(タイマをすべてなくした)(8/14)
;　タイマ#0を使用できるようにした(8/14)
;　未知の下りコマンド受信時、リセット時送信キーが無ければFAhを応答(8/18)
;　LED下りコマンドが動作しない不具合を修正中(8/21)
;　キーボードタイプコマンドの応答の不具合を修正中(8/21)
;　PC98本体がLED制御できるか判定するようにした,制御できない場合はアダプタ側が
;　制御するようにした(8/21)
;　カーソルリピートコマンドについては資料がないため、結局正常応答のみ(8/27)
;　XFER,NFERが逆になていたので修正(8/29)
;　INS,CAPS,CTRL,かなキーのリピートを抑止(8/29)
;　初期化ルーチンのタイマを復活。動作しないキーボードがあったため。(9/10)
;　初期化ルーチンの不具合を解決。INTFLAGが原因だった。(9/13)
;　初期化ルーチンを改善。電源投入時にFFh(オーバーラン)等のコードを送ってくる
;　キーボードがあるため、BAT終了コード受信をリトライ(10回)するようにした(9/17)
;　リセット時キー再送信処理を変更。キーバッファクリア,送信間隔1mS->30mS(9/22)
;  プログラムの無駄を省いてメモリのフリーエリアを広げた(9/28)
;　PAUSEキーMAKE〜BREAK間のウエイトを30mSにした(9/28)
;　フラグ(BRK,INTFLAG,BRKF,RPTF)のビット化でフリーエリアを広げた(9/28)
;　キーボードからの特殊コード処理を簡略化してフリーエリアを広げた(9/28)
;　フラグ(CAPS,KANA,NUMLOCK)をビット化してフリーエリアを広げた(9/29)
;  キーリピートMAKE,BREAK間隔を修正してAUTOREPEATが止まるのを防止(10/21)
;　割り込み処理PUSH/POPルーチンSTATUSが復帰されない不具合を修正(98/4/9)
;　下りコマンド:キーボードタイプ応答を変更し,FAh,A0h,80h応答にした(6/2)
;　リセットコマンドでキー状態の送信をしないようにした(6/3)
;  送信後READY信号をみて下りコマンドを受信しないことがあるのを修正(6/9)
;　IBMKEYTXを修正(9.8304MHz化時に不具合がでる)した(8/1)
;　JCC製AXキーボードで受信に失敗することがあるのでIBMKEYRXを修正(8/12)
;  PAGE UP = ROLL DOWN,PAGE DOWN = ROLL UP,END=ROLL DOWNとした(11/7)
;  98下りコマンドの割り込み受信からポーリングへ変更し省メモリ化(7/6)
;  98受信/送信,PS2受信/送信を一部変更、コメントを修正(7/6)
;  キー変換テーブルを高位アドレス側へ詰めてフリーエリアを確保(7/6)
;  ASCII/JIS/AX版共通ソース化,変更はKB_TYPEの値を変更する(7/6)
;  (AXキーボードの場合かな処理とLEDビットアサインが異なるので注意)
;  コストダウン用にシステムクロックを6.144MHz/10MHzから選べるようにするため
;  SEND98,RX98KEYをそれぞれ2つ用意した。またタイミングの微調整を行った(7/12)
;  PAGE UP,DOWNアサインをソースレベルで切り替えられるようにした(2000/1/15)
;
;  動作しないキーボード(SCORPIUS 98A)に対応した。(2000/2/7)
;  このキーボードはPOR中に送信を禁止しているとAAhを送ってこない。
;  このことから、POR直後の様々なパターンな対応するため、電源投入時の
;  手順を以下のように変更した。今後は他のGKAシリーズへも反映される。
;
;   1. 電源投入直後はCLK,DATA=HIGHでキーボード側は送信可にしておく。
;   2. POR終了のBAT完了コードの受信を3回試みて首尾よく受信できた
;      場合は、次の処理へ進む。何度か試みてだめな場合はエラー表示後次の処理へ
;   3. キーボードへリセットコマンドを送信する。
;   4. BAT完了コードの受信を試みる。受信できた場合は初期化処理成功。
;      何度か試みてだめな場合はエラー表示(LED点滅)してから停止せずに続行。
;
;  NOPx2=GOTO $+1と置き換えてコードサイズを縮小(2/7)
;  テンキー部のEND/PAGE UP/DOWNキーについてもアサインの入れ替えを適用(2/7)
;  ワークエリアの整理、コードサイズを縮小(2/26)
;  キーボード初期化のBAT完了コード受信回数を1回のみとした(3/1)
;
;  `,‾(チルダ)が刻印通りに入力できるようにSHIFT時にキーコードを入れ替えら
;  れるようにした(KEY_EXCHGで指定)(3/1)
;  @,^入れ替えで先にSHIFTを放すとキーがメイクされたままになるのを修正(3/1)
;  ↑機能は依然として誤動作することがあり現時点での使用は推奨しない(3/2)
;
;  一部コメント修正(3/27)
;  PFU Happy Hacking Keyboardに対応(4/4)
;  英数/CAPSキーをCTRLキーへ割り当てられるようにした(4/4)
;  全角/半角 -> XFER割り当て(2001/2/3)
;  コメントの大幅な書き換え(2003/3/19)
;  特殊仕様:NFER,CAPS,かなをSHIFT押しながらのみで操作に対応(3/21)
;
; キーボード下りコマンド対応の改善
;  1.リピート速度コマンド(9Ch)に正常応答するようにした。速度指定は無視(3/22)
;  2.LED状態返答コマンド(9Dh+60h)に対応,LEDワーク処理一部変更(3/22)
;  3.実装以外のコマンドに対しては応答しないようにした(3/22)
;  *上記1-3変更によりWindowsNT起動時に停止する不具合が改善された(3/22)
;
;  ソースすらCONFIG/IDLOCを設定するようにした(4/12)
;  MPLAB標準インクルードファイルを使用するようにした(4/12)
;  特殊仕様:SHIFT LOCK時にCAPSキーのみでCTRLキーになる(6/11)
;  PLUS PCB(I/O Direction制御)対応(12/4)
;  PIC16F628対応(2004/5/30)
;
; Make Options
;
#DEFINE KB_TYPE		2	; キーボード 0=101/104 1=AX 2=106/109 3=HHK
#DEFINE CAPS_ASSIGN	0	; 英数/CAPS割り当て 0=CAPS 1=CTRL
#DEFINE SYS_CLK		1	; システムクロック 0=6.144MHz 1=10MHz
#DEFINE ROLL		0	; PAGE UP/DWアサイン0=PD-RD,PU-RU 1=PD-RU,PU-RD
#DEFINE KEY_EXCHG	0	; @,^ KEY EXCHAGE with SHIFT 0=Not 1=Excange
#DEFINE SHIFT_LOCK	0	; SHIFTロック 0=OFF 1=ON(SHIFT+CAPS/かな/NFER)
#DEFINE CAPS_CTRL	0	; SHIFTロック時CAPSキー割り当て 0=CAPS 1=CTRL
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
; Bit表記の定義
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
; ワークエリア割り当て
;
	CBLOCK	RAMADR
	WAIT0
	WAIT1
	WAIT2
	PC98_DATA	; PC-9801キーボード送受信データ
	PS2_DATA	; PS/2キーボード送受信データ
	LOOP		; ループカウンタ1
	LOOP2		; ループカウンタ2
	WORK		; 汎用ワーク
	PTCNT		; パリティビットカウンタ

	SYSFLG		; B0:SHIFTフラグ 0=OFF 1=ON
			; B1:Breakフラグ 0=OFF 1=Break
			; B2:下りコマンド受信フラグ 1=Recieved
			; B3:キー未Breakフラグ 0=Break 1=まだMake
			; B4:リピート1=複数キーが押されつづけている
			; B5:CAPSフラグ 0=OFF 1=ON
			; B6:かなフラグ 0=OFF 1=ON
			; B7:NumLockフラグ 0=OFF 1=ON
	SYSFLG2		; B0:@,^入れ替え処理フラグ 1=入れ替え中
			; B1:SHIFT-Breakフラグ 1=Break

	LEDDATA		; PS/2キーボードのLEDデータ
	ETC		; 汎用ワーク
	BKEY		; 前回押されたキーコード（98コード）
	KBF_BGN		; 再送信バッファ開始アドレス(1Ah〜1A+KBF_LEN)
	LEDDATA98	; PC98 LED DATA
	ENDC
;
; 各種設定値
;
KBF_LEN		EQU	3	; 再送信キーバッファサイズ
DELAYT		EQU	4  	; 長時間ウエイト(500ms)
BATOK		EQU	0AAh	; BAT完了コード
BAT_RTY_NUM	EQU	1	; BAT完了コード受信リトライ回数
ERR_DSP_NUM	EQU	3	; キーボードエラーLED点滅回数
;
; 基板毎のピン割り当て
;
	;
	; オリジナル/共通PCB(2001)
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
	; 全基板共通
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
; スタートアップ
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
	; タイマ0,割込み関係初期化
	;
	BCF	STATUS,RP0	; SELECT PAGE 0
	CLRWDT			; ウォッチドッグタイマをクリア
	CLRF	TMR0		; TMR0内容クリア
	BSF	STATUS,RP0	; SELECT PAGE 1
	MOVLW	10000110B
				; RBプルアップ無し
				; INT割り込みエッジ=立ち下がり
				; タイマクロック=1/4OSC(648nS)
				; プリスケーラ:TMR0
				; プリスケーラ分周比:1/128(82.944uS/6.144MHz)
				;                         (51.2uS/10MHz)
	MOVWF	OPTION_REG	; OPTIONレジスタ設定
	BCF	STATUS,RP0	; SELECT PAGE 0
	;
	; ANALOG COMPARATOR(16F62x)
	;
	IF DEV == 1
	MOVLW	00000111B	; RA = DIGITAL I/O PORT
	MOVWF	CMCON
	ENDIF

	CLRF	TMR0		; TMR0内容クリア
	CALL	INITALIZE	; ワーク初期化,PS/2キーボード起動チェック
	CALL	KBRESET		; PS/2キーボードリセット
;
;　メインループ
; PS/2キーボード PC98キーボード変換処理
;
MAIN
	BCF	SYSFLG,B1	; Clear Break Flag
	CALL	CLKDATABIT_HIGH
PORT_CHK
	BTFSS	PORTB,B0	; 下りコマンド受信?
	GOTO	DOWN98COM
	BTFSC	DATA_IN		; PS/2データ受信?
	GOTO	PORT_CHK
	BCF	STATUS_LED	; 下りコマンド受け付けLED消灯
	CALL	IBMKEYRX	; PS/2キーボード受信処理
	MOVF	PS2_DATA,0	; キーボードからの特殊コード処理
	XORLW	0F0h		; Breakコード?
	BTFSS	STATUS,B2
	GOTO	SP_CODE
	BSF	SYSFLG,B1	; Set Break Flag
	CALL	IBMKEYRX	; 離されたキーコードを読む
	GOTO	IT98
SP_CODE
	MOVF	PS2_DATA,0
	SUBLW	0E2h		; E2h以上だったらCARRY=0(演算結果負)
	BTFSS	STATUS,B0
	GOTO	MAIN		; 特殊コード(AAh,FFh等)なら無視
	MOVF	PS2_DATA,1
	BTFSC	STATUS,B2	; 00h(オーバーラン)なら無視
	GOTO	MAIN
	;
	; シフトに影響されないキーのMake/Break処理
	;
IT98
	MOVF	PS2_DATA,0
	XORLW	0E0h
	BTFSC	STATUS,B2	; E0hで始まるキーコード？
	GOTO	IT98EXCODE	;  Yes. E0hコード処理へ
	MOVF	PS2_DATA,0
	XORLW	0E1h
	BTFSC	STATUS,B2	; E1h(PAUSE)?
	GOTO	PAUSE_KEY0	;  Yes. PAUSEキー処理
	BTFSC	SYSFLG,B7	; NumLock Flag?
	GOTO	IT98NNUM	;  No. 通常処理へ

	MOVF	PS2_DATA,0	; 以下NumLockキーシフト時の処理
	SUBLW	68h
	BTFSC	STATUS,B0	; 69h以上? CARRY=0(演算結果負)
	GOTO	IT98NNUM	;  No. NumLockキー対象外
	MOVF	PS2_DATA,0
	SUBLW	7Dh
	BTFSS	STATUS,B0	; 7Eh以上? CARRY=0(演算結果負)
	GOTO	IT98NNUM	;  No. NumLockキー対象外
	MOVLW	69h		; キーコード補正用オフセット値
	SUBWF	PS2_DATA,0	; オフセットを取る（注)PS2_DATA=PS2_DATA-W
	CALL	CNVNUM		; PS/2→NumLockキーシフト時のPS/2コード変換
	GOTO	IT98STORE
IT98NNUM
	MOVF	PS2_DATA,0	; W=PS/2キーコード
	CALL	CNVITO98	; PS/2→98コード変換 W=PC98キーコード
IT98STORE
	MOVWF	PC98_DATA
	XORLW	0FFh
	BTFSC	STATUS,B2
	GOTO	MAIN		; コード変換失敗
	;
	; チルダが刻印通り入力できるようSHIFT時にキーコードを入替える
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
	GOTO	KEY_EXCLR	; 対象外キーなら入れ替え中フラグクリア
KEY_EX1
	MOVLW	1Ah
	GOTO	KEY_EX3
KEY_EX2
	MOVLW	0Ch
KEY_EX3
	MOVWF	PC98_DATA	; 入れ替えたコードを送信ワークへセット
	BSF	SYSFLG2,B0	; 入れ替え中フラグセット
				; SHIFTが@,^キーより前に放された場合に@,^キー
				; がメイクされたままになるのを防ぐ!
	BTFSS	SYSFLG,B1	; ブレイク?
	GOTO	CHKSHIFT
KEY_EXCLR
	BCF	SYSFLG2,B0	; 入れ替え中フラグクリア
	BTFSS	SYSFLG2,B1	; SHIFTキーは既にブレイクされた?
	GOTO	CHKSHIFT
	BCF	SYSFLG,B0	; されたならSHIFTフラグをクリア
	BCF	SYSFLG2,B1	; SHIFTブレイクフラグをクリア
	ENDIF
	;
	; シフト状態をチェックしてLEDを制御する
	; (下りコマンドのない旧機種用処理含む)
	;
CHKSHIFT
	IF SHIFT_LOCK == 1	; SHIFTロック処理
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
	BSF	PC98_DATA,B7	; Breakコードを準備
	CALL	SEND98		; Breakコードを送信
	CALL	WAIT1MS
	MOVLW	51h		; NFERコードを復帰
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
	BSF	PC98_DATA,B7	; Breakコードを準備
	CALL	SEND98		; Breakコードを送信
	CALL	WAIT1MS
	MOVLW	71h		; CAPSコードを復帰
	MOVWF	PC98_DATA
	GOTO	CHKSHIFT2
SHIFTLK_KANA
	MOVF	PC98_DATA,0
	XORLW	72h
	BTFSS	STATUS,B2	; かな Make?
	GOTO	CHKSHIFT2	;  No.
	BTFSS	SYSFLG,B0	; SHIFT Flag?
	GOTO	MAIN		;  No.
	MOVLW	70h		; SHIFT break
	MOVWF	PC98_DATA
	BSF	PC98_DATA,B7	; Breakコードを準備
	CALL	SEND98		; Breakコードを送信
	CALL	WAIT1MS
	MOVLW	72h		; かなコードを復帰
	MOVWF	PC98_DATA
	ENDIF
CHKSHIFT2
	MOVF	PC98_DATA,0
	XORLW	071h
	BTFSC	STATUS,B2	; CAPS Make?
	GOTO	CAPS		;  Yes.

	IF KB_TYPE == 2		; 106/109のかなキー処理
	MOVF	PS2_DATA,0
	XORLW	13h
	BTFSC	STATUS,B2	; KANA Make?
	GOTO	KANA		;  Yes.
	ENDIF

	MOVF	PS2_DATA,0
	XORLW	77h
	BTFSC	STATUS,B2	; NumLock Make?
	GOTO	NUMLOCK		;  Yes.
	GOTO	IT98NRM		; Make/Break処理へ
	;
	;  CAPSキーとLED処理
	;
CAPS
	BTFSC	SYSFLG,B1
	GOTO	CAPKANA_BRK

	MOVF	BKEY,0		; CAPSキーはリピートさせない
	XORWF	PC98_DATA,0
	BTFSC	STATUS,B2	; Repeat?
	GOTO	MAIN		;  Yes.

	BTFSC	SYSFLG,B5	; CAPS Flag?
	GOTO	CAPOFF		;  Yes.
CAPON
	CALL	CAP_ON
	BSF	SYSFLG,B5	; Set CAPS Flag
	GOTO	IT98MK		; Make処理へ
CAPOFF
	CALL	CAP_OFF
	BCF	SYSFLG,B5	; Clear CAPS Flag
	GOTO	IT98BR2		; Break処理へ
CAPKANA_BRK
	MOVLW	0FFh
	MOVWF	BKEY		; Clear Before KeyCode
	GOTO	MAIN
	;
	; かなキーの処理
	;
KANA
	BTFSC	SYSFLG,B1	; Break Flag?
	GOTO	CAPKANA_BRK 	;  Yes.

	MOVF	BKEY,0		; かなキーはリピートさせない
	XORWF	PC98_DATA,0
	BTFSC	STATUS,B2	; Repeat?
	GOTO	MAIN		;  Yes.

	BTFSC	SYSFLG,B6	; かなFlag?
	GOTO	KANAOFF		;  Yes.
KANAON
	CALL	KANA_ON		; アダプタ側でLED制御する
	BSF	SYSFLG,B6	; Set かな Flag
	GOTO	IT98MK		; Make処理へ
KANAOFF
	CALL	KANA_OFF	; アダプタ側でLED制御する
	BCF	SYSFLG,B6	; Clear かな Flag
	GOTO	IT98BR2		; Break処理へ
	;
	; NumLockキーとLEDの処理
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
	; SHIFTキーのフラグ処理(@,^のキー入れ替え処理用)
	;
SHIFT
	IF KEY_EXCHG == 1
	BTFSC	SYSFLG,B1	; Break Flag?
	GOTO	SHIFTOFF
SHIFTON
	BSF	SYSFLG,B0	; Set SHIFT Flag
	BCF	SYSFLG2,B1	; Clear SHIFT-Break Flag
	GOTO	IT98NRM		; Make/Break処理へ
SHIFTOFF
	BSF	SYSFLG2,B1	; Set SHIFT-Break Flag
	BTFSS	SYSFLG2,B0	; @,^キーが入れ替え中?
	BCF	SYSFLG,B0	;  No. Clear SHIFT Flag
	GOTO	IT98NRM		; Make/Break処理へ
	ENDIF
	;
	; SHIFTキーのフラグ処理(SHIFTロック機能)
	;
SHIFT2
	IF SHIFT_LOCK == 1
	BTFSC	SYSFLG,B1	; SHIFT Flag?
	GOTO	SHIFT2OFF	;  Yes.
SHIFT2ON
	BSF	SYSFLG,B0	; Set SHIFT Flag
	GOTO	IT98NRM		; Make/Break処理へ
SHIFT2OFF
	BCF	SYSFLG,B0	; Clear SHIFT Flag
	GOTO	IT98NRM		; Make/Break処理へ
	ENDIF
	;
	; SHIFTロック時CAPSキーのみにCTRLキーを割り当てる
	;
EXC_CAPS_CTRL
	MOVLW	74h		; CTRLコード(PC-98)
	MOVWF	PC98_DATA
	;
	; Make/Break処理
	;
IT98NRM
	BTFSC	SYSFLG,B1	; Break?
	GOTO	IT98BR		;  Yes.Break送信処理へ
	GOTO	IT98MK		;  No. Make送信処理へ
	;
	; E0hで始まるキーの処理
	;
IT98EXCODE			; E0hコードMake/Break処理
	BCF	SYSFLG,B1
	CALL	IBMKEYRX
	MOVF	PS2_DATA,0
	XORLW	0F0h		; BreakCode?
	BTFSS	STATUS,B2
	GOTO	IT98EX
	BSF	SYSFLG,B1	; Set Break Flag
	CALL	IBMKEYRX	; BreakCode受信
	;
	; E0hで始まるキーとシフト状態の影響を受けるキーの処理
	;
IT98EX
	MOVF	PS2_DATA,0
	XORLW	12h		; シフト・NumLock?
	BTFSC	STATUS,B2
	GOTO	MAIN		; そうなら次のキーを読む
	MOVF	PS2_DATA,0
	XORLW	59h		; 右シフト?
	BTFSC	STATUS,B2
	GOTO	MAIN		; そうなら次のキーを読む
	;
	; E0hコードのMake/Break処理
	;
	CALL	IT98CNV1	; PS/2→PC98キーコード変換
	MOVWF	PC98_DATA
	XORLW	0FFH		; コード変換失敗?
	BTFSC	STATUS,B2
	GOTO	MAIN		; 変換失敗したのでなにもしない
	;
	; AXキーボード「かな」キー処理
	;
	IF KB_TYPE == 1
	MOVF	PS2_DATA,0
	XORLW	14h		; かなキーメイク?
	BTFSC	STATUS,B2
	GOTO	KANA
	ENDIF

	BTFSC	SYSFLG,B1	; Break Flag?
	GOTO	IT98BR
	;
	; 起動時のキー列送信用処理(システムセットアップメニュー等への対応)
	;  1キーリピートか複数キーのリピート状態かを
	;  判定しキーのバッファリングを行う
	;
IT98MK				; 1キーリピートのバッファリング
	MOVF	PC98_DATA,0	; 前回と同じMakeコードならリピート処理
	XORWF	BKEY,0
	BTFSC	STATUS,B2
	GOTO	IT_RPT1		; 通常のMake処理へ
	BTFSC	SYSFLG,B3	; キーが放されたかフラグを調べる
	GOTO	IT_RPT2		; キーが放されてなければバッファリング処理へ
	GOTO	IT98MK_2	; 通常Make処理へ
IT_RPT1
	MOVF	PC98_DATA,0	; ***通常の１キーリピート処理***
	MOVWF	BKEY
	CALL	KEY_RPT		; キーをバッファへ書き込む

	MOVF	PC98_DATA,0
	XORLW	73h		; GRAPHキーはリピートさせない
	BTFSC	STATUS,B2
	GOTO	RPT_CANCEL

	MOVF	PC98_DATA,0
	XORLW	74h		; CTRLキーはリピートさせない
	BTFSC	STATUS,B2
	GOTO	RPT_CANCEL

	MOVF	PC98_DATA,0
	XORLW	38h		; INSキーはリピートさせない
	BTFSC	STATUS,B2
	GOTO	RPT_CANCEL

	MOVF	PC98_DATA,0
	XORLW	70h		; SHIFTキーはリピートさせない
	BTFSC	STATUS,B2
	GOTO	RPT_CANCEL

	CALL	NRM_RPT		; 通常リピート処理を実行
RPT_CANCEL
	BSF	SYSFLG,B4	; リピート中フラグを設定
	GOTO	MAIN
IT_RPT2				; ***同時押しキーリピート用処理***
	MOVF	PC98_DATA,0	; 今回のMakeコードを呼び出す
	MOVWF	ETC		; それをETCへ保存
	MOVF	BKEY,0		; 前回のMakeコードをバッファへ書き込むため
	MOVWF	PC98_DATA	; データバッファへ書き込む
	CALL	KEY_RPT		; ***キーバッファリング処理を呼び出す***
	MOVF	ETC,0		; 保存Makeコードを戻す
	MOVWF	PC98_DATA
IT98MK_2			; 通常のMake処理
	BSF	SYSFLG,B3	; キー未Breakフラグセット
	MOVF	PC98_DATA,0	; Makeコードを保存
	MOVWF	BKEY
	CALL	SEND98		; PC98側へMakeコードを送る
	GOTO	MAIN
IT98BR
	BCF	SYSFLG,B3	; 今回Breakされたのでフラグをクリアする
	BCF	SYSFLG,B4	; リピートフラグをクリアする
	CALL	KBF_BRK2	; ***リピート終了処理へ***
	MOVLW	0FFh		; 未使用キーコード
	MOVWF	BKEY		; 前回キークリア
IT98BRK
	BSF	PC98_DATA,B7	; PC98側へBreakコードを送る
	CALL	SEND98
	GOTO	MAIN
IT98BR2
	BCF	SYSFLG,B3	; 今回Breakされたのでフラグをクリア
	BCF	SYSFLG,B4	; リピートフラグをクリア
	CALL	KBF_BRK2	; ***リピート終了処理へ***
	BCF	PC98_DATA,B7
	MOVF	PC98_DATA,0
	MOVWF	BKEY
	GOTO	IT98BRK
	;
	; 通常のリピート処理
	;
NRM_RPT
	BSF	PC98_DATA,B7	; Breakコードを準備
	CALL	SEND98		; BReakコードを送信
	CALL	WAIT100US
	CALL	WAIT100US
	CALL	WAIT100US
	CALL	WAIT100US
	MOVF	BKEY,0
	ANDLW	01111111B	; Makeコードを準備
	CALL	SEND98W		; Breakコードを送信
	CALL	WAIT10MS
	RETURN
;
; WAIT FOR 30ms
;
WAIT30MS
	MOVLW	30		; リピートMake-Break間隔=30ms
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
; 起動時キー列送信用バッファリング処理ルーチン
; 　機能：押されたままになっているキーメイクコードをバッファへ書き込む
;
KEY_RPT
	MOVLW	KBF_LEN
	MOVWF	LOOP		; キーバッファサイズをループワークにセット
	MOVLW	KBF_BGN
	MOVWF	FSR		; キーバッファ開始アドレスをFSRにセット
KEY_SEA				; キーバッファ内に同じコードがあれば処理中断
	MOVF	PC98_DATA,0
	XORWF	INDF,0
	BTFSC	STATUS,B2
	RETURN
	INCF	FSR,1
	DECFSZ	LOOP,1
	GOTO	KEY_SEA

	MOVLW	KBF_LEN
	MOVWF	LOOP		; キーバッファのサイズをループワークにセット
	MOVLW	KBF_BGN
	MOVWF	FSR		; キーバッファ開始アドレスをFSRにセット
KBF_SCAN1			; キーバッファを調べて空があるならリピート
				; Makeコードを書き込む
	MOVF	INDF,0		; 間接アドレッシングでキーバッファ参照
	XORLW	0FFh		; 参照したバッファの内容がFFh?
	BTFSC	STATUS,B2	; キーバッファ空?
	GOTO	KBF_WRI		; キーバッファの空きを発見したら書き込みへ
	INCF	FSR,1		; キーバッファポインタ+1
	DECFSZ	LOOP,1
	GOTO	KBF_SCAN1
	RETURN			; キーバッファフルなので無視
KBF_WRI				; キーバッファ空きにキーコードを書き込む
	MOVF	PC98_DATA,0	; 入力されたMakeコードを呼び出す
	MOVWF	INDF		; そのキーコードをバッファ空きに書き込む
	RETURN
;
; 起動時キー列再送信処理(GRAPH+(1)(2),HELP等のため)
;　機能:バッファ内に溜まったキーコードの送信処理を行う
;
KBF_RPT
	MOVLW	KBF_LEN
	MOVWF	LOOP2
	MOVLW	KBF_BGN
	MOVWF	FSR
KBF_RPTL
	MOVF	INDF,0		; キーバッファを参照
	XORLW	0FFh
	BTFSC	STATUS,B2	; キーバッファ未使用?
	GOTO	KBF_NULL	; 次のバッファの処理へ
	CALL	WAIT30MS	; 30ms待つ
	MOVF	INDF,0
	ANDLW	01111111B	; Makeコードを準備
	CALL	SEND98W		; Makeコードを送信
KBF_NULL
	INCF	FSR,1		; 参照用バッファポインタを更新
	DECFSZ	LOOP2,1
	GOTO	KBF_RPTL
	MOVLW	KBF_LEN
	MOVWF	LOOP2
	MOVLW	KBF_BGN
	MOVWF	FSR
	CALL	KBF_BRK2
	BCF	SYSFLG,B4
	RETURN			; すべてのバッファ処理終了
;
; 起動時キー列再送信処理(GRAPH+(1)(2),HELP等のため)
;  機能:キーバッファ内をすべて消去する
;
KBF_BRK2
	MOVLW	KBF_LEN		; バッファサイズをループワークに設定
	MOVWF	LOOP
	MOVLW	KBF_BGN		; バッファ開始アドレスをFSRに設定
	MOVWF	FSR
KBF_SCAN3
	MOVLW	0FFh
	MOVWF	INDF		; キーバッファクリア
	INCF	FSR,1		; キーバッファポインタ+1
	DECFSZ	LOOP,1
	GOTO	KBF_SCAN3
	RETURN
;
; PAUSEキーのメイクコード発生処理
;
PAUSE_KEY0
	MOVLW	7		; 8バイト送ってくるので残り7バイトを受信
	MOVWF	ETC
	CALL	PAUSE_DAMMY
	MOVLW	60h		; PauseキーはSTOPキーに割り当てる
	CALL	SEND98W		; PauseキーはBreakコードを発生しないので
				; 例外処理する。
	CALL	WAIT30MS	; Breakするまで30ms待つ
	MOVLW	11100000B	; STOPキーのBreakコードを準備
	CALL	SEND98W		; Breakコードを送信
	GOTO	MAIN
;
;  初期化ルーチン(ポートの状態設定,POR〜BAT完了コード受信,変数初期化)
;
INITALIZE
	CLRF	SYSFLG
	CLRF	SYSFLG2
	CLRF	LEDDATA
	CLRF	LEDDATA98
	CLRF	PORTA		; DATA & CLK = High
	MOVLW	PINIT_DATA
				; PC98側 RXD信号=High
				; 初期化開始 LED点灯
	MOVWF	PORTB
	MOVLW	BAT_RTY_NUM
	MOVWF	ETC
BAT_RTY
	CALL	IBMKEYRX	; BAT応答(AAh)を受信
	MOVF	PS2_DATA,0
	XORLW	BATOK		; 正常終了?
	BTFSC	STATUS,B2
	GOTO	BAT_CHK_OK
	DECFSZ	ETC,1
	GOTO	BAT_RTY
	CALL	ERROR1		; BAT受信エラーを表示!
BAT_CHK_OK
	BCF	STATUS_LED	; 初期化終了 LED消灯
	CLRF	PC98_DATA
	CLRF	PS2_DATA
	MOVLW	0FFh
	MOVWF	BKEY		; 前回キーコードを無効コードに初期化

	MOVLW	KBF_LEN
	MOVWF	LOOP
	MOVLW	KBF_BGN
	MOVWF	FSR
KBF_CLR
	MOVLW	0FFh		; キーバッファ未使用データ
	MOVWF	INDF		; キーバッファを未使用にする
	INCF	FSR,1
	DECFSZ	LOOP,1
	GOTO	KBF_CLR
	RETURN
;
; キーボード基本機能検査のエラーをLED点滅によって表示
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
;  PC-9801キーデータ送信ルーチン(19.2kbps送信)
;
SEND98W
	MOVWF	PC98_DATA	; W=送信データの時のエントリ
SEND98
	;
	; システムクロック=6.144MHz
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
	NOP			; StartBit Low〜3.906us待つ
SENDLOOP
	CALL	WAIT45US	; 45.57us
	RRF	PC98_DATA,1
	BTFSC	STATUS,B0	; 送信ビット判定
	GOTO	BITHIGH
	NOP
	BCF	PORTB,B2	; DataLine=Lowここまで3.906us
	GOTO	BITWAIT
BITHIGH
	BSF	PORTB,B2	; DataLine=High
	INCF	PTCNT,1		; ParityBitCoubter +1
	NOP
BITWAIT
	DECFSZ	LOOP,1
	GOTO 	SENDLOOP	; ここまででさらに3.906usかかる
				; つまり、1LOOP=3.906x2+45.57=53.382us
	CALL	WAIT45US	; 45.57us待つ
	CALL	WAIT5US		; 5.208us待つ
	BTFSC	PTCNT,B0	; パリティビット造る
	GOTO	PARITYOFF
	BSF	PORTB,B2	; ParityBit = High ここまで1.953us
				; 計45.57uS+5.208us+1.953us=52.731us
	GOTO	BITWAIT2
PARITYOFF
	BCF	PORTB,B2	; ParityBit=Low
	NOP
BITWAIT2
	CALL	WAIT45US
	CALL	WAIT5US		; ここまで45.57us+5.208us+1.302us=52.08us
	BSF	PORTB,B2	; StopBit=High
	CALL	WAIT45US
	CALL	WAIT5US
	GOTO	$+1		; ここまで52.08us
	RETURN
CHECKEND
	BTFSC	PORTB,B1	; PC-9801 Rready?
	GOTO	CHECKEND
	RETURN
	ENDIF
	;
	; 98送信:クロック=10MHzの場合
	;
	IF SYS_CLK == 1		; システムクロック=10MHz
	BTFSC	PORTB,B1	; PC98 Ready?
	GOTO	SEND98
	CLRF	PTCNT		; ParityBitCounter = 0
	MOVLW	8
	MOVWF	LOOP
	BCF	PORTB,B2	; StartBit=Low
SENDLOOP
	GOTO	$+1
	GOTO	$+1
	GOTO	$+1		; 計2.4us
	CALL	WAIT45US	; 46us
	RRF	PC98_DATA,1	; 送信データをCarryへシフト
	BTFSC	STATUS,B0	; 送信ビット0/1判定
	GOTO	BITHIGH
	BCF	PORTB,B2	; DataLine=Low
	GOTO	BITWAIT
BITHIGH
	BSF	PORTB,B2	; DataLine=High
	INCF	PTCNT,1		; ParityBitCoubter +1
BITWAIT
	DECFSZ	LOOP,1
	GOTO 	SENDLOOP	; RRF〜ここまでで3.6usかかる
				; 1LOOP=2.4+3.6+46=52us
	CALL	WAIT45US	; 46us待つ
	CALL	WAIT5US		; 5.2us待つ
MAKE_PARITY			; ここまで51.2us
	BTFSC	PTCNT,B0	; パリティビット造る
	GOTO	PARITY_OFF
PARITY_ON
	BSF	PORTB,B2	; ParityBit=High
	GOTO	BITWAIT2
PARITY_OFF
	BCF	PORTB,B2	; ParityBit=Low
	NOP
BITWAIT2
	CALL	WAIT45US
	CALL	WAIT5US		; PARITY_ONから1.6(0.8)+46+5.2=52.8/52us
	BSF	PORTB,B2	; StopBit = High
	CALL	WAIT45US
	CALL	WAIT5US
	GOTO	$+1		; ここまで52us
	RETURN
CHECKEND
	BTFSC	PORTB,B1	; PC-9801 Rready?
	GOTO	CHECKEND
	RETURN
	ENDIF
;
; PC-9801下りコマンド受信ルーチン(19.2kbps受信)

RX98KEY
	;
	; システムクロック=6.144MHz
	;
	IF SYS_CLK == 0
	BTFSC	PORTB,B0	; SB立ち下がりからここへは6〜8us程度かかる
	GOTO	RX98KEY		; スタートビットを待つ
	GOTO	$+1
	NOP
	MOVLW	0FFh		; PC-98 KeyData = FFh
	MOVWF	PC98_DATA
	MOVLW	8
	MOVWF	LOOP2		; ここまでで5.859us
	CALL	WAIT10US	; 11.718us
				; サンプリングのためスタートビット中央まで待つ
	BTFSS	PORTB,B0	; ビットが上がっていたらノイズと判断し戻る
	GOTO	RX98KEY_OK
	BCF	SYSFLG,B2
	RETURN			; abort RX98KEY
RX98KEY_OK			; ここまで5.859+11.718+1.304+7=25.881us
	CALL	WAIT45US	; 45.570us　ここから52us待つ
	CALL	WAIT5US		; 5.208us
	GOTO	$+1		; 45.570us+5.208+1.302us=52.08us待つとビット中央
RX98LOOP			; 読み込みループ
	RRF	PC98_DATA,1
	BTFSS	PORTB,B0
	GOTO	RX98BITL
RX98BITH
	BSF	PC98_DATA,B7	; DataBit=High
	GOTO	RX98END
RX98BITL
	BCF	PC98_DATA,B7	; DataBit=Low
	NOP
RX98END				; RXLOOPからここまで6クロック3.906us
	CALL	WAIT45US
	DECFSZ	LOOP2,1
	GOTO	RX98LOOP	; 1LOOP=3.906us+45.57us+1.953us=51.429us
	CALL	WAIT45US	; Wait for ParityBit
	CALL	WAIT5US
	GOTO	$+1		; 計52.08usS待つ
	CALL	WAIT5US		; 安全のため待つ
	RETURN			; Not Wait for StopBit
	ENDIF
	;
	; 98受信:クロック=10MHzの場合
	;
	IF SYS_CLK == 1		; システムクロック=10MHz
	BTFSC	PORTB,B0	; SB立ち下がりからここへは4〜5usかかる
	GOTO	RX98KEY		; スタートビットを待つ
	NOP
	MOVLW	0FFh		; PC-98 KeyData = FFh
	MOVWF	PC98_DATA
	MOVLW	8
	MOVWF	LOOP2		; ここまでで2.8us
	CALL	WAIT5US		; 11.2+5.2=16.4us
	CALL	WAIT10US
				; サンプリングのためスタートビット中央まで待つ
	BTFSS	PORTB,B0	; ビットが上がっていたらノイズと判断し戻る
	GOTO	RX98KEY_OK
	BCF	SYSFLG,B2
	RETURN			; abort RX98KEY
RX98KEY_OK			; ここまでの時間2.8+16.4+0.8+4.5(中)=24.5us
	CALL	WAIT45US	; 46us　ここから52us待つ
	CALL	WAIT5US		; 5.2us
RX98LOOP			; 1ビット受信ループ
	GOTO	$+1		; 0.8us 46+5.2+0.8=52us待つとビット中央
	RRF	PC98_DATA,1
	BTFSS	PORTB,B0
	GOTO	RX98BITL
RX98BITH
	BSF	PC98_DATA,B7	; DataBit=High
	GOTO	RX98END
RX98BITL
	BCF	PC98_DATA,B7	; DataBit=Low
	NOP
RX98END				; RXLOOPからここまで8サイクル=3.2us
	CALL	WAIT45US
	GOTO	$+1
	DECFSZ	LOOP2,1
	GOTO	RX98LOOP	; 1LOOP=3.2us+46us+2.8us=52us
	CALL	WAIT45US	; Wait for ParityBit
	CALL	WAIT5US
	GOTO	$+1		; 計52us待つ
	CALL	WAIT5US		; 安全のため待つ
	RETURN			; Not Wait for StopBit
	ENDIF
;
; PS/2キーボード送信ルーチン
;
IBMKEYTXW
	MOVWF	PS2_DATA	; W=送信データエントリ
IBMKEYTX
	CLRF	PTCNT		; ParityCounter = 0 
	MOVLW	8
	MOVWF	LOOP
	CALL	CLKBIT_LOW	; CLK=Low(60uS以上)
	CALL	DATABIT_LOW	; DATA=Low
	CALL	WAIT100US
	CALL	CLKBIT_HIGH	; CLK=High
	CALL	WAIT5US
IMTLP2
	CALL	WAITCLK_LOW	; CLK=Lowまで待ってデータビット送信
	CALL	WAIT10US
	RRF	PS2_DATA,1	; 送信データをシフトしてキャリーへ入れる
	BTFSC	STATUS,B0	; データ0/1を判定する
	GOTO	IMTBIT_HI
	CALL	DATABIT_LOW	; DATA=0(Low)
	GOTO	IMTEND
IMTBIT_HI
	CALL	DATABIT_HIGH	; DATA=1(High)
	INCF	PTCNT,1		; ParityCounter +1
IMTEND
	CALL	WAITCLK_HI	; CLK=Highまで待つ
	DECFSZ	LOOP,1
	GOTO	IMTLP2

	CALL	WAITCLK_LOW	; CLK=Lowまで待つ
	CALL	WAIT10US
	BTFSC	PTCNT,B0
	GOTO	IMT_PARITYOFF
	CALL	DATABIT_HIGH	; ParityBit=High
	GOTO	IMTSTOP
IMT_PARITYOFF
	CALL	DATABIT_LOW	; ParityBit=Low
IMTSTOP
	CALL	WAITCLK_HI	; CLK=Highまで待つ
	CALL	WAITCLK_LOW	; CLK=Lowまで待つ
	CALL	WAIT10US

	CALL	DATABIT_HIGH	; StopBit=High
	CALL	WAITCLK_HI	; CLK=Highまで待つ
	CALL	WAITCLK_LOW	; キーボード側が受信したか確認
	CALL	WAITCLK_HI
WAIT_KEYPS			; キーボード側の受信処理が終わるまで待つ
	BTFSS	DATA_IN		; DataLineを調べる
	GOTO	WAIT_KEYPS
	CALL	CLKBIT_LOW	; CLKをLowにしてキーボード送信不可にする
	RETURN
;
; PS/2キーボード受信ルーチン
;
IBMKEYRX
	CALL	CLKDATABIT_HIGH	; CLK & DATA=Highでキーボード送信可とする
	CLRF	PS2_DATA
	MOVLW	8
	MOVWF	LOOP
STARTBIT_LOW
	BTFSC	DATA_IN		; Wait for StartBit
	GOTO	STARTBIT_LOW
	CALL	WAITCLK_LOW	; DataLineの後ClockLine下がるため
	CALL	WAITCLK_HI
IKRL1
	RRF	PS2_DATA,1
	CALL	WAITCLK_LOW	; CLK=Lowになるのを待つ
	CALL	WAIT5US
	BTFSC	DATA_IN		; DataBitを調べる
	GOTO	IKRBIT_HIGH
	BCF	PS2_DATA,B7	; DataBit=0(Low)
	GOTO	IKREND
IKRBIT_HIGH
	BSF	PS2_DATA,B7	; DataBit=1(High)
IKREND
	CALL	WAITCLK_HI	; CLK=Highになるまで待つ
	DECFSZ	LOOP,1
	GOTO	IKRL1
	CALL	WAITCLK_LOW	; ParityBitのCLK=Lowになるのを待つ
	CALL	WAITCLK_HI	; CLK=Highになるので待つ
	CALL	WAITCLK_LOW	; StopBitのCLK=Lowになるのを待つ
	CALL	WAITCLK_HI	; CLK=Highになるので待つ
;	CALL	WAITCLK_LOW
	CALL	CLKBIT_LOW	; CLK=Lowにしてキーボード送信を禁止する
	RETURN
;
; PC98キーボード下りコマンド処理
;
DOWN98COM
	CALL	RX98KEY
	BCF	SYSFLG,B2	; 下りコマンド受信フラグクリア
	BSF	STATUS_LED	; 下りコマンド処理受け付けLED表示

	MOVF	PC98_DATA,0
	XORLW	00h		; キーボードリセットコマンド?
	BTFSC	STATUS,B2
	GOTO	DOWN_RESET

	MOVF	PC98_DATA,0
	XORLW	9Fh		; キーボードタイプ判定コマンド?
	BTFSC	STATUS,B2	; (LEDがソフト制御できるキーボードか?)
	GOTO	DOWN_KEYTYPE

	MOVF	PC98_DATA,0
	XORLW	9Dh		; キーボードLED制御コマンド?
	BTFSC	STATUS,B2
	GOTO	DOWN_LED

	MOVF	PC98_DATA,0
	XORLW	9Ch		; リピート速度コマンド?
	BTFSC	STATUS,B2
	GOTO	RPT_SPEED

	BTFSS	SYSFLG,B4	; 以下リセット時のシステムセットアップ
				; メニュー等を起動させるためにリセット直前
	GOTO	MAIN		; に押しつづけられていたキー列を送信するた
	CALL	KBF_RPT		; めの処理
	GOTO	MAIN
	;
	; 正常終了コードを98へ送る
	;
SENDFA				; コマンド正常終了コードを送る
	MOVLW	0FAh
	CALL	SEND98W
	RETURN
	;
	; キーボードリセットコマンド
	;
DOWN_RESET
	CALL	KBRESET2	; PS/2キーボードのリセットはしない
	GOTO	MAIN
	;
	; キーボードタイプコマンド
	;  ソフト制御できるキーボードであることをシステムへ返答する
	;
DOWN_KEYTYPE
	CALL	SENDFA		; 正常終了コードのみ送信
	CALL	WAIT100US
	MOVLW	0A0h		; A0h,80hの2バイトを送信
	CALL	SEND98W
	CALL	WAIT100US
	MOVLW	80h
	CALL	SEND98W
	GOTO	MAIN
	;
	; オートリピート速度コマンド
	;
RPT_SPEED
	CALL	SENDFA
	CALL	RX98KEY		; Recieve RepeatSpeed
	CALL	SENDFA
	GOTO	MAIN
	;
	; キーボードLED制御コマンド
	;  CAPS,かなLEDを制御する
	;
DOWN_LED
	CALL	SENDFA
	CALL	RX98KEY		; LED制御コードを受信する
	MOVF	PC98_DATA,0
	MOVWF	LEDDATA98	; Save LEDDATA(98)
	XORLW	60h
	BTFSC	STATUS,B2	; Response LED Status to Host?
	GOTO	DOWN_LED2	;  Yes. Send LED Status to 98

	BCF	LEDDATA,B2	; CapsLockLED OFF
	BTFSC	PC98_DATA,B2	; CAPS LED点灯?
	BSF	LEDDATA,B2	;  Yes. CapsLockLED ON

	IF KB_TYPE == 1
	BCF	LEDDATA,B3	; AXキーボードかなLED OFF
	ELSE
	BCF	LEDDATA,B0	; ScrollLockLED OFF
	ENDIF
	BTFSC	PC98_DATA,B3	; かな LED点灯?
	IF KB_TYPE == 1
	BSF	LEDDATA,B3	;  Yes. AXキーボードかなLED ON
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
; コードE0hシフトなしキーコードPC98キーコード変換ルーチン
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
	GOTO	KEYLW		; 左WIN

	MOVF	PS2_DATA,0
	XORLW	27h
	BTFSC	STATUS,B2
	GOTO	KEYRW		; 右WIN

	MOVF	PS2_DATA,0
	XORLW	2Fh
	BTFSC	STATUS,B2
	GOTO	KEYAP		; アプリ
	MOVF	PS2_DATA,0

	MOVF	PS2_DATA,0	; (注)SUBLWは値-Wレジスタ
	SUBLW	68h		; 69h以上だとCARRY=0（演算結果負）
				; (注)PICでは減算時CARRY=0負 CARRY=1正である!
	BTFSC	STATUS,B0
	RETLW	0FFh		; CARRY=1だと68h以下なので失敗
	MOVF	PS2_DATA,0
	SUBLW	7Eh		; 7Fh以上だとCARRY=0（演算結果負）
	BTFSS	STATUS,B0
	RETLW	0FFh		; CARRY=0だと7Fh以上なので失敗
	MOVLW	69h		; キーコード補正用オフセット値
	SUBWF	PS2_DATA,0	; オフセットを取る(注）PS2_DATA=PS2_DATA - W
	GOTO	EXCODE697E	; 300hからの変換ルーチンへ（100h境界対策)
	;
	; 69h以下のE0コード変換
	;
KEYRW
	RETLW	77h		; Windows(L)キー(98)
KEYLW
	RETLW	78h		; Windows(R)キー(98)
KEYAP
	RETLW	79h		; アプリケーションキー(98)

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
	RETLW	72h		; かな(AX) -> かな(98) AX
	ENDIF
	IF KB_TYPE == 2 | KB_TYPE == 3
	RETLW	74h		; CTRL(R) -> CTRL(98) 106/109/HHK
	ENDIF
KEY95
	RETLW	41h		; /(TEN98)
KEY108
	RETLW	1Ch		; ENTER -> RETURN(98)
;
; PS/2キーボード初期化ルーチン
;
KBRESET
	MOVLW	0FFh		; RESETコマンド送信
	CALL	IBMKEYTXW
	CALL	IBMKEYRX	; ACK受信
	CALL	WAIT100US
	CALL	IBMKEYRX	; BAT完了コードの受信を試みる
	MOVF	PS2_DATA,0
	XORLW	BATOK		; BAT完了?
	BTFSS	STATUS,B2
	CALL	ERROR1		; キーボードエラー
KBRESET2			; RESETコマンド(時間がかかる)なしエントリ
	BCF	SYSFLG,B5	; LEDワーク初期化
	BCF	SYSFLG,B6
	CLRF	LEDDATA
	CLRF	LEDDATA98
	MOVLW	0F3h		; タイプマティックレートを設定する
	CALL	IBMKEYTXW
	CALL	IBMKEYRX
	MOVLW	20h		; タイプマティックデータ
	CALL	IBMKEYTXW
	CALL	IBMKEYRX
;
; NumLock LED処理
;
NUM_ON
				; NumLock LEDを点灯
	BSF	SYSFLG,B7
	BSF	LEDDATA,B1
	GOTO	IBMLED
NUM_OFF
	BCF	SYSFLG,B7
	BCF	LEDDATA,B1
	GOTO	IBMLED
;
; CAPS LED処理
;
CAP_ON
	BSF	LEDDATA,B2
	GOTO	IBMLED
CAP_OFF
	BCF	LEDDATA,B2
	GOTO	IBMLED
;
; かなLED処理
;
KANA_ON
	IF KB_TYPE == 1
	BSF	LEDDATA,B3	; AXキーボードかなLED
	ELSE
	BSF	LEDDATA,B0	; ScrollLock LED
	ENDIF
	GOTO	IBMLED
KANA_OFF
	IF KB_TYPE == 1
	BCF	LEDDATA,B3	; AXキーボードかなLED
	ELSE
	BCF	LEDDATA,B0	; ScrollLock LED
	ENDIF
;
; PS/2キーボードのLEDを制御する
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
; CLK=Highまで待つルーチン
;
WAITCLK_HI
	BTFSS	CLK_IN
	GOTO	WAITCLK_HI
	RETURN
;
; CLK=Lowまで待つルーチン
;
WAITCLK_LOW
	BTFSC	CLK_IN
	GOTO	WAITCLK_LOW
	RETURN
;
; PS/2信号レベル操作 with I/O Direction Controle
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
;  100uS WAITルーチン
; (6.144MHz:82.944us+3.255us+5.208x2=96.615us)
; (10.00MHz:51.2usx2+1.6uS=104uS)
;
WAIT100US
	CLRF	TMR0
WL1
	IF SYS_CLK == 0		; システムクロック=6.144MHz
	MOVLW	1
	ENDIF
	IF SYS_CLK == 1		; システムクロック=10MHz
	MOVLW	2
	ENDIF
	SUBWF	TMR0,0
	BTFSS	STATUS,B0
	GOTO	WL1
	IF SYS_CLK == 0		; システムクロック=6.144MHz
	CALL	WAIT10US
	CALL	WAIT10US
	ENDIF
	RETURN
;
; 45uS WAITルーチン
; (6.144MHz:CALL+SUB+RET = 45.570uS)
; (10.00MHz:CALL+SUB+RET = 46.000uS
;
WAIT45US
	IF SYS_CLK == 0		; システムクロック=6.144MHz
	MOVLW	21		; 1
	ENDIF
	IF SYS_CLK == 1
	MOVLW	36		; システムクロック=10MHz
	ENDIF
	MOVWF	WAIT0		; 1
WL2
	DECFSZ	WAIT0,1		; 1
	GOTO	WL2		; 2
	NOP			; 1
	RETURN			; 2
;
; 5us WAITルーチン
; (CLK=6.144MHz:CALL+SUB+RET = 5.208uS)
; (CLK=10.00MHz:CALL+SUB+RET = 5.200uS)
;
WAIT5US
	IF SYS_CLK == 0		; システムクロック=6.144MHz
	GOTO	$+1
	GOTO	$+1
	ENDIF
	IF SYS_CLK == 1		; システムクロック=10MHz
	GOTO	$+1
	GOTO	$+1
	GOTO	$+1
	GOTO	$+1
	NOP
	ENDIF
	RETURN
;
; 10us WAITルーチン
; (CLK=6.144MHz:CALL+SUB+RET = 11.718us)
; (CLK=10.00MHz:CALL+SUB+RET = 11.200us)
;
WAIT10US
	CALL	WAIT5US
	CALL	WAIT5US
	RETURN
;
; 長時間タイマー(約500mS)
;
DELAY
	MOVLW	5
	MOVWF	WAIT1
DELAY1
	IF SYS_CLK == 0		; システムクロック=6.144MHz
	MOVLW	100
	ENDIF
	IF SYS_CLK == 1		; システムクロック=10MHz
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
; 1mSタイマー
;
WAIT1MS
	CLRF	TMR0
WAIT1MS1
	IF SYS_CLK == 0		; システムクロック=6.144MHz
	MOVLW	12
	ENDIF
	IF SYS_CLK == 1		; システムクロック=10MHz
	MOVLW	20
	ENDIF
	SUBWF	TMR0,0
	BTFSS	STATUS,B0
	GOTO	WAIT1MS1
	RETURN
;
; E0コード69h〜7Ehまでの変換ルーチン
;
	ORG 335h
EXCODE697E
	MOVWF	WORK
	MOVLW	3
	MOVWF	PCLATH
	MOVF	WORK,0
	ADDWF	PCL,1

	IF ROLL == 1		; PAGEキーアサイン
	RETLW	37h		; 69 END -> ROLL DOWN(逆)
	ELSE
	RETLW	36h		; 68 END -> ROLL UP(通常)
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

	IF ROLL == 1		; PAGEキーアサイン
	RETLW	36h		; 7A PAGE DOWN -> ROLL UP(逆)
	ELSE
	RETLW	37h		; 7A PAGE DOWN -> ROLL DOWN(通常)
	ENDIF

	RETLW	0FFh		; 7B xx
	RETLW	61h		; 7C PRINT SCREEN

	IF ROLL == 1		; PAGEキーアサイン
	RETLW	37h		; 7D PAGE UP -> ROLL DOWN(逆)
	ELSE
	RETLW	36h		; 7D PAGE UP -> ROLL UP(通常)
	ENDIF
PAUSE_KEY1			; 7E PAUSE + CTRL Makeコード
	MOVLW	5		; 5バイト送ってくるため残り4バイトを受信
	MOVWF	ETC
	CALL	PAUSE_DAMMY
	MOVLW	84h		; 何故かCTRLのBreakコードが出ないので
				; 代わりに98側にBreakコードを出す
	CALL	SEND98W
	RETLW	0FFh
PAUSE_DAMMY
	CALL	IBMKEYRX
	DECFSZ	ETC,1
	GOTO	PAUSE_DAMMY
	RETLW	0FFh
;
; PS/2キーコードからPC98キーコード変換ルーチン
;
CNVITO98
	MOVWF	WORK
	SUBLW	83h		; 84h以上だったらCARRYが0(負)
	BTFSC	STATUS,B0
	GOTO	CNVITO98OK	; キーコード正常なので変換処理へ
	RETLW	0FFh		; キーコード変換エラー
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
	RETLW	0Dh		; 0E '/‾(101/104/AX/HHK) -> ¥
	ELSE
	RETLW	35h		; 0E 半角/全角(106/109)
	ENDIF

	RETLW	0FFh		; 0F xx
	RETLW	0FFh		; 10 xx
	RETLW	73h		; 11 Alt
	RETLW	70h		; 12 Shift(L)
	RETLW	72h		; 13 かな
	RETLW	74h		; 14 Ctrl
	RETLW	10h		; 15 Q
	RETLW	01h		; 16 1
	RETLW	51h		; 17 xx (AX:無変換) -> NFER
	RETLW	0FFh		; 18 xx
	RETLW	0FFh		; 19 xx
	RETLW	29h		; 1A Z
	RETLW	1Eh		; 1B S
	RETLW	1Dh		; 1C A
	RETLW	11h		; 1D W
	RETLW	02h		; 1E 2
	RETLW	034h		; 1F xx (AX:変換) -> スペース
	RETLW	0FFh		; 20 xx
	RETLW	2Bh		; 21 C
	RETLW	2Ah		; 22 X
	RETLW	1Fh		; 23 D
	RETLW	12h		; 24 E
	RETLW	04h		; 25 4
	RETLW	03h		; 26 3
	RETLW	78h		; 27 xx (AX:AXキー) -> Windows(L)キー
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

	IF CAPS_ASSIGN == 0	; CAPS/英数キーのアサイン
	RETLW	71h		; 58 英数/CapsLock -> CAPS
	ELSE
	RETLW	74h		; 58 英数/CapsLock -> CTRL
	ENDIF

	RETLW	70h		; 59 Shift(R)
	RETLW	1Ch		; 5A Return
	RETLW	1Bh		; 5B [
	RETLW	0FFh		; 5C xx
	RETLW	28h		; 5D ]
	RETLW	0FFh		; 5E
	RETLW	0FFh		; 5F xx
	RETLW	0FFh		; 60 xx
	RETLW	033h		; 61 (予約) (AX:_ -> _ )
	RETLW	0FFh		; 62 xx
	RETLW	0FFh		; 63 xx
	RETLW	035h		; 64 変換
	RETLW	0FFh		; 65 xx
	RETLW	0Eh		; 66 BS
	RETLW	051h		; 67 無変換
	RETLW	0FFh		; 68 xx
	RETLW	4Ah		; 69 1(TEN)
	RETLW	0Dh		; 6A ¥
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
; PS/2→NumLockキーシフトPS/2キーコード変換テーブル
;
CNVNUM
	MOVWF	WORK
	MOVLW	3
	MOVWF	PCLATH
	MOVF	WORK,0
	ADDWF	PCL,1

	IF ROLL == 1		; PAGEキーアサイン
	RETLW	37h		; 69 1(TEN)End -> ROLL DOWN(逆)
	ELSE
	RETLW	36h		; 69 1(TEN)End -> ROLL UP(通常)
	ENDIF

	RETLW	0Dh		; 6A ¥
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

	IF ROLL == 1		; PAGEキーアサイン
	RETLW	36h		; 7A 3(TEN)PageDown -> ROLL UP(逆)
	ELSE
	RETLW	37h		; 7A 3(TEN)PageDown -> ROLL DOWN(通常)
	ENDIF

	RETLW	40h		; 7B -(TEN)
	RETLW	45h		; 7C *(TEN)

	IF ROLL == 1		; PAGEキーアサイン
	RETLW	37h		; 7D 9(TEN)PageUp -> ROLL DOWN(逆)
	ELSE
	RETLW	36h		; 7D 9(TEN)PageUp -> ROLL UP(通常)
	ENDIF

	END
