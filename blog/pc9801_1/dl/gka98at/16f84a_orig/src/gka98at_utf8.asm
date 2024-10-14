;
; PC-9801 to PS/2 Keyboard Adaptor 'GKA-98AT' Ver1.28
;  1998 Programmed by m.sawada/magonote honpo
;
;  LAST UPDATE 2003/12/8版
;
; KEY1Mをベースに開発開始(4/9)
; 補助装置側PS/2送信・受信ルーチンを追加中(4/17)
; 基本動作(AT認識,キー変換)が可能になった(7/13)
; CAPS,かなのPC98用処理を外して使用可能にした(10/29)
; PC-98ではCAPS,かなはトグル動作でM/Bコードを送るため、対応(11/26)
; F7キーはなんとビット7が1なのでE0h判定が誤動作するため例外で対応(12/8)
; LED下りコマンド取りこぼし回避のためCAPS,かなブレイクコードを遅延
; 送信するようにカウンタを設けた。(12/17)
; LED状態をTMR0で約1.1s間隔で再設定を行うようにした(1/7)
; Windowsキー,Aplicationキーに対応(1/8)
; SOYO/5EMMで下りLED不具合→PS/2下りコマンドでLED制御をしない(2/1)
; GA686BX下りLED不具合→CAPS,かなブレイク送信ウエイトを110mSに設定(2/1)
; SOYO/5EMM電源ON時停止→98キーボード受信にStartBitタイムアウトを追加(2/1)
; 同上→98キーボード受信エラー時にはMAINへ復帰(2/1)
; LED状態再設定間隔約1.0sに調整(2/1)
; PS/2送信スタートビット〜クロック立ち上がり間隔35us→70usに変更(2/1)
; キーの取りこぼし→LED再設定は下りコマンド,CAPS,かなブレイク後0.5sのみ(2/2)
; キーリピート停止コマンドにてキーボードリピート停止(3/29)
; リピート発生機能追加(ディレイ、タイプマティック別に設定可能)(3/30)
; ThinkPAD220にてキーの取りこぼしが発生したため、タイプマテックを制限(4/7)
; リピート方式を変換しない旧キーボードモード、リピートをPS/2互換にできる
; 新キーボードモードを切り替え可能にし、EEROMに記憶できるようにした(4/7)
; 新・旧キーボードモードをCTRL+SHIFT+GRPAH(ALT)で切り替えるようにした(4/7)
; E0h,F0hなどのプリフィクスとコード送信間隔を4mSとした
;
; *AIR製切替器ショートカット取りこぼし対策でPS2デバイス送信ルーチン改良(5/11)
;  1.クロックHIGH時間を最低でも10us確保するようにした。
;  2.クロック幅を約44usと延長した。
;  3.クロックとスタートビットの間隔を10US開けた。
;  4.パリティ・ストップビットのタイミングを正しく修正した。
; *THINKPAD220のような低速PCで入力文字が化ける対策
;  1.送信時のクロックHIGH時間にラインを監視しLOWを検出して再送信をかける(5/11)
;
; キーボードモードの違いにより電源投入時とモード切り替え操作時にLED表示する
; ようにした。旧モード:ON→OFF 新モード:ON→OFF→ON→OFF (5/21)
; PS/2送受タイミング調整(送信T2時間=20us,CLK-Hi/Low時間=40us)(5/25)
; PS/2再送信コマンド処理でちゃんと直前の送信データを送るように修正(5/26)
; 新キーボードで電源再投入しなくても旧キーボードモードを使用するため、
; 切り替え時にリピート再開コマンド9Ch,51hを送るようにした(5/26)
; AIR製のPC切り替え器のキー操作と競合するのでモード切り替えキーアサインを
; 変更した(半角/全角+CTRL+SHIFT)(5/26)
; テンキー"="キーをフルキー側のコードを使い送信できるようにした(6/21)
; 半角/全角とESCのアサインを入れ替え、STOP=半角/全角,ESC=ESCとした(8/16)
; これに伴い、モード切り替えはESC+CTRL+SHIFT)となった(8/16)
; Windowsキー付きのキーボードを判別してWin95キーを有効にする(9/23)
; Ctrl+Pause,PrintScreenのコードを出力するようにした(10/11)
; Shift/Ctrl/Alt+PrintScreenのコードを実装したがメモリ不足で凍結(10/11)
;
; DIGITAL WAVE製D-BOARDに対応。生成オブジェクト指定により、LED制御OFF,
; ALT+カナ=SHIFT+カナ(Make-Break),ALT+ESC=カナ(Make-Break),KBモード設定OFF
; 以上の設定となる(10/14)
;
; NEC mobioNX MB-12C用の対策(11/30)
; こいつはキーボードコマンド以外のコマンドを送信してキーボードが再送要求(FEh)
; を返してくるかをチェックしている。これがパスしないと外部キーボードを認識
; しない。また、システムからキーボードへのコマンド送信時にクロックLow時間が
; 300us以上続くことがあるため、これに対応するため監視タイムアウト時間を500us
; 以上確保した。これによって活線挿抜時も認識できるようになった。
; 
; ROLL UP/DOWNのアサインをソース上で入れ替えられるようにした。(2000/1/15)
; `,‾(チルダ)が刻印通りに入力できるようにSHIFT時にキーコードを入れ替えら
; れるようにした(ソースで指定)(2/29)
; NOPx2 = GOTO $+1に置き換えてコードサイズ縮小(3/1)
; デバッグ用LED表示を#DEFINEでON/OFFするようにした(3/1)
; D-BOARD対応にて、ALT(DB)+ESC,ESCのアサインが逆だったので修正(3/15)
;
; PS/2不安定電源マシン対策(リセットIC+KB電源コントロール回路用コード)(4/27)
; 動作説明:リセットICによりVCC立上り後にPICがスタートし、その後に
;          PC98キーボードの電源をI/OポートからTrを制御しONにする。
;          これで長時間の不安定電源においてもPICの確実なスタートと
;          PC98キーボードのハングアップを防ぐことができる。
; *テストしたPCではPC-98キーボード電源ON時にはVCCが0.5V程度低下するため
;  リセット検出電圧は4.0V程度が望ましい。4.5Vだと再リセットが発生する。
;   (リセットICに三菱M62022を使用)
;  ただし電源制御ポート(RB5)の状態は保持(Low)されるためCALL DELAYによる
;  待ち時間のみが発生するが、リセット信号がLowの間はPICのポート電圧が変動
;  するため(ハイ・インピーダンス?)電源波形が階段状になり汚くなる。
;  きれいな電源ON波形を実現するにはリセット検出電圧を4.0V程度にして再リセット
;  を回避する必要がある。(4/27)
;
;  キーを押すとLEDを消灯するようにした(5/12)
;  ThinkPad220本体電源スイッチで電源投入すると認識されないことが判明(9/18)
;  Windowsキー有効時に右SHIFTキーが効かない不具合を修正(9/19)
;
;  Windowsキー付きキーボード判定ルーチン待ち時間を505->300msに短縮し、
;  ThinkPad220本体スイッチでの電源投入で認識されない不具合に対応(9/19)
;
;  PrintScreen例外処理がメモリ内に納まったのでデフォルト有効にした(9/19)
;  10MHz時にWin95キー判定に失敗する不具合を修正(10/30)
;  リセットコマンドでLEDをすべて消灯するようにした(2002/11/22)
;  (給電有りPCにて電源OFF時にLEDが点灯したままになる不具合対策)
;  MPLAB標準インクルードファイルに切り替え(2003/4/12)
;  ソースからCONFIG BITを設定するようにした(4/12)
;  D-Board指定時にWindowsKey設定がOFFになるようにした(7/13)
;  キーボードエミュレータモード(98キーボード無視)に対応(7/13)
;  キーボードリセット回路制御処理(KB_POR)削除(12/2)
;  TeamPlusPCB(I/O direction制御)対応(LEDのみBit4/JDM Writer)(12/3)
;  メモリ不足のためタイマルーチンを共通化して省メモリ化(12/3)
;  ウエイトルーチンを共通化して微調整を削除し省メモリ化(12/4)
;  PLUS PCBを考慮してスタート時PortA出力ラッチをLow(0)にした(12/4)
;
	RADIX		DEC
	PROCESSOR	16F84A
	INCLUDE		"P16F84A.INC"
	__CONFIG _CP_OFF & _WDT_OFF & _HS_OSC & _PWRTE_ON
	__IDLOCS	H'0001'
;
; 生成オブジェクト設定
;
#DEFINE	SYS_CLK 	0	; システムクロック 0=6.144MHz 1=10MHz
#DEFINE	PRINTSCREEN	1	; PrintScreen例外 0=無効 1=有効
#DEFINE	D_BOARD		0	; D-Board対応 0=PC-98KB 1=D-Board
#DEFINE LED_CTRL	1	; 98KEYBOARD LED CONTROLE 0=Disable 1=Enable
#DEFINE WIN95KEY_CHK	1	; Windows95KEY CHECK 0=Diasable 1=Enable
#DEFINE ROLL		0	; PAGE ASSIGN 0=PageUp->R.DOWN PageDown->R.UP
				;             1=PageUP->R.UP PageDown->R.Down
#DEFINE KEY_EXCHG	0	; KEY EXCHAGE+SHIFT 0=Not 1=Excange
#DEFINE DEBUG		0	; DEBUG LED 0=無効 1=有効
#DEFINE WIN95KB_DEBUG	0	; 98KB Windowsキー対応デバッグ時に使用したもの
#DEFINE	KB_EMU		0	; KEYBAORD EMULATOR MODE 1=Enable(NO KEYBAORD)
#DEFINE	MODEL		0	; 0=ORIGINAL/COMMON-PCB 1=PLUS PCB
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
; ワークエリアの割り当て
;
WAIT0		EQU	0Ch
WAIT1		EQU	0Dh
WAIT2		EQU	0Eh
PC98_DATA	EQU	0Fh	; PC98 TX/RX DATA
PS2_DATA	EQU	10h	; PS/2 TX/RX DATA
LOOP		EQU	11h	; LOOP COUNTER
TIMEF0		EQU	12h
TIMEF1		EQU	13h
TIMEF2		EQU	14h
WORK		EQU	15h
PTCNT		EQU	16h	; PARITY BIT COUNTER
TOC		EQU	17h	; タイムアウト用カウンタ
PS2_KEYCODE	EQU	18h	; 変換処理用PS/2キーデータ

SYSFLG		EQU	19h	; B0:LED再設定フラグ0=必要なし 1=設定要求
				; B1:ブレイクフラグ 0=MAKE 1=BREAK
				; B2:CAPS M/Bキーコードフラグ 1=PRESS
				; B3:かな M/Bキーコードフラグ 1=PRESS
				; B4:リピート判定用 0=BREAKED 1=MAKED
				; B5:KB MODE 0=OLD 1=NEW KEYBOARD
				; B6: N/A
				; B7:NumLockフラグ 0=Not 1=NUMLOCK

SYSFLG2		EQU	1Ah	; B0:KB-MODE CTRL  1=BREAK
				; B1:KB-MODE SHIFT 1=BREAK
				; B2:KB-MODE GRAPH 1=BREAK
				; B3:CTRL  0=BREAK 1=MAKE
				; B4:SHIFT 0=BREAK 1=MAKE
				; B5:ALT   0=BREAK 1=MAKE
				; B6:ALT(D) 0=BREAK 1=MAKE
				; B7: N/A

LEDDATA		EQU	1Bh	; IBM KEYBOARD LED DATA
LOOP2		EQU	1Ch	; LOOP COUNTER (FOR INTRRUPT)
ETC		EQU	1Dh	; 汎用ワーク
ETC1		EQU	1Eh	; 汎用ワーク
BKEY		EQU	1Fh	; 前回押されたキー（９８コード）
LED_SETCNT	EQU	20h	; LED再設定カウンタ
BRK_SETCNT	EQU	21h	; かな,CAPSブレイクコード送信カウンタ
RX98_TOC	EQU	22h	; PC98受信タイムアウトカウンタ
KEYREP_CNT	EQU	23h	; オートリピートカウンタ
E_ADR		EQU	24h	; EEPROMアクセスアドレス
PS2_DBAK	EQU	25h	; 直前に送信されたPS/2データ
;
; 各種設定値
;
RX98_TMO	EQU	10	; タイムアウト時間(x1mS)
DELAYT		EQU	4  	; DELAY TIME 505mS
TOC_MAX		EQU	100	; PS/2クロック監視タイムアウト時間(x 5us〜)
	;
	; システムクロック=6.144MHz
	;
	IF SYS_CLK == 0
LED_CNT		EQU	24	; LED再設定カウント値500ms(x21.2ms)
BRK_CNT		EQU	5	; CAPS,かなブレイク送信待ち時間100ms(x21.2ms)
REP_DELAY	EQU	24	; リピートディレイ時間500ms(x21.2ms)
REP_TYPEMATIC	EQU	1	; リピートタイプマテック時間30ms(1x21.2ms)
	ENDIF
	;
	; システムクロック=10MHz
	;
	IF SYS_CLK == 1
LED_CNT		EQU	38	; LED再設定カウント値500ms(x13.1ms)
BRK_CNT		EQU	8	; CAPS,かなブレイク送信待ち時間100ms(x13.1ms)
REP_DELAY	EQU	38	; リピートディレイ時間500ms(x13.1ms)
REP_TYPEMATIC	EQU	2	; リピートタイプマテック時間30ms(x13.1ms)
	ENDIF

MODE_KEY1	EQU	00h	; モード切り替えキー1 全角/半角
MODE_KEY2	EQU	74h	; モード切り替えキー1 CTRL
MODE_KEY3	EQU	70h	; モード切り替えキー1 SHIFT
EQU_WAIT	EQU	4	; テンキー"="送信コード間ウエイト(mS)
;
; PS/2システム→キーボードコマンド
;
PS2S_DEFAULT_DISABLE	EQU	0F5h	; 電源投入状態で走査停止し待機/ACK
PS2S_ECHO		EQU	0EEh	; 診断用/EEh
PS2S_ENABLE		EQU	0F4h	; 出力ﾊﾞｯﾌｧとﾀｲﾌﾟﾏﾃｨｯｸ停止し走査/ACK
PS2S_ID_READ		EQU	0F2h	; ID読みだし/ACK,ID-H,ID-L
PS2S_RESEND		EQU	0FEh	; 再送信要求/直前のバイト
PS2S_RESET		EQU	0FFh	; リセットと自己診断/ACK
PS2S_SCANCODE		EQU	0F0h	; 走査コード/F0,ACK,OPT,ACK(CODE)
PS2S_ALL_TYPEMATIC	EQU	0F7h	; 全キーをﾀｲﾌﾟﾏﾃｨｯｸにする/ACK
PS2S_ALL_MAKEBREAK	EQU	0F8h	; 全キーをメイク/ブレイクにする/ACK
PS2S_ALL_MAKE		EQU	0F9h	; 全キーをメイクにする/ACK
PS2S_ALL_TMB		EQU	0FAh	; 全キーをﾀｲﾌﾟﾏﾃｨｯｸ,ﾒｲｸ,ﾌﾞﾚｲｸに/ACK
PS2S_SET_DEFAULT	EQU	0F6h	; 電源投入状態で走査継続/ACK
PS2S_SET_KEYTYPEMATIC	EQU	0FBh	; 個々のキーをﾀｲﾌﾟﾏﾃｨｯｸ/ACK
PS2S_SET_KEYMAKEBREAK	EQU	0FCh	; 個々のキーをメイク/ブレイクに/ACK
PS2S_SET_KEYMAKE	EQU	0FDh	; 個々のキーをメイクに/ACK
PS2S_SR_STATUS_INDI	EQU	0EDh	; キーボードLED設定/ACK,ACK
PS2S_SET_TM_RATE	EQU	0F3h	; ﾀｲﾌﾟﾏﾃｨｯｸﾚｰﾄを設定/ACK,ACK
;
; PS/2キーボード→システムコマンド
;
PS2D_ACK		EQU	0FAh	; ACK応答
PS2D_BAT_OK		EQU	0AAh	; BAT正常終了
PS2D_BAT_BAD		EQU	0FCh	; BAT障害、走査停止
PS2D_BERAK_PRIFIX	EQU	0F0h	; ScanCode2/3のブレイクコード
PS2D_ECHO		EQU	0EEh	; エコーコマンドに対して返す
PS2D_KEYBOARD_ID1H	EQU	83h	; ｷｰﾎﾞｰﾄﾞIDﾃﾝｷｰ付きID(HIGH)
PS2D_KEYBOARD_ID1L	EQU	0ABh	; ｷｰﾎﾞｰﾄﾞIDﾃﾝｷｰ付きID(LOW)
PS2D_KEYBOARD_ID2H	EQU	84h	; ｷｰﾎﾞｰﾄﾞIDﾃﾝｷｰなしID(HIGH)
PS2D_KEYBPARD_ID2L	EQU	0ABh	; ｷｰﾎﾞｰﾄﾞIDﾃﾝｷｰなしID(LOW)
PS2D_OVERRUN1		EQU	00h	; ｷｰﾊﾞｯﾌｧあふれたとき最後に付く
PS2D_OVERRUN2		EQU	0FFh	; ｷｰﾊﾞｯﾌｧあふれたとき最後に付く
PS2D_RESEND		EQU	0FEh	; データの再送信
;
; 基板別設定
;
	;
	; オリジナルPCB/共通PCB(2001)
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
	; 全PCB共通
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
; スタートアップ
;
	ORG	00h
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

				; タイマ0,割込み関係初期化
	BCF	STATUS,RP0	; SELECT PAGE 0
	CLRF	INTCON
	CLRWDT			; ウォッチドッグタイマをクリア
	CLRF	TMR0		; TMR0内容クリア
	BSF	STATUS,RP0	; SELECT PAGE 1
	MOVLW	00000110B
				; RBプルアップ有効
				; INT割り込みエッジ=立ち下がり
				; タイマクロック=1/4OSC(651ns/400ns)
				; プリスケーラ:TMR0
				; プリスケーラ分周比:1/128(82.944us/51.2us)
	MOVWF	OPTION_REG	; OPTIONレジスタ設定
	BCF	STATUS,RP0	; SELECT PAGE 0
	CLRF	TMR0		; TMR0内容クリア
	;
	; 初期化
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

	CLRF	SYSFLG		; SYSTEMフラグクリア
	CLRF	SYSFLG2
	CLRF	PC98_DATA
	CLRF	PS2_DATA
	CLRF	LEDDATA
	CLRF	KEYREP_CNT
	MOVLW	BRK_CNT
	MOVWF	BRK_SETCNT	; CAPS,かなブレイク送信遅延カウンタ

	IF WIN95KEY_CHK == 1 & D_BOARD == 0 & KB_EMU == 0
	CALL	KB_WIN95	; 接続されているキーボードを判別する
	CALL	KB_SET		; EE設定値から新/旧キーボードモード設定
	ENDIF

	MOVLW	0AAh		; システムへBAT OKコードを送信
	CALL	PS2D_TX0
;
;　メインループ
; PC98キーボード→PS/2変換処理
;
MAIN
	CLRF	TMR0
	BCF	INTCON,B2	; TMR0 Overflowフラグクリア
	MOVLW	LED_CNT
	MOVWF	LED_SETCNT	; LED再設定カウンタ1を設定

	CALL	CLKDATABIT_HIGH	; CLK & DATA=Highで本体送信可とする
	BTFSC	SYSFLG,B2
	GOTO	SENDSYS
	BTFSC	SYSFLG,B3
	GOTO	SENDSYS
	BCF	PORTB,B1	; RDY=0,PC98キーボードからの送信を許可
SENDSYS
	BTFSS	DATA_IN		; システムデータ送信?
	GOTO	PS2_DOWNCMD
	BTFSC	SYSFLG,B2
	GOTO	KANA_CAPS_REIGAI
	BTFSC	SYSFLG,B3
	GOTO	KANA_CAPS_REIGAI
	BTFSS	PORTB,B2	; PC98キーボードスタートビット?
	GOTO	PC982PS2
	;
	; PC98キーボードは独自にLED制御するため定期的にLED状態を設定
	;
LED_RESET
	BTFSS	INTCON,B2	; TMR0オーバーフロー?
				; (6.144MHz=21.23ms,10MHz=13.1072ms)
	GOTO	SENDSYS
	BCF	INTCON,B2	; TMR0 Overflowフラグクリア
	BTFSS	SYSFLG,B5	; キーボード判別
	GOTO	LED_RESET2	; 旧キーボードはリピート変換しない
	BTFSS	SYSFLG,B4	; キーメイク?
	GOTO	LED_RESET2
	INCF	KEYREP_CNT,1	; リピート判定カウンタ+1
	MOVF	KEYREP_CNT,0	; W=リピート判定カウント
	XORLW	REP_DELAY	; リピートしている?
	BTFSS	STATUS,B2
	GOTO	LED_RESET2	; リピートしている
AUTO_REPEAT
	BSF	PORTB,B1	; RDY=1
	MOVF	BKEY,0
	MOVWF	PC98_DATA
	BCF	SYSFLG,B1	; ブレイクフラグをクリア
	MOVLW	REP_DELAY - REP_TYPEMATIC
	MOVWF	KEYREP_CNT
	GOTO	MAKE_REPEAT
LED_RESET2
	DECFSZ	LED_SETCNT,1	; LED再設定カウンタ1段目-1
	GOTO	SENDSYS
	MOVLW	LED_CNT
	MOVWF	LED_SETCNT	; LED再設定カウンタ1を設定
	BTFSS	SYSFLG,B0	; LED再設定要求あり?
	GOTO	MAIN
	BCF	SYSFLG,B0	; LED再設定要求をクリア
	MOVLW	00010000B
	XORWF	PORTB,1
	IF LED_CTRL == 0 | D_BOARD == 1 | KB_EMU == 1
	GOTO	MAIN		; LED設定しない
	ELSE
	GOTO	KEYBOARD_LED_SET ; キーボードのLED設定を行う
	ENDIF
	;
	; CAPS,かな用例外処理(MAKE - BREAK)
	;
KANA_CAPS_REIGAI
	BTFSS	INTCON,B2	; TMR0オーバーフロー?(5.308mS)
	GOTO	SENDSYS
	BCF	INTCON,B2
	DECFSZ	BRK_SETCNT,1	; ブレイクコード送信カウンタ
	GOTO	SENDSYS
	MOVLW	BRK_CNT
	MOVWF	BRK_SETCNT
	BSF	SYSFLG,B0	; LED再設定要求フラグを立てる
	BCF	SYSFLG,B2	; CAPS M/Bフラグクリア
	BCF	SYSFLG,B3	; かな M/Bフラグクリア
				; CAPS,かなはトグル動作(M/B)なので、
	GOTO	NRM_BREAK	; GKA-98AT側が110mS後に自動発生するため、
				; 当然押しっぱなしは不可能!
	;
	; PC98→PS/2変換(リピート制御等)開始
	;
PC982PS2
	BCF	STATUS_LED	; LED OFF
	BCF	SYSFLG,B4	; メイクフラグクリア
	BCF	SYSFLG,B1	; ブレイクコードフラグをクリア
	MOVLW	0FFh
	MOVWF	BKEY		; 前回キーコードを無効コードに初期化
	CALL	RX98KEY		; PC98からキーデータを受信する
	BTFSC	STATUS,B0	; PC98受信エラー?
	GOTO	MAIN
	BTFSS	PC98_DATA,B7	; ブレイクコード?
	GOTO	MAKE_CODE
	BSF	SYSFLG,B1	; ブレイクコードフラグを立てる
	CLRF	KEYREP_CNT	; リピート判定カウンタクリア
	GOTO	MAKE_REPEAT
	;
	; 通常make処理(リピート判定開始)
	;
MAKE_CODE
	BSF	SYSFLG,B4	; メイクフラグセット(入力待ちと区別するため)
	CLRF	KEYREP_CNT	; リピート判定カウンタクリア
	;
	; リピート中処理
	;
MAKE_REPEAT
	BCF	PC98_DATA,B7	; BIT7=0
	;
	; F7キー例外処理
	;
	MOVF	PC98_DATA,0
	XORLW	68h		; F7?(PS/2:83h)
	BTFSS	STATUS,B2
	GOTO	CHK_PAUSECODE
	MOVLW	83h		; F7だけ(!)7ビット目が1なので例外処理
	MOVWF	PS2_KEYCODE
	BTFSC	SYSFLG,B1	; make/break処理選択
	GOTO	NRM_BREAK
	GOTO	NRM_MAKE
	;
	; Pauseキーの例外処理
	;
CHK_PAUSECODE
	MOVF	PC98_DATA,0
	XORLW	55h
	BTFSC	STATUS,B2
	GOTO	F14_KEY		; F14(VF4) -> Pause
	;
	; COPYキー(PrintScreen)の例外処理
	;
CHK_COPYCODE
	MOVF	PC98_DATA,0
	XORLW	61h
	BTFSC	STATUS,B2
	GOTO	COPY_KEY	; COPY -> PrintScreen
	;
	; PS/2キーボードのシフト状態による例外処理用フラグ設定
	; CTRLキーチェック
	;
CHK_CTRL
	MOVF	PC98_DATA,0
	XORLW	74h
	BTFSC	STATUS,B2
	CALL	CTRL_KEY
	;
	; SHIFTキーチェック
	;
	MOVF	PC98_DATA,0
	XORLW	70h
	BTFSC	STATUS,B2
	CALL	SHIFT_KEY
	;
	; GRAPH(ALT)キーチェック
	;
	MOVF	PC98_DATA,0
	XORLW	73h
	BTFSC	STATUS,B2
	CALL	GRAPH_KEY
	;
	; ALT(D-BOARD)キーチェック
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
	GOTO	MAIN		; ブレイクコードは無視する
	MOVLW	72h		; 入力をカナに置き換える
	MOVWF	PC98_DATA
	BSF	SYSFLG,B3	; かなキーが押された
	BCF	SYSFLG,B4	; このキーはリピートさせない
	GOTO	KCC98TOPS2
	ENDIF
	;
	; CAPSキーの例外処理
	;
CHK_CAPSCODE
	MOVF	PC98_DATA,0	; PC-9801 CAPSキー用フラグ設定
	XORLW	71h		; CAPSが押された?
	BTFSS	STATUS,B2
	GOTO	CHK_KANACODE
	BSF	SYSFLG,B2	; CAPSキーが押された
	BCF	SYSFLG,B4	; このキーはリピートさせない
	GOTO	KCC98TOPS2
	;
	; かなキーの例外処理
	;
CHK_KANACODE
	MOVF	PC98_DATA,0	; PC-9801 かなキー用フラグ設定
	XORLW	72h		; かなが押された?
	BTFSS	STATUS,B2
	GOTO	CHK_TENEQU
	BSF	SYSFLG,B3	; かなキーが押された
	BCF	SYSFLG,B4	; このキーはリピートさせない
	IF D_BOARD == 1
	BTFSS	SYSFLG2,B6	; D-BOARD ALT MAKE?
	GOTO	KCC98TOPS2
	GOTO	SHIFT_KANA_KEY
	ELSE
	GOTO	KCC98TOPS2
	ENDIF
	;
	; テンキー部"="キー例外処理
	;
CHK_TENEQU
	MOVF	PC98_DATA,0
	XORLW	4Dh		; テンキー部の"="?
	BTFSC	STATUS,B2
	GOTO	EQU_KEY		; "="キーのMAKE,BREAK処理
	;
	; PC98→PS/2キーコード変換
	;
KCC98TOPS2
	MOVF	PC98_DATA,0
	CALL	CNV982AT	; ATキーコードに変換 BIT7=E0hコードフラグ
	MOVWF	PS2_KEYCODE	; 変換されたデータを保存
	XORLW	0FFh
	BTFSC	STATUS,B2	; 変換失敗?(0FFh=失敗)
	GOTO	MAIN
	;
	; チルダが刻印通り入力できるようSHIFT時にキーコードを入替える
	;
	IF KEY_EXCHG == 1
	BTFSS	SYSFLG2,B4	; SHIFTメイク?
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
	; キーmake/break判定
	;
MAKEBREAK
	BTFSC	SYSFLG,B2	; CAPSキーが押された(CAPSはトグル動作)
	GOTO	MAKE		; M/Bに関らずMAKE処理へ
	BTFSC	SYSFLG,B3	; かなキーが押された(かなはトグル動作)
	GOTO	MAKE		; M/Bに関らずMAKE処理へ
	BTFSC	SYSFLG,B1	; MAKE/BREAK処理選択
	GOTO	BREAK
	;
	; キーmake処理(E0h判定あり)	
	;
MAKE
	BTFSS	PS2_KEYCODE,B7	; E0hコード?
	GOTO	NRM_MAKE
	MOVLW	0E0h		; 拡張コード送信
	CALL	PS2D_TX0
	MOVLW	4
	CALL	WAITNMS
	BCF	PS2_KEYCODE,B7	; E0判定ビットをクリアする
NRM_MAKE
	MOVF	PC98_DATA,0
	MOVWF	BKEY
	MOVF	PS2_KEYCODE,0
	CALL	PS2D_TX0	; PS/2キーコード送信
	GOTO	MAIN
	;
	; キーbreak処理(E0h判定有り)
	;
BREAK
	MOVF	PC98_DATA,0	; W=PC98キーコード
	XORLW	MODE_KEY1	; モードキー1?
	BTFSS	STATUS,B2
	GOTO	BRK_CODE1
	BSF	SYSFLG2,B0	; SET FLAG
	GOTO	BRK_E0_CHK
BRK_CODE1
	MOVF	PC98_DATA,0
	XORLW	MODE_KEY2	; モードキー2?
	BTFSS	STATUS,B2
	GOTO	BRK_CODE2
	BSF	SYSFLG2,B1	; SET FLAG
	GOTO	BRK_E0_CHK
BRK_CODE2
	MOVF	PC98_DATA,0
	XORLW	MODE_KEY3	; モードキー3?
	BTFSS	STATUS,B2
	GOTO	BRK_CODE_CLR
	BSF	SYSFLG2,B2	; SET FLAG
	GOTO	BRK_E0_CHK
BRK_CODE_CLR
	MOVLW	11111000B
	ANDWF	SYSFLG2,1
BRK_E0_CHK
	BTFSS	PS2_KEYCODE,B7	; E0hコード?
	GOTO	NRM_BREAK
	MOVLW	0E0h		; 拡張コード送信
	CALL	PS2D_TX_WAIT
	BCF	PS2_KEYCODE,B7	; E0判定ビットをクリアする
NRM_BREAK
	MOVLW	0F0h		; ブレイクコードPrifix送信
	CALL	PS2D_TX0
	MOVLW	4
	CALL	WAITNMS
	MOVF	PS2_KEYCODE,0
	CALL	PS2D_TX0
	;
	; キーボードモード切り替え判定
	;
	IF D_BOARD == 1
	GOTO	MAIN
	ELSE
	MOVF	SYSFLG2,0	; モードキーがすべて押された?
	ANDLW	00000111B
	XORLW	00000111B
	BTFSS	STATUS,B2
	GOTO	MAIN
	MOVLW	11111000B
	ANDWF	SYSFLG2,1
	;
	; 新・旧キーボードモードを切り替える
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
	;　カナキー処理(遅延ブレイクフラグセット,D-BOARD等)
	;
SHIFT_KANA_KEY			; SHIFT+かなコード送信
	IF D_BOARD == 1
	BCF	SYSFLG,B3	; かなキーの遅延ブレイクは止める(!)
	MOVLW	12h		; SHIFTキーを押す
	CALL	PS2D_TX_WAIT2
	MOVLW	13h		; カナキーを押す
	CALL	PS2D_TX_WAIT2
	MOVLW	0F0h		; ブレイクコードPrifix
	CALL	PS2D_TX_WAIT2
	MOVLW	13h		; カナキーを離す
	CALL	PS2D_TX_WAIT2
	MOVLW	0F0h		; ブレイクコードPrifix
	CALL	PS2D_TX_WAIT2
	MOVLW	12h		; SHIFTキーを離す
	CALL	PS2D_TX_WAIT2
	GOTO	MAIN
	ENDIF
	;
	; F14キー(Pause)処理
	;
F14_KEY
	BTFSC	SYSFLG,B1	; ブレイクコード?
	GOTO	MAIN		; PAUSEはブレイクコードがない
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
	; COPYキー(PrintScreen)処理
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
	; テンキー部"="キーの例外処理
	;
EQU_KEY
	BTFSC	SYSFLG,B1	; BREAK?
	GOTO	EQU_BRK
	MOVLW	12h		; SHIFTキーを押す
	CALL	PS2D_TX_WAIT2
	MOVLW	4Eh		; フルキーの-/=を押す
	CALL	PS2D_TX_WAIT2
	MOVLW	0F0h		; ブレイクコードPrifix
	CALL	PS2D_TX_WAIT2
	MOVLW	12h		; SHIFTキー離す
	CALL	PS2D_TX_WAIT2
	MOVLW	4Dh		; リピート処理のため
	MOVWF	BKEY
	GOTO	MAIN
EQU_BRK
	MOVLW	0F0h
	CALL	PS2D_TX_WAIT2
	MOVLW	4Eh
	CALL	PS2D_TX_WAIT2
	GOTO	MAIN
	;
	; CTRLキーチェック
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
	; SHIFTキーチェック
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
	; GRAPH(ALT)キーチェック
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
	; ALT(D-BOARD)キーチェック
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
; PS/2下りコマンド処理
; (PS/2デバイスエミュレーション処理)
;
PS2_DOWNCMD
	BSF	PORTB,B1		; RDY=1,PC98キーボードからの送信を禁止
	BSF	STATUS_LED		; 下りコマンド受信LED点灯
	CALL	PS2D_RX			; システムからのデータを受信
	BTFSC	STATUS,B0		; 受信成功?
	GOTO	SENDSYS			; PS/2データ受信タイムアウト
	MOVF	PS2_DATA,0		; 受信データ
	CALL	WAIT100US

	MOVF	PS2_DATA,0
	XORLW	PS2S_DEFAULT_DISABLE	; デフォルト待機
	BTFSC	STATUS,B2
	GOTO	PS2_ACKOK		; ACK応答のみ

	MOVF	PS2_DATA,0
	XORLW	PS2S_ECHO		; エコー?
	BTFSC	STATUS,B2
	GOTO	PS2_SYS_ECHO

	MOVF	PS2_DATA,0
	XORLW	PS2S_ENABLE		; ﾊﾞｯﾌｧ,ﾀｲﾌﾟﾏﾃｨｯｸ停止し走査
	BTFSC	STATUS,B2
	GOTO	PS2_ACKOK		; ACK応答のみ

	MOVF	PS2_DATA,0
	XORLW	PS2S_ID_READ		; キーボードID
	BTFSC	STATUS,B2
	GOTO	PS2_SYS_KEYID

	MOVF	PS2_DATA,0
	XORLW	PS2S_RESEND		; 再送
	BTFSC	STATUS,B2
	GOTO	PS2_SYS_RESEND

	MOVF	PS2_DATA,0
	XORLW	PS2S_RESET		; リセット
	BTFSC	STATUS,B2
	GOTO	PS2_SYS_RESET

	MOVF	PS2_DATA,0
	XORLW	PS2S_SCANCODE		; 走査コード指定
	BTFSC	STATUS,B2
	GOTO	PS2_SYS_SCANCODE

	MOVF	PS2_DATA,0
	XORLW	PS2S_ALL_TYPEMATIC	; 全キータイプマティック
	BTFSC	STATUS,B2
	GOTO	PS2_ACKOK		; ACK応答のみ

	MOVF	PS2_DATA,0
	XORLW	PS2S_ALL_MAKEBREAK	; 全キーメイクブレイク
	BTFSC	STATUS,B2
	GOTO	PS2_ACKOK		; ACK応答のみ

	MOVF	PS2_DATA,0
	XORLW	PS2S_ALL_MAKE		; 全キーメイク
	BTFSC	STATUS,B2
	GOTO	PS2_ACKOK		; ACK応答のみ

	MOVF	PS2_DATA,0
	XORLW	PS2S_ALL_TMB		; 全キーT/M/B
	BTFSC	STATUS,B2
	GOTO	PS2_ACKOK		; ACK応答のみ

	MOVF	PS2_DATA,0
	XORLW	PS2S_SET_DEFAULT	; 電源投入状態で走査
	BTFSC	STATUS,B2
	GOTO	PS2_ACKOK		; ACK応答のみ

	MOVF	PS2_DATA,0
	XORLW	PS2S_SR_STATUS_INDI	; キーボードLED設定
	BTFSC	STATUS,B2
	GOTO	PS2_SYS_LED

	MOVF	PS2_DATA,0
	XORLW	PS2S_SET_TM_RATE	; タイプマティックレートを設定
	BTFSC	STATUS,B2
	GOTO	PS2_SYS_TYPEMATIC

	MOVLW	0FEh
	CALL	PS2D_TX0
	GOTO	MAIN
;
; PS/2コマンドACK送信
;
PS2_ACK
	MOVLW	PS2D_ACK	; ACKコード
	CALL	PS2D_TX_WAIT
	RETURN
PS2_ACKOK
	CALL	PS2_ACK
	GOTO	MAIN
PS2_SYS_RESET			; 応答:ACK+500mS+BAT終了コード
	CALL	PS2_ACK
	CALL	DELAY		; 500mS待機
	MOVLW	PS2D_BAT_OK	; BAT終了コード
	CALL	PS2D_TX_WAIT
	CLRF	LEDDATA		; LED ALL OFF
	GOTO	KEYBOARD_LED_SET
PS2_SYS_ECHO			; 応答:EEh
	MOVLW	PS2D_ECHO
	CALL	PS2D_TX0
	GOTO	MAIN
PS2_SYS_KEYID			; 応答:ACK+ID(L)+ID(H)
	CALL	PS2_ACK
	MOVLW	PS2D_KEYBOARD_ID1L
	CALL	PS2D_TX_WAIT
	MOVLW	PS2D_KEYBOARD_ID1H
	CALL	PS2D_TX_WAIT
	GOTO	MAIN
PS2_SYS_RESEND			; 応答:直前のデータ
	MOVF	PS2_DBAK,0	; W=直前のデータ
	CALL	PS2D_TX0
	CALL	PS2_ACK
	GOTO	MAIN
PS2_SYS_LED
	CALL	PS2_ACK		; 応答:ACK+OPT+ACK
GET_LED
	CALL	PS2D_RX
	BTFSC	STATUS,B0	; 受信成功?
	GOTO	GET_LED		; PS/2データ受信タイムアウト
	MOVF	PS2_DATA,0
	MOVWF	LEDDATA		; LEDデータ保存
	CALL	WAIT100US
	CALL	PS2_ACK
	BSF	SYSFLG,B0	; LED再設定要求フラグを立てる
	GOTO	MAIN
KEYBOARD_LED_SET
	IF LED_CTRL == 0 | D_BOARD == 1
	GOTO	MAIN		; D-BOARDならLED操作しない!
	ELSE
	MOVLW	70h		; CLEAR LED WORK
	MOVWF	ETC
	BTFSC	LEDDATA,B1	; NUMLOCK LED ON?
	BSF	ETC,B3		; かなLED -> NUMLOCK LED
	BTFSC	LEDDATA,B2	; CAPS LED ON?
	BSF	ETC,B2		; CAPS LED -> CAPSLOCK LED
	MOVLW	9Dh		; PC98 LEDコマンド
	CALL	SEND98		; PC98キーボードへコマンド送信
	CALL	RX98KEY		; 応答(FAh)受信
	MOVLW	5		; WAIT 5mS
	CALL	WAITNMS
	BCF	PORTB,B1	; RDY=0
	MOVLW	102		; WAIT 102mS
	CALL	WAITNMS
	MOVF	ETC,0
	CALL	SEND98		; PC98キーボードへLEDデータ送信
	CALL	RX98KEY		; 応答(FAh)受信
	GOTO	MAIN
	ENDIF
PS2_SYS_SCANCODE		; 応答:ACK+コード指定+ACK+現在のコード
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
PS2_SYS_TYPEMATIC		; 応答:ACK+OPT+ACK
	CALL	PS2_ACK
	CALL	PS2D_RX
	CALL	PS2_ACK
	GOTO	MAIN
;
; EEROMの設定からキーボードの動作モードを設定
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
KB_DEFAULT_SET			; 規定値以外ならモード1に設定
	MOVLW	0
	MOVWF	E_ADR
	MOVLW	1
	CALL	EE_WRITE
;
; 旧キーボード用の動作モードを設定
;  LED ON -> OFF
;
KB_MODE1
	BCF	SYSFLG,B5	; KEYBOARD = OLD
	BSF	PORTB,B1	; RDY=1,PC98キーボードからの送信を禁止
	BSF	STATUS_LED	; LED ON
	CALL	DELAY
	BCF	STATUS_LED	; LED OFF
	CALL	DELAY
	MOVLW	100		; WAIT 100mS
	CALL	WAITNMS
	MOVLW	9Ch		; リピート開始コマンド1バイト目送信
	CALL	SEND98
	CALL	RX98KEY		; 応答(FAh)受信
	MOVLW	5		; WAIT 5mS
	CALL	WAITNMS
	BCF	PORTB,B1	; RDY=0
	MOVLW	100		; WAIT 100mS
	CALL	WAITNMS
	MOVLW	51h		; リピート開始コマンド2バイト目送信
	CALL	SEND98
	CALL	RX98KEY		; 応答(FAh)受信
	RETURN
;
; 新キーボード用の動作モードを設定
; (PC-98キーボードをリピート禁止にする)
;  LED ON -> OFF -> ON -> OFF 
;
KB_MODE2
	BSF	STATUS_LED	; LED ON
	BSF	SYSFLG,B5	; KEYBOARD = NEW
	BSF	PORTB,B1	; RDY=1,PC98キーボードからの送信を禁止
	CALL	DELAY
	BCF	STATUS_LED	; LED OFF
	CALL	DELAY
	BSF	STATUS_LED	; LED ON
	MOVLW	100		; WAIT 100mS
	CALL	WAITNMS
	MOVLW	9Ch		; リピート禁止コマンド1バイト目送信
	CALL	SEND98
	CALL	RX98KEY		; 応答(FAh)受信
	MOVLW	5		; WAIT 5mS
	CALL	WAITNMS
	BCF	PORTB,B1	; RDY=0
	MOVLW	100		; WAIT 100mS
	CALL	WAITNMS
	MOVLW	70h		; リピート禁止コマンド2バイト目送信
	CALL	SEND98
	CALL	RX98KEY		; 応答(FAh)受信
	MOVLW	255
	CALL	WAITNMS
	BCF	STATUS_LED	; LED OFF
	RETURN
;
; 接続されているWIN95キーボードを判別し、95キーボードなら
; Windowsキー,アプリケーションキーを有効にする
;
KB_WIN95
	MOVLW	200		; キーボードコマンド受け付け有効を待つ
	CALL	WAITNMS
	MOVLW	190		; 200ms + 190ms = 計390msの間待つ
	CALL	WAITNMS
	BSF	PORTB,B1	; RDY=1,PC98キーボードからの送信を禁止

	IF WIN95KB_DEBUG == 1	; Windosw95キーボードデバッグ用
	MOVLW	96h		; キーボードタイプ送信
	CALL	SEND98
	CALL	RX98KEY		; 応答(FAh)受信
	BTFSC	STATUS,B0
	RETURN
	CALL	RX98KEY		; 1バイト目受信
	BTFSC	STATUS,B0
	RETURN
	CALL	RX98KEY		; 2バイト目受信
	BTFSC	STATUS,B0
	RETURN
	MOVLW	5		; WAIT 5ms
	CALL	WAITNMS
	BCF	PORTB,B1	; RDY=0

	MOVLW	100		; WAIT 100ms
	CALL	WAITNMS
	ENDIF

	MOVLW	95h		; Winキー有効コマンド1バイト目送信
	CALL	SEND98
	CALL	RX98KEY		; 応答(FAh)受信
	BTFSC	STATUS,B0
	GOTO	KB_WIN95_ABT

	MOVLW	5		; WAIT 5ms
	CALL	WAITNMS
	BCF	PORTB,B1	; RDY=0

	MOVLW	100		; WAIT 100ms
	CALL	WAITNMS
	MOVLW	03h		; Winキー有効コマンド2バイト目送信
	CALL	SEND98
	CALL	RX98KEY		; 応答(FAh)受信
KB_WIN95_ABT
	MOVLW	5		; WAIT 5ms
	CALL	WAITNMS
	BCF	PORTB,B1	; RDY=0
	RETURN
;
; デバッグ用キー入力
;
	IF WIN95KB_DEBUG == 1	; デバッグ用キー入力ルーチン
CHK_W95_TEST
	BCF	PORTB,B1	; RDY=0,PC98キーボードからの送信を許可
CHK_W95_LOOP
	BTFSC	PORTB,B2	; PC98キーボードスタートビット?
	GOTO	CHK_W95_LOOP
	CALL	RX98KEY
	GOTO	CHK_W95_TEST
	ENDIF
;
;  PC-9801キーデータ送信ルーチン(19.2kbps/8bit/Stop1bit/odd)
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
	; 98送信:クロック=6.144MHz
	;
	IF SYS_CLK == 0		; CLK=6.144MHz
	CLRF	PTCNT		; ParityBitCounter = 0
	MOVLW	8
	MOVWF	LOOP
	BCF	PORTB,B0	; StartBit=Low
	GOTO	$+1
	GOTO	$+1
	NOP			; StartBit Low〜3.906us待つ
SENDLOOP
	CALL	WAIT45US	; 45.57us
	RRF	PC98_DATA,1
	BTFSC	STATUS,B0	; 送信ビット判定
	GOTO	BITHIGH
	NOP
	BCF	PORTB,B0	; DataLine=Lowここまで3.906us
	GOTO	BITWAIT
BITHIGH
	BSF	PORTB,B0	; DataLine=High
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
	BSF	PORTB,B0	; ParityBit = High ここまで1.953us
				; 計45.57us+5.208us+1.953us=52.731us
	GOTO	BITWAIT2
PARITYOFF
	BCF	PORTB,B0	; ParityBit = Low
	NOP
BITWAIT2
	CALL	WAIT45US
	CALL	WAIT5US		; ここまで45.57us+5.208us+1.302us=52.08us
	BSF	PORTB,B0	; StopBit = High
	CALL	WAIT45US
	CALL	WAIT5US
	GOTO	$+1		; ここまで52.08us
	BCF	PORTB,B1	; RDY=0
	CALL	WAIT45US
	RETURN
	ENDIF
	;
	; 98送信:クロック=10MHzの場合
	;
	IF SYS_CLK == 1		; クロック=10MHz
	CLRF	PTCNT		; ParityBitCounter = 0
	MOVLW	8
	MOVWF	LOOP
	BCF	PORTB,B0	; StartBit=Low
SENDLOOP
	GOTO	$+1
	GOTO	$+1
	GOTO	$+1
	CALL	WAIT45US	; 46us
	RRF	PC98_DATA,1	; 送信データをCarryへシフト
	BTFSC	STATUS,B0	; 送信ビット0/1判定
	GOTO	BITHIGH
	BCF	PORTB,B0	; DataLine=Low
	GOTO	BITWAIT
BITHIGH
	BSF	PORTB,B0	; DataLine=High
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
	BSF	PORTB,B0	; ParityBit = High
	GOTO	BITWAIT2
PARITY_OFF
	BCF	PORTB,B0	; ParityBit = Low
	NOP
BITWAIT2
	CALL	WAIT45US
	CALL	WAIT5US		; PARITY_ONから1.6(0.8)+46+5.2=52.8/52us
	BSF	PORTB,B0	; StopBit = High
	CALL	WAIT45US
	CALL	WAIT5US
	GOTO	$+1		; ここまで52us
	BCF	PORTB,B1	; RDY=0
	CALL	WAIT45US
	RETURN
	ENDIF
;
; PC-9801下りコマンド受信ルーチン(19.2kbps受信)

RX98KEY
	IF KB_EMU == 1		; KEYBAORD EMULATOR MODE?
	RETURN
	ENDIF
	;
	; 98受信:クロック=6.144MHz
	;
	IF SYS_CLK == 0
	BCF	PORTB,B1	; RDY=0,PC98キーボード送信許可
	MOVLW	RX98_TMO	; クロックLowタイムアウト
	MOVWF	RX98_TOC
	CLRF	TMR0
RX98_SBWAIT
	BTFSS	PORTB,B2	; スタートビットLow?
	GOTO	RX98_START
	MOVLW	12		; 1LOOP=1mS(84.944us x 12)
	SUBWF	TMR0,0
	BTFSS	STATUS,B0
	GOTO	RX98_SBWAIT
	CLRF	TMR0
	DECFSZ	RX98_TOC,1
	GOTO	RX98_SBWAIT
	BSF	STATUS,B0	; エラー(CARRY=1)
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
	MOVWF	LOOP2		; ここまでで5.859us
	CALL	WAIT10US	; 11.718us

	IF DEBUG == 1
	BCF	STATUS_LED	; Debug LED
	ENDIF
				; サンプリングのためスタートビット中央まで待つ
	BTFSS	PORTB,B2	; ビットが上がっていたらノイズと判断し戻る
	GOTO	RX98KEY_OK
	BCF	SYSFLG,B2
	RETURN			; abort RX98KEY
RX98KEY_OK			; ここまで5.859+11.718+1.304+7=25.881us
	CALL	WAIT45US	; 45.570us　ここから52us待つ
	CALL	WAIT5US		; 5.208us
	GOTO	$+1		; 45.570us+5.208+1.302us=52.08us待つと1BIT中央
RX98LOOP			; 読み込みループ
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
RX98END				; RXLOOPからここまで6クロック3.906us
	IF DEBUG == 1
	BCF	STATUS_LED	; Debug LED
	ENDIF

	CALL	WAIT45US
	DECFSZ	LOOP2,1
	GOTO	RX98LOOP	; 1LOOP=3.906us+45.57us+1.953us=51.429us
	CALL	WAIT45US	; Wait for ParityBit
	CALL	WAIT5US
	GOTO	$+1		; 計52.08us待つ
	CALL	WAIT5US		; 安全のため待つ
RX98DHWAIT
	BTFSS	PORTB,B2
	GOTO	RX98DHWAIT
RX98RDY
	CALL	WAIT45US
	BSF	PORTB,B1	; RDY=1キーボードにデータ受信を通知
	CALL	WAIT45US
	MOVF	PC98_DATA,0
	BCF	STATUS,B0	; 受信終了(CARRY=0)
	RETURN			; ストップビットは読まないで戻る
	ENDIF
	;
	; 98受信:クロック=10MHzの場合
	;
	IF SYS_CLK == 1
	BCF	PORTB,B1	; RDY=0,PC98キーボード送信許可
	MOVLW	RX98_TMO	; クロックLowタイムアウト
	MOVWF	RX98_TOC
	CLRF	TMR0
RX98_SBWAIT
	BTFSS	PORTB,B2	; スタートビットLow?
	GOTO	RX98_START
	MOVLW	12		; 1LOOP=1mS(84.944us x 12)
	SUBWF	TMR0,0
	BTFSS	STATUS,B0
	GOTO	RX98_SBWAIT
	CLRF	TMR0
	DECFSZ	RX98_TOC,1
	GOTO	RX98_SBWAIT
	BSF	STATUS,B0	; エラー(CARRY=1)
	RETURN
RX98_START
	IF DEBUG == 1
	BSF	STATUS_LED	; Debug LED
	ENDIF

	NOP
	MOVLW	0FFh		; PC-98 KeyData = FFh
	MOVWF	PC98_DATA
	MOVLW	8
	MOVWF	LOOP2		; ここまでで2.8us
	CALL	WAIT5US		; 11.2+5.2=16.4us
	CALL	WAIT10US
				; サンプリングのためスタートビット中央まで待つ
	BTFSS	PORTB,B2	; ビットが上がっていたらノイズと判断し戻る
	GOTO	RX98KEY_OK
	BCF	SYSFLG,B2
	RETURN			; abort RX98KEY
RX98KEY_OK			; ここまでの時間2.8+16.4+0.8+4.5(中)=24.5us
	IF DEBUG == 1
	BCF	STATUS_LED	; Debug LED
	ENDIF

	CALL	WAIT45US	; 46us　ここから52us待つ
	CALL	WAIT5US		; 5.2us
RX98LOOP			; 1ビット受信ループ
	GOTO	$+1		; 0.8us
				; 46+5.2+0.8=52us待つとBIT中央
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
RX98END				; RXLOOPからここまで8サイクル=3.2us
	IF DEBUG == 1
	BCF	STATUS_LED	; Debug LED
	ENDIF

	CALL	WAIT45US
	GOTO	$+1
	DECFSZ	LOOP2,1
	GOTO	RX98LOOP	; 1LOOP=3.2us+46us+2.8us=52us
	CALL	WAIT45US	; Wait for ParityBit
	CALL	WAIT5US
	GOTO	$+1		; 計52us待つ
	CALL	WAIT5US		; 安全のため待つ
RX98DHWAIT
	BTFSS	PORTB,B2
	GOTO	RX98DHWAIT
RX98RDY
	CALL	WAIT45US
	BSF	PORTB,B1	; RDY=1キーボードにデータ受信を通知
	CALL	WAIT45US
	MOVF	PC98_DATA,0
	BCF	STATUS,B0	; 受信終了(CARRY=0)
	RETURN			; ストップビットは読まないで戻る
	ENDIF
;
; PS/2デバイス側データ受信ルーチン
;  機能：PC本体からのデータをキーボード／マウス側で受信する。
;
PS2D_RX
	CLRF	PS2_DATA	; データクリア
	MOVLW	8
	MOVWF	LOOP
PS2D_RX_STARTBIT
	BTFSC	DATA_IN		; スタートビット待ち
	GOTO	PS2D_RX_STARTBIT
	MOVLW	TOC_MAX		; クロックLowタイムアウト
	MOVWF	TOC
PS2D_RX_CLKLOW
	BTFSC	CLK_IN		; システム側がクロックをLowにしている?
	GOTO	PS2D_RX_START
	CALL	WAIT5US
	DECFSZ	TOC,1
	GOTO	PS2D_RX_CLKLOW
	GOTO	PS2D_ABT
PS2D_RX_START
	CALL	WAIT40US	; クロックHigh時間
PS2D_RX_LOOP
	CALL	CLKBIT_LOW	; クロック=Low
	CALL	WAIT40US	; クロックLow時間
	CALL	CLKBIT_HIGH	; クロック=High
	CALL	WAIT5US
	BTFSS	CLK_IN		; システムがクロックをLowにしている?
	GOTO	PS2D_ABT	; システムがデータ送信を中止
	RRF	PS2_DATA,1
	CALL	WAIT5US		; データはクロックがHighから1usで確定
	BTFSC	DATA_IN		; データビットを調べる
	GOTO	PS2D_RX_HIGH
	BCF	PS2_DATA,B7	; データビット=0
	GOTO	PS2D_RX_NEXT
PS2D_RX_HIGH
	BSF	PS2_DATA,B7	; データビット=1
PS2D_RX_NEXT
	CALL	WAIT20US	; クロックHigh時間を40usに調整
	CALL	WAIT5US
	DECFSZ	LOOP,1
	GOTO	PS2D_RX_LOOP

	CALL	WAIT40US	; 8thクロックHigh時間
	CALL	CLKBIT_LOW	; 9thクロック=Low
	CALL	WAIT40US	; 9thクロックLow時間
	CALL	CLKBIT_HIGH	; 9thクロック=Highパリティビット受信

	CALL	WAIT40US	; 9thクロックHigh時間
	CALL	CLKBIT_LOW	; 10thクロック=Low
	CALL	WAIT40US	; 10thクロックLow時間
	CALL	CLKBIT_HIGH	; 10thクロック=Highストップビット受信

	CALL	WAIT20US	; 10thクロックHigh時間
	CALL	DATABIT_LOW	; データ=Low,システムにデータ受信を通知
	CALL	WAIT20US
	CALL	CLKBIT_LOW	; 11thクロック=Low
	CALL	WAIT20US	; 11thクロックLow時間
	CALL	CLKBIT_HIGH	; 11thクロック=High
	CALL	DATABIT_HIGH	; データ=High,システムにデータ受信を通知

	BCF	STATUS,B0	; 受信成功:Carry=0
	IF DEBUG == 1
	BCF	STATUS_LED
	ENDIF
	RETURN
;
; PS/2送信・受信処理中止:Carry=1
;
PS2D_ABT
	CALL	WAIT5US
	CLRF	PS2_DATA
	BSF	STATUS,B0	; CARRY=1
	RETURN
;
; PS/2キーボード／データ送信ルーチン
;　機能：キーボードからPC本体へデータを送信する。
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
	MOVWF	PS2_DBAK	; 送信データを保存しておく
PS2D_TX
	CALL	WAIT5US
	BTFSS	CLK_IN		; クロックHigh?
	GOTO	PS2D_TX		; Lowならキーボード禁止なので処理中止
	BTFSS	DATA_IN		; データHigh?
	GOTO	PS2D_TX		; Lowならシステム送信なので処理中止
	CALL	WAIT10US
	CLRF	PTCNT		; パリティカウンタリセット
	MOVLW	8
	MOVWF	LOOP
	CALL	DATABIT_LOW	; データLow(スタートビット)
	CALL	WAIT100US
	CALL	CLKBIT_LOW	; データをセットしたのでクロックLow
	CALL	WAIT40US	; T3クロックLow時間30〜50us
PS2D_TX_LOOP
	CALL	CLKBIT_HIGH	; データをセットする前にクロックHigh
	CALL	WAIT20US	; T2時間の一部(30〜50us)
	BTFSC	CLK_IN		; データ送信中止?
	GOTO	PS2D_TX_CONT	; データ送信継続

; システム側によって送信が中断されたデータを再送信
	CALL	DATABIT_HIGH	; データライン=HI
	CALL	WAIT10US	; 再送信まで10us待機する
	MOVF	PS2_DBAK,0	; W=送信データ
	GOTO	PS2D_TX0
PS2D_TX_CONT
	RRF	PS2_DATA,1	; 送信データをシフトしてキャリーへ入れる
	BTFSC	STATUS,B0	; データ0/1を判定する
	GOTO	PS2D_TX_HIGH
	CALL	DATABIT_LOW	; データビット=LOW
	GOTO	PS2D_TX_NEXT
PS2D_TX_HIGH
	CALL	DATABIT_HIGH	; データビット=HI
	INCF	PTCNT,1		; パリティカウンタ+1
PS2D_TX_NEXT
	CALL	WAIT20US	; T4時間がすぎるまでの残り時間を待つ
	CALL	CLKBIT_LOW	; データをセットしたのでクロックLow
	CALL	WAIT40US	; T3クロックLow時間30〜50us
	DECFSZ	LOOP,1
	GOTO	PS2D_TX_LOOP
PS2D_TX_PARITY
	CALL	CLKBIT_HIGH	; パリティセットする前に9thクロックHigh
	CALL	WAIT20US	; T2時間
	BTFSC	PTCNT,B0	; パリティビットを作る
	GOTO	PS2D_TX_PARIOFF
	CALL	DATABIT_HIGH	; パリティビット=HI
	GOTO	PS2D_TX_STOP
PS2D_TX_PARIOFF
	CALL	DATABIT_LOW	; パリティビット=LOW
PS2D_TX_STOP
	CALL	WAIT20US	; T4時間がすぎるまで待つ
	CALL	CLKBIT_LOW	; 10thクロックLow
	CALL	WAIT40US	; T3クロックLow時間
	CALL	CLKBIT_HIGH	; ストップビット前に10thクロックHigh
	CALL	WAIT20US	; T2時間
	CALL	DATABIT_HIGH	; ストップビットをセットする
	CALL	WAIT20US	; T4時間がすぎるまで待つ
	CALL	CLKBIT_LOW	; 11thクロックLow
	CALL	WAIT40US	; T3クロックLow時間
	CALL	CLKBIT_HIGH	; 11thクロックHigh
	BCF	STATUS,B0	; 送信成功:Carry=0
	RETURN
;
; クロック=Highまで待つ
;
WAITCLK_HI
	BTFSS	CLK_IN
	GOTO	WAITCLK_HI
	RETURN
;
; クロック=Lowまで待つ
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
; DATA EEPROM WRITE
;  IN: E_ADR=ADDRESS W=DATA
;
EE_WRITE
	BCF	STATUS,RP0	; PAGE 0
	MOVWF	EEDATA
	MOVF	E_ADR,0
	MOVWF	EEADR
	BSF	STATUS,RP0	; PAGE 1
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
;
; DATA EEPROM READ
; IN: W=EEPROM ADDRESS OUT: W=EEPROM DATA
;
EE_READ
	BCF	STATUS,RP0	; PAGE 0
	MOVWF	EEADR		; SET ADDRESS
	BSF	STATUS,RP0	; PAGE 1
	BSF	EECON1,B0	; READ BEGIN
WAIT_EER
	BTFSC	EECON1,B0	; WAIT FOR READING
	GOTO	WAIT_EER
	BCF	STATUS,RP0	; PAGE 0
	MOVF	EEDATA,0
	RETURN
;
;  100us WAITルーチン
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
; 45us WAITルーチン
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
; 5us WAITルーチン
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
; 10us WAITルーチン
; (CLK=6.144MHz:CALL+SUB+RET = 11.718us)
; (CLK=10.00MHz:CALL+SUB+RET = 11.200us)
;
WAIT10US
	CALL	WAIT5US
	CALL	WAIT5US
	RETURN
;
; 20us WAITルーチン
;
WAIT20US
	CALL	WAIT10US
	CALL	WAIT10US
	RETURN
;
; 35us WAITルーチン
;
WAIT35US
	CALL	WAIT20US
	CALL	WAIT10US
	CALL	WAIT5US
	RETURN
;
; 40us WAITルーチン
;
WAIT40US
	CALL	WAIT20US
	CALL	WAIT20US
	RETURN
;
; 長時間タイマー(約500ms)
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
; 1msタイマー
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
; PC98キーコードからPS/2へのコード変換ルーチン
;
	ORG	377h
CNV982AT
	MOVWF	WORK
	SUBLW	7Eh		; 7Fh以上だったらCARRYが0(負)
	BTFSC	STATUS,B0
	GOTO	CNV982AT_OK	; キーコード正常なので変換処理へ
	RETLW	0FFh		; キーコード変換エラー
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
	RETLW	55h		; 0C ^‾
	RETLW	6Ah		; 0D ¥|
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
	RETLW	64h		; 35 XFER -> 変換

	IF ROLL == 1		; PAGEキーアサイン
	RETLW	11111101B	; 36 ROLL UP -> PAGE UP(逆)
	ELSE
	RETLW	11111010B	; 36 ROLL UP -> PAGE DOWN(通常)
	ENDIF

	IF ROLL == 1
	RETLW	11111010B	; 37 ROLL DOWN -> PAGE DOWN(逆)
	ELSE
	RETLW	11111101B	; 37 ROLL DOWN -> PAGE UP(通常)
	ENDIF

	RETLW	11110000B	; 38 INS
	RETLW	11110001B	; 39 DEL
	RETLW	11110101B	; 3A ↑
	RETLW	11101011B	; 3B ←
	RETLW	11110100B	; 3C →
	RETLW	11110010B	; 3D ↓
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
	RETLW	0FFh		; 4D = (TEN) -> = (例外処理)
	RETLW	70h		; 4E 0 (TEN)
	RETLW	41h		; 4F , (TEN) -> ,
	RETLW	71h		; 50 . (TEN)
	RETLW	67h		; 51 NFER -> 無変換
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
	RETLW	11101100B	; 5E HOME(PC-98XAのみ)
	RETLW	0FFh		; 5F 
	RETLW	0Eh		; 60 STOP -> 半角/全角
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
	RETLW	13h		; 72 かな
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
	RETLW	59h		; 7D SHIFT -> SHIFT(R) (WINキー有効時)
	RETLW	0FFh		; 7E
	RETLW	0FFh		; 7F
	END
