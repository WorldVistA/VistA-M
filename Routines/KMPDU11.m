KMPDU11 ;OAK/RAK - CM Tools Text Display Utility ;2/17/04  09:50
 ;;2.0;CAPACITY MANAGEMENT TOOLS;;Mar 22, 2002
 ;
WP(KMPUAR,KMPUTM,KMPUBM,KMPULM,KMPURM,KMPUNW,KMPUXIT) ;-- word processing display.
 ;--------------------------------------------------------------------
 ; KMPUAR...  Array containing word processing text.
 ;            Example: ^KMPUTMP(1001,1,0)="This is the"
 ;                     ^KMPUTMP(1001,2,0)="text to display."
 ;
 ;  Optional parameters:
 ;
 ; KMPUTM.. Top margin of screen area.
 ; KMPUBM.. Bottom margin of screen area.
 ; KMPULM.. Left margin.
 ; KMPURM.. Right margin.
 ; KMPUNW.. Nowrap:
 ;           0 - nowrap (print as entered)
 ;           1 - wrap
 ; KMPUXIT. Exit without 'continue' text.  This allows the programmer
 ;          to use their own display for continuing
 ;           0 - do not exit - display 'continue' text
 ;           1 - exit
 ;
 ; If more than one page this routine allows the user to scroll back
 ; and forth between pages. If KMPUTM and KMPUBM are not passed will
 ; default to full screen (0 to 22).
 ;--------------------------------------------------------------------
 ;
 Q:'$D(KMPUAR)
 ;
 N CLRSCR,I,KMPUI,KMPUOUT,LEN,LINES,PAGE,PAGES
 N DIR,DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,X,Y,Z
 N IOBM,IOECH,IOELALL,IOELEOL,IORVON,IORVOFF,IOTM,IOSTBM
 ;
 S KMPUXIT=+$G(KMPUXIT)
 S KMPUTM=+$G(KMPUTM),KMPUBM=$S(+$G(KMPUBM):KMPUBM,1:22)
 S KMPULM=+$G(KMPULM),KMPURM=+$G(KMPURM),KMPUNW=+$G(KMPUNW)
 S:KMPUBM>22 KMPUBM=22 S DIWL=KMPULM,DIWR=$S(KMPURM:KMPURM,1:IOM)
 S KMPUNW=$S(KMPUNW=1:"",1:"N")
 S X="IOECH;IOELALL;IOELEOL;IORVON;IORVOFF;IOSTKMPUBM" D ENDR^%ZISS
 ; set CLRSCR (clear screen) 
 ; clear full screen
 I DIWL=0,(DIWR=IOM) D 
 .S CLRSCR="F DY=(KMPUBM-1):-1:KMPUTM X IOXY W IOELALL,!"
 ; clear left margin to end of screen
 E  I DIWR=IOM D 
 .S CLRSCR="S DX=DIWL F DY=(KMPUBM-1):-1:KMPUTM X IOXY W IOELEOL,!"
 ; clear left margin to right margin
 E  S CLRSCR="F DY=(KMPUBM-1):-1:KMPUTM F DX=DIWL:1:DIWR X IOXY W IOECH"
 K ^UTILITY($J,"W") S DIWF=KMPUNW,X=""
 ; use fileman to format text
 F KMPUI=0:0 S KMPUI=$O(@KMPUAR@(KMPUI)) Q:'KMPUI  D 
 .Q:'$D(@KMPUAR@(KMPUI,0))  S X=@KMPUAR@(KMPUI,0) D ^DIWP
 Q:'$D(^UTILITY($J,"W",DIWL))  S LINES=$G(^(DIWL))
 ; check for last line equal to null
 I $G(^UTILITY($J,"W",DIWL,LINES,0))="" S LINES=LINES-1
 S LEN=KMPUBM-KMPUTM,PAGES=LINES\LEN I LINES#LEN S PAGES=PAGES+1
 ;
 ; set up the pages() array -  first piece = starting line
 ;                            second piece = ending line
 F I=1:1:PAGES D 
 .S PAGES(I)=$S(I=1:1,1:(I*LEN-LEN+1))
 .I I=1 S $P(PAGES(I),U,2)=$S(LINES<LEN:LINES,1:LEN) Q
 .S $P(PAGES(I),U,2)=(I*LEN)
 S DY=(KMPUTM-1),PAGE=1,KMPUOUT=0
 ; main loop
 F  D  Q:KMPUOUT
 .F KMPUI=$P(PAGES(PAGE),U):1:$P(PAGES(PAGE),U,2) D 
 ..Q:'$D(^UTILITY($J,"W",DIWL,KMPUI,0))
 ..S DX=DIWL,DY=DY+1 X IOXY W ^UTILITY($J,"W",DIWL,KMPUI,0),!
 .I 'KMPUXIT D FTR X CLRSCR Q:KMPUOUT  S DY=DY-1
 .E  S KMPUOUT=1
 F DY=22,23 X IOXY W IOELALL
 K ^UTILITY($J,"W")
 Q
 ;
FTR ;-- footer designed for wp subroutine above.
 N READ,READX S READ=""
 S DX=0,DY=22 X IOXY W $$REPEAT^XLFSTR("_",IOM)
 I PAGES=1 S READ="X",READ("A")=$J(" ",28)_"Press <RET> to continue"
 I PAGES>1 S READ="X",READ("A")="E[x]it" D 
 .I PAGE<PAGES S READ=READ_"N",READ("A")=READ("A")_", [N]ext Screen"
 .I PAGE>1 S READ=READ_"P",READ("A")=READ("A")_", [P]revious Screen"
 S READ("A")=READ("A")_": "
FTR1 ;-- read
 S DX=0,DY=23 X IOXY W IOELALL
 S DX=62 X IOXY W " Page ",PAGE," of ",PAGES," "
 S DX=0 X IOXY W READ("A")
 R READX:DTIME S READX=$$UP^XLFSTR(READX)
 I READX="X"!(READX="^")!(READ="X") S KMPUOUT=1 Q
 I READX="N",(READ["N") S PAGE=PAGE+1 Q
 I READX="P",(READ["P") S PAGE=PAGE-1 Q
 I READX["?" D HELP G FTR1
 W *7
 G FTR1
 ;
HELP ;-- clear screen, print help text, repaint screen.
 N I,READX X CLRSCR S DY=KMPUTM,DX=$S(DIWL>7:DIWL,1:7) X IOXY
 F I=1:1:$L(READ) S DY=DY+1 X IOXY D 
 .I $E(READ,I)="X" W "Enter 'X' (or '^') to exit.",!
 .I $E(READ,I)="N" W "Enter 'N' to advance to the next screen.",!
 .I $E(READ,I)="P" W "Enter 'P' to backup to the previous screen.",!
 S DY=(KMPUBM-1) X IOXY R "Press <RET> to continue: ",READX:DTIME
 ; repaint screen.
 X CLRSCR S DY=(KMPUTM-1)
 F I=$P(PAGES(PAGE),U):1:$P(PAGES(PAGE),U,2) D 
 .Q:'$D(^UTILITY($J,"W",DIWL,I,0))
 .S DX=DIWL,DY=DY+1 X IOXY W ^UTILITY($J,"W",DIWL,I,0),!
 Q
