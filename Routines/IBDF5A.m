IBDF5A ;ALB/CJM - ENCOUNTER FORM ;NOV 16,1992
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
IDXFORM(IBTOPLN,IBBOTLN) ;creates an array for the list processor
 ;containing the image of the form - or just rebuilds a portion of the
 ;array - if IBTOPLN,IBBOTLN defined they specify a range within which to
 ;update the array - otherwise, create it from scratch
 ;IBFORM should be passed by reference
 ;
 N IBBLK,BLKTOP
 W !,"... BUILDING THE FORM ..."
 S VALMSG="[Editing "_IBFORM("NAME")_"]  ?? for more actions"
 I ('$D(IBTOPLN))!('$D(IBBOTLN)) D
 .K @VALMAR D KILL^VALM10()
 .S VALMCNT=IBFORM("HT")+1
 .W "."
 .D BLNKFORM(0,IBFORM("HT")-1,IBFORM("WIDTH"))
 .S I="",$P(I,"~",IBFORM("WIDTH")+1)="~"
 .S @VALMAR@(IBFORM("HT")+1,0)="    "_I
 .W "."
 E  D
 .F LN=IBTOPLN+1:1:IBBOTLN+1 D KILL^VALM10(LN)
 .D BLNKFORM(IBTOPLN,IBBOTLN,IBFORM("WIDTH")) W "."
 .I IBTOPLN'>IBFORM("HT"),IBBOTLN>(IBFORM("HT")-1) S I="",$P(I,"~",IBFORM("WIDTH")+1)="~",@VALMAR@(IBFORM("HT")+1,0)="    "_I
 S IBBLK="" F  S IBBLK=$O(^IBE(357.1,"C",IBFORM,IBBLK)) Q:'IBBLK  D
 .I $D(IBTOPLN),$D(IBBOTLN) Q:'$$BETWEEN(IBBLK,IBTOPLN,IBBOTLN,.BLKTOP)
 .I '($D(IBTOPLN)&$D(IBBOTLN)) S BLKTOP=$P($G(^IBE(357.1,IBBLK,0)),"^",4) Q:BLKTOP=""
 .D DRWBLOCK^IBDF2A1(.IBBLK) W "."
 .D PGBNDRY($G(IBBLK("Y")),$G(IBBLK("H")),IBFORM("PAGE_HT"),$G(IBBLK("NAME")))
 ;
 ;************************************************************
 ;this is needed for Paper Keyboards anchors, but may change
 D ANCHORS
 ;************************************************************
 Q
BETWEEN(BLOCK,TOP1,BOT1,BLKTOP) ;determines if the block=BLOCK falls between TOP1 and BOT!, also returns BLKTOP
 N TOP2,BOT2 S (TOP2,BOT2)=""
 D TOPNBOT^IBDFU5(BLOCK,.TOP2,.BOT2) S BLKTOP=TOP2
 I ((TOP2>BOT1)&(BOT2>BOT1))!((TOP2<TOP1)&(BOT2<TOP1)) Q 0
 Q 1
BLNKFORM(TOP,BOT,W) ;
 ;creates an array of lines the length of the form with nothing but
 ;line numbers on the left
 N I
 F I=TOP+1:1:BOT+1 S @VALMAR@(I,0)=$S(((I>1)&(I#$S($G(IBFORM("PAGE_HT")):IBFORM("PAGE_HT"),1:1000)=1)):"NP >",1:$J((I)#1000,3,0)_" ")_$J("",W)_":" D CNTRL^VALM10(I,4,1,IORVON,IORVOFF)
 Q
 ;
ANCHORS ;blanks out the areas near the anchors
 N PAGE
 I IBFORM("SCAN") F PAGE=1:1:IBFORM("PAGES") D
 .D WHITEOUT(((PAGE-1)*IBFORM("PAGE_HT")+1),5,5)
 .D WHITEOUT(((PAGE-1)*IBFORM("PAGE_HT")+1),67,9)
 .D WHITEOUT(((PAGE-1)*IBFORM("PAGE_HT")+1),131,6)
 .D WHITEOUT((((PAGE)*IBFORM("PAGE_HT"))),5,5)
 .D WHITEOUT((((PAGE)*IBFORM("PAGE_HT"))),67,9)
 .D WHITEOUT((((PAGE)*IBFORM("PAGE_HT"))),131,6)
 Q
 ;
WHITEOUT(IBY,IBX,LEN) ;erases at (IBY,IBX) for LEN characters
 N CURLINE
 S CURLINE=$G(@VALMAR@(IBY,0))
 S CURLINE=$$SETSTR^VALM1(" ",CURLINE,IBX,LEN)
 D SET^VALM10(IBY,CURLINE)
 Q
 ;
PGBNDRY(ROW,HT,PGHT,NAME) ;checks the if the block=NAME starting at ROW and of hight HT overlaps a page boundry - if so a warning is displayed
 I (ROW\PGHT)<((ROW+HT-1)\PGHT) W !,"WARNING: The block = ",NAME," overlaps page boundries!" D PAUSE^IBDFU5
 Q
