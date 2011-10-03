XGFDEMO ;SFISC/VYD - demonstrate graphics functions ;12/30/93  10:22
 ;;8.0;KERNEL;;Jul 10, 1995
 N NT,NL,NB,NR ;top,left,bottom,right for narrative window
 N MT,ML,MB,MR ;top,left,bottom,right for menu window
 N OLDCHOIC,NEWCHOIC,TAG,STOP,CHOICE
 D PREP^XGF ;prepare environment for graphics functions
 D GRID
 D WELCOME
 D MENU
 S STOP=0
 F  S %=$$CHOOSE() D  Q:STOP
 .S TAG=$$UP^XLFSTR($TR($TR(CHOICE(%),"&","")," ",""))
 .D @(TAG_"^XGFDEMO1") ;do the menu choice
 D CLEAN^XGF K ^TMP($J)
 Q
 ;
CHOOSE() ;choose a choice from the menu
 ;;Use <UP ARROW> or <DOWN ARROW>
 ;;or press a hot key of a choice
 ;;
 ;;Press <RETURN> to select.
 N I,S,STOP
 D CLEAR^XGF(NT+1,NL+1,NB-1,NR-1)
 F I=1:1:4 S S=$P($T(CHOOSE+I),";;",2) D SAY^XGF(NT+I,NL+1,S)
 I '$D(OLDCHOIC) S OLDCHOIC=2
 S:'$D(NEWCHOIC) NEWCHOIC=1
 S STOP=0
 F  D  Q:STOP
 .I NEWCHOIC'=OLDCHOIC D  ;another choice was selected
 ..D SAYU^XGF(MT+OLDCHOIC,ML+1,CHOICE(OLDCHOIC),"E1")
 ..D SAYU^XGF(MT+NEWCHOIC,ML+1,CHOICE(NEWCHOIC),"R1")
 ..D SAY^XGF(IOSL-1,2,CHOICE(NEWCHOIC,1)_$J("",80))
 ..S OLDCHOIC=NEWCHOIC
 .S KEY=$$READ^XGF(1)
 .I XGRT="CR" S STOP=1
 .E  I $L(KEY),$D(CHOICE("HK",$$UP^XLFSTR(KEY))) S NEWCHOIC=CHOICE("HK",$$UP^XLFSTR(KEY))
 .E  I XGRT="UP" S NEWCHOIC=$S($D(CHOICE(OLDCHOIC-1)):OLDCHOIC-1,1:$O(CHOICE("A"),-1))
 .E  I XGRT="DOWN" S NEWCHOIC=$S($D(CHOICE(OLDCHOIC+1)):OLDCHOIC+1,1:$O(CHOICE("")))
 Q NEWCHOIC
 ;
MENU ;main menu
 ;;&Cursor;Cursor positioning
 ;;&Attributes;Output text in different video attributes
 ;;&Windows;Open overlapping pop-up windows and restore screen when closed
 ;;&Keyboard;Experiment with the low level keyboard reader
 ;;E&xit;Stop the demo
 N I
 F I=1:1 D  Q:CHOICE(I)["E&xit"
 .S CHOICE(I)=$P($T(MENU+I),";",3)
 .S CHOICE(I)=CHOICE(I)_$J("",11-$L(CHOICE(I)))
 .S CHOICE(I,1)=$P($T(MENU+I),";",4)
 .S CHOICE("HK",$$UP^XLFSTR($E($P(CHOICE(I),"&",2))))=I ;hot key x-ref
 S MT=2,ML=2,MB=MT+I+1,MR=ML+11
 D WIN^XGF(MT,ML,MB,MR,$NA(^TMP($J,"MENU")))
 S $Y=MT
 F %=1:1:I D SAYU^XGF("+",ML+1,CHOICE(%))
 Q
 ;
GRID ;draw a grid
 N %,I
 ;   X scale accross the top
 S %="" F I=0:1:IOM-1 S %=%_$S((I#10)=0:I/10,(I#5)=0:"+",1:"-")
 D SAY^XGF(0,0,%)
 ;   Y scale along the left
 F I=1:1:IOSL-1 S %=$S((I#10)=0:I/10,(I#5)=0:"+",1:"|") D SAY^XGF(I,0,%)
 ;   grid of dots
 S %="" F I=5:5:IOM-1 S %=%_"    ."
 F I=5:5:IOSL D SAY^XGF(I,1,%)
 Q
WELCOME ;displays welcome text
 ;;The purpose of this demo is to
 ;;exercise different components of
 ;;the low level graphics functions
 S NB=IOSL-3,NR=IOM-1,NT=NB-6,NL=NR-33
 D SAVE^XGF(NT,NL,NB,NR,$NA(^TMP($J,"NARRATIVE")))
 D CLEAR^XGF(NT,NL,NB,NR),CHGA^XGF("R1"),FRAME^XGF(NT,NL,NB,NR),CHGA^XGF("R0")
 D SAY^XGF(NT+1,NL+11,"W E L C O M E","U1B1")
 F I=1:1:3 S S=$P($T(WELCOME+I),";;",2) D SAY^XGF(NT+I+1,NL+1,S)
 D SAY^XGF(NB-1,NL+8,"RETURN","R1"),SAY^XGF("","+"," to continue")
 F  S %=$$READ^XGF(1) Q:XGRT="CR"
 Q
