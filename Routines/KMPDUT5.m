KMPDUT5 ;OAK/RAK - CM Tools Utility Text Display ;2/17/04  10:49
 ;;2.0;CAPACITY MANAGEMENT TOOLS;;Mar 22, 2002
 ;
DISPLAY(KMPDARRY,KMPDMRGN,KMPDNW,KMPDCLR,KMPDBX) ;display text
 ;-------------------------------------------------------------------
 ;  If there is more than one page (screen) of text this api
 ;  allows the user to scroll back and forth between pages
 ;
 ;   KMPDARRY - global or local array that contains word processing text
 ;           example: "^ASKV(673700,12,11,"
 ;                    "TMP($J)"
 ;
 ;           the following is an example of how the array might be set
 ;           up:
 ;               KMPDARRY($J,0)=number of lines
 ;               KMPDARRY($J,1,0)=text to display
 ;               KMPDARRY($J,2,0)=text to display
 ;               KMPDARRY($J,3,0)=text to display
 ;               KMPDARRY($J...
 ;
 ;
 ;            KMPDARRY must not be ^UTILITY($J,"W") - this routine uses
 ;            fileman to format text, therefore ^UTILITY($J,"W") is
 ;            used and then killed when routine complete
 ;
 ;  optional parameters
 ;
 ; KMPDMRGN - margins for display of text in 4 up-arrow pieces
 ;           TM - top margin of screen area...... piece 1
 ;           BM - bottom margin of screen area... piece 2
 ;           LM - left margin.................... piece 3
 ;           RM - right margin................... piece 4
 ;                        *** NOTE ***
 ;           if TM and BM are not passed the display will default to
 ;           full screen (0 to 22)
 ;
 ;    KMPDNW - nowrap    0 - nowrap (display as entered)
 ;                     1 - wrap
 ;
 ;   KMPDCLR - clear screen when exiting
 ;           0 - clear screen
 ;           1 - do not clear screen
 ;
 ;    KMPDBX - this variable is in 2 up-arrow pieces
 ;           piece 1: 0 - do not draw a box (or window) around text
 ;                    1 - draw box
 ;           piece 2: header (if any) for box
 ;
 ;  other variables
 ;
 ;      FT - top margin for footer
 ;      FB - bottom margin for footer
 ;  LENGTH - length of text to display (RM-LM)
 ;      OS - operating system
 ;--------------------------------------------------------------------
 ;
 Q:'$D(KMPDARRY)
 ;
 S KMPDMRGN=$G(KMPDMRGN),KMPDNW=+$G(KMPDNW)
 S KMPDCLR=+$G(KMPDCLR),KMPDBX=$G(KMPDBX)
 ; place array in correct format
 I $E(KMPDARRY,$L(KMPDARRY))="," S $E(KMPDARRY,$L(KMPDARRY))=")"
 I $E(KMPDARRY,$L(KMPDARRY))'=")" S KMPDARRY=KMPDARRY_")"
 I $E(KMPDARRY)'="^" I $E(KMPDARRY,$L(KMPDARRY)-1,$L(KMPDARRY))="()" D
 .S KMPDARRY=$E(KMPDARRY,1,$L(KMPDARRY)-2)
 ;
 N ASKI,KMPDOUT,BM,CLRSCR,FB,FT,I,LEN,LENGTH,LINES,LM,OS,PAGE,PAGES,RM,TM
 N DIR,DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DX,DY,X,Y,Z
 N IOBM,IOECH,IOELALL,IOELEOL,IORVON,IORVOFF,IOTM,IOSTBM
 ;
 ; set up special terminal variables
 S X="IOECH;IOELALL;IOELEOL;IORVON;IORVOFF;IOSTBM" D ENDR^%ZISS
 S OS=$G(^%ZOSF("OS"))
 S TM=+$P(KMPDMRGN,U),LM=+$P(KMPDMRGN,U,3),RM=+$P(KMPDMRGN,U,4)
 S BM=+$P(KMPDMRGN,U,2) S:'BM!(BM>22) BM=$S(OS["MSM":22,1:23)
 S:'RM RM=IOM S FB=BM,FT=(FB-1),BM=(FB-2),LENGTH=(RM-LM)
 S DIWL=LM,DIWR=$S(RM:RM,1:IOM),KMPDNW=$S(KMPDNW=1:"",1:"N")
 ; if full screen
 I LM=0,(RM=IOM) S CLRSCR="F DY=BM:-1:TM X IOXY W IOELALL,!"
 ; else partial screen
 E  S CLRSCR="S DX=LM F DY=BM:-1:TM X IOXY W $J("" "",LENGTH)"
 ;
 D LOOP
 ;
 K ^UTILITY($J,"W")
 ;
 Q
 ;
LOOP ;-- main loop
 ;
 ; use fileman to format text
 K ^UTILITY($J,"W") S DIWF=KMPDNW,X=""
 F I=0:0 S I=$O(@KMPDARRY@(I)) Q:'I  D
 .Q:'$D(@KMPDARRY@(I,0))  S X=@KMPDARRY@(I,0)
 .I KMPDNW="N" S X=$E(X,1,LENGTH)
 .D ^DIWP
 ; quit if no data to display
 Q:'$D(^UTILITY($J,"W",DIWL))  S LINES=$G(^(DIWL))
 ; check for last line equal to null
 I $G(^UTILITY($J,"W",DIWL,LINES,0))="" S LINES=LINES-1
 S LEN=BM-TM+1,PAGES=LINES\LEN I LINES#LEN S PAGES=PAGES+1
 ;
 ; set up the PAGES() array -  first piece = starting line
 ;                            second piece = ending line
 F I=1:1:PAGES D
 .S PAGES(I)=$S(I=1:1,1:(I*LEN-LEN+1))
 .I I=1 S $P(PAGES(I),U,2)=$S(LINES<LEN:LINES,1:LEN) Q
 .S $P(PAGES(I),U,2)=(I*LEN)
 ;
 ; if KMPDBX draw box around text
 ;I KMPDBX D KMPDBX^KMPDUTxxx((TM-1),(LM-1),(RM+1),FB,$P(KMPDBX,U,2))
 S DX=LM,DY=TM,PAGE=1,KMPDOUT=0
 ;
 ; main loop that displays text to the screen and prompts
 ; for the next page or previous page (if appropriate)
 F  D  Q:KMPDOUT
 .F I=$P(PAGES(PAGE),U):1:$P(PAGES(PAGE),U,2) D
 ..Q:'$D(^UTILITY($J,"W",DIWL,I,0))
 ..X IOXY W ^UTILITY($J,"W",DIWL,I,0),! S DY=DY+1
 .D FTR S DY=DY+1 Q:KMPDOUT  X CLRSCR
 ; clear screen if no KMPDCLR
 I 'KMPDCLR X CLRSCR F DY=22,23 X IOXY W IOELALL
 ;
 Q
 ;
FTR ;--footer
 ;
 N READ,READX S READ=""
 F DY=(FB-1):-1:(FB-3) X IOXY W !
 S DX=LM,DY=FT X IOXY W $$REPEAT^XLFSTR("_",LENGTH) ; I OS["MSM" W !
 S DX=LM,DY=FB X IOXY
 I PAGES=1 S READ="Q",READ("A")="Press <RET> to continue"
 I PAGES>1 S READ="Q" D 
 .I PAGE<PAGES S READ=READ_"N"
 .I PAGE>1 S READ=READ_"P"
 ;
 ; READ("A") - the prompt that appears in footer
 ; if LENGTH>44 characters: [Q]uit, [N]ext screen, [P]revious Screen:
 ; if LENGTH>28 characters: [Q]uit, [N]ext, [P]revious:
 ; else....................: [Q], [N], [P]
 I $G(READ("A"))']"" D 
 .I READ["Q" S READ("A")="[Q]" D 
 ..I LENGTH>28 S READ("A")=READ("A")_"uit"
 .I READ["N" S READ("A")=READ("A")_", [N]" D 
 ..I LENGTH>44 S READ("A")=READ("A")_"ext Screen" Q
 ..I LENGTH>28 S READ("A")=READ("A")_"ext"
 .I READ["P" S READ("A")=READ("A")_", [P]" D 
 ..I LENGTH>44 S READ("A")=READ("A")_"revious Screen" Q
 ..I LENGTH>28 S READ("A")=READ("A")_"revious"
 S READ("A")=READ("A")_": "
 ;
 ;-footer loop
 D  Q:KMPDOUT
 .S DX=LM,DY=FB X IOXY W $J(" ",$S(LENGTH<80:LENGTH,1:(LENGTH-1)))
 .I OS["MSM" W !
 .I OS["MSM" W ! F DY=(FB-1):-1:(FB-3) X IOXY W !
 .;
 .; if LENGTH>55 characters print pages
 .I LENGTH>55 D 
 ..S DX=(RM-15),DY=FB X IOXY W " Page ",PAGE," of ",PAGES," "
 ..I OS["MSM" W !
 .S DX=LM,DY=FB X IOXY W READ("A")
 .R READX:DTIME S:'$T READX="Q" S READX=$$UP^XLFSTR(READX)
 .I READX="Q"!(READX="^")!(READ="E") S KMPDOUT=1 Q
 .I READX="N",(READ["N") S PAGE=PAGE+1 Q
 .I READX="P",(READ["P") S PAGE=PAGE-1 Q
 .I READX["?" D HELP Q
 .;
 .; end of the screen - this just scrolls up a couple of lines and
 .; seems to reset the screen coordinates for MSM
 .I OS["MSM" F DY=(BM-1):-1:(BM-3) X IOXY W !
 .W $C(7)
 ;
 Q
 ;
HELP ;-- clear screen, print help text, repaint screen
 ;
 N I,READX X CLRSCR S DY=TM,DX=$S(DIWL>7:DIWL,1:7) X IOXY
 F I=1:1:$L(READ) S DY=DY+1 X IOXY D
 .I $E(READ,I)="E" W "Enter 'E' (or '^') to exit.",!
 .I $E(READ,I)="N" W "Enter 'N' to advance to the next screen.",!
 .I $E(READ,I)="P" W "Enter 'P' to backup to the previous screen.",!
 S DY=BM X IOXY R "Press <RET> to continue: ",READX:DTIME
 ; repaint screen
 X CLRSCR S DY=(TM-1)
 F I=$P(PAGES(PAGE),U):1:$P(PAGES(PAGE),U,2) D
 .Q:'$D(^UTILITY($J,"W",DIWL,I,0))
 .S DX=DIWL,DY=DY+1 X IOXY W ^UTILITY($J,"W",DIWL,I,0),!
 ;
 Q
