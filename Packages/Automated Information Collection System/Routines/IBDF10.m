IBDF10 ;ALB/CJM - ENCOUNTER FORM - (shift block contents) ;APRIL 22,1993
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
SHIFT(TYPE) ;shifts contents of blocks - prompts user for what to shift (unless TYPE is defined), and how much to shift
 ;assumes IBBLK is defined unless TYPE="B"
 N AMOUNT,WAY,QUIT,TOP,BOTTOM,LEFT,RIGHT,HT,WIDTH,MAX
 S QUIT=0,VALMBCK="R"
 I '$D(TYPE) N TYPE D TYPE
 I $D(TYPE),"EDSLTMH"[TYPE S HT=IBBLK("H"),WIDTH=IBBLK("W")
 I $G(TYPE)="B" S HT=IBFORM("HT"),WIDTH=IBFORM("WIDTH")
 D:'QUIT DIRECTN
 D RE^VALM4
 D:'QUIT RANGE(HT,WIDTH)
 S:'QUIT MAX=$S(WAY="U":$S(BOTTOM:BOTTOM,1:HT),WAY="D":HT-TOP-1,WAY="L":$S(RIGHT:RIGHT,1:WIDTH),1:WIDTH-LEFT-1)
 S:'QUIT MAX=$$MAX^IBDF10C(TYPE,WAY,MAX,TOP,BOTTOM,LEFT,RIGHT)
 D:'QUIT AMOUNT(MAX)
 D:('QUIT)&($G(AMOUNT)>0) @TYPE
 S VALMBCK="R"
 Q
TYPE ;asks user for what should be shifted
 D TYPEHELP
 K DIR S DIR(0)="SB^E:Everything;D:Display Fields;S:Selection Lists;L:Lines;T:Text Areas;M:Multiple Choice Fields;H:Hand Print Fields",DIR("A")="What should be shifted?",DIR("B")="Everything"
 S DIR("?")="^D TYPEHELP^IBDF10"
 D ^DIR K DIR I (Y=-1)!$D(DIRUT) S QUIT=1 Q
 S TYPE=Y
 Q
TYPEHELP ;help for TYPE
 W !!,"You can choose what should be shifted. Select one of the following:",!," [E]verything, [D]isplay fields, [S]election lists, [L]ines, [T]ext areas,",!," [M]ultiple choice fields, [H]and print fields"
 Q
DIRECTN ;asks user for direction of shift - returns WAY
 S DIR(0)="SB^U:UP;D:DOWN;L:LEFT;R:RIGHT",DIR("A")="Shift UP, DOWN, LEFT, or RIGHT?",DIR("B")="DOWN",DIR("?")="Which direction should the shift be in?"
 D ^DIR K DIR I (Y=-1)!$D(DIRUT) S QUIT=1 Q
 S WAY=Y
 Q
AMOUNT(MAX) ;now ask user how far to shift - returns AMOUNT
 ;MAX is the maxium shift allowed
 S DIR(0)="N^0:"_MAX_":0"
 S DIR("A")="Shift how far "_$S(WAY="U":"up in rows",WAY="D":"down in rows",WAY="R":"to the right in columns",1:"to the left in columns")_"?"
 D ^DIR K DIR I (Y=-1)!$D(DIRUT) S QUIT=1 Q
 S AMOUNT=Y
 Q
RANGE(HT,WIDTH) ;asks the user for the range - returns TOP,BOTTOM,LEFT,RIGHT
 N I
 K DIR
 ;get TOP
 S DIR("A")="What is the top-most row to shift?"
 S DIR(0)="N^1:"_HT_":0",DIR("B")=1
 D ^DIR K DIR I (Y=-1)!$D(DIRUT) S QUIT=1 Q
 S TOP=Y
 ;now get BOTTOM
 S DIR("A")="What is the bottom-most row to shift? (optional)",DIR("?",1)="Enter the lowest row that the shift should effect.",DIR("?")="Enter nothing to shift everything below the top-most row that you specified."
 K DIR("B")
 S DIR(0)="NO^"_TOP_":"_HT_":0"
 D ^DIR K DIR I (Y=-1)!$D(DTOUT)!$D(DUOUT) S QUIT=1 Q
 S BOTTOM=Y
 ;get LEFT
 S DIR("A")="What is the left-most column to shift?"
 S DIR(0)="N^1:"_WIDTH_":0",DIR("B")=1
 D ^DIR K DIR I (Y=-1)!$D(DIRUT) S QUIT=1 Q
 S LEFT=Y
 ;now get RIGHT
 S DIR("A")="What is the right-most column to shift? (optional)"
 S DIR("?",1)="Enter the right-most column that the shift should effect.",DIR("?")="Enter nothing to shift everything to the right of the left-most column that you specified."
 K DIR("B")
 S DIR(0)="NO^"_LEFT_":"_WIDTH_":0"
 D ^DIR K DIR I (Y=-1)!$D(DTOUT)!$D(DUOUT) S QUIT=1 Q
 S RIGHT=Y
 ;now change TOP,BOTTOM,LEFT,RIGHT to their internal values
 ;(BOTTOM or RIGHT)="" has special meaning - means shift without limit 
 S TOP=TOP-1,LEFT=LEFT-1
 S:BOTTOM>0 BOTTOM=BOTTOM-1
 S:RIGHT>0 RIGHT=RIGHT-1
 Q
E ;shift everything
 D FLDS^IBDF10A(WAY,AMOUNT,TOP,BOTTOM,LEFT,RIGHT)
 D LSTS^IBDF10B(WAY,AMOUNT,TOP,BOTTOM,LEFT,RIGHT)
 D TXT^IBDF10A(WAY,AMOUNT,TOP,BOTTOM,LEFT,RIGHT)
 D LINES^IBDF10A(WAY,AMOUNT,TOP,BOTTOM,LEFT,RIGHT)
 D MFLDS^IBDF10A(WAY,AMOUNT,TOP,BOTTOM,LEFT,RIGHT)
 D HFLDS^IBDF10A(WAY,AMOUNT,TOP,BOTTOM,LEFT,RIGHT)
 Q
D ;shift data fields
 D FLDS^IBDF10A(WAY,AMOUNT,TOP,BOTTOM,LEFT,RIGHT)
 Q
M ;shift multiple choice fields
 D MFLDS^IBDF10A(WAY,AMOUNT,TOP,BOTTOM,LEFT,RIGHT)
 Q
H ;shift hand print fields
 D HFLDS^IBDF10A(WAY,AMOUNT,TOP,BOTTOM,LEFT,RIGHT)
 Q
S ;shift selection lists
 D LSTS^IBDF10B(WAY,AMOUNT,TOP,BOTTOM,LEFT,RIGHT)
 Q
T ;shift text areas
 D TXT^IBDF10A(WAY,AMOUNT,TOP,BOTTOM,LEFT,RIGHT)
 Q
L ;shift lines
 D LINES^IBDF10A(WAY,AMOUNT,TOP,BOTTOM,LEFT,RIGHT)
 Q
B ;shift blocks
 D BLOCKS^IBDF10A(WAY,AMOUNT,TOP,BOTTOM,LEFT,RIGHT)
 Q
