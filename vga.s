; select the device dsPIC33EP256GP502 - otherwise the include file won't be accepted
.equ __33EP512GP502, 1

; include the definitions specific to the selected device
.include "p33EP512GP502.inc"

config __FICD, ICS_PGD3 & JTAGEN_OFF
config __FPOR, ALTI2C1_OFF & ALTI2C2_OFF & WDTWIN_WIN25
config __FWDT, WDTPOST_PS32768 & WDTPRE_PR128 & PLLKEN_ON & WINDIS_OFF & FWDTEN_OFF
config __FOSC, POSCMD_HS & OSCIOFNC_OFF & IOL1WAY_OFF & FCKSM_CSECME
config __FOSCSEL, FNOSC_FRCDIVN & IESO_OFF
config __FGS, GWRP_OFF & GCP_OFF

.global __reset

.global __OscillatorFail
.global __AddressError
.global __GenericHard
.global __StackError
.global __MathError
.global __DMACError
.global __GenericSoft

; IFS0 interrupts
.global __INT0Interrupt
.global __IC1Interrupt
.global __OC1Interrupt
.global __T1Interrupt
.global __DMA0Interrupt
.global __IC2Interrupt
.global __OC2Interrupt
.global __T2Interrupt
.global __T3Interrupt
.global __SPI1EInterrupt
.global __SPI1Interrupt
.global __U1RXInterrupt
.global __U1TXInterrupt
.global __AD1Interrupt
.global __DMA1Interrupt
; IFS1 interrupts
.global __SI2C1Interrupt
.global __MI2C1Interrupt
.global __CMInterrupt
.global __CNInterrupt
.global __INT1Interrupt
.global __DMA2Interrupt
.global __OC3Interrupt
.global __OC4Interrupt
.global __T4Interrupt
.global __T5Interrupt
.global __INT2Interrupt
.global __U2RXInterrupt
.global __U2TXInterrupt
; IFS2 interrupts
.global __SPI2EInterrupt
.global __SPI2Interrupt
.global __DMA3Interrupt
.global __IC3Interrupt
.global __IC4Interrupt
; IFS3 interrupts
.global __SI2C2Interrupt
.global __MI2C2Interrupt
; IFS4 interrupts
.global __U1EInterrupt
.global __U2EInterrupt
.global __CRCInterrupt
.global __CTMUInterrupt
; IFS8 interrupts
.global __ICDInterrupt
.global __JTAGInterrupt
; IFS9 interrupts
.global __PTGSTEPInterrupt
.global __PTGWDTInterrupt
.global __PTG0Interrupt
.global __PTG1Interrupt
.global __PTG2Interrupt
.global __PTG3Interrupt

; --- ram addresses of variables (0x1000 - 0xcfff) ---
.equiv BackgroundColour, 0x1000		; [1 word:	0x1000 - 0x1001] - global background colour
.equiv ForegroundColour, 0x1002		; [1 word:	0x1002 - 0x1003] - global foreground colour (character colour)
.equiv CursorColumn, 0x1004		; [1 word:	0x1004 - 0x1005] - cursor column [0..39]
.equiv CursorRow, 0x1006		; [1 word:	0x1006 - 0x1007] - cursor row [0..29]
.equiv CursorStatus, 0x1008		; [1 byte:	0x1008 - 0x1008] - cursor status - '0x00' (hidden) or '0xff' (visible)
.equiv CursorEnable, 0x1009		; [1 byte:	0x1009 - 0x1009] - cursor enable flag - '0x00' (off) or '0xff' (on)
.equiv CursorDelay, 0x100a		; [1 byte:	0x100a - 0x100a] - delay value for the cursor's blinking
.equiv HorScrollOff, 0x100c		; [1 word:	0x100c - 0x100d] - horizontal scroll offset [0..7] - scroll to the LEFT
.equiv HorScrollEnable, 0x100e		; [1 word:	0x100e - 0x100f] - enable (1) or disable (0) horizontal scrolling (39 or 40 character horizontally)
.equiv VerScrollOff, 0x1010		; [1 word:	0x1010 - 0x1011] - vertictal scroll offset [0..7] - scroll UP
.equiv VerScrollEnable, 0x1012		; [1 word:	0x1012 - 0x1013] - enable (1) or disable (0) vertical scrolling (29 or 30 character vertically)
.equiv ModeSelect, 0x1014		; [1 word:	0x1014 - 0x1015] - (0) text mode, (1) graphics mode
.equiv CharData, 0x1016			; [1 word:	0x1016 - 0x1017] - base address of the character set data
.equiv TileData, 0x1018			; [1 word:	0x1018 - 0x1019] - base address of the tile data
.equiv SpriteTable, 0x1020		; [96 words:    0x1020 - 0x10df] - table for 32 sprites: Xpos, Ypos, pattern number (192 bytes)
.equiv RenderBuffer0, 0x10e0		; [336 bytes:   0x10e0 - 0x122f] - render buffer #0
.equiv RenderBuffer1, 0x1230		; [336 bytes:   0x1230 - 0x137f] - render buffer #1
.equiv FgColourRam, 0x1380		; [1200 bytes:	0x1380 - 0x182f] - buffer for 40x40 foreground colour attributes
.equiv BgColourRam, 0x1830		; [1200 bytes:	0x1830 - 0x1cdf] - buffer for 40x30 background colour attributes
.equiv VideoRam, 0x1ce0			; [1200 bytes:  0x1ce0 - 0x218f] - buffer for 40x30 ASCII codes (one screen)


.equiv DemoBgCol240, 0x2200		; [240 bytes:	0x2200 - 0x22ef] - global background colour for each of the 240 pixel rows
.equiv DemoFgCol240, 0x22f0		; [240 bytes:	0x22f0 - 0x23df] - global foreground colour for each of the 240 pixel rows
.equiv DemoTopPurpleCopper, 0x23e0	; [60 bytes:	0x23e0 - 0x241b] - 15 bytes top purple copper, 30 bytes center blue copper + 15 bytes bottom purple copper
.equiv DemoGoldCopper, 0x241c		; [30 bytes:	0x241c - 0x2439] - 30 bytes golden copper
.equiv DemoSinusData, 0x243a		; [120 bytes:	0x243a - 0x24b1] - 120 bytes vertical offsets for moving the golden copper bars
.equiv DemoSinusIndex1, 0x24b2		; [1 word:	0x24b2 - 0x24b3] - index into sinus table for copper bar #1
.equiv DemoSinusIndex2, 0x24b4		; [1 word:	0x24b4 - 0x24b5] - index into sinus table for copper bar #2
.equiv DemoHorColData0, 0x24b6		; [48 bytes:	0x24b6 - 0x24e5] - horizontal colour scroll data #0
.equiv DemoHorColData1, 0x24e6		; [36 bytes:	0x24e6 - 0x2509] - horizontal colour scroll data #1
.equiv DemoHorColDelay0, 0x250a		; [1 word:	0x250a - 0x250b] - horizontal colour scroll delay #0
.equiv DemoHorColIndex0, 0x250c		; [1 word:	0x250c - 0x250d] - horizontal colour scroll index #0
.equiv DemoHorColDelay1, 0x250e		; [1 word:	0x250e - 0x250f] - horizontal colour scroll delay #1
.equiv DemoHorColIndex1, 0x2510		; [1 word:	0x2510 - 0x2511] - horizontal colour scroll index #1
.equiv ScrollPatternIndex, 0x2512	; [1 word:	0x2512 - 0x2513]
.equiv SrollPatternDelay, 0x2514	; [1 word:	0x2514 - 0x2515]
.equiv DemoScrollPattern, 0x2516	; [64 bytes:	0x2516 - 0x2555] - scoll pattern data
.equiv DemoVScrollTextIndex, 0x2556	; [1 word:	0x2556 - 0x2557] - index into the vertical scroll text string
.equiv DemoVScrollTextShift, 0x2558	; [1 word:	0x2558 - 0x2559] - bit shift value [0..7] for the vertical scroll text
.equiv DemoVScrollTextDelay, 0x255a	; [1 word:	0x255a - 0x255b] - delay for vertical scroll text
.equiv DemoPatternColourIndex, 0x255c	; [1 word:	0x255c - 0x255d] - pattern scroll colour index
.equiv DemoPatternColourDelay, 0x255e	; [1 word:	0x255e - 0x255f] - pattern scroll colour delay
.equiv DemoPatternColourData, 0x2560 	; [64 bytes:	0x2560 - 0x259f] - pattern scroll colour data
.equiv DemoHScrollTextIndex, 0x25a0	; [1 word:	0x25a0 - 0x25a1] - index into the horizontal scroll text string
.equiv DemoHScrollTextShift, 0x25a2	; [1 word:	0x25a2 - 0x25a3] - bit shift value [0..7] for the horizontal scroll text
.equiv DemoHScrollTextDelay, 0x25a4	; [1 word:	0x25a4 - 0x25a5] - delay for horizontal scroll text
.equiv DemoVerColDelay, 0x25a6		; [1 word:	0x25a6 - 0x25a7] - delay for the vertical colour scroll
.equiv DemoVerColBgIndex, 0x25a8	; [1 word:	0x25a8 - 0x25a9] - index into vertical background colour scroll
.equiv DemoVerColFgIndex, 0x25aa	; [1 word:	0x25aa - 0x25ab] - index into vertical foreground colour scroll
.equiv DemoVerColData, 0x25ac		; [32 bytes:	0x25ac - 0x25cb] - rainbow scroll colours
.equiv DemoSpritePointers, 0x25cc	; [20 words:	0x25cc - 0x25f3] - pointers to the 20 demo sprites
.equiv DemoSpriteY, 0x25f4		; [5 words:	0x25f4 - 0x25fd] - Y-coordinates of the demo srites
.equiv DemoSpriteSine, 0x25fe		; [5 words:	0x25fe - 0x2607] - 5 sprite sine indices
.equiv DemoSpriteData, 0x2608		; [1280 bytes:	0x2608 - 0x2b07] - 20 sprites with 64 bytes each (P, H, O, X, Ball)
.equiv DemoSineData, 0x2b08		; [90 bytes:	0x2b08 - 0x2b61] - 90 sinusoidal sprite Y-coordinates
.equiv DemoBallX, 0x2b62		; [1 word:	0x2b62 - 0x2b63] - X-coordinate of the jumping ball
.equiv DemoBallDeltaX, 0x2b64		; [1 word:	0x2b64 - 0x2b65] - increase/decrease value for X-ccordinate
.equiv DemoBallIndex, 0x2b66		; [1 word:	0x2b66 - 0x2b67] - index into the ball's sine table
.equiv DemoBallSine, 0x2b68		; [53 words:	0x2b68 - 0x2bd1] - sinusoidal Y-coordinates of the ball
.equiv DemoScrollSineIndex, 0x2bd2	; [1 word:	0x2bd2 - 0x2bd3] - start index for the vertical scroll text's sinusoidal X-coordinates
.equiv DemoSpriteScrollShift, 0x2bd4	; [1 word:	0x2bd4 - 0x2bd5] - sprite scroll vertical shift [0..7]
.equiv DemoSpriteScrollIndex, 0x2bd6	; [1 word:	0x2bd6 - 0x2bd7] - start read index for the sprite scroll data
.equiv DemoSpriteTextIndex, 0x2bd8	; [1 word:	0x2bd8 - 0x2bd9] - read index for the sprite scroll text
.equiv DemoScrollSineData, 0x2bda	; [239 words:	0x2bda - 0x2db7] - sinusoidal X-coordinates of the vertical scroll text
.equiv DemoBallOutline, 0x2db8		; [16 words:	0x2db8 - 0x2dd7] - rightmost pixel offsets of the ball

.equiv DemoScrollChar, 0xb700		; [4096 bytes:	0xb700 - 0xc6ff] - 64 characters for the sprite scroll text (64 bytes each)

					; [2048 bytes:	0xc700 - 0xceff] - 256 characters (text) with 8 bytes each
					; [128 words:   0xcf00 - 0xcfff] - stack (256 bytes)

; here is the start of the code executed after a reset
.text
__reset:

; --- initialise the stack pointer (W15) and its limit (256 bytes) - 48k sram [0x1000:0xcFFF] - stack pointer grows --
    mov #0xcf00, W15
    mov #0xcffe, W0
    mov W0, SPLIM

; --- initialise the VGA raster line number (W14) ---
    mov #2, W14

; --- configure the directions of i/o pins and the driven value of output pins ---
    mov #0, W0				; set all pins of PORTA to digital mode
    mov W0, ANSELA
    mov #0b0000000000000100, W0		; RA0 = Hsync, RA1 = Vsync
    mov W0, LATA
    mov #0b0000000000000100, W0
    mov W0, TRISA

    mov #0, W0				; set all pins of PORTB to digital mode
    mov W0, ANSELB
    mov #0b0000000011000011, W0
    mov W0, LATB
    mov #0b0000000000000011, W0
    mov W0, TRISB

; --- switch to the external oscillator (including PLL setup) ---
    mov #82, W0				; M = 84 --> PLLDIV<8:0> = 82
    mov W0, PLLFBD
    mov CLKDIV, W1			; get the initial value from CLKDIV
    mov #0b1111111100000000, W0		; set PLLPOST<1:0> (CLKDIV<7:6>) and PLLPRE<4:0> (CLKDIV<4:0>) zero
    and W1, W0, W1
    mov #0b0000000000000011, W0		; N2 = 2 --> PLLPOST = 0, N1 = 5 --> PLLPRE = 3
    ior W1, W0, W1
    mov W1, CLKDIV

    mov #0x3, W0			; primary oscillator (HS) with PLL (NOSC = 0b011)
    mov #OSCCONH, W1			; OSCCONH (high byte) unlock sequence
    mov #0x78, W2
    mov #0x9A, W3
    mov.b W2, [W1]
    mov.b W3, [W1]
    mov.b W0, [W1]			; set new oscillator selection
    mov #OSCCONL, W1			; OSCCONL (low byte) unlock sequence
    mov #0x46, W2
    mov #0x57, W3
    mov.b W2, [W1]
    mov.b W3, [W1]
    bset OSCCON, #0			; request clock Switching by Setting OSWEN bit
wait_switch:
    btsc OSCCONL, #OSWEN		; wait for the clock switch to take effect
    bra wait_switch

; --- (pre-)initialise the pointers to the character and tile data ---
    mov #0xc700, W0
    mov W0, CharData
    mov #0x8f00, W0
    mov W0, TileData

; --- copy the char data from program memory to the RAM ---
    mov #tblpage(_FontData), W0
    mov W0, _TBLPAG
    mov #tbloffset(_FontData), W0
    mov CharData, W1
    repeat #2047
    tblrdl.b [W0++], [W1++]

; --- initialise the video RAM ---
    rcall ResetScreen

; --- set the global foreground and background colour ---
    mov #0x0006, W0
    mov W0, BackgroundColour
    mov #0x002b, W0
    mov W0, ForegroundColour

; --- initialise the cursor ---
    clr CursorColumn
    clr CursorRow
    setm.b CursorStatus
    setm.b CursorEnable
    mov.b #20, W0
    mov.b WREG, CursorDelay

; --- initialise horizontal scrolling ---
    mov #4, W0
    mov W0, HorScrollOff		; the initial scroll offset is '4'
    clr HorScrollEnable			; initially horizontal scrolling is disabled (40 character mode)

; --- initialise vertical scrolling ---
    mov #4, W0
    mov W0, VerScrollOff		; the initial scroll offset is '4'
    clr VerScrollEnable			; initially vertical scrolling is disabled (30 character mode)

; --- select the text mode ---
    clr ModeSelect

; --- initialise the sprite table ---
    mov #SpriteTable, W0
    mov #-8, W1
    mov #0, W2
    mov #0, W3
    do #31, _IST000
    mov W1, [W0++]
    mov W2, [W0++]
_IST000:
    mov W3, [W0++]

; --- assign OC1 (010000) and OC2 (010001) to RP38 and RP39 ---
    mov #0b0001000100010000, W0
    mov WREG, RPOR2

; --- set up OC1 to generate the Hsync signal ---
    mov #0, W0				; as good practice, set OC1CON1 and OC1CON2 zero
    mov W0, OC1CON1
    mov W0, OC1CON2

    mov #1, W0				; initialise the timer registers - start at '1' to be on par with the other OC/Timer
    mov W0, TMR2
    mov W0, OC1TMR

    mov #0b0000000000000000, W0		; select T2CLK
    mov W0, OC1CON1

    mov #0, W0				; OC1R = 0
    mov W0, OC1R
    mov #192, W0			; OC1RS = 192
    mov W0, OC1RS

    mov #0, W0				; make sure Timer 2 is stopped
    mov W0, T2CON
    mov #1599, W0			; period length is 1600 cycles
    mov W0, PR2

    mov #0b0001000000001100, W0		; invert output and select Timer 2 as sync source
    mov W0, OC1CON2
    mov #0b0000000000000101, W0		; T2CLK, continuous pulse mode
    mov W0, OC1CON1

; --- set up OC2 to generate the Vsync signal ---
    mov #0, W0				; as good practice, set OC2CON1 and OC2CON2 zero
    mov W0, OC2CON1
    mov W0, OC2CON2

    mov #0, W0				; initialise the timer registers
    mov W0, TMR3
    mov W0, OC2TMR

    mov #0b0000010000000000, W0		; select T3CLK
    mov W0, OC2CON1

    mov #12250, W0			; OC2R = 490 * 25
    mov W0, OC2R
    mov #12300, W0			; OC2RS = 492 * 25
    mov W0, OC2RS

    mov #0b0000000000100000, W0		; Make sure Timer #3 is stopped
    mov W0, T3CON
    mov #13124, W0			; period length is 13125 cycles
    mov W0, PR3

    mov #0b0001000000001101, W0		; invert output and select Timer 3 as sync source
    mov W0, OC2CON2
    mov #0b0000010000000101, W0		; T3CLK, continuous pulse mode
    mov W0, OC2CON1

; --- start OC2 first (Vsync), the OC1 (Hsync) second ---
    mov #0b1000000000000000, W1		; init value for Timer #2
    mov #0b1000000000100000, W0		; Init value for Timer #3
    mov W0, T3CON			; start timer #3
    mov W1, T2CON			; start timer #2

    mov #0b0000000000000000, W0		; VAR = 0
    mov W0, CORCON
    mov #0b1000000000000000, W0		; NSTDIS = 1
    mov W0, INTCON1
    mov #0b1000000000000000, W0		; GIE = 1
    mov W0, INTCON2
    mov #0b0000000000000000, W0		; nothing special
    mov W0, INTCON3
    mov #0b0000000000000000, W0		; nothing special
    mov W0, INTCON4

    mov IPC0, W0
    mov #0b0000011100000000, W1
    ior W0, W1, W0
    mov W0, IPC0
    
    bclr IFS0, #OC1IF
    bset IEC0, #OC1IE

; --- Here is the pre-demo loop ---
    mov #tblpage(_BootScreenText), W0
    mov W0, _TBLPAG
    mov #tbloffset(_BootScreenText), W0
    mov #(VideoRam + 40), W1
    repeat #165
    tblrdl.b [W0++], [W1++]
    mov #0, W0
    mov #6, W1
    rcall SetCursorPosition

pre_main00:
    mov #600, W0
    rcall WaitNFrames

    clr W12
pre_main01:
    mov #tblpage(_DemoAnnouncement), W0
    mov W0, _TBLPAG
    mov #tbloffset(_DemoAnnouncement), W13
    add W12, W13, W13
    clr W0
    tblrdl.b [W13++], W0
    rcall PrintCharacter
    mov #6, W0
    rcall WaitNFrames
    inc W12, W12
    cp W12, #16
    bra NZ, pre_main01

    mov #120, W0
    rcall WaitNFrames
    rcall ClearScreen
    mov #60, W0
    rcall WaitNFrames

    rcall DemoInit

    rcall WaitOneFrame

; --- Here is the main loop ---
main:
    mov #0, W1				; W1 = pixel row compare value
    mov #DemoBgCol240, W2		; W2 = pointer at pixel row background colour
    mov #DemoFgCol240, W3		; W3 = pointer at pixel row foreground colour

__ma00:
    cp W14, W1
    bra NZ, __ma00			; loop until the current pixel row is equal the compare value
    lsr W14, #1, W4			; W4 = current pixel row
    mov.b [W2 + W4], W0			; set the background colour for the current pixel row
    mov.b WREG, BackgroundColour
    mov.b [W3 + W4], W0			; set the foreground colour for the current pixel row
    mov.b WREG, ForegroundColour

    mov #(SpriteTable + 2), W5
    mov #DemoSpriteY, W6
    mov #(DemoSpritePointers + 20), W7
    do #4, __ma00y			; loop through 5 (big) sprites
    mov [W6++], W0
    add #8, W0				; W0 = Y-coordinate + 8
    cp W4, W0
    bra NZ, __ma00x			; if the current pixel row (W4) is not equal to the Y-coordinate (W0), skip
    mov W0, [W5]			; set the y-coordinate for sprite #0, #2, #4, #6, #8
    mov W0, [W5 + 6]			; set the y-coordinate for sprite #1, #3, #5, #7, #9
    mov [W7], W0			; W0 = data pointer
    mov W0, [W5 + 2]			; set data pointer for sprite #0, #2, #4, #6, #8
    mov [W7 + 2], W0			; W0 = data pointer
    mov W0, [W5 + 8]			; set data pointer for sprite #1, #3, #5, #7, #9
__ma00x:
    add #4, W7
__ma00y:
    add #12, W5

    mov #DemoScrollSineIndex, W4	; [1]
    lsr W14, #1, W6			; [2]
    add W6, [W4], W5			; [3] W5 = pixel row number + sine table index
    mov #239, W4			; [4]
    cpslt W5, W4			; [5] if (W5 >= 239)...
    sub W5, W4, W5			; [6] ...subtract 239
    cpslt W5, W4			; [7] if still (W5 >= 239)...
    sub W5, W4, W5			; [8] ...subtract 239 again
    sl W5, #1, W5			; [9] W5 = index into the sine table
    mov #DemoScrollSineData, W4		; [10]
    add W4, W5, W4			; [11] W4 = address of entry in sine table
    mov #(SpriteTable + 84), W5		; [12] W5 = pointer at descriptor of sprite #15
    mov [W4], W4			; [13]
    cp W6, #14				; [14]
    bra LT, __ma00w			; [15-18]
    mov #41, W0				; [16]
    cpsgt W6, W0			; [17]
    mov #-8, W4				; [18]
__ma00w:
    mov W4, [W5]
    btss W4, #15
    add #8, W4
    mov W4, [W5 + 6]

    mov #DemoSpriteScrollShift, W4	; [1]
    lsr W14, #1, W6			; [2]
    add W6, [W4], W6
    and #0b1111111000, W6		; [3] W6 = pixel row number with least significant three bits set to zero
    sub W6, [W4], W6			; [4] sprite Y-ccordinate = (pixel row & 0x03f8) - scroll shift
    mov W6, [W5 + 2]
    mov W6, [W5 + 8]
    mov #DemoSpriteScrollIndex, W0	; [5]
    lsr W14, #1, W6			; [6]
    add W6, [W4], W6			; [7]
    lsr W6, #3, W6			; [8] W6 = (pixel row + scroll shift) / 8
    add W6, [W0], W6			; [9]
    and #31, W6				; [10]
    sl W6, #7, W6			; [11]
    mov #DemoScrollChar, W0		; [12]
    add W0, W6, W6			; [13]
    mov W6, [W5 + 4]			; [14] sprite pattern
    add #64, W6				; [15]
    mov W6, [W5 + 10]			; [16]

    inc W1, W1
    mov #448, W0
    cp W1, W0
    bra LT, __ma00

__ma01:
    cp W14, W1
    bra NZ, __ma01			; loop until the current pixel row is equal the compare value
    lsr W14, #1, W4			; W4 = current pixel row
    mov.b [W2 + W4], W0			; set the background colour for the current pixel row
    mov.b WREG, BackgroundColour
    mov.b [W3 + W4], W0			; set the foreground colour for the current pixel row
    mov.b WREG, ForegroundColour
    setm HorScrollEnable		; initially horizontal scrolling is disabled (40 character mode)
    mov #DemoHScrollTextShift, W5
    mov [W5], W0
    mov W0, HorScrollOff		; the initial scroll offset is '4'

    mov #DemoScrollSineIndex, W4	; [1]
    lsr W14, #1, W6			; [2]
    add W6, [W4], W5			; [3] W5 = pixel row number + sine table index
    mov #239, W4			; [4]
    cpslt W5, W4			; [5] if (W5 >= 239)...
    sub W5, W4, W5			; [6] ...subtract 239
    cpslt W5, W4			; [7] if still (W5 >= 239)...
    sub W5, W4, W5			; [8] ...subtract 239 again
    sl W5, #1, W5			; [9] W5 = index into the sine table
    mov #DemoScrollSineData, W4		; [10]
    add W4, W5, W4			; [11] W4 = address of entry in sine table
    mov #(SpriteTable + 84), W5		; [12] W5 = pointer at descriptor of sprite #15
    mov [W4], W4			; [13] set sprite X-coordinate
    mov W4, [W5]
    add #8, W4
    mov W4, [W5 + 6]

    mov #DemoSpriteScrollShift, W4	; [1]
    lsr W14, #1, W6			; [2]
    add W6, [W4], W6
    and #0b1111111000, W6		; [3] W6 = pixel row number with least significant three bits set to zero
    sub W6, [W4], W6			; [4] sprite Y-ccordinate = (pixel row & 0x03f8) - scroll shift
    mov W6, [W5 + 2]
    mov W6, [W5 + 8]
    mov #DemoSpriteScrollIndex, W0	; [5]
    lsr W14, #1, W6			; [6]
    add W6, [W4], W6			; [7]
    lsr W6, #3, W6			; [8] W6 = (pixel row + scroll shift) / 8
    add W6, [W0], W6			; [9]
    and #31, W6				; [10]
    sl W6, #7, W6			; [11]
    mov #DemoScrollChar, W0		; [12]
    add W0, W6, W6			; [13]
    mov W6, [W5 + 4]			; [14] sprite pattern
    add #64, W6				; [15]
    mov W6, [W5 + 10]			; [16]

    inc W1, W1
    mov #464, W0
    cp W1, W0
    bra LT, __ma01

__ma02:
    cp W14, W1
    bra NZ, __ma02			; loop until the current pixel row is equal the compare value
    lsr W14, #1, W4			; W4 = current pixel wow
    mov.b [W2 + W4], W0			; set the background colour for the current pixel row
    mov.b WREG, BackgroundColour
    mov.b [W3 + W4], W0			; set the foreground colour for the current pixel row
    mov.b WREG, ForegroundColour
    clr HorScrollEnable			; initially horizontal scrolling is disabled (40 character mode)

    mov #DemoScrollSineIndex, W4	; [1]
    lsr W14, #1, W6			; [2]
    add W6, [W4], W5			; [3] W5 = pixel row number + sine table index
    mov #239, W4			; [4]
    cpslt W5, W4			; [5] if (W5 >= 239)...
    sub W5, W4, W5			; [6] ...subtract 239
    cpslt W5, W4			; [7] if still (W5 >= 239)...
    sub W5, W4, W5			; [8] ...subtract 239 again
    sl W5, #1, W5			; [9] W5 = index into the sine table
    mov #DemoScrollSineData, W4		; [10]
    add W4, W5, W4			; [11] W4 = address of entry in sine table
    mov #(SpriteTable + 84), W5		; [12] W5 = pointer at descriptor of sprite #15
    mov [W4], W4			; [13] set sprite X-coordinate
    mov W4, [W5]
    add #8, W4
    mov W4, [W5 + 6]

    mov #DemoSpriteScrollShift, W4	; [1]
    lsr W14, #1, W6			; [2]
    add W6, [W4], W6
    and #0b1111111000, W6		; [3] W6 = pixel row number with least significant three bits set to zero
    sub W6, [W4], W6			; [4] sprite Y-ccordinate = (pixel row & 0x03f8) - scroll shift
    mov W6, [W5 + 2]
    mov W6, [W5 + 8]
    mov #DemoSpriteScrollIndex, W0	; [5]
    lsr W14, #1, W6			; [6]
    add W6, [W4], W6			; [7]
    lsr W6, #3, W6			; [8] W6 = (pixel row + scroll shift) / 8
    add W6, [W0], W6			; [9]
    and #31, W6				; [10]
    sl W6, #7, W6			; [11]
    mov #DemoScrollChar, W0		; [12]
    add W0, W6, W6			; [13]
    mov W6, [W5 + 4]			; [14] sprite pattern
    add #64, W6				; [15]
    mov W6, [W5 + 10]			; [16]

    inc W1, W1
    mov #480, W0
    cp W1, W0
    bra LT, __ma02

    mov #482, W0
__ma03:
    cp W14, W0
    bra LT, __ma03			; loop until the current pixel row is equal the compare value

    mov #0, W0
    mov W0, HorScrollEnable		; initially horizontal scrolling is disabled (40 character mode)

    rcall DrawHorColScrolls
    rcall DrawScrollPattern
    rcall DrawVerticalScrollText
    rcall DrawPatternColScroll
    rcall DemoDrawCopperBars
    rcall DrawHorizontalScrollText
    rcall DrawDemoVerColScroll
    rcall UpdateDemoSprites
    rcall UpdateSpriteScroll
    rcall MoveJumpingBall
    rcall BallScrollCollision

    bra main

; --- INITIALISE THE DEMO DATA ---
DemoInit:

; don't show the cursor
    mov.b #0x00, W0
    mov.b WREG, CursorEnable

; initialise the pixel row wise global background colour
    mov #DemoBgCol240, W1
    mov #0x0000, W0
    repeat #239
    mov.b W0, [W1++]

; initialise the pixel row wise global foreground colour
    mov #DemoFgCol240, W1
    mov #0x002a, W0
    repeat #239
    mov.b W0, [W1++]

; initialise the horizontal bar
    mov #(VideoRam + 40), W1
    mov #(FgColourRam + 40), W2
    mov #(BgColourRam + 40), W3

    mov.b #0xfd, W0			; ASCII code 0xfd
    repeat #39
    mov.b W0, [W1++]
    mov.b #0x3f, W0			; white foreground colour
    repeat #39
    mov.b W0, [W2++]
    mov.b #0x00, W0			; black background colour
    repeat #39
    mov.b W0, [W3++]

    mov.b #0xff, W0			; ASCII code 0xff
    repeat #119
    mov.b W0, [W1++]
    mov.b #0x00, W0			; black foreground colour
    repeat #119
    mov.b W0, [W2++]
    mov.b #0x2a, W0			; bright grey background colour
    repeat #119
    mov.b W0, [W3++]

    mov.b #0xfe, W0			; ASCII code 0xfe
    repeat #39
    mov.b W0, [W1++]
    mov.b #0x15, W0			; dark grey foreground colour
    repeat #39
    mov.b W0, [W2++]
    mov.b #0x00, W0			; black background colour
    repeat #39
    mov.b W0, [W3++]

; initialise the vertical bar (for the vertical scroll text)
    mov #0x0082, W0
    mov #(VideoRam + 1), W1
    mov #(FgColourRam + 1), W2
    mov #(BgColourRam + 1), W3
    do #29, _DI00

    mov.b #0x80, W4
    mov.b W4, [W1]
    mov.b W0, [W1 + 0x01]
    mov.b #0x81, W4
    mov.b W4, [W1 + 0x02]

    mov.b #0x2a, W4
    mov.b W4, [W2]
    mov.b W4, [W2 + 0x01]
    mov.b W4, [W2 + 0x02]

    mov.b #0x3f, W4
    mov.b W4, [W3]
    mov.b #0x40, W4
    mov.b W4, [W3 + 0x01]
    mov.b #0x15, W4
    mov.b W4, [W3 + 0x02]

    inc W0, W0
    add #40, W1
    add #40, W2
_DI00:
    add #40, W3

; copy the copper bars from program to data memory (15 + 30 + 15 + 30 bytes)
    mov #tblpage(_DemoCopperBars), W0
    mov W0, _TBLPAG
    mov #tbloffset(_DemoCopperBars), W0
    mov #DemoTopPurpleCopper, W1
    repeat #89
    tblrdl.b [W0++], [W1++]

; copy the sinusoidal offsets for moving the copper bars from program to data memory
    mov #tblpage(_DemoCopperSinus), W0
    mov W0, _TBLPAG
    mov #tbloffset(_DemoCopperSinus), W0
    mov #DemoSinusData, W1
    repeat #119
    tblrdl.b [W0++], [W1++]

; initialise the copper bar's indices into the sinus table
    mov #DemoSinusIndex1, W1
    mov #0, W0
    mov W0, [W1]
    mov #DemoSinusIndex2, W1
    mov #60, W0
    mov W0, [W1]

; initialise the horizontal colour scroll
    mov #tblpage(_DemoHorTextCol0), W0
    mov W0, _TBLPAG
    mov #tbloffset(_DemoHorTextCol0), W0
    mov #DemoHorColData0, W1
    repeat #47
    tblrdl.b [W0++], [W1++]
    mov #DemoHorColIndex0, W1
    mov #0, W0
    mov W0, [W1]
    mov #DemoHorColDelay0, W1
    mov #2, W0
    mov W0, [W1]

    mov #tblpage(_DemoHorTextCol1), W0
    mov W0, _TBLPAG
    mov #tbloffset(_DemoHorTextCol1), W0
    mov #DemoHorColData1, W1
    repeat #35
    tblrdl.b [W0++], [W1++]
    mov #DemoHorColIndex1, W1
    mov #0, W0
    mov W0, [W1]
    mov #DemoHorColDelay1, W1
    mov #2, W0
    mov W0, [W1]

; copy the texts to be displayed from program to video memory
    mov #tblpage(_DemoText01), W0
    mov W0, _TBLPAG
    mov #tbloffset(_DemoText01), W0
    mov #(VideoRam + 568), W1
    repeat #23
    tblrdl.b [W0++], [W1++]

    mov #tblpage(_DemoText02), W0
    mov W0, _TBLPAG
    mov #tbloffset(_DemoText02), W0
    mov #(VideoRam + 930), W1
    repeat #19
    tblrdl.b [W0++], [W1++]

    mov #tblpage(_DemoText03), W0
    mov W0, _TBLPAG
    mov #tbloffset(_DemoText03), W0
    mov #(VideoRam + 1011), W1
    repeat #17
    tblrdl.b [W0++], [W1++]

; initialise the scroll pattern data
    mov #tblpage(_DemoScrollPattern), W0
    mov W0, _TBLPAG
    mov #tbloffset(_DemoScrollPattern), W0
    mov #DemoScrollPattern, W1
    repeat #63
    tblrdl.b [W0++], [W1++]

; initialise the scroll pattern colour
    mov #tblpage(_DemoPatternCopper), W0
    mov W0, _TBLPAG
    mov #tbloffset(_DemoPatternCopper), W0
    mov #DemoPatternColourData, W1
    repeat #63
    tblrdl.b [W0++], [W1++]

    mov #DemoPatternColourIndex, W1
    mov #0, W0
    mov W0, [W1]
    mov #DemoPatternColourDelay, W1
    mov #4, W0
    mov W0, [W1]
    
    mov #ScrollPatternIndex, W1
    mov #0x38, W0
    mov W0, [W1]
    mov #SrollPatternDelay, W1
    mov #3, W0
    mov W0, [W1]

; initialise the vertical scroll text
    mov #DemoVScrollTextIndex, W1
    mov #0, W0
    mov W0, [W1]
    mov #DemoVScrollTextShift, W1
    mov #7, W0
    mov W0, [W1]
    mov #DemoVScrollTextDelay, W1
    mov #2, W0
    mov W0, [W1]

; initialise the horizontal scroll text
    mov #DemoHScrollTextIndex, W1
    mov #0, W0
    mov W0, [W1]
    mov #DemoHScrollTextShift, W1
    mov #0, W0
    mov W0, [W1]
    mov #DemoHScrollTextDelay, W1
    mov #60, W0
    mov W0, [W1]

    mov.b #0x20, W0
    mov #(VideoRam + 1120), W1
    repeat #39
    mov.b W0, [W1++]
    mov.b #0x40, W0
    mov #(FgColourRam + 1120), W1
    repeat #39
    mov.b W0, [W1++]
    mov.b #0x40, W0
    mov #(BgColourRam + 1120), W1
    repeat #39
    mov.b W0, [W1++]

    mov #tblpage(_DemoVerColScroll0), W0
    mov W0, _TBLPAG
    mov #tbloffset(_DemoVerColScroll0), W0
    mov #DemoVerColData, W1
    repeat #31
    tblrdl.b [W0++], [W1++]

    mov #DemoVerColDelay, W1
    mov #3, W0
    mov W0, [W1]
    mov #DemoVerColBgIndex, W1
    mov #20, W0
    mov W0, [W1]
    mov #DemoVerColFgIndex, W1
    mov #0, W0
    mov W0, [W1]

; initialise the sprite data
    mov #tblpage(_DemoSprites), W0
    mov W0, _TBLPAG
    mov #tbloffset(_DemoSprites), W0
    mov #DemoSpriteData, W1
    repeat #1279
    tblrdl.b [W0++], [W1++]

; initialise the demo sprites
    mov #tblpage(_DemoSpriteX), W0
    mov W0, _TBLPAG
    mov #tbloffset(_DemoSpriteX), W0
    mov #SpriteTable, W1
    do #9, _DI01
    tblrdl [W0], [W1]
    add #2, W0
_DI01:
    add #6, W1

    mov #tblpage(_DemoSpritePointers), W0
    mov W0, _TBLPAG
    mov #tbloffset(_DemoSpritePointers), W0
    mov #DemoSpritePointers, W1
    repeat #19
    tblrdl [W0++], [W1++]

    mov #tblpage(_DemoSpriteSine), W0
    mov W0, _TBLPAG
    mov #tbloffset(_DemoSpriteSine), W0
    mov #DemoSineData, W1
    repeat #89
    tblrdl.b [W0++], [W1++]

    mov #20, W0
    mov #DemoSpriteY, W1
    repeat #4
    mov W0, [W1++]

    mov #DemoSpriteSine, W1
    mov #0, W0
    mov W0, [W1++]
    mov #10, W0
    mov W0, [W1++]
    mov #20, W0
    mov W0, [W1++]
    mov #30, W0
    mov W0, [W1++]
    mov #40, W0
    mov W0, [W1++]

; initialise the jumping ball (4 sprites)
    mov #tblpage(_DemoBallSine), W0
    mov W0, _TBLPAG
    mov #tbloffset(_DemoBallSine), W0
    mov #DemoBallSine, W1
    repeat #52
    tblrdl [W0++], [W1++]

    mov #(SpriteTable + 60), W0
    mov #(DemoSpriteData + 1024), W1

    mov W1, [W0 + 4]
    add #64, W1
    mov W1, [W0 + 10]
    add #64, W1
    mov W1, [W0 + 16]
    add #64, W1
    mov W1, [W0 + 22]

    mov #32, W1
    mov #200, W2
    mov W1, [W0]
    mov W1, [W0 + 12]
    mov W2, [W0 + 2]
    mov W2, [W0 + 8]
    add #8, W1
    mov W1, [W0 + 6]
    mov W1, [W0 + 18]
    add #8, W2
    mov W2, [W0 + 14]
    mov W2, [W0 + 20]

    mov #32, W0
    mov #DemoBallX, W1
    mov W0, [W1]
    mov #1, W0
    mov #DemoBallDeltaX, W1
    mov W0, [W1]

    mov #DemoBallIndex, W0
    clr [W0]

    mov #DemoBallOutline, W1
    mov #11, W0
    mov W0, [W1]
    mov W0, [W1 + 30]
    mov #13, W0
    mov W0, [W1 + 2]
    mov W0, [W1 + 28]
    mov #14, W0
    mov W0, [W1 + 4]
    mov W0, [W1 + 26]
    mov #15, W0
    mov W0, [W1 + 6]
    mov W0, [W1 + 8]
    mov W0, [W1 + 22]
    mov W0, [W1 + 24]
    mov #16, W0
    mov W0, [W1 + 10]
    mov W0, [W1 + 12]
    mov W0, [W1 + 14]
    mov W0, [W1 + 16]
    mov W0, [W1 + 18]
    mov W0, [W1 + 20]

; initialise vertical sprite-based scroll text
    mov #tblpage(_DemoScrollSineData), W0
    mov W0, _TBLPAG
    mov #tbloffset(_DemoScrollSineData), W0
    mov #DemoScrollSineData, W1
    repeat #238
    tblrdl [W0++], [W1++]

    mov #DemoScrollChar, W1
    mov #32, W2
_DI02:
    mov #8, W3
_DI03:
    mov.b #0b00111111, W0
    mov.b W0, [W1++]
    mov.b #0b00101010, W0
    repeat #6
    mov.b W0, [W1++]
    dec W3, W3
    bra NZ, _DI03
    mov #8, W3
_DI04:
    mov.b #0b00101010, W0
    repeat #6
    mov.b W0, [W1++]
    mov.b #0b00010101, W0
    mov.b W0, [W1++]
    dec W3, W3
    bra NZ, _DI04
    dec W2, W2
    bra NZ, _DI02

    mov #DemoScrollSineIndex, W1
    mov #0, W0
    mov W0, [W1]

    mov #DemoSpriteScrollShift, W1
    mov #0, W0
    mov W0, [W1]

    mov #DemoSpriteScrollIndex, W1
    mov #0, W0
    mov W0, [W1]

    mov #DemoSpriteTextIndex, W1
    mov #0, W0
    mov W0, [W1]

    return

; --- draw the static and moving copper bars ---
DemoDrawCopperBars:
    mov.b #0, W0			; []
    mov #(DemoBgCol240 + 75), W1	; []
    repeat #24				; []
    mov.b W0, [W1++]			; []
    mov #(DemoBgCol240 + 130), W1	; []
    repeat #24				; []
    mov.b W0, [W1++]			; []

    mov #DemoSinusIndex1, W0		; []
    mov #DemoSinusIndex2, W4		; []
    mov [W0], W1			; []
    mov [W4], W2			; []
    cpslt W1, W2			; []
    exch W0, W4				; []

    mov #DemoSinusData, W1		; []
    add W1, [W0], W1			; []
    mov #DemoGoldCopper, W2		; []
    ze [W1], W1				; []
    mov #DemoBgCol240, W3		; []
    add W1, W3, W3			; []
    repeat #29				; []
    mov.b [W2++], [W3++]		; []
    inc [W0], W1			; []
    mov #120, W2			; []
    cpsne W1, W2			; []
    mov #0, W1				; []
    mov W1, [W0]			; []

    mov #(DemoTopPurpleCopper + 15), W1	; []
    mov #(DemoBgCol240 + 100), W2	; []
    repeat #29				; []
    mov.b [W1++], [W2++]		; []

    mov #DemoSinusData, W1		; []
    add W1, [W4], W1			; []
    mov #DemoGoldCopper, W2		; []
    ze [W1], W1				; []
    mov #DemoBgCol240, W3		; []
    add W1, W3, W3			; []
    mov #DemoFgCol240, W5		; []
    add W1, W5, W5			; []
    repeat #29				; []
    mov.b [W2++], [W3++]		; []
    mov #DemoGoldCopper, W2		; []
    repeat #29				; []
    mov.b [W2++], [W5++]		; []
    inc [W4], W1			; []
    mov #120, W2			; []
    cpsne W1, W2			; []
    mov #0, W1				; []
    mov W1, [W4]			; []

    mov #DemoTopPurpleCopper, W1	; []
    mov #(DemoBgCol240 + 60), W2	; []
    repeat #14				; []
    mov.b [W1++], [W2++]		; []
    mov #(DemoTopPurpleCopper + 45), W1	; []
    mov #(DemoBgCol240 + 155), W2	; []
    repeat #14				; []
    mov.b [W1++], [W2++]		; []

    return				; [-] 6 cycles for this command

; --- draw the horizontal text colour scrolls --- *** 78 cycles ***
DrawHorColScrolls:
    mov #DemoHorColIndex0, W1		; [1]
    mov #DemoHorColData0, W2		; [2]
    mov [W1], W0			; [3]
    mov #(FgColourRam + 930), W3	; [4]
    mov #DemoHorColDelay0, W4		; [5]
    add W0, W2, W2			; [6]
    repeat #19				; [7]
    mov.b [W2++], [W3++]		; [8..27]
    dec [W4], W2			; [28]
    bra NZ, _DHCS00			; [29-32]
    mov #3, W2				; [30]
    inc W0, W0				; [31]
    nop					; [32]
_DHCS00:
    mov W2, [W4]			; [33]
    mov #18, W2				; [34]
    cpsne W0, W2			; [35]
    mov #0, W0				; [36]
    mov W0, [W1]			; [37]

    mov #DemoHorColIndex1, W1		; [38]
    mov #DemoHorColData1, W2		; [39]
    mov [W1], W0			; [40]
    mov #(FgColourRam + 1011), W3	; [41]
    mov #DemoHorColDelay1, W4		; [42]
    add W0, W2, W2			; [43]
    repeat #17				; [44]
    mov.b [W2++], [W3++]		; [45..62]
    dec [W4], W2			; [63]
    bra NZ, _DHCS01			; [64-67]
    mov #3, W2				; [65]
    dec W0, W0				; [66]
    nop					; [67]
_DHCS01:
    mov W2, [W4]			; [68]
    mov #0xffff, W2			; [69]
    cpsne W0, W2			; [70]
    mov #17, W0				; [71]
    mov W0, [W1]			; [72]

    return				; [73-78] 6 cycles for this command

; --- draw the scroll pattern --- *** 28 cycles ***
DrawScrollPattern:
    mov #ScrollPatternIndex, W1		; [1]
    mov #DemoScrollPattern, W2		; [2]
    add W2, [W1], W2			; [3]
    mov #2040, W0
    add CharData, WREG
    repeat #7				; [5]
    mov.b [W2++], [W0++]		; [6..13]
    mov #SrollPatternDelay, W2		; [14]
    mov [W1], W0			; [15]
    dec [W2], W3			; [16]
    bra NZ, _DSP00			; [17-20]
    add.b #8, W0			; [18]
    and.b #0x3f, W0			; [19]
    mov #3, W3				; [20]
_DSP00:
    mov W0, [W1]			; [21]
    mov W3, [W2]			; [22]

    return				; [23-28] 6 cycles for this command

; --- draw the scroll pattern colours --- *** 31 cycles ***
DrawPatternColScroll:
    mov #DemoPatternColourIndex, W1	; [1]
    mov #DemoPatternColourData, W2	; [2]
    mov [W1], W0			; [3]
    mov #(DemoFgCol240 + 112), W3	; [4]
    mov #DemoPatternColourDelay, W4	; [5]
    add W0, W2, W2			; [6]
    repeat #7				; [7]
    mov.b [W2++], [W3++]		; [8..15]
    dec [W4], W2			; [16]
    bra NZ, _DPCS00			; [17-20]
    mov #2, W2				; [18]
    inc W0, W0				; [19]
    nop					; [20]
_DPCS00:
    mov W2, [W4]			; [21]
    mov #56, W2				; [22]
    cpsne W0, W2			; [23]
    mov #0, W0				; [24]
    mov W0, [W1]			; [25]

    return				; [26-31] 6 cycles for this command

; --- draw the vertical scroll text --- *** 310 cycles ***
DrawVerticalScrollText:
    mov #DemoVScrollTextDelay, W1	; [1]
    nop					; [2]
    dec [W1], W0			; [3]
    bra NZ, _DVST01			; [4-7]
    mov #1, W0				; [5]
    mov W0, [W1]			; [6]

    mov #tblpage(_DemoVScrollText), W0	; [7]
    mov W0, _TBLPAG			; [8]
    mov #DemoVScrollTextIndex, W0	; [9]
    mov #tbloffset(_DemoVScrollText), W1	; [10]
    add W1, [W0], W1			; [11]
    mov #DemoVScrollTextShift, W2	; [12]
    clr W0				; [13]
    tblrdl.b [W1], W0			; [14-18] read the ASCII character from program memory
    sl W0, #3, W0			; [19] ASCII character * 8
    mov CharData, W1			; [20]
    add W0, W1, W1			; [21] W1 = pointer at ASCII character's bitmask
    mov [W2], W2			; [22] W2 = bitmask bit position

    clr W0				; [23]
    do #7, _DVST00			; [24-25]
    mov.b [W1++], W3			; [26..47]
    btst.c W3, W2			; [27..48]
_DVST00:
    rlc W0, W0				; [28..49]

    mov CharData, W1
    mov #1278, W2
    add W1, W2, W1
    inc W1, W2

    repeat #238				; [52]
    mov.b [W1--], [W2--]		; [53..291]
    com.b W0, W0			; [292]
    mov.b W0, [W2]			; [293]

    mov #DemoVScrollTextShift, W1	; [294]
    mov #DemoVScrollTextIndex, W2	; [295]
    dec [W1], W0			; [296]
    bra NN, _DVST01			; [297-300]
    mov #7, W0				; [298]
    mov W0, [W1]			; [299]
    inc [W2], W0			; [300]
    mov #590, W1			; [301]
    cpsne W0, W1			; [302]
    mov #0, W0				; [303]
    mov W0, [W2]			; [304]

    return				; [305-310] 6 cycles for this command

_DVST01:
    mov W0, [W1]			; [301]
    return				; [302-307] 6 cycles for this command

; --- horizontal scroll text rendering ---
DrawHorizontalScrollText:
    mov #DemoHScrollTextDelay, W4	; []
    dec [W4], W0			; []
    bra Z, _DHST00			; [-]
    mov W0, [W4]			; []
    return				; [-] 6 cycles for this command

_DHST00:
    mov #1, W0				; []
    mov W0, [W4]			; []

    mov #DemoHScrollTextShift, W4	; []
    inc [W4], W0			; []
    mov #8, W1				; []
    cp W0, W1				; []
    bra Z, _DHST01			; [-]
    mov W0, [W4]			; []
    return				; [-] 6 cycles for this command
    
_DHST01:
    mov #0, W0				; []
    mov W0, [W4]			; []

    mov #(VideoRam + 1120), W2		; []
    inc W2, W3				; []
    repeat #38				; []
    mov.b [W3++], [W2++]		; []

    mov #tblpage(_DemoHScrollText), W0	; []
    mov W0, _TBLPAG			; []
    mov #tbloffset(_DemoHScrollText), W0; []
    mov #DemoHScrollTextIndex, W4	; []
    add W0, [W4], W0			; []
    tblrdl.b [W0], [W2]			; [-] read the ASCII character from program memory

    inc [W4], W0			; []
    mov #448, W1			; []
    cpsne W0, W1			; []
    mov #0, W0				; []
    mov W0, [W4]			; []

    return				; [-] 6 cycles for this command

; --- draw the horizontal scroll colours ---
DrawDemoVerColScroll:
    mov #DemoVerColDelay, W1		; []
    dec [W1], W0			; []
    bra Z, _DDVCS00			; [-]
    mov W0, [W1]			; []
    return				; [-] 6 cycles for this command

_DDVCS00:
    mov #4, W0				; []
    mov W0, [W1]			; []

    mov #DemoVerColBgIndex, W0		; []
    mov #DemoVerColData, W1		; []
    add W1, [W0], W1			; []
    mov #(DemoBgCol240 + 224), W0	; []
    repeat #7				; []
    mov.b [W1++], [W0++]		; []

    mov #DemoVerColFgIndex, W0		; []
    mov #DemoVerColData, W1		; []
    add W1, [W0], W1			; []
    mov #(DemoFgCol240 + 224), W0	; []
    repeat #7				; []
    mov.b [W1++], [W0++]		; []

    mov #DemoVerColBgIndex, W1		; []
    inc [W1], W0			; []
    mov #24, W2				; []
    cpsne W0, W2			; []
    mov #16, W0				; []
    mov W0, [W1]			; []

    mov #DemoVerColFgIndex, W1		; []
    inc [W1], W0			; []
    mov #8, W2				; []
    cpsne W0, W2			; []
    mov #0, W0				; []
    mov W0, [W1]			; []
    return				; [-] 6 cycles for this command

; --- Update the demo sprite pointers and Y-positions ---
UpdateDemoSprites:
    mov #(SpriteTable + 2), W0		; []
    mov #DemoSineData, W1		; []
    mov #DemoSpriteSine, W2		; []
    mov #DemoSpriteY, W3		; []
    mov #90, W4				; []

    do #4, _UDS00			; [-]
    mov [W2], W5			; [] W5 = sprite sine index
    add W1, W5, W6			; [] W6 = index into sine Y-coordinate table
    inc W5, W5				; [] W5 = sprite sine index + 1
    cpsne W5, W4			; [] if W5 is '90'...
    clr W5				; [] ...set W5 to '0'
    mov W5, [W2++]			; [] store the updated index
    ze [W6], W5				; [] W5 = Y-coordinate
    mov W5, [W3++]			; [] store Y-coordinate
    mov W5, [W0]			; []
    add #6, W0				; []
    mov W5, [W0]			; []
_UDS00:
    add #6, W0				; []

    mov #DemoSpritePointers, W0		; [] initialise the top sprites' pointers
    mov #(SpriteTable + 4), W1		; []
    do #9, _UDS01			; [-]
    mov [W0], [W1]			; []
    add #2, W0				; []
_UDS01:
    add #6, W1				; []
    return				; [-] 6 cycles for this command

; --- update the sprite scroll ---
UpdateSpriteScroll:
    mov #DemoScrollSineIndex, W1	; []
    mov #239, W2			; []
    inc2 [W1], W0			; [] W0 = sine table index + 2
    cpslt W0, W2			; [] if W0 >= 239...
    sub W0, W2, W0			; [] ...subtract 239...
    mov W0, [W1]			; [] ...and store the updated index

    mov #DemoSpriteScrollShift, W1	; []
    nop					; []
    inc [W1], W0			; []
    cp W0, #8				; []
    bra NZ, _MSS02			; [-]

    mov #tblpage(_DemoSpriteText), W0	; []
    mov W0, _TBLPAG			; []
    mov #DemoSpriteTextIndex, W3	; []
    mov #tbloffset(_DemoSpriteText), W2	; []
    mov [W3], W4			; [] W4 = index into sprite scroll text
    add W2, W4, W2			; [] W2 = pointer to character in sprite scroll text
    clr W0				; []
    tblrdl.b [W2], W0			; [] W0 = ASCII value
    inc W4, W4				; [] W4 = index into sprite scroll text + 1
    mov #350, W5			; []
    cpsne W4, W5			; []
    mov #0, W4				; []
    mov W4, [W3]			; []

    mov #DemoSpriteScrollIndex, W3	; []
    mov #(DemoScrollChar + 68), W2	; []
    mov [W3], W4			; []
    inc W4, W5				; []
    and #31, W5				; []
    mov W5, [W3]			; []
    add #31, W4				; []
    and #31, W4				; []
    sl W4, #7, W4			; []
    add W4, W2, W2			; []

    mov CharData, W3
    sl W0, #3, W0
    add W0, W3, W3
    mov #2, W4
_MSS00:
    do #3, _MSS01			; [1-2] loop 8 times (loop length 34)
    mov.b [W3++], W0			; [3..241]
    swap W0				; [4..242]
    mov.b #0b01000000, W0		; [5..243]
    btss W0, #15			; [6..244]
    mov.b #0b00101010, W0		; [7..245]
    mov.b W0, [--W2]			; [8..246]
    mov.b #0b01000000, W0		; [9..247]
    btss W0, #14			; [10..248]
    mov.b #0b00101010, W0		; [11..249]
    mov.b W0, [W2 + 8]			; [12..250]
    mov.b #0b01000000, W0		; [13..251]
    btss W0, #13			; [14..252]
    mov.b #0b00101010, W0		; [15..253]
    mov.b W0, [W2 + 16]			; [16..254]
    mov.b #0b01000000, W0		; [17..255]
    btss W0, #12			; [18..256]
    mov.b #0b00101010, W0		; [19..257]
    mov.b W0, [W2 + 24]			; [20..258]
    mov.b #0b01000000, W0		; [21..259]
    btss W0, #11			; [22..260]
    mov.b #0b00101010, W0		; [23..261]
    mov.b W0, [W2 + 32]			; [24..262]
    mov.b #0b01000000, W0		; [25..263]
    btss W0, #10			; [26..264]
    mov.b #0b00101010, W0		; [27..265]
    mov.b W0, [W2 + 40]			; [28..266]
    mov.b #0b01000000, W0		; [29..267]
    btss W0, #9				; [30..268]
    mov.b #0b00101010, W0		; [31..269]
    mov.b W0, [W2 + 48]			; [32..270]
    mov.b #0b01000000, W0		; [33..271]
    btss W0, #8				; [34..272]
    mov.b #0b00101010, W0		; [35..273]
_MSS01:
    mov.b W0, [W2 + 56]			; [36..274]
    sub #56, W2
    dec W4, W4
    bra NZ, _MSS00

    mov #0, W0
_MSS02:
    mov W0, [W1]

    return				; [-] 6 cycles for this command

; --- move the jumpung ball ---
MoveJumpingBall:
    mov #(SpriteTable + 60), W0		; []
    mov #DemoBallX, W1			; []
    mov #DemoBallDeltaX, W2		; []

    mov [W1], W3			; [] W3 = ball X-coordinate
    mov W3, [W0]			; [] set X-coordinate for sprite #11
    mov W3, [W0 + 12]			; [] set X-coordinate for sprite #13
    add #8, W3				; []
    mov W3, [W0 + 6]			; [] set X-coordinate for sprite #12
    mov W3, [W0 + 18]			; [] set X-coordinate for sprite #14

    mov [W1], W3			; [] W3 = ball X-coordinate
    mov [W2], W0			; [] W0 = update value for X-coordinate
    add W0, W3, W3			; [] W3 = updated X-coordinate
    mov W3, [W1]			; [] save updated X-coordinate

    mov #32, W4				; []
    cpsne W3, W4			; [] if the X-coordinate has reached the leftmost boundary...
    mov #1, W0				; [] ...negate the update value
    mov #304, W4			; []
    cpsne W3, W4			; [] if the X-coordinate has reached the rightmost boundary...
    mov #-1, W0				; [] ...negate the update value
    mov W0, [W2]			; []

    mov #(SpriteTable + 60), W0		; []
    mov #DemoBallIndex, W1		; []
    mov #DemoBallSine, W2		; []
    add W2, [W1], W2			; []
    add W2, [W1], W2			; []
    mov #53, W3				; []
    mov [W2], W4			; []
    mov W4, [W0 + 2]			; [] set X-coordinate for sprite #11
    mov W4, [W0 + 8]			; [] set X-coordinate for sprite #12
    add #8, W4				; []
    mov W4, [W0 + 14]			; [] set X-coordinate for sprite #13
    mov W4, [W0 + 20]			; [] set X-coordinate for sprite #14

    inc [W1], W0			; []
    cpsne W0, W3			; []
    clr W0				; []
    mov W0, [W1]			; []

    return				; [-] 6 cycles for this command

; --- handle a possible collision between the ball and the sprite scroller ---
BallScrollCollision:
    mov #(SpriteTable + 60), W1		; []
    mov #DemoScrollSineIndex, W2	; []
    mov #DemoBallOutline, W3		; []
    mov #DemoScrollSineData, W4		; []
    clr W5				; [] max. overlap
    mov [W2], W2			; []
    mov [W1 + 2], W0			; []
    add W0, W2, W2			; []
    mov #239, W0			; []
    cpslt W2, W0			; []
    sub W2, W0, W2			; []
    sl W2, #1, W2			; [] W2 = scroll sine data index * 2

    do #15, _BSC00			; [-]
    mov [W3++], W0			; []
    add W0, [W1], W0			; [] W0 = X_ball + d_i
    mov [W4 + W2], W6			; [] W6 = sine value
    sub W0, W6, W0			; [] W0 = (X_ball + d_i) - sine value
    cpslt W0, W5			; []
    mov W0, W5				; []
    mov #478, W0			; []
    inc2 W2, W2
    cpslt W2, W0			; []
    sub W2, W0, W2			; []
_BSC00:
    nop					; []

    cp0 W5				; []
    bra Z, _BSC01			; []
    mov #DemoBallDeltaX, W2		; []
    mov #-1, W0				; []
    mov W0, [W2]			; []
    neg W5, W5				; []
    add W5, [W1], W5			; []
    mov W5, [W1]			; []
    mov W5, [W1 + 12]			; []
    add #8, W5				; []
    mov W5, [W1 + 6]			; []
    mov W5, [W1 + 18]			; []
_BSC01:
    return				; [-] 6 cycles for this command

; +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
; General functions related to screen content manipulation
; +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
; --- wait for one frame to pass ---
WaitOneFrame:
    mov #482, W0			; []
_WOF00:
    cp W14, W0				; [] loop until the raster line is NOT '0' anymore
    bra Z, _WOF00			; [-]
_WOF01:
    cp W14, W0				; [] loop until the raster line is '0'
    bra NZ, _WOF01			; [-]
    return				; [-]

; --- wait for W0 frame to pass ---
WaitNFrames:
    push W1				; []
_WNF00:
    mov #482, W1			; []
_WNF01:
    cp W14, W1				; [] loop until the raster line is NOT '0' anymore
    bra Z, _WNF01			; [-]
_WNF02:
    cp W14, W1				; [] loop until the raster line is '0'
    bra NZ, _WNF02			; [-]
    dec W0, W0
    bra NZ, _WNF00
    pop W1
    return				; [-]

; --- clear the screen (video RAM only) ---
ClearScreen:
    push.d W0				; [-]
    mov #0x2020, W0			; [] fill the video RAM with space characters
    mov #VideoRam, W1			; []
    repeat #599				; []
    mov W0, [W1++]			; [..]
    clr CursorColumn			; [] set cursor position to left upper corner
    clr CursorRow			; []
    pop.d W0				; [-]
    return				; [-]

; --- reset the screen (video RAM, foreground and background colour) ---
ResetScreen:
    push.d W0				; [-]
    mov #0x2020, W0			; [] fill the video RAM with space characters
    mov #VideoRam, W1			; []
    repeat #599				; []
    mov W0, [W1++]			; [..]
    mov #0x4040, W0			; []
    mov #BgColourRam, W1		; []
    repeat #599				; []
    mov W0, [W1++]			; [..] set all background colour attributes to transparent (global colour)
    mov #FgColourRam, W1		; []
    repeat #599				; []
    mov W0, [W1++]			; [..] set all foreground colour attributes to transparent (global colour)
    clr CursorColumn			; [] set cursor position to left upper corner
    clr CursorRow			; []
    pop.d W0				; [-]
    return				; [-]

; --- set the column (W0) and row (W1) of the cursor ---
SetCursorPosition:
    push W2				; []
    mov #40, W2				; [] end if the x-coordinate is out of bounds
    cp W0, W2				; []
    bra GEU, _SCP00			; [-]
    mov #30, W2				; [] end if the y-coordinate is out of bounds
    cp W1, W2				; []
    bra GEU, _SCP00			; [-]
    mov W0, CursorColumn		; [] set the cursor column and row
    mov W1, CursorRow			; []
_SCP00:
    pop W2				; []
    return				; [-]

; --- move screen content up one text row (text only) ---
MoveTextUp:
    push.d W0				; [1-2] push W0 and W1 onto the stack
    mov #(VideoRam + 40), W0		; [3] move 29 rows of text up
    mov #VideoRam, W1			; [4]
    repeat #579				; [5]
    mov [W0++], [W1++]			; [6..585]
    pop.d W0				; [586-587] pop W1 and W0 from the stack
    return				; [588-593]

; --- move screen content up one text row (text, foreground and background colour) ---
MoveScreenUp:
    push.d W0				; [1-2] push W0 and W1 onto the stack
    mov #(VideoRam + 40), W0		; [3] move 29 rows of text up
    mov #VideoRam, W1			; [4]
    repeat #579				; [5]
    mov [W0++], [W1++]			; [6..585]
    mov #(BgColourRam + 40), W0		; [] move 29 rows of background colour attributes up
    mov #BgColourRam, W1		; []
    repeat #579				; []
    mov [W0++], [W1++]			; [..]
    mov #(FgColourRam + 40), W0		; [] move 29 rows of foreground colour attributes up
    mov #FgColourRam, W1		; []
    repeat #579				; []
    mov [W0++], [W1++]			; [..]
    pop.d W0				; [-] pop W1 and W0 from the stack
    return				; [-]

; --- fill the bottom text row (text only) ---
InitBottomTextRowSimple:
    push.d W0				; [1-2]
    mov #0x2020, W0			; [3]
    mov #(VideoRam + 1160), W1		; [4]
    repeat #19				; [5]
    mov W0, [W1++]			; [6..25]
    pop.d W0				; [26-27]
    return				; [28-33]

; --- fill the bottom text row (text, foreground and background colour) ---
InitBottomTextRowFull:
    push.d W0				; [1-2]
    mov #0x2020, W0			; [3]
    mov #(VideoRam + 1160), W1		; [4]
    repeat #19				; [5]
    mov W0, [W1++]			; [6..25]
    mov #0x4040, W0			; []
    mov #(BgColourRam + 1160), W1	; []
    repeat #19				; []
    mov W0, [W1++]			; [..]
    mov #0x4040, W0			; []
    mov #(FgColourRam + 1160), W1	; []
    repeat #19				; []
    mov W0, [W1++]			; [..]
    pop.d W0				; [-]
    return				; [-]

; --- move screen content down one text row (text only) ---
MoveTextDown:
    push.d W0				; [1-2] push W0 and W1 onto the stack
    mov #(VideoRam + 1158), W0		; [3] move 29 rows of text down
    mov #(VideoRam + 1198), W1		; [4]
    repeat #579				; [5]
    mov [W0--], [W1--]			; [6..585]
    pop.d W0				; [-] pop W1 and W0 from the stack
    return				; [-]

; --- move screen content down one text row (text, foreground and background colour) ---
MoveScreenDown:
    push.d W0				; [1-2] push W0 and W1 onto the stack
    mov #(VideoRam + 1158), W0		; [3] move 29 rows of text down
    mov #(VideoRam + 1198), W1		; [4]
    repeat #579				; [5]
    mov [W0--], [W1--]			; [6..585]
    mov #(BgColourRam + 1158), W0	; [] move 29 rows of background colour attributes down
    mov #(BgColourRam + 1198), W1	; []
    repeat #579				; []
    mov [W0--], [W1--]			; [..]
    mov #(FgColourRam + 1158), W0	; [] move 29 rows of foreground colour attributes down
    mov #(FgColourRam + 1198), W1	; []
    repeat #579				; []
    mov [W0--], [W1--]			; [..]
    pop.d W0				; [-] pop W1 and W0 from the stack
    return				; [-]

; --- fill the top text row (text only) ---
InitTopTextRowSimple:
    push.d W0				; [1-2]
    mov #0x2020, W0			; [3]
    mov #VideoRam, W1			; [4]
    repeat #19				; [5]
    mov W0, [W1++]			; [6..25]
    pop.d W0				; [26-27]
    return				; [28-33]

; --- fill the top text row (text, foreground and background colour) ---
InitTopTextRowFull:
    push.d W0				; [1-2]
    mov #0x2020, W0			; [3]
    mov #VideoRam, W1			; [4]
    repeat #19				; [5]
    mov W0, [W1++]			; [6..25]
    mov #0x4040, W0			; []
    mov #BgColourRam, W1		; []
    repeat #19				; []
    mov W0, [W1++]			; [..]
    mov #0x4040, W0			; []
    mov #FgColourRam, W1		; []
    repeat #19				; []
    mov W0, [W1++]			; [..]
    pop.d W0				; [-]
    return				; [-]

; --- move screen content left one text column (text only) ---
MoveTextLeft:
    push.d W0				; [1-2] push W0 and W1 onto the stack
    mov #(VideoRam + 1), W0		; []
    mov #VideoRam, W1			; []
    repeat #1198			; []
    mov.b [W0++], [W1++]		; [..]
    pop.d W0				; [-] pop W1 and W0 from the stack
    return				; [-]

; --- move screen content down one text row (text, foreground and background colour) ---
MoveScreenLeft:
    push.d W0				; [1-2] push W0 and W1 onto the stack
    mov #(VideoRam + 1), W0		; []
    mov #VideoRam, W1			; []
    repeat #1198			; []
    mov.b [W0++], [W1++]		; [..]
    mov #(BgColourRam + 1), W0		; []
    mov #BgColourRam, W1		; []
    repeat #1198			; []
    mov.b [W0++], [W1++]		; [..]
    mov #(FgColourRam + 1), W0		; []
    mov #FgColourRam, W1		; []
    repeat #1198			; []
    mov.b [W0++], [W1++]		; [..]
    pop.d W0				; [-] pop W1 and W0 from the stack
    return				; [-]

; --- fill the right text column (text only) ---
InitRightTextColumnSimple:
    push.d W0				; [1-2]
    push W2				; []
    mov.b #0x20, W0			; []
    mov #(VideoRam + 39), W1		; []
    mov #40, W2				; []
    do #29, _IRTCS00			; [-]
    mov.b W0, [W1]			; [..]
_IRTCS00:
    add W1, W2, W1			; []
    pop W2				; []
    pop.d W0				; [-]
    return				; [-]

; --- fill the right text column (text, foreground and background colour) ---
InitRightTextColumnFull:
    push.d W0				; [1-2]
    push W2				; []
    mov.b #0x20, W0			; []
    mov #(VideoRam + 39), W1		; []
    mov #40, W2				; []
    do #29, _IRTCF00			; [-]
    mov.b W0, [W1]			; [..]
_IRTCF00:
    add W1, W2, W1			; []
    mov.b #0x40, W0			; []
    mov #(BgColourRam + 39), W1		; []
    do #29, _IRTCF01			; [-]
    mov.b W0, [W1]			; [..]
_IRTCF01:
    add W1, W2, W1			; []
    mov.b #0x40, W0			; []
    mov #(FgColourRam + 39), W1		; []
    do #29, _IRTCF02			; [-]
    mov.b W0, [W1]			; [..]
_IRTCF02:
    add W1, W2, W1			; []
    pop W2				; []
    pop.d W0				; [-]
    return				; [-]

; --- move screen content right one text column (text only) ---
MoveTextRight:
    push.d W0				; [1-2] push W0 and W1 onto the stack
    mov #(VideoRam + 1198), W0		; []
    mov #(VideoRam + 1199), W1		; []
    repeat #1198			; []
    mov.b [W0--], [W1--]		; [..]
    pop.d W0				; [-] pop W1 and W0 from the stack
    return				; [-]

; --- move screen content right one text column (text, foreground and background colour) ---
MoveScreenRight:
    push.d W0				; [1-2] push W0 and W1 onto the stack
    mov #(VideoRam + 1198), W0		; []
    mov #(VideoRam + 1199), W1		; []
    repeat #1198			; []
    mov.b [W0--], [W1--]		; [..]
    mov #(BgColourRam + 1198), W0	; []
    mov #(BgColourRam + 1199), W1	; []
    repeat #1198			; []
    mov.b [W0--], [W1--]		; [..]
    mov #(FgColourRam + 1198), W0	; []
    mov #(FgColourRam + 1199), W1	; []
    repeat #1198			; []
    mov.b [W0--], [W1--]		; [..]
    pop.d W0				; [-] pop W1 and W0 from the stack
    return				; [-]

; --- fill the left text column (text only) ---
InitLefttTextColumnSimple:
    push.d W0				; [1-2]
    push W2				; []
    mov.b #0x20, W0			; []
    mov #VideoRam, W1			; []
    mov #40, W2				; []
    do #29, _ILTCS00			; [-]
    mov.b W0, [W1]			; [..]
_ILTCS00:
    add W1, W2, W1			; []
    pop W2				; []
    pop.d W0				; [-]
    return				; [-]

; --- fill the left text column (text, foreground and background colour) ---
InitLeftTextColumnFull:
    push.d W0				; [1-2]
    push W2				; []
    mov.b #0x20, W0			; []
    mov #VideoRam, W1			; []
    mov #40, W2				; []
    do #29, _ILTCF00			; [-]
    mov.b W0, [W1]			; [..]
_ILTCF00:
    add W1, W2, W1			; []
    mov.b #0x40, W0			; []
    mov #BgColourRam, W1		; []
    do #29, _ILTCF01			; [-]
    mov.b W0, [W1]			; [..]
_ILTCF01:
    add W1, W2, W1			; []
    mov.b #0x40, W0			; []
    mov #FgColourRam, W1		; []
    do #29, _ILTCF02			; [-]
    mov.b W0, [W1]			; [..]
_ILTCF02:
    add W1, W2, W1			; []
    pop W2				; []
    pop.d W0				; [-]
    return				; [-]

; --- print a character (ASCII code in W0) at the current cursor location ---
PrintCharacter:
    push.d W2				; [-] push W2 and W3 to the stack
    mov CursorRow, W2			; []
    mov #40, W3				; []
    mul.uu W2, W3, W2			; [] W2 = cursor row * 40
    mov #VideoRam, W3			; []
    add W2, W3, W3			; [] W3 = start of video RAM + (cursor row * 40)
    mov CursorColumn, W2		; [] W2 = cursor column
    add W2, W3, W3			; [] W3 = start of video RAM + (cursor row * 40) + cursor column
    mov.b W0, [W3]			; [] set character at cursor location
    mov #40, W0				; []
    inc W2, W2				; []
    cp W2, W0				; [] if the (increased) cursor column is NOT 40...
    bra NZ, _PC01			; [-] ...skip the next code section
    clr W2				; [] otherwise set the cursor column 0...
    mov #30, W0				; []
    mov CursorRow, W3			; []
    inc W3, W3				; [] ...increase the cursor row by 1...
    cp W3, W0				; [] ...and check if it is 30
    bra NZ, _PC00			; [-] if not, skip the next code section
    dec W3, W3				; [] otherwise restore the cursor row...
    rcall MoveTextUp			; [..] ...move the screen contents (text only) up...
    rcall InitBottomTextRowSimple	; [..] ...and enter an empty text row at the bottom
_PC00:
    mov W3, CursorRow			; [] save the (possibly) changed cursor row
_PC01:
    mov W2, CursorColumn		; [] save the (possibly) changed cursor column
    pop.d W2				; [-] pop W3 and W2 from the stack
    return				; [-]

; --- print a newline character ---
PrintNewLine:
    push.d W0				; [-]
    clr CursorColumn			; []
    inc CursorRow, WREG			; []
    mov #30, W1				; []
    cp W0, W1				; []
    bra NZ, _PNL00			; [-]
    dec W0, W0				; [] otherwise restore the cursor row...
    rcall MoveTextUp			; [..] ...move the screen contents (text only) up...
    rcall InitBottomTextRowSimple	; [..] ...and enter an empty text row at the bottom
_PNL00:
    mov W0, CursorRow			; []
    pop.d W0				; [-]
    return				; [-]

; --- the trap service routines (TSR) ---
.text
__OscillatorFail:
    reset
__AddressError:
    reset
__GenericHard:
    reset
__StackError:
    reset
__MathError:
    reset
__DMACError:
    reset
__GenericSoft:
    reset

; the interrupt service routines (ISR)
.text

; --- IFS0 interrupts ---
__INT0Interrupt:			; External Interrupt 0
    bclr IFS0, #INT0IF
    retfie

__IC1Interrupt:				; Input Capture 1
    bclr IFS0, #IC1IF
    retfie

; This interrupt occurs when there is a match of OC1TMR with OC1RS, which holds the value '192'.
; At the **end** of OC1TMR value '192' period, Hsync goes HI (so the whole of OC1TMR value '193' and beyond are HI).
; the OC1IF flag is set at the **start** of OC1TMR value '195'.
; The first instruction cycle of the ISR should be executed at the **start** OC1TMR value '208'.
; This ISR takes place during the back porch (96 cycles in total).
; OC1TMR value '193' corresponds to back porch cycle #1 --> OC1TMR value '208' corresponds to back porch cycle #16
; After back porch cycle #96, we'll start with cycle #1 again, which is the cycle when the first pixel value output takes place.
; The last cycle of the pixel data output is #1280.
; After that, on the subsequent cycle #1, we'll output the pixel value black (#0b00000000).
__OC1Interrupt:
    push RCOUNT				; [16][OC1TMR '208'] push RCOUNT and W0 on the stack
    push W0				; [17][OC1TMR '209']

    mov #215, W0			; [18][OC1TMR '210'] remove possible jitter of the interrupt latency 
    subr OC1TMR, WREG			; [19-20][OC1TMR '211'-'212']
    repeat W0				; [21]
    nop					; [22...25]

    mov #481, W0			; [26]
    btsc VerScrollEnable, #0		; [27] if vertical scrolling is enabled...
    mov #473, W0			; [28] ...the bottommost 4 pixel rows (8 raster lines) are blank
    cp W14, W0				; [29]
    bra LE, _TextOut000			; [30-33]

    inc W14, W14			; [31] W14 = raster line + 1
    mov #525, W0			; [32]
    cpsne W14, W0			; [33] if the raster line is #525...
    mov #0, W14				; [34] ...reset it to zero

    pop W0				; [35] pop W0 and RCOUNT from the stack
    pop RCOUNT				; [36]
    bclr IFS0, #OC1IF			; [37-38] clear the interrupt flag
    retfie				; [39-44] return from interrupt - 6 clock cycles

; --- decide on rendering text or graphics, blank topmost 4 pixel rows or not, depending on vertical scrolling on/off ---
_TextOut000:
    mov ModeSelect, WREG		; [34] WREG = ModeSelect (this sets/clears the zero flag)
    bra NZ, _TilesOut000		; [35-38] jump to graphics rendering if the graphics mode is enabled
    mov #2, W0				; [36]
    btsc VerScrollEnable, #0		; [37] the pixel row at which rendering with simultaneous video output happens, depends on whether vertical scrolling is enabled
    mov #10, W0				; [38]
    cp W14, W0				; [39]
    bra GE, _TextOut002			; [40-43] go to rendering with simultaneous video output if it's NOT the topmost visible pixel row

    btss VerScrollEnable, #0		; [41]
    bra _TeO000_00			; [42-45]
    nop					; [43] *** REMOVE ***
    cp W14, #8				; [44]
    bra LT, _TeO000_02			; [45-48] if vertical scrolling is enabled, don't show the topmost 8 raster lines (4 pixel rows)

; --- TEXT MODE: render pixel row #0 (raster line #0) without video output ---
_TeO000_00:
    push W1				; [46] push W1 on the stack
    push.d W2				; [47-48] push W2 and W3 on the stack
    push.d W4				; [49-50] push W4 and w5 on the stack
    push.d W6				; [51-52] push W6 and W7 on the stack
    push.d W8				; [53-54] push W8 and W9 on the stack

    lsr W14, #1, W0			; [55] W0 = pixel row
    mov VerScrollOff, W1		; [56]
    sub #4, W1				; [57] W1 = vertical scroll offset - 4
    btsc VerScrollEnable, #0		; [58]
    add W0, W1, W0			; [59]
    and W0, #7, W1			; [60] W1 = pixel row offset within the current text row [0..7]
    mov CharData, W3			; [61]
    add W1, W3, W3			; [62] W3 = pointer to character data (including pixel row offset)

    mov #VideoRam, W4			; [63] W4 = pointer to video RAM
    mov #BgColourRam, W6		; [64] W6 = pointer to background colour RAM
    mov #FgColourRam, W7		; [65] W7 = pointer to foreground colour RAM

    mov #(RenderBuffer0 + 8), W2	; [66] W2 = pointer to WRITE render buffer
    mov #4, W0				; [67]
    subr HorScrollOff, WREG		; [68] W0 = 4 - horizontal scroll offset [-3..4]
    btsc HorScrollEnable, #0		; [69]
    add W2, W0, W2			; [70] W2 = pointer to WRITE render buffer (including horizontal pixel offset in case of horizontal scrolling)

    btsc W14, #0			; [71]
    bra _TextOut001			; [72-75] branch if odd raster line (#1 or #9)

    do #38, _TeO000_01			; [73-74] loop through 39 characters - 33 cycles each (1287 cycles in total)

    ze [W4++], W0			; [75..1233] W0 = ASCII code with upper byte of W4 being 0x00
    mov.b [W6++], W8			; [76..1234] W8 = cell background colour
    mov.b [W7++], W9			; [77..1235] W9 = cell foreground colour
    sl W0, #3, W0			; [78..1236] W0 = ASCI code * 8
    btsc W8, #6				; [79..1237] if the cell background colour is transparent, use the global background colour
    mov BackgroundColour, W8		; [80..1238]
    mov.b [W0 + W3], W0			; [81..1239] W0, lower byte = bitmask for foreground/background pixels
    btsc W9, #6				; [82..1240] if the cell foreground colour is transparent, use the global foreground colour
    mov ForegroundColour, W9		; [83..1241]

    mov.b W8, [W2++]			; [84..1242]
    btsc W0, #7				; [85..1243] if bitmask bit #7 is cleared/set, render the background/foreground colour
    mov.b W9, [W2 - 0x01]		; [86..1244]
    mov.b W8, [W2++]			; [87..1245]
    btsc W0, #6				; [88..1246] if bitmask bit #6 is cleared/set, render the background/foreground colour
    mov.b W9, [W2 - 0x01]		; [89..1247]
    mov.b W8, [W2++]			; [90..1248]
    btsc W0, #5				; [91..1249] if bitmask bit #5 is cleared/set, render the background/foreground colour
    mov.b W9, [W2 - 0x01]		; [92..1250]
    mov.b W8, [W2++]			; [93..1251]
    btsc W0, #4				; [94..1252] if bitmask bit #4 is cleared/set, render the background/foreground colour
    mov.b W9, [W2 - 0x01]		; [95..1253]
    mov.b W8, [W2++]			; [96..1254]
    btsc W0, #3				; [1..1255] if bitmask bit #3 is cleared/set, render the background/foreground colour
    mov.b W9, [W2 - 0x01]		; [2..1256]
    mov.b W8, [W2++]			; [3..1257]
    btsc W0, #2				; [4..1258] if bitmask bit #2 is cleared/set, render the background/foreground colour
    mov.b W9, [W2 - 0x01]		; [5..1259]
    mov.b W8, [W2++]			; [6..1260]
    btsc W0, #1				; [7..1261] if bitmask bit #1 is cleared/set, render the background/foreground colour
    mov.b W9, [W2 - 0x01]		; [8..1262]
    mov.b W8, [W2++]			; [9..1263]
    btsc W0, #0				; [10..1264] if bitmask bit #0 is cleared/set, render the background/foreground colour
_TeO000_01:
    mov.b W9, [W2 - 0x01]		; [11..1265]

    pop.d W8				; [1266-1267] pop W9 and W8 from stack
    pop.d W6				; [1268-1269] pop W7 and W6 from stack
    pop.d W4				; [1270-1271] pop W5 and W4 from stack
    pop.d W2				; [1272-1273] pop W3 and W2 from stack
    pop W1				; [1274] pop W1 from stack
_TeO000_02:
    inc W14, W14			; [1275] W14 = raster line #1 or #9
    pop W0				; [1276] pop W0 and RCOUNT from stack
    pop RCOUNT				; [1277]
    bclr IFS0, #OC1IF			; [1278-1279] clear the interrupt flag
    retfie				; [1280-5] return from interrupt - 6 clock cycles

; --- TEXT MODE: continue rendering pixel row #0 (raster line #1) without video output ---
_TextOut001:
    add #312, W2			; [76] W2 = pointer to WRITE render buffer
    add #39, W4				; [77] W4 = pointer to video RAM
    add #39, W6				; [78] W5 = pointer to background colour RAM
    add #39, W7				; [79] W7 = pointer to foreground colour RAM

    ze [W4++], W0			; [80] W0 = ASCII code with upper byte of W4 being 0x00
    mov.b [W6++], W8			; [81] W8 = cell background colour
    mov.b [W7++], W9			; [82] W9 = cell foreground colour
    sl W0, #3, W0			; [83] W0 = ASCII code * 8
    btsc W8, #6				; [84] if the cell background colour is transparent, use the global background colour
    mov BackgroundColour, W8		; [85]
    mov.b [W0 + W3], W0			; [86] W0, lower byte = bitmask for foreground/background pixels
    btsc W9, #6				; [87] if the cell foreground colour is transparent, use the global foreground colour
    mov ForegroundColour, W9		; [88]

    mov.b W8, [W2++]			; [89]
    btsc W0, #7				; [90] if bitmask bit #7 is cleared/set, render the background/foreground colour
    mov.b W9, [W2 - 0x01]		; [91]
    mov.b W8, [W2++]			; [92]
    btsc W0, #6				; [93] if bitmask bit #6 is cleared/set, render the background/foreground colour
    mov.b W9, [W2 - 0x01]		; [94]
    mov.b W8, [W2++]			; [95]
    btsc W0, #5				; [96] if bitmask bit #5 is cleared/set, render the background/foreground colour
    mov.b W9, [W2 - 0x01]		; [1]
    mov.b W8, [W2++]			; [2]
    btsc W0, #4				; [3] if bitmask bit #4 is cleared/set, render the background/foreground colour
    mov.b W9, [W2 - 0x01]		; [4]
    mov.b W8, [W2++]			; [5]
    btsc W0, #3				; [6] if bitmask bit #3 is cleared/set, render the background/foreground colour
    mov.b W9, [W2 - 0x01]		; [7]
    mov.b W8, [W2++]			; [8]
    btsc W0, #2				; [9] if bitmask bit #2 is cleared/set, render the background/foreground colour
    mov.b W9, [W2 - 0x01]		; [10]
    mov.b W8, [W2++]			; [11]
    btsc W0, #1				; [12] if bitmask bit #1 is cleared/set, render the background/foreground colour
    mov.b W9, [W2 - 0x01]		; [13]
    mov.b W8, [W2++]			; [14]
    btsc W0, #0				; [15] if bitmask bit #0 is cleared/set, render the background/foreground colour
    mov.b W9, [W2 - 0x01]		; [16]

; --- make the cursor blink ---
    mov.b CursorStatus, WREG		; [17]
    mov.b W0, W1			; [18]
    mov.b CursorDelay, WREG		; [19]
    dec.b W0, W0			; [20] decrement the cursor blink delay
    bra NZ, _TeO001_00			; [21-24]
    xor.b #0xff, W1			; [22] if the decremented delay is zero, toggle the status of the cursor and reset the delay
    mov #20, W0				; [23]
    nop					; [24]
_TeO001_00:
    mov.b WREG, CursorDelay		; [25]
    mov.b W1, W0			; [26]
    mov.b WREG, CursorStatus		; [27]

; --- render the cursor ---
    sub #320, W2			; [28] W2 = pointer to render buffer
    mov CursorColumn, W0		; [29] W0 = column number of cursor
    mov #BgColourRam, W6		; [30] W6 = pointer to background colour RAM
    mov #FgColourRam, W7		; [31] W7 = pointer to foreground colour RAM
    add W0, W6, W6			; [32] W6 = (adjusted) pointer to background colour RAM
    add W0, W7, W7			; [33] W7 = (adjusted) pointer to foreground colour RAM
    sl W0, #3, W0			; [34] W0 = cursor column number * 8
    add W0, W2, W2			; [35] addjust the pointer to the WRITE render buffer according to the cursor column number
    mov.b [W6], W3			; [36]
    btsc W3, #6				; [37] if the cell background colour is transparent, use the global background colour
    mov BackgroundColour, W3		; [38]
    mov.b [W7], W4			; [39]
    btsc W4, #6				; [40] if the cell foreground colour is transparent, use the global foreground colour
    mov ForegroundColour, W4		; [41]
    xor.b W3, W4, W0			; [42] W0, low = XOR value for rendering the cursor

    mov CursorRow, W4			; [43] W4 = cursor row number
    mov #0, W3				; [44]
    cpseq W3, W4			; [45] if cursor row number and current text row number are NOT equal...
    clr W0				; [46] ...set the cursor rendering XOR mask to '0'
    mov W2, W3				; [47] W3 = pointer to the WRITE render buffer
    and.b CursorStatus, WREG		; [48] cursor status - '0x00' (hidden) or '0xff' (visible)
    and.b CursorEnable, WREG		; [49] cursor enable flag - '0x00' (off) or '0xff' (on)

    repeat #7				; [50]
    xor.b W0, [W2++], [W3++]		; [51..58] render cursor pixels #0..#7

; --- render 16 sprites ---
    mov #8, W3				; [59] W3 = 8, used in the sprite loop
    mov #SpriteTable, W7		; [60] W7 = pointer to sprite table
    mov #(RenderBuffer0 + 8), W8	; [61] W8 = pointer to render buffer
    lsr W14, #1, W9			; [62] W9 = pixel row

    do #15, _TeO001_01			; [63-64] repeat 15 times - each loop takes 33 cycles (528 cycles in total)
    add W8, [W7++], W2			; [65..560] W2 = points at render buffer + X-coordinate of the sprite
    sub W9, [W7++], W4			; [66..561] W4 = pixel number MINUS Y-coordinate - W4 = [0..7] means visible
    and W4, #7, W6			; [67..562] make sure delta Y is [0..7]
    btsc W4, #15			; [68..563] if the result (W4) is negative...
    sub W8, #8, W2			; [69..564] ...set the X-coordinate to a position outside the visible part of the screen
    sl W6, #3, W6			; [70..565] W6 = sprite raster line number * 8 (8 bytes per line)
    add W6, [W7++], W6			; [71..566] W6 = (sprite pattern number * 64) + (sprite raster line number * 8)
    cpslt W4, W3			; [72..567] if the result (W4) is greater or equal '8'...
    sub W8, #8, W2			; [73..568] ...set the X-coordinate to a position outside the visible part of the screen
    mov.b [W6++], W0			; [74..569]
    btss W0, #6				; [75..570] if sprite pixel #0 is not transparent write it to the WRITE render buffer
    mov.b W0, [W2]			; [76..571]
    mov.b [W6++], W0			; [77..572]
    btss W0, #6				; [78..573] if sprite pixel #1 is not transparent write it to the WRITE render buffer
    mov.b W0, [W2 + 0x01]		; [79..574]
    mov.b [W6++], W0			; [80..575]
    btss W0, #6				; [81..576] if sprite pixel #2 is not transparent write it to the WRITE render buffer
    mov.b W0, [W2 + 0x02]		; [82..577]
    mov.b [W6++], W0			; [83..578]
    btss W0, #6				; [84..579] if sprite pixel #3 is not transparent write it to the WRITE render buffer
    mov.b W0, [W2 + 0x03]		; [85..580]
    mov.b [W6++], W0			; [86..581]
    btss W0, #6				; [87..582] if sprite pixel #4 is not transparent write it to the WRITE render buffer
    mov.b W0, [W2 + 0x04]		; [88..583]
    mov.b [W6++], W0			; [89..584]
    btss W0, #6				; [90..585] if sprite pixel #5 is not transparent write it to the WRITE render buffer
    mov.b W0, [W2 + 0x05]		; [91..586]
    mov.b [W6++], W0			; [92..587]
    btss W0, #6				; [93..588] if sprite pixel #6 is not transparent write it to the WRITE render buffer
    mov.b W0, [W2 + 0x06]		; [94..589]
    mov.b [W6++], W0			; [95..590]
    btss W0, #6				; [96..591] if sprite pixel #7 is not transparent write it to the WRITE render buffer
_TeO001_01:
    mov.b W0, [W2 + 0x07]		; [97..592]

; --- conditionally render the horizontal scrolling border ---
    btss HorScrollEnable, #0		; [593] if horizontal scrolling is enabled...
    bra _TeO001_02			; [594-597]
    mov #0x0000, W0			; [595]
    mov #(RenderBuffer0 + 8), W2	; [596] ...set four black pixels on the left border...
    mov W0, [W2++]			; [597]
    mov W0, [W2++]			; [598]
    mov #(RenderBuffer0 + 324), W2	; [599] ...and four black pixels on the right border
    mov W0, [W2++]			; [600]
    mov W0, [W2++]			; [601]
    
_TeO001_02:
    inc W14, W14			; [602] W14 = raster line #2 or #10

    pop.d W8				; [603-604] pop W9 and W8 from stack
    pop.d W6				; [605-606] pop W7 and W6 from stack
    pop.d W4				; [607-608] pop W5 and W4 from stack
    pop.d W2				; [609-610] pop W3 and W2 from stack
    pop.d W0				; [611-612] pop W1 and W0 from stack
    pop RCOUNT				; [613] pop RCOUNT and W0 from stack
    bclr IFS0, #OC1IF			; [614-615] clear the interrupt flag
    retfie				; [616-621] return from interrupt - 6 clock cycles

; --- TEXT MODE: render pixel line #1-#239 (with video output) during raster lines #2 to #479 ---
_TextOut002:
    mov #480, W0			; [44]
    cp W14, W0				; [45]
    bra GE, _TextOut480			; [46-49]

    repeat #4				; [47] wait for 6 cycles
    nop					; [48..52]
    
    push W1				; [53]
    push.d W2				; [54-55] push W2 and W3 on the stack
    push.d W4				; [56-57] push W4 and W5 on the stack
    push.d W6				; [58-59] push W6 and W7 on the stack
    push.d W8				; [60-61] push W8 and W9 on the stack
    mov VerScrollOff, W1		; [62]
    sub W1, #4, W1			; [63] W1 = verstical scroll offset - 4
    lsr W14, #1, W0			; [64] W0 = pixel row
    btsc VerScrollEnable, #0		; [65]
    add W0, W1, W0			; [66]
    and W0, #7, W1			; [67] W1 = pixel row number within text row [0..7]
    mov CharData, W3			; [68]
    add W1, W3, W3			; [69] W3 = pointer to character data (including pixel row offset)
    lsr W0, #3, W0			; [70] W0 = text row
    mov #40, W1				; [71]
    mul.uu W0, W1, W4			; [72] W4 = text row * 40
    btsc W14, #0			; [73] if it's an odd pixel row...
    add #29, W4				; [74] ...start rendering at character #29
    mov #VideoRam, W0			; [75]
    mov #BgColourRam, W6		; [76]
    mov #FgColourRam, W7		; [77]
    add W4, W6, W6			; [78] W6 = pointer to background colour RAM
    add W4, W7, W7			; [79] W7 = pointer to foreground colour RAM
    add W0, W4, W4			; [80] W4 = pointer to video RAM
    mov #(RenderBuffer0 + 8), W1	; [81] W1 = pointer to READ render buffer
    mov #(RenderBuffer1 + 8), W2	; [82] W2 = pointer to WRITE render buffer
    btss W14, #1			; [83]
    exch W1, W2				; [84]
    mov #4, W0				; [85]
    subr HorScrollOff, WREG		; [86] W0 = 4 - horizontal scroll offset [-3..4]
    btsc HorScrollEnable, #0		; [87]
    add W2, W0, W2			; [88] add W0 to W2 if horizontal scrolling is enabled
    mov #LATBH, W5			; [89] W5 = pointer to PORTB (high byte)
    btsc W14, #0			; [90]
    add #232, W2			; [91] render start for odd raster lines is horizontal pixel #232
    btsc W14, #0			; [92]
    bra _TextOut003			; [93-96]
    nop					; [94]
    nop					; [95]
    nop					; [96]

    mov.b [W1++], [W5]			; [1] output of pixel #0
    inc W14, W14			; [2]  W14 = raster line + 1
    do #28, _TeO002_00			; [3-4] loop through 29 characters - 44 cycles each (1276 cycles in total)

    mov.b [W1++], [W5]			; [5..1237] output of pixel #1..#309
    ze [W4++], W0			; [6..1238] W4 = ASCII code with upper byte of W4 being 0x00
    mov.b [W6++], W8			; [7..1239] W8 = cell background colour
    mov.b [W7++], W9			; [8..1240] W9 = cell foreground colour
    mov.b [W1++], [W5]			; [9..1241] output of pixel #2..#310
    sl W0, #3, W0			; [10..1242] W4 = ASCI code * 8
    btsc W8, #6				; [11..1243] if the cell background colour is transparent...
    mov BackgroundColour, W8		; [12..1244] ...use the global background colour
    mov.b [W1++], [W5]			; [13..1245] output of pixel #3..#311
    mov.b [W0 + W3], W0			; [14..1246] W0, lower byte = bitmask for foreground/background pixels
    btsc W9, #6				; [15..1247] if the cell foreground colour is "transparent"...
    mov ForegroundColour, W9		; [16..1248] ...use the global foreground colour
    mov.b [W1++], [W5]			; [17..1249] output of pixel #4..#312
    mov.b W8, [W2++]			; [18..1250] bit #7 background
    btsc W0, #7				; [19..1251]
    mov.b W9, [W2 - 0x01]		; [20..1252] bit #7 foreground
    mov.b [W1++], [W5]			; [21..1253] output of pixel #5..#313
    mov.b W8, [W2++]			; [22..1254] bit #6 background
    btsc W0, #6				; [23..1255]
    mov.b W9, [W2 - 0x01]		; [24..1256] bit #6 foreground
    mov.b [W1++], [W5]			; [25..1257] output of pixel #6..#314
    mov.b W8, [W2++]			; [26..1258] bit #5 background
    btsc W0, #5				; [27..1259]
    mov.b W9, [W2 - 0x01]		; [28..1260] bit #5 foreground
    mov.b [W1++], [W5]			; [29..1261] output of pixel #7..#315
    mov.b W8, [W2++]			; [30..1262] bit #4 background
    btsc W0, #4				; [31..1263]
    mov.b W9, [W2 - 0x01]		; [32..1264] bit #4 foreground
    mov.b [W1++], [W5]			; [33..1265] output of pixel #8..#316
    mov.b W8, [W2++]			; [34..1266] bit #3 background
    btsc W0, #3				; [35..1267]
    mov.b W9, [W2 - 0x01]		; [36..1268] bit #3 foreground
    mov.b [W1++], [W5]			; [37..1269] output of pixel #9..#317
    mov.b W8, [W2++]			; [38..1270] bit #2 background
    btsc W0, #2				; [39..1271]
    mov.b W9, [W2 - 0x01]		; [40..1272] bit #2 foreground
    mov.b [W1++], [W5]			; [41..1273] output of pixel #10..#318
    mov.b W8, [W2++]			; [42..1274] bit #1 background
    btsc W0, #1				; [43..1275]
    mov.b W9, [W2 - 0x01]		; [44..1276] bit #1 foreground
    mov.b [W1++], [W5]			; [45..1277] output of pixel #11..#319
    mov.b W8, [W2++]			; [46..1278] bit #0 background
    btsc W0, #0				; [47..1279]
_TeO002_00:
    mov.b W9, [W2 - 0x01]		; [48..1280] bit #0 foreground

    clr.b [W5]				; [1] output of black - first cycle of the FRONT PORCH
    pop.d W8				; [2-3] pop W9 and W8 from stack
    pop.d W6				; [4-5] pop W7 and W6 from stack
    pop.d W4				; [6-7] pop W5 and W4 from stack
    pop.d W2				; [8-9] pop W3 and W2 from stack
    pop.d W0				; [10-11] pop W1 and W0 from stack
    pop RCOUNT				; [12]
    bclr IFS0, #OC1IF			; [13-14]
    retfie				; [15-20] 6 clock cycles

_TextOut003:
    mov.b [W1++], [W5]			; [1] output of pixel #0
    nop					; [2]
    do #10, _TeO003_00			; [3-4] loop through 11 characters - 44 cycles each (484 cycles in total)

    mov.b [W1++], [W5]			; [5..445] output of pixel #1..#111
    ze [W4++], W0			; [6..446] W4 = ASCII code with upper byte of W4 being 0x00
    mov.b [W6++], W8			; [7..447] W8 = cell background colour
    mov.b [W7++], W9			; [8..448] W9 = cell foreground colour
    mov.b [W1++], [W5]			; [9..449] output of pixel #2..#112
    sl W0, #3, W0			; [10..450] W4 = ASCI code * 8
    btsc W8, #6				; [11..451] if the cell background colour is transparent...
    mov BackgroundColour, W8		; [12..452] ...use the global background colour
    mov.b [W1++], [W5]			; [13..453] output of pixel #3..#113
    mov.b [W0 + W3], W0			; [14..454] W0, lower byte = bitmask for foreground/background pixels
    btsc W9, #6				; [15..455] if the cell foreground colour is "transparent"...
    mov ForegroundColour, W9		; [16..456] ...use the global foreground colour
    mov.b [W1++], [W5]			; [17..457] output of pixel #4..#114
    mov.b W8, [W2++]			; [18..458] bit #7 background
    btsc W0, #7				; [19..459]
    mov.b W9, [W2 - 0x01]		; [20..460] bit #7 foreground
    mov.b [W1++], [W5]			; [21..461] output of pixel #5..#115
    mov.b W8, [W2++]			; [22..462] bit #6 background
    btsc W0, #6				; [23..463]
    mov.b W9, [W2 - 0x01]		; [24..464] bit #6 foreground
    mov.b [W1++], [W5]			; [25..465] output of pixel #6..#116
    mov.b W8, [W2++]			; [26..466] bit #5 background
    btsc W0, #5				; [27..467]
    mov.b W9, [W2 - 0x01]		; [28..468] bit #5 foreground
    mov.b [W1++], [W5]			; [29..469] output of pixel #7..#117
    mov.b W8, [W2++]			; [30..470] bit #4 background
    btsc W0, #4				; [31..471]
    mov.b W9, [W2 - 0x01]		; [32..472] bit #4 foreground
    mov.b [W1++], [W5]			; [33..473] output of pixel #8..#118
    mov.b W8, [W2++]			; [34..474] bit #3 background
    btsc W0, #3				; [35..475]
    mov.b W9, [W2 - 0x01]		; [36..476] bit #3 foreground
    mov.b [W1++], [W5]			; [37..477] output of pixel #9..#119
    mov.b W8, [W2++]			; [38..478] bit #2 background
    btsc W0, #2				; [39..479]
    mov.b W9, [W2 - 0x01]		; [40..480] bit #2 foreground
    mov.b [W1++], [W5]			; [41..481] output of pixel #10..#120
    mov.b W8, [W2++]			; [42..482] bit #1 background
    btsc W0, #1				; [43..483]
    mov.b W9, [W2 - 0x01]		; [44..484] bit #1 foreground
    mov.b [W1++], [W5]			; [45..485] output of pixel #11..#121
    mov.b W8, [W2++]			; [46..486] bit #0 background
    btsc W0, #0				; [47..487]
_TeO003_00:
    mov.b W9, [W2 - 0x01]		; [48..488] bit #0 foreground

; --- render the cursor ---
    mov.b [W1++], [W5]			; [489] output of pixel #122
    sub #40, W6				; [490] W6 = pointer to start of text row's background colour RAM
    sub #40, W7				; [491] W7 = pointer to start of text row's background colour RAM
    sub #320, W2			; [492] W2 = pointer to the start of the WRITE render buffer

    mov.b [W1++], [W5]			; [493] output of pixel #123
    mov CursorColumn, W0		; [494] W0 = column number of cursor
    add W0, W6, W6			; [495] W6 = (adjusted) pointer to background colour RAM
    add W0, W7, W7			; [496] W7 = (adjusted) pointer to foreground colour RAM

    mov.b [W1++], [W5]			; [497] output of pixel #124
    sl W0, #3, W0			; [498] W0 = cursor column number * 8
    add W0, W2, W2			; [499] W2 = (adjusted) pointer to the WRITE render buffer according to the cursor column number
    mov.b [W6], W3			; [500] W3 = local background colour at cursor position *** W6 is free now ***

    mov.b [W1++], [W5]			; [501] output of pixel #125
    btsc W3, #6				; [502] if the local background colour is transparent...
    mov BackgroundColour, W3		; [503] ...replace it with the global background colour
    mov.b [W7], W4			; [504] W4 = local foreground colour at cursor position *** W7 is free now ***

    mov.b [W1++], [W5]			; [505] output of pixel #126
    btsc W4, #6				; [506] if the local foreground colour is transparent...
    mov ForegroundColour, W4		; [507] ...replace it with the global foreground colour
    xor W3, W4, W0			; [508] W0, low = XOR value for rendering the cursor *** W3 and W4 are free now ***

    mov.b [W1++], [W5]			; [509] output of pixel #127
    mov CursorRow, W4			; [510]
    sl W4, #3, W4			; [511] W4 = cursor row number * 8
    mov VerScrollOff, W9		; [512] W9 = vertical scroll offset [0..7]

    mov.b [W1++], [W5]			; [513] output of pixel #128
    sub W9, #4, W9			; [514] W9 = vertical scroll offset - 4 [-4..3]
    btsc VerScrollEnable, #0		; [515] if vertical scrolling is enabled...
    sub W4, W9, W4			; [516] ...adjust the cursor's "Y-coordinate" to (cursor row number * 8) - vertical scroll offset + 4 *** W9 is free now ***

    mov.b [W1++], [W5]			; [517] output of pixel #129
    mov W2, W6				; [518] W6 = (saved adjusted) pointer to the WRITE render buffer according to the cursor column number
    lsr W14, #1, W9			; [519] W9 = pixel row number
    sub W9, W4, W4			; [520] W4 = pixel row number - cursor's "Y-coordinate", visible if [0..7]

    mov.b [W1++], [W5]			; [521] output of pixel #130
    btsc SR, #N				; [522] if the cursor's "Y-coordinate" is below the current pixel row...
    clr W0				; [523] ...don't render the cursor
    mov #8, W3				; [524] W3 = constant '8'

    mov.b [W1++], [W5]			; [525] output of pixel #131
    cpslt W4, W3			; [526] if the cursor's "Y-coordinate" is above the current pixel row...
    clr W0				; [527] ...don't render the cursor
    and.b CursorStatus, WREG		; [528] cursor status - '0x00' (hidden) or '0xff' (visible)

    mov.b [W1++], [W5]			; [529] output of pixel #132
    and.b CursorEnable, WREG		; [530] cursor enable flag - '0x00' (off) or '0xff' (on)
    xor.b W0, [W2++], [W6++]		; [531] cursor pixel #0
    xor.b W0, [W2++], [W6++]		; [532] cursor pixel #1

    mov.b [W1++], [W5]			; [533] output of pixel #133
    xor.b W0, [W2++], [W6++]		; [534] cursor pixel #2
    xor.b W0, [W2++], [W6++]		; [535] cursor pixel #3
    xor.b W0, [W2++], [W6++]		; [536] cursor pixel #4

    mov.b [W1++], [W5]			; [537] output of pixel #134
    xor.b W0, [W2++], [W6++]		; [538] cursor pixel #5
    xor.b W0, [W2++], [W6++]		; [539] cursor pixel #6
    xor.b W0, [W2++], [W6++]		; [540] cursor pixel #7

    mov.b [W1++], [W5]			; [541] output of pixel #135
    mov #(RenderBuffer1 + 8), W8	; [542] W8 = pointer to WRITE render buffer
    btss W14, #1			; [543]
    mov #(RenderBuffer0 + 8), W8	; [544] W8 = pointer to WRITE render buffer

; --- render 16 sprites ---
    mov.b [W1++], [W5]			; [545] output of pixel #136
    mov #SpriteTable, W7		; [546] W7 = base address of the sprite table
    do #15, _TeO003_01			; [547-548] repeat 16 times - each loop takes 44 cycles (704 cycles in total)
    
    mov.b [W1++], [W5]			; [549..1209] output of pixel #137..#302 from READ render buffer to PORTB
    add W8, [W7++], W2			; [550..1210] W2 = points at render buffer + X-coordinate of the sprite
    sub W9, [W7++], W4			; [551..1211] W4 = pixel number MINUS Y-coordinate - W4 = [0..7] means visible
    and W4, #7, W6			; [552..1212] make sure delta Y is [0..7]
    mov.b [W1++], [W5]			; [553..1213] output of pixel #138..#303 from READ render buffer to PORTB
    btsc W4, #15			; [554..1214] if the result (W4) is negative...
    sub W8, #8, W2			; [555..1215] ...set the X-coordinate to a position outside the visible part of the screen
    sl W6, #3, W6			; [556..1216] W6 = sprite raster line number * 8 (8 bytes per line)
    mov.b [W1++], [W5]			; [557..1217] output of pixel #139..#304 from READ render buffer to PORTB
    add W6, [W7++], W6			; [558..1218] W6 = (sprite pattern number * 64) + (sprite raster line number * 8)
    cpslt W4, W3			; [559..1219] if the result (W4) is greater or equal '8'...
    sub W8, #8, W2			; [560..1220] ...set the X-coordinate to a position outside the visible part of the screen
    mov.b [W1++], [W5]			; [561..1221] output of pixel #140..#305 from READ render buffer to PORTB
    mov.b [W6++], W0			; [562..1222] W0 = SPRITE pixel #0
    btss W0, #6				; [563..1223] if the pixel colour is NOT transparent...
    mov.b W0, [W2]			; [564..1224] ...write it to the render buffer
    mov.b [W1++], [W5]			; [565..1225] output of pixel #141..#306 from READ render buffer to PORTB
    mov.b [W6++], W0			; [566..1226] W0 = SPRITE pixel #1
    btss W0, #6				; [567..1227] if the pixel colour is NOT transparent...
    mov.b W0, [W2 + 0x01]		; [568..1228] ...write it to the render buffer
    mov.b [W1++], [W5]			; [569..1229] output of pixel #142..#307 from READ render buffer to PORTB
    mov.b [W6++], W0			; [570..1230] W0 = SPRITE pixel #2
    btss W0, #6				; [571..1231] if the pixel colour is NOT transparent...
    mov.b W0, [W2 + 0x02]		; [572..1232] ...write it to the render buffer
    mov.b [W1++], [W5]			; [573..1233] output of pixel #143..#308 from READ render buffer to PORTB
    mov.b [W6++], W0			; [574..1234] W0 = SPRITE pixel #3
    btss W0, #6				; [575..1235] if the pixel colour is NOT transparent...
    mov.b W0, [W2 + 0x03]		; [576..1236] ...write it to the render buffer
    mov.b [W1++], [W5]			; [577..1237] output of pixel #144..#309 from READ render buffer to PORTB
    mov.b [W6++], W0			; [578..1238] W0 = SPRITE pixel #4
    btss W0, #6				; [579..1239] if the pixel colour is NOT transparent...
    mov.b W0, [W2 + 0x04]		; [580..1240] ...write it to the render buffer
    mov.b [W1++], [W5]			; [581..1241] output of pixel #145..#310 from READ render buffer to PORTB
    mov.b [W6++], W0			; [582..1242] W0 = SPRITE pixel #5
    btss W0, #6				; [583..1243] if the pixel colour is NOT transparent...
    mov.b W0, [W2 + 0x05]		; [584..1244] ...write it to the render buffer
    mov.b [W1++], [W5]			; [585..1245] output of pixel #146..#311 from READ render buffer to PORTB
    mov.b [W6++], W0			; [586..1246] W0 = SPRITE pixel #6
    btss W0, #6				; [587..1247] if the pixel colour is NOT transparent...
    mov.b W0, [W2 + 0x06]		; [588..1248] ...write it to the render buffer
    mov.b [W1++], [W5]			; [589..1249] output of pixel #147..#312 from READ render buffer to PORTB
    mov.b [W6++], W0			; [590..1250] W0 = SPRITE pixel #7
    btss W0, #6				; [591..1251] if the pixel colour is NOT transparent...
_TeO003_01:
    mov.b W0, [W2 + 0x07]		; [592..1252] ...write it to the render buffer

; --- conditionally render the horizontal scrolling border ---
    mov.b [W1++], [W5]			; [1253] output of pixel #313
    mov W8, W2				; [1254] W2 and W8 are pointing at the start of the WRITE render buffer
    nop					; [1255]
    nop					; [1256]
    mov.b [W1++], [W5]			; [1257] output of pixel #314 from READ render buffer to PORTB
    setm W0				; [1258] if horizontal scrolling is DISABLED, W0 is '0xffff'
    btsc HorScrollEnable, #0		; [1259]
    clr W0				; [1260] if horizontal scrolling is ENABLED, W0 is '0x0000'
    mov.b [W1++], [W5]			; [1261] output of pixel #315 from READ render buffer to PORTB
    and W0, [W2++], [W8++]		; [1262] set the leftmost four pixels to the colour black...
    and W0, [W2++], [W8++]		; [1263] ...if horizontal scrolling is ENABLED
    add #312, W2			; [1264] set the read pointer into the WRITE render buffer to the four rightmost pixels
    mov.b [W1++], [W5]			; [1265] output of pixel #316 from READ render buffer to PORTB
    add #312, W8			; [1266] set the write pointer into the WRITE render buffer to the four rightmost pixels
    and W0, [W2++], [W8++]		; [1267] set the rightmost four pixels to the colour black...
    and W0, [W2++], [W8++]		; [1268] ...if horizontal scrolling is ENABLED

; --- output the remaining pixels ---
    mov.b [W1++], [W5]			; [1269] output of pixel #317 from READ render buffer to PORTB
    inc W14, W14			; [1270]
    do #1, _TeO003_02			; [1271-1272] loop through 2 pixels
    mov.b [W1++], [W5]			; [1273..1277] output of pixel #318..#319 from READ render buffer to PORTB
    nop					; [1274..1278]
    nop					; [1275..1279]
_TeO003_02:
    nop					; [1276..1280]

    clr.b [W5]				; [1] output of black - first cycle of the FRONT PORCH
    pop.d W8				; [2-3] pop W9 and W8 from stack
    pop.d W6				; [4-5] pop W7 and W6 from stack
    pop.d W4				; [6-7] pop W5 and W4 from stack
    pop.d W2				; [8-9] pop W3 and W2 from stack
    pop.d W0				; [10-11] pop W1 and W0 from stack
    pop RCOUNT				; [12]
    bclr IFS0, #OC1IF			; [13-14]
    retfie				; [15-20] 6 clock cycles

; ***** GRAPHICS MODE: render pixel line #0 (without video output) during raster lines #0/#8 and #1/#9 *****
_TilesOut000:
    nop					; [39]
    nop					; [40]
    mov #2, W0				; [41] if vertical scrolling is disabled, show the top-most 8 raster lines (4 pixel rows)
    btsc VerScrollEnable, #0		; [42] if vertical scrolling is enabled...
    mov #10, W0				; [43] ...don't show the bottom-most 8 raster lines (4 pixel rows)
    cp W14, W0				; [44]
    bra GE, _TilesOut002		; [45-48]

    btss VerScrollEnable, #0		; [46] if vertical scrolling is NOT enabled...
    bra _TiO000_00			; [47-50] ...jump directly to the rendering part, ...
    nop					; [48] *** REMOVE *** ...otherwise check if the current raster line is [0..7], ...
    cp W14, #8				; [49] ...which is in the vertical blanking in case of vertical scrolling
    bra LT, _TiO000_03			; [50-53] if it is vertical blanking, skip the rendering part and end immediately
; *** CORRECT CYCLES FROM HERE ON - NOT _TilesOut002, it's O.K. ***

_TiO000_00:
    push W1				; [49] push W1 to the stack
    push.d W2				; [50-51] push W2 and W3 on the stack
    push.d W4				; [52-53] push W4 and w5 on the stack
    push.d W6				; [54-55] push W6 and W7 on the stack
    push.d W8				; [56-57] push W8 and W9 on the stack

    mov #(RenderBuffer0 + 8), W2	; [58] W2 = pointer to write render buffer
    mov #SpriteTable, W7		; [59] W7 = base address of the sprite table
    mov W2, W8				; [60] W8 = pointer to write render buffer (reload value)
    lsr W14, #1, W9			; [61] W9 is number of pixel row
    btsc W14, #0			; [62] if raster line #1 or #9...
    bra _TilesOut001			; [63-66] ...branch to sprite rendering only 

    mov #VideoRam, W1			; [64] W1 = pointer to video RAM
    mov #4, W0				; [65]
    subr HorScrollOff, WREG		; [66] W0 = (4 - horizontal scroll offset) [-3..4]
    btsc HorScrollEnable, #0		; [67] if horizontal scrolling is enabled...
    add W2, W0, W2			; [68] ...adjust pointer to write render buffer (W2)
    mov VerScrollOff, W0		; [69] W0 = vertical scroll offset [0..7]
    sl W0, #3, W0			; [70] W0 = (vertical scroll offset * 8) {0, 8, 16, 24, 32, 40, 48, 56}
    mov TileData, W3			; [71] W3 = pointer to tile data
    btsc VerScrollEnable, #0		; [72] if vertical scrolling is enabled...
    add W0, W3, W3			; [73] ...adjust pointer to tile data (W3)

; --- background rendering WITHOUT VGA output - uses W0..W3 - bytewise pixel copy to allow odd write addresses ---
    do #39, _TiO000_01			; [74-75] loop 40 times - each loop takes 12 cycles
    ze [W1++], W0			; [76..544] W0 = tile number (byte read from video RAM and zero extend to word)
    sl W0, #6, W0			; [77..545] W0 = tile number * 64
    add W0, W3, W0			; [78..546] W0 = pointer into tile data
    nop					; [79..547] can be removed, but then there will be a 1 cycle stall instead
    mov.b [W0++], [W2++]		; [80..548] copy tile pixel #0 to write render buffer
    mov.b [W0++], [W2++]		; [81..549] copy tile pixel #1 to write render buffer
    mov.b [W0++], [W2++]		; [82..550] copy tile pixel #2 to write render buffer
    mov.b [W0++], [W2++]		; [83..551] copy tile pixel #3 to write render buffer
    mov.b [W0++], [W2++]		; [84..552] copy tile pixel #4 to write render buffer
    mov.b [W0++], [W2++]		; [85..553] copy tile pixel #5 to write render buffer
    mov.b [W0++], [W2++]		; [86..554] copy tile pixel #6 to write render buffer
_TiO000_01:
    mov.b [W0++], [W2++]		; [87..555] copy tile pixel #7 to write render buffer

; --- sprite rendering (21 sprites) WITHOUT VGA output ---
    mov #8, W3				; [556] W3 = 8, used in the sprite loop
    do #20, _TiO000_02			; [557-558] repeat 21 times - each loop takes 33 cycles
    add W8, [W7++], W2			; [559..1219] W2 = points at render buffer + X-coordinate of the sprite
    sub W9, [W7++], W4			; [560..1220] W4 = pixel number MINUS Y-coordinate - W4 = [0..7] means visible
    and W4, #7, W6			; [561..1221] make sure delta Y is [0..7]
    btsc W4, #15			; [562..1222] if the result (W4) is negative...
    sub W8, #8, W2			; [563..1223] ...set the X-coordinate to a position outside the visible part of the screen
    sl W6, #3, W6			; [564..1224] W6 = sprite raster line number * 8 (8 bytes per line)
    add W6, [W7++], W6			; [565..1225] W6 = (sprite pattern number * 64) + (sprite raster line number * 8)
    cpslt W4, W3			; [566..1226] if the result (W4) is greater or equal '8'...
    sub W8, #8, W2			; [567..1227] ...set the X-coordinate to a position outside the visible part of the screen
    mov.b [W6++], W0			; [568..1228]
    btss W0, #6				; [569..1229] if sprite pixel #0 is not transparent write it to the WRITE render buffer
    mov.b W0, [W2]			; [570..1230]
    mov.b [W6++], W0			; [571..1231]
    btss W0, #6				; [572..1232] if sprite pixel #1 is not transparent write it to the WRITE render buffer
    mov.b W0, [W2 + 0x01]		; [573..1233]
    mov.b [W6++], W0			; [574..1234]
    btss W0, #6				; [575..1235] if sprite pixel #2 is not transparent write it to the WRITE render buffer
    mov.b W0, [W2 + 0x02]		; [576..1236]
    mov.b [W6++], W0			; [577..1237]
    btss W0, #6				; [578..1238] if sprite pixel #3 is not transparent write it to the WRITE render buffer
    mov.b W0, [W2 + 0x03]		; [579..1239]
    mov.b [W6++], W0			; [580..1240]
    btss W0, #6				; [581..1241] if sprite pixel #4 is not transparent write it to the WRITE render buffer
    mov.b W0, [W2 + 0x04]		; [582..1242]
    mov.b [W6++], W0			; [583..1243]
    btss W0, #6				; [584..1244] if sprite pixel #5 is not transparent write it to the WRITE render buffer
    mov.b W0, [W2 + 0x05]		; [585..1245]
    mov.b [W6++], W0			; [586..1246]
    btss W0, #6				; [587..1247] if sprite pixel #6 is not transparent write it to the WRITE render buffer
    mov.b W0, [W2 + 0x06]		; [588..1248]
    mov.b [W6++], W0			; [589..1249]
    btss W0, #6				; [590..1250] if sprite pixel #7 is not transparent write it to the WRITE render buffer
_TiO000_02:
    mov.b W0, [W2 + 0x07]		; [591..1251]

    pop.d W8				; [1252-1253] pop W9 and W8 from stack
    pop.d W6				; [1254-1255] pop W7 and W6 from stack
    pop.d W4				; [1256-1257] pop W5 and W4 from stack
    pop.d W2				; [1258-1259] pop W3 and W2 from stack
    pop W1				; [1260] pop W1 from stack
_TiO000_03:
    inc W14, W14			; [1261] W14 = raster line #1 or #9
    pop W0				; [1262] pop W0 from stack
    pop RCOUNT				; [1263] restore the REPEAT count
    bclr IFS0, #OC1IF			; [1264-1265] clear the OC1 interrupt flag
    retfie				; [1266-1271] 6 clock cycles

; --- sprite rendering (11 sprites) WITHOUT VGA output ---
_TilesOut001:
    add #126, W7			; [67] W7 = base address of the sprite table - starting with sprite #19
    mov #8, W3				; [68] W3 = 8, used in the sprite loop
    do #10, _TiO001_00			; [69-70] repeat 11 times - each loop takes 33 cycles
    add W8, [W7++], W2			; [71..401] W2 = points at render buffer + X-coordinate of the sprite
    sub W9, [W7++], W4			; [72..402] W4 = pixel number MINUS Y-coordinate - W4 = [0..7] means visible
    and W4, #7, W6			; [73..403] make sure delta Y is [0..7]
    btsc W4, #15			; [74..404] if the result (W4) is negative...
    sub W8, #8, W2			; [75..405] ...set the X-coordinate to a position outside the visible part of the screen
    sl W6, #3, W6			; [76..406] W6 = sprite raster line number * 8 (8 bytes per line)
    add W6, [W7++], W6			; [77..407] W6 = (sprite pattern number * 64) + (sprite raster line number * 8)
    cpslt W4, W3			; [78..408] if the result (W4) is greater or equal '8'...
    sub W8, #8, W2			; [79..409] ...set the X-coordinate to a position outside the visible part of the screen
    mov.b [W6++], W0			; [80..410]
    btss W0, #6				; [81..411] if sprite pixel #0 is not transparent write it to the WRITE render buffer
    mov.b W0, [W2]			; [82..412]
    mov.b [W6++], W0			; [83..413]
    btss W0, #6				; [84..414] if sprite pixel #1 is not transparent write it to the WRITE render buffer
    mov.b W0, [W2 + 0x01]		; [85..415]
    mov.b [W6++], W0			; [86..416]
    btss W0, #6				; [87..417] if sprite pixel #2 is not transparent write it to the WRITE render buffer
    mov.b W0, [W2 + 0x02]		; [88..418]
    mov.b [W6++], W0			; [89..419]
    btss W0, #6				; [90..420] if sprite pixel #3 is not transparent write it to the WRITE render buffer
    mov.b W0, [W2 + 0x03]		; [91..421]
    mov.b [W6++], W0			; [92..422]
    btss W0, #6				; [93..423] if sprite pixel #4 is not transparent write it to the WRITE render buffer
    mov.b W0, [W2 + 0x04]		; [94..424]
    mov.b [W6++], W0			; [95..425]
    btss W0, #6				; [96..426] if sprite pixel #5 is not transparent write it to the WRITE render buffer
    mov.b W0, [W2 + 0x05]		; [97..427]
    mov.b [W6++], W0			; [98..428]
    btss W0, #6				; [99..429] if sprite pixel #6 is not transparent write it to the WRITE render buffer
    mov.b W0, [W2 + 0x06]		; [100..430]
    mov.b [W6++], W0			; [101..431]
    btss W0, #6				; [102..432] if sprite pixel #7 is not transparent write it to the WRITE render buffer
_TiO001_00:
    mov.b W0, [W2 + 0x07]		; [103..433]

    btss HorScrollEnable, #0		; [434] if horizontal scrolling is enabled...
    bra _TiO001_01			; [435]
    clr [W8++]				; [436] ...blank the four leftmost pixels [0..3]...
    clr [W8++]				; [437]
    add #312, W8			; [438]
    clr [W8++]				; [439] ...and the four rightmost pixels [316..319]
    clr [W8++]				; [440]
    
_TiO001_01:
    inc W14, W14			; [441] W14 = raster line #2 or #10

    pop.d W8				; [442-443] pop W9 and W8 from stack
    pop.d W6				; [444-445] pop W7 and W6 from stack
    pop.d W4				; [446-447] pop W5 and W4 from stack
    pop.d W2				; [448-449] pop W3 and W2 from stack
    pop.d W0				; [450-451] pop W1 and W0 from stack
    pop RCOUNT				; [452] restore the REPEAT count
    bclr IFS0, #OC1IF			; [453-454] clear the OC1 interrupt flag
    retfie				; [455-460] 6 clock cycles

; --- GRAPHICS MODE: render pixel line #1-#239 (with video output) during raster lines #2 to #479 ---
_TilesOut002:
    mov #480, W0			; [49]
    cp W14, W0				; [50]
    bra GE, _TilesOut480		; [51-54]

    repeat #5				; [52] 7 cycles delay
    nop					; [53..58]

    push W1				; [59] push W1 on the stack
    push.d W2				; [60-61] push W2 and W3 on the stack
    push.d W4				; [62-63] push W4 and W5 on the stack
    push.d W6				; [64-65] push W6 and W7 on the stack
    push.d W8				; [66-67] push W8 and W9 on the stack

    mov #(RenderBuffer0 + 8), W1	; [68] W1 = pointer to READ render buffer
    mov #(RenderBuffer1 + 8), W2	; [69] W2 = pointer to WRITE render buffer
    btss W14, #1			; [70] if it's an even pixel row number...
    exch W1, W2				; [71] ...render buffer #0 is the WRITE buffer and render buffer #1 is the READ buffer
    mov W2, W8				; [72] W8 = copy of pointer to WRITE render buffer
    lsr W14, #1, W9			; [73] W9 is number of pixel row

    btsc W14, #0			; [74] if it's an odd raster line...
    bra _TilesOut003			; [75-78] ...branch to sprite rendering only 

    mov VerScrollOff, W5		; [76]
    sub W5, #4, W5			; [77] W5 = vertical scroll offset - 4 [-4..3]
    lsr W14, #1, W0			; [78] W0 = pixel row
    btsc VerScrollEnable, #0		; [79] if vertical scrolling is enabled...
    add W0, W5, W0			; [80] ...adjust the pixel row number
    and W0, #7, W5			; [81] W5 = pixel row number within tile row [0..7]
    sl W5, #3, W5			; [82] W5 = (pixel row * 8) {0, 8, 16, 24, 32, 40, 48, 56}
    mov TileData, W3			; [83]
    add W5, W3, W3			; [84] W3 = pointer to character data (including pixel row offset)
    lsr W0, #3, W0			; [85] W0 = tile row number
    mov #40, W6				; [86]
    mul.uu W0, W6, W4			; [87] W4 = tile row * 40
    mov #VideoRam, W0			; [88]
    add W0, W4, W4			; [89] W4 = pointer to video RAM
    mov #4, W0				; [90]
    subr HorScrollOff, WREG		; [91] W0 = 4 - horizontal scroll offset [-3..4]
    btsc HorScrollEnable, #0		; [92] if horizontal scrolling is enabled...
    add W2, W0, W2			; [93] ...adjust the pointer to the WRITE render buffer
    mov #LATBH, W5			; [94] W5 = pointer to high byte of PORTB
    
; --- background rendering (40 tiles) WITH VGA output ---
    do #39, _TiO002_00			; [95-96] repeat 40 times - each loop takes 16 cycles

    mov.b [W1++], [W5]			; [1..625] output of pixel #0..156# - from READ render buffer to PORTB
    ze [W4++], W0			; [2..626] W0 = tile number (byte read from video RAM and zero extend to word)
    sl W0, #6, W0			; [3..627] W0 = tile number * 64
    add W0, W3, W0			; [4..628] W0 = pointer into tile data

    mov.b [W1++], [W5]			; [5..629] output of pixel #1..157# - from READ render buffer to PORTB
    mov.b [W0++], [W2++]		; [6..630] copy tile pixel #0 to WRITE render buffer
    mov.b [W0++], [W2++]		; [7..631] copy tile pixel #1 to WRITE render buffer
    mov.b [W0++], [W2++]		; [8..632] copy tile pixel #2 to WRITE render buffer

    mov.b [W1++], [W5]			; [9..633] output of pixel #2..158# - from READ render buffer to PORTB
    mov.b [W0++], [W2++]		; [10..634] copy tile pixel #3 to WRITE render buffer
    mov.b [W0++], [W2++]		; [11..635] copy tile pixel #4 to WRITE render buffer
    mov.b [W0++], [W2++]		; [12..636] copy tile pixel #5 to WRITE render buffer

    mov.b [W1++], [W5]			; [13..637] output of pixel #3..159# - from READ render buffer to PORTB
    mov.b [W0++], [W2++]		; [14..638] copy tile pixel #6 to WRITE render buffer
    mov.b [W0++], [W2++]		; [15..639] copy tile pixel #7 to WRITE render buffer
_TiO002_00:
    mov #SpriteTable, W7		; [16..640] W7 = base address of the sprite table

; --- sprite rendering (14 sprites) WITH VGA output ---
    mov.b [W1++], [W5]			; [641] output of pixel #160
    mov #8, W3				; [642] W3 = constant '8', used in loop
    do #13, _TiO002_01			; [643-644] repeat 14 times - each loop takes 44 cycles

    mov.b [W1++], [W5]			; [645..1217] output of pixel #161..#304 from READ render buffer to PORTB
    add W8, [W7++], W2			; [646..1218] W2 = points at render buffer + X-coordinate of the sprite
    sub W9, [W7++], W4			; [647..1219] W4 = pixel number MINUS Y-coordinate - W4 = [0..7] means visible
    and W4, #7, W6			; [648..1220] make sure delta Y is [0..7]

    mov.b [W1++], [W5]			; [649..1221] output of pixel #162..#305 from READ render buffer to PORTB
    btsc W4, #15			; [650..1222] if the result (W4) is negative...
    sub W8, #8, W2			; [651..1223] ...set the X-coordinate to a position outside the visible part of the screen
    sl W6, #3, W6			; [652..1224] W6 = sprite raster line number * 8 (8 bytes per line)

    mov.b [W1++], [W5]			; [653..1225] output of pixel #163..#306 from READ render buffer to PORTB
    add W6, [W7++], W6			; [654..1226] W6 = (sprite pattern number * 64) + (sprite raster line number * 8)
    cpslt W4, W3			; [655..1227] if the result (W4) is greater or equal '8'...
    sub W8, #8, W2			; [656..1228] ...set the X-coordinate to a position outside the visible part of the screen

    mov.b [W1++], [W5]			; [657..1229] output of pixel #164..#307 from READ render buffer to PORTB
    mov.b [W6++], W0			; [658..1230] W0 = SPRITE pixel #0
    btss W0, #6				; [659..1231] if the pixel colour is NOT transparent...
    mov.b W0, [W2]			; [660..1232] ...write it to the render buffer

    mov.b [W1++], [W5]			; [661..1233] output of pixel #165..#308 from READ render buffer to PORTB
    mov.b [W6++], W0			; [662..1234] W0 = SPRITE pixel #1
    btss W0, #6				; [663..1235] if the pixel colour is NOT transparent...
    mov.b W0, [W2 + 0x01]		; [664..1236] ...write it to the render buffer

    mov.b [W1++], [W5]			; [665..1237] output of pixel #166..#309 from READ render buffer to PORTB
    mov.b [W6++], W0			; [666..1238] W0 = SPRITE pixel #2
    btss W0, #6				; [667..1239] if the pixel colour is NOT transparent...
    mov.b W0, [W2 + 0x02]		; [668..1240] ...write it to the render buffer

    mov.b [W1++], [W5]			; [669..1241] output of pixel #167..#310 from READ render buffer to PORTB
    mov.b [W6++], W0			; [670..1242] W0 = SPRITE pixel #3
    btss W0, #6				; [671..1243] if the pixel colour is NOT transparent...
    mov.b W0, [W2 + 0x03]		; [672..1244] ...write it to the render buffer

    mov.b [W1++], [W5]			; [673..1245] output of pixel #168..#311 from READ render buffer to PORTB
    mov.b [W6++], W0			; [674..1246] W0 = SPRITE pixel #4
    btss W0, #6				; [675..1247] if the pixel colour is NOT transparent...
    mov.b W0, [W2 + 0x04]		; [676..1248] ...write it to the render buffer

    mov.b [W1++], [W5]			; [677..1249] output of pixel #169..#312 from READ render buffer to PORTB
    mov.b [W6++], W0			; [678..1250] W0 = SPRITE pixel #5
    btss W0, #6				; [679..1251] if the pixel colour is NOT transparent...
    mov.b W0, [W2 + 0x05]		; [680..1252] ...write it to the render buffer

    mov.b [W1++], [W5]			; [681..1253] output of pixel #170..#313 from READ render buffer to PORTB
    mov.b [W6++], W0			; [682..1254] W0 = SPRITE pixel #6
    btss W0, #6				; [683..1255] if the pixel colour is NOT transparent...
    mov.b W0, [W2 + 0x06]		; [684..1256] ...write it to the render buffer

    mov.b [W1++], [W5]			; [685..1257] output of pixel #171..#314 from READ render buffer to PORTB
    mov.b [W6++], W0			; [686..1258] W0 = SPRITE pixel #7
    btss W0, #6				; [687..1259] if the pixel colour is NOT transparent...
_TiO002_01:
    mov.b W0, [W2 + 0x07]		; [688..1260] ...write it to the render buffer

    mov.b [W1++], [W5]			; [1261] output of pixel #315 from READ render buffer to PORTB
    inc W14, W14			; [1262] W14 = raster line + 1
    do #3, _TiO002_02			; [1263-1264]

    mov.b [W1++], [W5]			; [1265..1277] output of pixel #316..#319 from READ render buffer to PORTB
    nop					; [1266..1278]
    nop					; [1267..1279]
_TiO002_02:
    nop					; [1268..1280]

    clr.b [W5]				; [1] output of black - first cycle of the FRONT PORCH
    pop.d W8				; [2-3] pop W9 and W8 from stack
    pop.d W6				; [4-5] pop W7 and W6 from stack
    pop.d W4				; [6-7] pop W5 and W4 from stack
    pop.d W2				; [8-9] pop W3 and W2 from stack
    pop.d W0				; [10-11] pop W1 and W0 from stack
    pop RCOUNT				; [12]
    bclr IFS0, #OC1IF			; [13-14]
    retfie				; [15-20] 6 clock cycles

; --- W1, W8 and W9 have already been initialised ---
_TilesOut003:
    repeat #11				; [79] 13 cycles delay
    nop					; [80..91]

    mov #8, W3				; [92] W3 = constant '8', used in the sprite loop
    mov #LATBH, W5			; [93] W5 = pointer to high byte of PORTB
    mov #(SpriteTable + 84), W7		; [94] W7 = base address of the sprite table, start at sprite #14

; --- sprite rendering (18 sprites) WITH VGA output ---
    do #17, _TiO003_00			; [95-96] repeat 18 times - each loop takes 44 cycles
    
    mov.b [W1++], [W5]			; [1..749] output of pixel #0..#187 from READ render buffer to PORTB
    add W8, [W7++], W2			; [2..750] W2 = points at render buffer + X-coordinate of the sprite
    sub W9, [W7++], W4			; [3..751] W4 = pixel number MINUS Y-coordinate - W4 = [0..7] means visible
    and W4, #7, W6			; [4..752] make sure delta Y is [0..7]
    
    mov.b [W1++], [W5]			; [5..753] output of pixel #1..#188 from READ render buffer to PORTB
    btsc W4, #15			; [6..754] if the result (W4) is negative...
    sub W8, #8, W2			; [7..755] ...set the X-coordinate to a position outside the visible part of the screen
    sl W6, #3, W6			; [8..756] W6 = sprite raster line number * 8 (8 bytes per line)

    mov.b [W1++], [W5]			; [9..757] output of pixel #2..#189 from READ render buffer to PORTB
    add W6, [W7++], W6			; [10..758] W6 = (sprite pattern number * 64) + (sprite raster line number * 8)
    cpslt W4, W3			; [11..759] if the result (W4) is greater or equal '8'...
    sub W8, #8, W2			; [12..760] ...set the X-coordinate to a position outside the visible part of the screen

    mov.b [W1++], [W5]			; [13..761] output of pixel #3..#190 from READ render buffer to PORTB
    mov.b [W6++], W0			; [14..762] W0 = SPRITE pixel #0
    btss W0, #6				; [15..763] if the pixel colour is NOT transparent...
    mov.b W0, [W2]			; [16..764] ...write it to the render buffer

    mov.b [W1++], [W5]			; [17..765] output of pixel #4..#191 from READ render buffer to PORTB
    mov.b [W6++], W0			; [18..766] W0 = SPRITE pixel #1
    btss W0, #6				; [19..767] if the pixel colour is NOT transparent...
    mov.b W0, [W2 + 0x01]		; [20..768] ...write it to the render buffer

    mov.b [W1++], [W5]			; [21..769] output of pixel #5..#192 from READ render buffer to PORTB
    mov.b [W6++], W0			; [22..770] W0 = SPRITE pixel #2
    btss W0, #6				; [23..771] if the pixel colour is NOT transparent...
    mov.b W0, [W2 + 0x02]		; [24..772] ...write it to the render buffer

    mov.b [W1++], [W5]			; [25..773] output of pixel #6..#193 from READ render buffer to PORTB
    mov.b [W6++], W0			; [26..774] W0 = SPRITE pixel #3
    btss W0, #6				; [27..775] if the pixel colour is NOT transparent...
    mov.b W0, [W2 + 0x03]		; [28..776] ...write it to the render buffer

    mov.b [W1++], [W5]			; [29..777] output of pixel #7..#194 from READ render buffer to PORTB
    mov.b [W6++], W0			; [30..778] W0 = SPRITE pixel #4
    btss W0, #6				; [31..779] if the pixel colour is NOT transparent...
    mov.b W0, [W2 + 0x04]		; [32..780] ...write it to the render buffer

    mov.b [W1++], [W5]			; [33..781] output of pixel #8..#195 from READ render buffer to PORTB
    mov.b [W6++], W0			; [34..782] W0 = SPRITE pixel #5
    btss W0, #6				; [35..783] if the pixel colour is NOT transparent...
    mov.b W0, [W2 + 0x05]		; [36..784] ...write it to the render buffer

    mov.b [W1++], [W5]			; [37..785] output of pixel #9..#196 from READ render buffer to PORTB
    mov.b [W6++], W0			; [38..786] W0 = SPRITE pixel #6
    btss W0, #6				; [39..787] if the pixel colour is NOT transparent...
    mov.b W0, [W2 + 0x06]		; [40..788] ...write it to the render buffer

    mov.b [W1++], [W5]			; [41..789] output of pixel #10..#197 from READ render buffer to PORTB
    mov.b [W6++], W0			; [42..790] W0 = SPRITE pixel #7
    btss W0, #6				; [43..791] if the pixel colour is NOT transparent...
_TiO003_00:
    mov.b W0, [W2 + 0x07]		; [44..792] ...write it to the render buffer

; --- conditionally render the horizontal scrolling border ---
    mov.b [W1++], [W5]			; [793] output of pixel #198
    mov W8, W2				; [794] W2 and W8 are pointing at the start of the WRITE render buffer
    inc W14, W14			; [795] W14 = raster line + 1
    nop					; [796]

    mov.b [W1++], [W5]			; [797] output of pixel #199 from READ render buffer to PORTB
    setm W0				; [798] if horizontal scrolling is DISABLED, W0 is '0xffff'
    btsc HorScrollEnable, #0		; [799]
    clr W0				; [800] if horizontal scrolling is ENABLED, W0 is '0x0000'

    mov.b [W1++], [W5]			; [801] output of pixel #200 from READ render buffer to PORTB
    and W0, [W2++], [W8++]		; [802] set the leftmost four pixels to the colour black...
    and W0, [W2++], [W8++]		; [803] ...if horizontal scrolling is ENABLED
    add #312, W2			; [804] set the read pointer into the WRITE render buffer to the four rightmost pixels

    mov.b [W1++], [W5]			; [805] output of pixel #201 from READ render buffer to PORTB
    add #312, W8			; [806] set the write pointer into the WRITE render buffer to the four rightmost pixels
    and W0, [W2++], [W8++]		; [807] set the rightmost four pixels to the colour black...
    and W0, [W2++], [W8++]		; [808] ...if horizontal scrolling is ENABLED

; --- output the remaining pixels ---
    mov.b [W1++], [W5]			; [809] output of pixel #202 from READ render buffer to PORTB
    nop					; [810]
    do #116, _TiO003_01			; [811-812] loop through 117 pixels
    mov.b [W1++], [W5]			; [813..1277] output of pixel #203..#319 from READ render buffer to PORTB
    nop					; [814..1278]
    nop					; [815..1279]
_TiO003_01:
    nop					; [816..1280]

    clr.b [W5]				; [1] output of black - first cycle of the FRONT PORCH
    pop.d W8				; [2-3] pop W9 and W8 from stack
    pop.d W6				; [4-5] pop W7 and W6 from stack
    pop.d W4				; [6-7] pop W5 and W4 from stack
    pop.d W2				; [8-9] pop W3 and W2 from stack
    pop.d W0				; [10-11] pop W1 and W0 from stack
    pop RCOUNT				; [12]
    bclr IFS0, #OC1IF			; [13-14]
    retfie				; [15-20] 6 clock cycles

; --- TEXT & TILE MODE: video data output (without rendering) for raster lines #480 and #481 ---
_TextOut480:
    nop					; [50] 41 cycles delay
    nop					; [51]
    nop					; [52]
    nop					; [53]
    nop					; [54]
_TilesOut480:
    repeat #34				; [55] 36 cycles delay
    nop					; [56..90]

    push W1				; [91]
    mov #(RenderBuffer1 + 8), W0	; [92] W0 = pointer to READ render buffer
    mov #LATBH, W1			; [93] W1 = pointer to PORTB (high byte)

    do #319, _TiO480_00			; [94-95] output 320 pixels in a loop (4 cycles per loop)
    nop					; [96..1276]
    mov.b [W0++], [W1]			; [1..1277] output of pixel #0 - #319
    nop					; [2..1278]
_TiO480_00:
    nop					; [3..1279]
    clr W0				; [1280] 
    mov.b W0, [W1]			; [1] output of black - first cycle of the FRONT PORCH

    inc W14, W14			; [2] raster line + 1
    pop.d W0				; [3-4] pop W1 and W0 from stack
    pop RCOUNT				; [5]
    bclr IFS0, #OC1IF			; [6-7]
    retfie				; [8-13] 6 clock cycles

__T1Interrupt:				; Timer1
    bclr IFS0, #T1IF
    retfie

__DMA0Interrupt:			; DMA Channel 0
    bclr IFS0, #DMA0IF
    retfie

__IC2Interrupt:				; Input Capture 2
    bclr IFS0, #IC2IF
    retfie

__OC2Interrupt:				; Output Compare 2
    bclr IFS0, #OC2IF
    retfie

__T2Interrupt:				; Timer2
    bclr IFS0, #T2IF
    retfie

__T3Interrupt:				; Timer3
    bclr IFS0, #T3IF
    retfie

__SPI1EInterrupt:			; SPI1 Error
    bclr IFS0, #SPI1EIF
    retfie

__SPI1Interrupt:			; SPI1 Transfer Done
    bclr IFS0, #SPI1IF
    retfie

__U1RXInterrupt:			; UART1 Receiver
    bclr IFS0, #U1RXIF
    retfie

__U1TXInterrupt:			; UART1 Transmitter
    bclr IFS0, #U1TXIF
    retfie

__AD1Interrupt:				; ADC1 Convert Done
    bclr IFS0, #AD1IF
    retfie

__DMA1Interrupt:			; DMA Channel 1
    bclr IFS0, #DMA1IF
    retfie

; --- IFS1 interrupts ---
__SI2C1Interrupt:			; I2C1 Slave Event 
    bclr IFS1, #SI2C1IF
    retfie

__MI2C1Interrupt:			; I2C1 Master Event
    bclr IFS1, #MI2C1IF
    retfie

__CMInterrupt:				; Comparator Combined Event
    bclr IFS1, #CMIF
    retfie

__CNInterrupt:				; Input Change Interrupt
    bclr IFS1, #CNIF
    retfie

__INT1Interrupt:			; External Interrupt 1
    bclr IFS1, #INT1IF
    retfie

__DMA2Interrupt:			; DMA Channel 2
    bclr IFS1, #DMA2IF
    retfie

__OC3Interrupt:				; Output Compare 3
    bclr IFS1, #OC3IF
    retfie

__OC4Interrupt:				; Output Compare 4
    bclr IFS1, #OC4IF
    retfie

__T4Interrupt:				; Timer4
    bclr IFS1, #T4IF
    retfie

__T5Interrupt:				; Timer5
    bclr IFS1, #T5IF
    retfie

__INT2Interrupt:			; External Interrupt 2
    bclr IFS1, #INT2IF
    retfie

__U2RXInterrupt:			; UART2 Receiver
    bclr IFS1, #U2RXIF
    retfie

__U2TXInterrupt:			; UART2 Transmitter
    bclr IFS1, #U2TXIF
    retfie

; --- IFS2 interrupts ---
__SPI2EInterrupt:			; SPI2 Error
    bclr IFS2, #SPI2EIF
    retfie

__SPI2Interrupt:			; SPI2 Transfer Done
    bclr IFS2, #SPI2IF
    retfie

__DMA3Interrupt:			; DMA Channel 3
    bclr IFS2, #SPI2IF
    retfie

__IC3Interrupt:				; Input Capture 3
    bclr IFS2, #IC3IF
    retfie

__IC4Interrupt:				; Input Capture 4
    bclr IFS2, #IC4IF
    retfie

; --- IFS3 interrupts ---
__SI2C2Interrupt:			; I2C2 Slave Event
    bclr IFS3, #SI2C2IF
    retfie

__MI2C2Interrupt:			; I2C2 Master Event
    bclr IFS3, #MI2C2IF
    retfie

; --- IFS4 interrupts ---
__U1EInterrupt:				; UART1 Error Interrupt
    bclr IFS4, #U1EIF
    retfie

__U2EInterrupt:				; UART2 Error Interrupt
    bclr IFS4, #U2EIF
    retfie

__CRCInterrupt:				; CRC Generator Interrupt
    bclr IFS4, #CRCIF
    retfie

__CTMUInterrupt:			; CTMU Interrupt
    bclr IFS4, #CTMUIF
    retfie

; --- IFS8 interrupts ---
__ICDInterrupt:				; ICD Application
    bclr IFS8, #ICDIF
    retfie

__JTAGInterrupt:			; JTAG Programming
    bclr IFS8, #JTAGIF
    retfie

; --- IFS9 interrupts ---
__PTGSTEPInterrupt:			; PTG Step
    bclr IFS9, #PTGSTEPIF
    retfie

__PTGWDTInterrupt:			; PTG Watchdog Time-out
    bclr IFS9, #PTGWDTIF
    retfie

__PTG0Interrupt:			; PTG Interrupt 0
    bclr IFS9, #PTG0IF
    retfie

__PTG1Interrupt:			; PTG Interrupt 1
    bclr IFS9, #PTG1IF
    retfie

__PTG2Interrupt:			; PTG Interrupt 2
    bclr IFS9, #PTG2IF
    retfie

__PTG3Interrupt:			; PTG Interrupt 3
    bclr IFS9, #PTG3IF
    retfie

; 256 characters of a 8x8 pixel font (2048 bytes)
_FontData:
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x00827c, 0x0082aa, 0x0082ba, 0x00007c
.pword 0x00fe7c, 0x00fed6, 0x00fec6, 0x00007c, 0x00fe6c, 0x00fefe, 0x00387c, 0x000010
.pword 0x003810, 0x00fe7c, 0x00387c, 0x000010, 0x005a3c, 0x007e7e, 0x00185a, 0x00003c
.pword 0x003c18, 0x007e7e, 0x00187e, 0x00003c, 0x000000, 0x003838, 0x000038, 0x000000
.pword 0x00fefe, 0x00c6c6, 0x00fec6, 0x0000fe, 0x003800, 0x00446c, 0x00386c, 0x000000
.pword 0x00c6fe, 0x00ba92, 0x00c692, 0x0000fe, 0x000e1e, 0x007a1e, 0x00d8d8, 0x000070
.pword 0x00663c, 0x003c66, 0x003c18, 0x000018, 0x00181e, 0x00181e, 0x007818, 0x000070
.pword 0x00667e, 0x00667e, 0x00ee66, 0x0000cc, 0x005a00, 0x00663c, 0x003c66, 0x00005a
.pword 0x007060, 0x007c78, 0x007078, 0x000060, 0x001c0c, 0x007c3c, 0x001c3c, 0x00000c
.pword 0x003c18, 0x001818, 0x003c18, 0x000018, 0x006666, 0x006666, 0x000066, 0x000066
.pword 0x000000, 0x006cfe, 0x006c6c, 0x00006c, 0x00181e, 0x006c3c, 0x003078, 0x0000f0
.pword 0x000000, 0x003c3c, 0x003c3c, 0x000000, 0x003c18, 0x00187e, 0x003c7e, 0x007e18
.pword 0x003c18, 0x00187e, 0x001818, 0x000018, 0x001818, 0x001818, 0x003c7e, 0x000018
.pword 0x000800, 0x00fe0c, 0x000cfe, 0x000008, 0x002000, 0x00fe60, 0x0060fe, 0x000020
.pword 0x000000, 0x000c7c, 0x000c0c, 0x000000, 0x002800, 0x00fe6c, 0x006cfe, 0x000028
.pword 0x001000, 0x007c38, 0x00fefe, 0x000000, 0x00fe00, 0x007cfe, 0x001038, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x001818, 0x001818, 0x000018, 0x000018
.pword 0x003636, 0x00006c, 0x000000, 0x000000, 0x006c6c, 0x006cfe, 0x006cfe, 0x00006c
.pword 0x007e10, 0x007cd0, 0x00fc16, 0x000010, 0x006662, 0x00180c, 0x006630, 0x000046
.pword 0x00cc78, 0x0078cc, 0x00ccce, 0x000076, 0x001818, 0x000030, 0x000000, 0x000000
.pword 0x00180c, 0x003030, 0x001830, 0x00000c, 0x001830, 0x000c0c, 0x00180c, 0x000030
.pword 0x006c44, 0x00ee38, 0x006c38, 0x000044, 0x001800, 0x007e18, 0x001818, 0x000000
.pword 0x000000, 0x000000, 0x001800, 0x003018, 0x000000, 0x007e00, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x001800, 0x000018, 0x000602, 0x00180c, 0x006030, 0x000040
.pword 0x00663c, 0x00766e, 0x006666, 0x00003c, 0x003818, 0x001818, 0x001818, 0x00003c
.pword 0x00663c, 0x000c06, 0x003018, 0x00007e, 0x00663c, 0x001c06, 0x006606, 0x00003c
.pword 0x006666, 0x007e66, 0x000606, 0x000006, 0x00607c, 0x007c60, 0x000606, 0x00007c
.pword 0x00603c, 0x007c60, 0x006666, 0x00003c, 0x00067e, 0x000c06, 0x001818, 0x000018
.pword 0x00663c, 0x003c66, 0x006666, 0x00003c, 0x00663c, 0x003e66, 0x000606, 0x00003c
.pword 0x000000, 0x000018, 0x001800, 0x000000, 0x000000, 0x001800, 0x001800, 0x003018
.pword 0x00180c, 0x006030, 0x001830, 0x00000c, 0x000000, 0x00007e, 0x00007e, 0x000000
.pword 0x003060, 0x000c18, 0x003018, 0x000060, 0x00663c, 0x000c06, 0x000018, 0x000018
.pword 0x00c67c, 0x00dcde, 0x00c6c0, 0x00007c, 0x00663c, 0x007e66, 0x006666, 0x000066
.pword 0x00667c, 0x007c66, 0x006666, 0x00007c, 0x00663c, 0x006060, 0x006660, 0x00003c
.pword 0x00667c, 0x006666, 0x006666, 0x00007c, 0x00607e, 0x007c60, 0x006060, 0x00007e
.pword 0x00607e, 0x007c60, 0x006060, 0x000060, 0x00663c, 0x006e60, 0x006666, 0x00003c
.pword 0x006666, 0x007e66, 0x006666, 0x000066, 0x00183c, 0x001818, 0x001818, 0x00003c
.pword 0x000606, 0x000606, 0x006606, 0x00003c, 0x006c66, 0x007078, 0x006c78, 0x000066
.pword 0x006060, 0x006060, 0x006060, 0x00007e, 0x00eec6, 0x00d6fe, 0x00c6c6, 0x0000c6
.pword 0x007666, 0x007e7e, 0x00666e, 0x000066, 0x00663c, 0x006666, 0x006666, 0x00003c
.pword 0x00667c, 0x007c66, 0x006060, 0x000060, 0x00663c, 0x006666, 0x003c66, 0x00000e
.pword 0x00667c, 0x007c66, 0x006666, 0x000066, 0x00603c, 0x003c60, 0x000606, 0x00007c
.pword 0x00187e, 0x001818, 0x001818, 0x000018, 0x006666, 0x006666, 0x006666, 0x00003c
.pword 0x006666, 0x006666, 0x003c66, 0x000018, 0x00c6c6, 0x00d6c6, 0x00eefe, 0x0000c6
.pword 0x006666, 0x00183c, 0x00663c, 0x000066, 0x006666, 0x003c66, 0x001818, 0x000018
.pword 0x00067e, 0x00180c, 0x006030, 0x00007e, 0x00303c, 0x003030, 0x003030, 0x00003c
.pword 0x006040, 0x001830, 0x00060c, 0x000002, 0x000c3c, 0x000c0c, 0x000c0c, 0x00003c
.pword 0x003810, 0x00006c, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x00ff00
.pword 0x003030, 0x000018, 0x000000, 0x000000, 0x000000, 0x00063c, 0x00663e, 0x00003e
.pword 0x006060, 0x007c60, 0x006666, 0x00007c, 0x000000, 0x00603c, 0x006060, 0x00003e
.pword 0x000606, 0x003e06, 0x006666, 0x00003e, 0x000000, 0x00663c, 0x00607e, 0x00003e
.pword 0x00180c, 0x003c18, 0x001818, 0x001818, 0x000000, 0x00663e, 0x003e66, 0x003c06
.pword 0x006060, 0x007c60, 0x006666, 0x000066, 0x001800, 0x003800, 0x001818, 0x000018
.pword 0x001800, 0x003800, 0x001818, 0x003018, 0x006060, 0x007c66, 0x006c78, 0x000066
.pword 0x001818, 0x001818, 0x001818, 0x00000c, 0x000000, 0x00fe6c, 0x00d6d6, 0x0000c6
.pword 0x000000, 0x00667c, 0x006666, 0x000066, 0x000000, 0x00663c, 0x006666, 0x00003c
.pword 0x000000, 0x00667c, 0x007c66, 0x006060, 0x000000, 0x00663e, 0x003e66, 0x000606
.pword 0x000000, 0x00180c, 0x001818, 0x000018, 0x000000, 0x00603c, 0x00063c, 0x00007c
.pword 0x001818, 0x00183c, 0x001818, 0x000018, 0x000000, 0x006666, 0x006666, 0x00003e
.pword 0x000000, 0x006666, 0x003c66, 0x000018, 0x000000, 0x00d6c6, 0x00fed6, 0x00006c
.pword 0x000000, 0x003c66, 0x003c18, 0x000066, 0x000000, 0x006666, 0x003e66, 0x003c06
.pword 0x000000, 0x000c7e, 0x003018, 0x00007e, 0x00180c, 0x003018, 0x001818, 0x00000c
.pword 0x001010, 0x000010, 0x001000, 0x001010, 0x001830, 0x000c18, 0x001818, 0x000030
.pword 0x003c14, 0x000028, 0x000000, 0x000000, 0x003c18, 0x006666, 0x006666, 0x00007e
.pword 0x003f3f, 0x003f3f, 0x003f3f, 0x003f3f, 0x00fcfc, 0x00fcfc, 0x00fcfc, 0x00fcfc
.pword 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff
.pword 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff
.pword 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff
.pword 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff
.pword 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff
.pword 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff
.pword 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff
.pword 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff
.pword 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff
.pword 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff
.pword 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff
.pword 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff
.pword 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff
.pword 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff
.pword 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff, 0x00ffff
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
.pword 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x00ffff
.pword 0x00ffff, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000

_DemoSprites:
; 16 sprites (4 "characters" with 4 sprites each - P, H, O, X) - 1024 bytes
.pword 0x001340, 0x001313, 0x001313, 0x001313, 0x001307, 0x001307, 0x001307, 0x001307
.pword 0x000707, 0x000707, 0x000707, 0x000707, 0x00070b, 0x00070b, 0x00070b, 0x001515
.pword 0x000b0b, 0x000b0b, 0x000b0b, 0x004015, 0x000b0f, 0x000b0f, 0x000b0f, 0x004015
.pword 0x000f0f, 0x000f0f, 0x000f0f, 0x000f0f, 0x000f2c, 0x000f2c, 0x000f2c, 0x000f2c
.pword 0x001313, 0x001313, 0x004040, 0x004040, 0x001307, 0x001307, 0x001307, 0x004040
.pword 0x000707, 0x000707, 0x000707, 0x004007, 0x000715, 0x00070b, 0x00070b, 0x00150b
.pword 0x004040, 0x000b0b, 0x000b0b, 0x00150b, 0x000b40, 0x000b0f, 0x000b0f, 0x00150f
.pword 0x000f0f, 0x000f0f, 0x000f0f, 0x00150f, 0x000f2c, 0x000f2c, 0x000f2c, 0x001515
.pword 0x002c2c, 0x002c2c, 0x002c2c, 0x002c2c, 0x002c3c, 0x002c3c, 0x002c3c, 0x001515
.pword 0x003c3c, 0x003c3c, 0x003c3c, 0x004015, 0x003c38, 0x003c38, 0x003c38, 0x004015
.pword 0x003838, 0x003838, 0x003838, 0x004015, 0x003830, 0x003830, 0x003830, 0x004015
.pword 0x003040, 0x003030, 0x001530, 0x004015, 0x004040, 0x001515, 0x001515, 0x004040
.pword 0x002c2c, 0x002c2c, 0x001515, 0x004015, 0x001515, 0x001515, 0x004015, 0x004040
.pword 0x004040, 0x004040, 0x004040, 0x004040, 0x004040, 0x004040, 0x004040, 0x004040
.pword 0x004040, 0x004040, 0x004040, 0x004040, 0x004040, 0x004040, 0x004040, 0x004040
.pword 0x004040, 0x004040, 0x004040, 0x004040, 0x004040, 0x004040, 0x004040, 0x004040
.pword 0x001340, 0x001313, 0x004013, 0x004040, 0x001307, 0x001307, 0x001307, 0x004040
.pword 0x000707, 0x000707, 0x000707, 0x004015, 0x00070b, 0x00070b, 0x00070b, 0x004015
.pword 0x000b0b, 0x000b0b, 0x000b0b, 0x004015, 0x000b0f, 0x000b0f, 0x000b0f, 0x004015
.pword 0x000f0f, 0x000f0f, 0x000f0f, 0x000f0f, 0x000f2c, 0x000f2c, 0x000f2c, 0x000f2c
.pword 0x004040, 0x001313, 0x001313, 0x004040, 0x001340, 0x001307, 0x001307, 0x004007
.pword 0x000740, 0x000707, 0x000707, 0x001507, 0x000740, 0x00070b, 0x00070b, 0x00150b
.pword 0x000b40, 0x000b0b, 0x000b0b, 0x00150b, 0x000b40, 0x000b0f, 0x000b0f, 0x00150f
.pword 0x000f0f, 0x000f0f, 0x000f0f, 0x00150f, 0x000f2c, 0x000f2c, 0x000f2c, 0x00152c
.pword 0x002c2c, 0x002c2c, 0x002c2c, 0x002c2c, 0x002c3c, 0x002c3c, 0x002c3c, 0x001515
.pword 0x003c3c, 0x003c3c, 0x003c3c, 0x004015, 0x003c38, 0x003c38, 0x003c38, 0x004015
.pword 0x003838, 0x003838, 0x003838, 0x004015, 0x003830, 0x003830, 0x003830, 0x004015
.pword 0x003040, 0x003030, 0x001530, 0x004015, 0x004040, 0x001515, 0x001515, 0x004040
.pword 0x002c2c, 0x002c2c, 0x002c2c, 0x00152c, 0x002c15, 0x002c3c, 0x002c3c, 0x00153c
.pword 0x003c40, 0x003c3c, 0x003c3c, 0x00153c, 0x003c40, 0x003c38, 0x003c38, 0x001538
.pword 0x003840, 0x003838, 0x003838, 0x001538, 0x003840, 0x003830, 0x003830, 0x001530
.pword 0x004040, 0x003030, 0x003030, 0x001515, 0x004040, 0x001540, 0x001515, 0x004015
.pword 0x004040, 0x004040, 0x001313, 0x001313, 0x004040, 0x001307, 0x001307, 0x001307
.pword 0x000740, 0x000707, 0x000707, 0x000707, 0x000740, 0x00070b, 0x00070b, 0x00150b
.pword 0x000b0b, 0x000b0b, 0x000b0b, 0x001515, 0x000b0f, 0x000b0f, 0x000b0f, 0x004015
.pword 0x000f0f, 0x000f0f, 0x000f0f, 0x004015, 0x000f2c, 0x000f2c, 0x000f2c, 0x004015
.pword 0x001313, 0x004013, 0x004040, 0x004040, 0x001307, 0x001307, 0x004007, 0x004040
.pword 0x000707, 0x000707, 0x000707, 0x004040, 0x00070b, 0x00070b, 0x00070b, 0x004015
.pword 0x000b40, 0x000b0b, 0x000b0b, 0x00400b, 0x000b40, 0x000b0f, 0x000b0f, 0x00150f
.pword 0x000f40, 0x000f0f, 0x000f0f, 0x00150f, 0x000f40, 0x000f2c, 0x000f2c, 0x00152c
.pword 0x002c2c, 0x002c2c, 0x002c2c, 0x004015, 0x002c3c, 0x002c3c, 0x002c3c, 0x004015
.pword 0x003c3c, 0x003c3c, 0x003c3c, 0x004015, 0x003c40, 0x003c38, 0x003c38, 0x004038
.pword 0x003840, 0x003838, 0x003838, 0x003838, 0x004040, 0x003830, 0x003830, 0x003830
.pword 0x004040, 0x003040, 0x003030, 0x003030, 0x004040, 0x004040, 0x001515, 0x001515
.pword 0x002c40, 0x002c2c, 0x002c2c, 0x00152c, 0x002c40, 0x002c3c, 0x002c3c, 0x00153c
.pword 0x003c40, 0x003c3c, 0x003c3c, 0x00153c, 0x003c38, 0x003c38, 0x003c38, 0x001515
.pword 0x003838, 0x003838, 0x003838, 0x004015, 0x003830, 0x003830, 0x001530, 0x004015
.pword 0x003030, 0x001530, 0x001515, 0x004040, 0x001515, 0x001515, 0x004040, 0x004040
.pword 0x001340, 0x001313, 0x004013, 0x004040, 0x001307, 0x001307, 0x001307, 0x004040
.pword 0x000707, 0x000707, 0x000707, 0x004015, 0x00070b, 0x00070b, 0x00070b, 0x004015
.pword 0x000b0b, 0x000b0b, 0x000b0b, 0x00400b, 0x000b40, 0x000b0f, 0x000b0f, 0x000b0f
.pword 0x004040, 0x000f0f, 0x000f0f, 0x000f0f, 0x004040, 0x000f40, 0x000f2c, 0x000f2c
.pword 0x004040, 0x001313, 0x001313, 0x004040, 0x001340, 0x001307, 0x001307, 0x004007
.pword 0x000740, 0x000707, 0x000707, 0x001507, 0x000740, 0x00070b, 0x00070b, 0x00150b
.pword 0x000b0b, 0x000b0b, 0x000b0b, 0x00150b, 0x000b0f, 0x000b0f, 0x000b0f, 0x001515
.pword 0x000f0f, 0x000f0f, 0x00150f, 0x004015, 0x000f2c, 0x000f2c, 0x001515, 0x004040
.pword 0x004040, 0x002c2c, 0x002c2c, 0x002c2c, 0x002c40, 0x002c3c, 0x002c3c, 0x002c3c
.pword 0x003c3c, 0x003c3c, 0x003c3c, 0x00153c, 0x003c38, 0x003c38, 0x003c38, 0x001515
.pword 0x003838, 0x003838, 0x003838, 0x004015, 0x003830, 0x003830, 0x003830, 0x004015
.pword 0x003040, 0x003030, 0x001530, 0x004015, 0x004040, 0x001515, 0x001515, 0x004040
.pword 0x002c2c, 0x002c2c, 0x00402c, 0x004040, 0x002c3c, 0x002c3c, 0x002c3c, 0x004040
.pword 0x003c3c, 0x003c3c, 0x003c3c, 0x00403c, 0x003c40, 0x003c38, 0x003c38, 0x001538
.pword 0x003840, 0x003838, 0x003838, 0x001538, 0x003840, 0x003830, 0x003830, 0x001530
.pword 0x004040, 0x003030, 0x003030, 0x001515, 0x004040, 0x001540, 0x001515, 0x004015
; 4 sprites (ball) - 256 bytes
.pword 0x004040, 0x004040, 0x000240, 0x000202, 0x004040, 0x000240, 0x000302, 0x001717
.pword 0x004040, 0x000302, 0x002b17, 0x000317, 0x000240, 0x002b03, 0x002b3f, 0x000303
.pword 0x000240, 0x003f17, 0x00172b, 0x000303, 0x001702, 0x003f2b, 0x000317, 0x000303
.pword 0x001702, 0x002b3f, 0x000303, 0x000303, 0x001702, 0x00173f, 0x000303, 0x000303
.pword 0x000202, 0x004002, 0x004040, 0x004040, 0x000303, 0x000203, 0x004002, 0x004040
.pword 0x000303, 0x000303, 0x000203, 0x004040, 0x000303, 0x000303, 0x000303, 0x004002
.pword 0x000303, 0x000303, 0x000303, 0x004002, 0x000303, 0x000303, 0x000303, 0x000203
.pword 0x000303, 0x000303, 0x000303, 0x000203, 0x000303, 0x000303, 0x000303, 0x000202
.pword 0x001702, 0x00032b, 0x000303, 0x000303, 0x000302, 0x000317, 0x000303, 0x000303
.pword 0x000202, 0x000303, 0x000303, 0x000303, 0x000240, 0x000303, 0x000303, 0x000303
.pword 0x000240, 0x000302, 0x000303, 0x000303, 0x004040, 0x000202, 0x000303, 0x000303
.pword 0x004040, 0x000240, 0x000202, 0x000303, 0x004040, 0x004040, 0x000240, 0x000202
.pword 0x000303, 0x000303, 0x000303, 0x000203, 0x000303, 0x000303, 0x000303, 0x000202
.pword 0x000303, 0x000303, 0x000303, 0x000202, 0x000303, 0x000303, 0x000203, 0x004002
.pword 0x000303, 0x000303, 0x000202, 0x004002, 0x000303, 0x000203, 0x000202, 0x004040
.pword 0x000203, 0x000202, 0x004002, 0x004040, 0x000202, 0x004002, 0x004040, 0x004040

_BootScreenText:
.ascii "  *** dsPIC33EP512GP502 VGA output ***  "
.ascii "                                        "
.ascii " Text mode 40x30 chars (320x240 pixels) "
.ascii "                                        "
.ascii "READY.                                  "

_DemoAnnouncement:
.ascii "Starting demo..."

_DemoCopperBars:
; top half of red copper bar (length: 15 bytes, colours: 0x12, 0x23, 0x37, 0x3f)
; center blue copper bar (length: 30 bytes, colours: 0x06, 0x0b, 0x1f, 0x3f)
; bottom half of red copper bar (length: 15 bytes, colours: 0x12, 0x23, 0x37, 0x3f)
.byte 0x12, 0x00, 0x12, 0x12, 0x23, 0x12, 0x23, 0x23, 0x37, 0x23, 0x37, 0x37
.byte 0x3f, 0x37, 0x3f, 0x06, 0x00, 0x06, 0x06, 0x0b, 0x06, 0x0b, 0x0b, 0x1f
.byte 0x0b, 0x1f, 0x1f, 0x3f, 0x1f, 0x3f, 0x3f, 0x1f, 0x3f, 0x1f, 0x1f, 0x0b
.byte 0x1f, 0x0b, 0x0b, 0x06, 0x0b, 0x06, 0x06, 0x00, 0x06, 0x3f, 0x37, 0x3f
.byte 0x37, 0x37, 0x23, 0x37, 0x23, 0x23, 0x12, 0x23, 0x12, 0x12, 0x00, 0x12
; moving gold copper bar (length: 30 bytes, colours: 0x24, 0x38, 0x3c, 0x3f)
.byte 0x24, 0x00, 0x24, 0x24, 0x38, 0x24, 0x38, 0x38, 0x3c, 0x38, 0x3c, 0x3c
.byte 0x3f, 0x3c, 0x3f, 0x3f, 0x3c, 0x3f, 0x3c, 0x3c, 0x38, 0x3c, 0x38, 0x38
.byte 0x24, 0x38, 0x24, 0x24, 0x00, 0x24

_DemoCopperSinus:
; vertical sinusoidal offsets for the golden copper bars ()
.pword 0x003c3c, 0x003c3c, 0x003d3d, 0x003f3e, 0x00403f, 0x004241, 0x004544, 0x004846, 0x004b49
.pword 0x004e4c, 0x005250, 0x005654, 0x005a58, 0x005e5c, 0x006260, 0x006664, 0x006a68, 0x006e6c
.pword 0x007270, 0x007674, 0x007a78, 0x007d7c, 0x00807f, 0x008382, 0x008684, 0x008887, 0x008989
.pword 0x008b8a, 0x008c8b, 0x008c8c, 0x008c8c, 0x008c8c, 0x008b8b, 0x00898a, 0x008889, 0x008687
.pword 0x008384, 0x008082, 0x007d7f, 0x007a7c, 0x007678, 0x007274, 0x006e70, 0x006a6c, 0x006668
.pword 0x006264, 0x005e60, 0x005a5c, 0x005658, 0x005254, 0x004e50, 0x004b4c, 0x004849, 0x004546
.pword 0x004244, 0x004041, 0x003f3f, 0x003d3e, 0x003c3d, 0x003c3c

_DemoHorTextCol0:
; length 48 - 1 period length = 18
.pword 0x002424, 0x002424, 0x003434, 0x003838, 0x003c3c, 0x003f3f, 0x003c3c, 0x003838
.pword 0x003434, 0x002424, 0x002424, 0x003434, 0x003838, 0x003c3c, 0x003f3f, 0x003c3c
.pword 0x003838, 0x003434, 0x002424, 0x002424, 0x003434, 0x003838, 0x003c3c, 0x003f3f
    
_DemoHorTextCol1:
; length 36 - 1 period length = 18
.pword 0x000606, 0x000606, 0x000707, 0x000b0b, 0x000f0f, 0x003f3f, 0x000f0f, 0x000b0b
.pword 0x000707, 0x000606, 0x000606, 0x000707, 0x000b0b, 0x000f0f, 0x003f3f, 0x000f0f
.pword 0x000b0b, 0x000707

_DemoScrollPattern:
.byte 0x18, 0x18, 0x3c, 0xe7, 0xe7, 0x3c, 0x18, 0x18
.byte 0x30, 0x78, 0xcf, 0xcf, 0x78, 0x30, 0x30, 0x30
.byte 0xf0, 0x9f, 0x9f, 0xf0, 0x60, 0x60, 0x60, 0x60
.byte 0x3f, 0x3f, 0xe1, 0xc0, 0xc0, 0xc0, 0xc0, 0xe1
.byte 0x7e, 0xc3, 0x81, 0x81, 0x81, 0x81, 0xc3, 0x7e
.byte 0x87, 0x03, 0x03, 0x03, 0x03, 0x87, 0xfc, 0xfc
.byte 0x06, 0x06, 0x06, 0x06, 0x0f, 0xf9, 0xf9, 0x0f
.byte 0x0c, 0x0c, 0x0c, 0x1e, 0xf3, 0xf3, 0x1e, 0x0c

_DemoPatternCopper:
; length 64 bytes
.byte 0x3f, 0x3b, 0x32, 0x21, 0x3b, 0x32, 0x21, 0x32, 0x21, 0x00, 0x21, 0x00, 0x00, 0x00, 0x00, 0x00
.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3f, 0x3b, 0x32, 0x21, 0x3b, 0x32, 0x21, 0x32

_DemoVerColScroll0:
; length 32 bytes
.byte 0x24, 0x34, 0x38, 0x3c, 0x3f, 0x3c, 0x38, 0x34, 0x24, 0x34, 0x38, 0x3c, 0x3f, 0x3c, 0x38, 0x34
.byte 0x06, 0x07, 0x0b, 0x0f, 0x3f, 0x0f, 0x0b, 0x07, 0x06, 0x07, 0x0b, 0x0f, 0x3f, 0x0f, 0x0b, 0x07

_DemoText01:				; length 24 bytes
.ascii "VGA on a microcontroller"
    
_DemoText02:				; length 20 bytes
.ascii "Created on 2016-6-17"

_DemoText03:				; length 18 bytes
.ascii "by Peter Einramhof"

_DemoVScrollText:
.ascii "                This demo showcases the VGA output that I've imp"
.ascii "lemented on the dsPIC33E - the chip is running at 50.4MHz. All "
.ascii "output signals correspond to the video mode 640x480@60Hz, howeve"
.ascii "r, the effective resolution is 320x240. There are 64 colours (RG"
.ascii "B222). What you are seeing is the text mode with 40x30 character"
.ascii "s and an 8x8 pixel font. For each character cell there is an ind"
.ascii "ividual background and foreground colour attribute. If the colou"
.ascii "r of either attribute is transparent, the global background and/"
.ascii "or foreground colour is used. This allows showing copper bars..."
.ascii "              "

_DemoHScrollText:
.ascii "                This horizontal scroll text is generated by maki"
.ascii "ng use of the global horizontal scrolling capability of this 'vi"
.ascii "deo chip'. Since horizontal scrolling can be turned on and off f"
.ascii "rom one pixel row to the next, horizontal scrolling can also be "
.ascii "used locally without affecting the rest of the screen contents. "
.ascii "This allows showing smooth scroll texts without the need for man"
.ascii "ipulating the character set...                                  "

; X-positions of the (5 * 2 = ) 10 (top) sprites [10 words]
_DemoSpriteX:
.word 88, 96, 120, 128, 152, 160, 184, 192, 216, 224

; (5 * 4 = ) 20 pointers to the sprites' data - 10 top sprites first, then 10 bottom sprites [20 words]
_DemoSpritePointers:
.word DemoSpriteData, (DemoSpriteData + 64), (DemoSpriteData + 256), (DemoSpriteData + 320)
.word (DemoSpriteData + 512), (DemoSpriteData + 576), (DemoSpriteData + 768), (DemoSpriteData + 832)
.word (DemoSpriteData + 768), (DemoSpriteData + 832), (DemoSpriteData + 128), (DemoSpriteData + 192)
.word (DemoSpriteData + 384), (DemoSpriteData + 448), (DemoSpriteData + 640), (DemoSpriteData + 704)
.word (DemoSpriteData + 896), (DemoSpriteData + 960), (DemoSpriteData + 896), (DemoSpriteData + 960)

; 90 words for the sinusoidal motion of the top sprites
_DemoSpriteSine:
.byte 20, 21, 22, 22, 23, 24, 25, 26, 26, 27, 28, 28, 29, 29, 30, 30
.byte 31, 31, 31, 32, 32, 32, 32, 32, 32, 32, 32, 31, 31, 31, 30, 30
.byte 29, 29, 28, 28, 27, 26, 26, 25, 24, 23, 22, 22, 21, 20, 19, 18
.byte 18, 17, 16, 15, 14, 14, 13, 12, 12, 11, 11, 10, 10, 9, 9, 9
.byte 8, 8, 8, 8, 8, 8, 8, 8, 9, 9, 9, 10, 10, 11, 11, 12
.byte 12, 13, 14, 14, 15, 16, 17, 18, 18, 19

_DemoBallSine:
; 53 words for the sinusoidal motion of the ball
.word 208, 205, 202, 200, 197, 194, 191, 189, 186, 184, 181, 179, 177, 175, 173, 171
.word 169, 167, 166, 165, 164, 163, 162, 161, 161, 160, 160, 160, 160, 161, 161, 162
.word 163, 164, 165, 166, 167, 169, 171, 173, 175, 177, 179, 181, 184, 186, 189, 191
.word 194, 197, 200, 202, 205

; 239 words - sinusoidal X-coordinates for the vert9ical sprite scroll text
_DemoScrollSineData:
.word 290, 290, 290, 290, 291, 291, 291, 291, 291, 291, 292, 292, 292, 292, 292, 292
.word 292, 293, 293, 293, 293, 293, 293, 293, 294, 294, 294, 294, 294, 294, 294, 294
.word 294, 295, 295, 295, 295, 295, 295, 295, 295, 295, 295, 295, 295, 296, 296, 296
.word 296, 296, 296, 296, 296, 296, 296, 296, 296, 296, 296, 296, 296, 296, 296, 296
.word 296, 296, 296, 296, 296, 296, 296, 296, 296, 296, 296, 296, 295, 295, 295, 295
.word 295, 295, 295, 295, 295, 295, 295, 295, 294, 294, 294, 294, 294, 294, 294, 294
.word 293, 293, 293, 293, 293, 293, 293, 293, 292, 292, 292, 292, 292, 292, 291, 291
.word 291, 291, 291, 291, 291, 290, 290, 290, 290, 290, 290, 289, 289, 289, 289, 289
.word 289, 289, 288, 288, 288, 288, 288, 288, 287, 287, 287, 287, 287, 287, 287, 287
.word 286, 286, 286, 286, 286, 286, 286, 286, 285, 285, 285, 285, 285, 285, 285, 285
.word 285, 285, 285, 285, 284, 284, 284, 284, 284, 284, 284, 284, 284, 284, 284, 284
.word 284, 284, 284, 284, 284, 284, 284, 284, 284, 284, 284, 284, 284, 284, 284, 284
.word 284, 284, 284, 285, 285, 285, 285, 285, 285, 285, 285, 285, 285, 285, 285, 286
.word 286, 286, 286, 286, 286, 286, 286, 286, 287, 287, 287, 287, 287, 287, 287, 288
.word 288, 288, 288, 288, 288, 288, 289, 289, 289, 289, 289, 289, 290, 290, 290

_DemoSpriteText:
.ascii "                This scroll text consists of 62 sprites. Actuall"
.ascii "y, it is only two sprites that are being multiplexed. The top wa"
.ascii "vey text spelling 'PHOXX' consits of 10 sprites that are also mu"
.ascii "ltiplexed so that it seemingly consists of 20 sprites. Last but "
.ascii "not least, the jumping ball consists of four sprites, which are "
.ascii "not multiplexed...            "

.end
