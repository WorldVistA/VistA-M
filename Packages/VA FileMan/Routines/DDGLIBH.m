DDGLIBH ;SFISC/MKO-SCREEN EDITOR HELP ; 15NOV2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
HLP(DDGLHN1,DDGLHN2,DDGLSUB,DDGLPLN) ;
 ;DDGLHN1  = Entry number in Dialog file of first help screen
 ;DDGLHN2  = Entry number of last help screen
 ;DDGLSUB  = Subscript in ^TMP to copy help to
 ;DDGLPLN  = $Y to print prompt
 ;
 N DX,DY,DDGLI,DDGLJ,DDGLSC,DDGLTX,DDGLX,DIHELP,DDGL0
 S DDGL0=$C(31)
 D:'$D(DDGLH) GETKEY
 I $D(IOTM)[0 N IOTM S IOTM=1
 I $D(IOBM)[0 N IOBM S IOBM=IOSL
 I '$G(DDGLPLN) S DDGLPLN=IOBM-1
 S DDGLSC=DDGLHN1
 ;
 D DISP(DDGLHN1)
 ;
 F  S DDGLX=$$READ D @DDGLX Q:DDGLX=U
 Q
 ;
UP I DDGLSC>DDGLHN1 S DDGLSC=DDGLSC-1 D DISP(DDGLSC)
 Q
 ;
DN I DDGLSC<DDGLHN2 S DDGLSC=DDGLSC+1 D DISP(DDGLSC)
 Q
 ;
TO W $C(7)
QT S DDGLX=U
 Q
 ;
PT ;Prompt for device and print
 ;Clear screen
 N POP
 N %,%A,%B,%B1,%B2,%B3,%BA,%C,%E,%G,%H,%I,%J,%K,%M,%N
 N %P,%S,%T,%W,%X,%Y
 N %A0,%D1,%D2,%DT,%J1,%W0
 ;
 S DY=IOTM-1,DX=0 X IOXY
 W $P(DDGLVID,DDGLDEL)_"PRINT THE HELP SCREENS"_$P(DDGLVID,DDGLDEL,10)_$P(DDGLCLR,DDGLDEL)
 F DDGLI=1:1:IOBM-IOTM W $C(13,10)_$P(DDGLCLR,DDGLDEL)
 S DY=IOTM+1,DX=0 X IOXY
 ;
 X DDGLZOSF("EON"),DDGLZOSF("TRMOFF")
 S X=$G(IOM,80) X DDGLZOSF("RM") ; VEN/SMH changed.
 W $P(DDGLVID,DDGLDEL,9)
 ;
DEVICE ;Device prompt
 N IOF,IOSL
 S IOF="#",IOSL=IOBM-IOTM+1 ;In case help frames are invoked
 S %ZIS=$S($D(^%ZTSK):"Q",1:""),%ZIS("B")=""
 D ^%ZIS K %ZIS
 ;
 I POP D
 . W !!,"Report canceled!"
 . H 2
 ;
 ;Queue report
 E  I $D(IO("Q")),$D(^%ZTSK) D
 . S ZTRTN="PRINT^DDGLIBH"
 . S ZTDESC="Help screen printout."
 . N I F I="DDGLHN1","DDGLHN2" S ZTSAVE(I)=""
 . D ^%ZTLOAD
 . I $D(ZTSK)#2 W !,"Report queued!",!,"Task number: "_ZTSK,!
 . E  W !,"Report canceled!",!
 . K ZTSK
 . S IOP="HOME" D ^%ZIS
 ;
 E  I $E(IOST,1,2)="C-" D
 . W !,$C(7)_"You cannot print the help screens on a CRT.",!
 . H 2
 ;
 ;Non-queued report
 E  D
 . W !,"Printing ..."
 . U IO
 . D PRINT
 . X $G(^%ZIS("C"))
 ;
 ;Repaint help screen
 X DDGLZOSF("EOFF"),DDGLZOSF("TRMON")
 S X=0 X DDGLZOSF("RM") ; VEN/SMH changed.
 W $P(DDGLVID,DDGLDEL,8)
 D DISP(DDGLSC)
 Q
 ;
PRINT ;
 N DDGLJ,DDGLL,DDGLP
 F DDGLI=DDGLHN1:1:DDGLHN2 D
 . I DDGLI'=DDGLHN1 D
 .. I $Y+$O(^DI(.84,DDGLI,2," "),-1)+2'<IOSL W @IOF
 .. E  W !!
 . S DDGLJ=0
 . F  S DDGLJ=$O(^DI(.84,DDGLI,2,DDGLJ)) Q:'DDGLJ  D
 .. S DDGLL=$G(^DI(.84,DDGLI,2,DDGLJ,0))
 .. F  Q:DDGLL'["\"  D
 ... S DDGLP=$F(DDGLL,"\") Q:$E(DDGLL,DDGLP)="\"
 ... S $E(DDGLL,DDGLP-1,DDGLP)=""
 .. W !,DDGLL
 ;
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
DISP(DDGLHN) ;Print help screen DDGLHN
 N DDGLHARR
 S DDGLHARR=$NA(^TMP(DDGLSUB,$J,DDGLHN))
 D:'$D(@DDGLHARR) BLD^DIALOG(DDGLHN,"","",DDGLHARR)
 ;
 S DY=IOTM-1,DX=0 X IOXY
 F DDGLI=1:1 Q:'$D(@DDGLHARR@(DDGLI))  S DDGLTX=^(DDGLI) D
 . I DDGLTX["\B" F  S DDGLJ=$F(DDGLTX,"\B") Q:'DDGLJ  D
 .. S $E(DDGLTX,DDGLJ-2,DDGLJ-1)=$P(DDGLVID,DDGLDEL)
 . I DDGLTX["\n" F  S DDGLJ=$F(DDGLTX,"\n") Q:'DDGLJ  D
 .. S $E(DDGLTX,DDGLJ-2,DDGLJ-1)=$P(DDGLVID,DDGLDEL,10)
 . W $S(DDGLI>1:$C(13,10),1:"")_DDGLTX_$P(DDGLCLR,DDGLDEL)
 ;
 F DDGLI=DDGLI:1:IOBM-IOTM+1 W $C(13,10)_$P(DDGLCLR,DDGLDEL)
 Q
 ;
READ() ;
 S DY=DDGLPLN,DX=0 X IOXY
 W $P(DDGLCLR,DDGLDEL)_"Press "
 W:DDGLSC>DDGLHN1 $P(DDGLVID,DDGLDEL)_"<Up>"_$P(DDGLVID,DDGLDEL,10)_" for previous page, "
 W:DDGLSC<DDGLHN2 $P(DDGLVID,DDGLDEL)_"<Down>"_$P(DDGLVID,DDGLDEL,10)_" for next page, "
 W $P(DDGLVID,DDGLDEL)_"P"_$P(DDGLVID,DDGLDEL,10)_" to print, "
 W $P(DDGLVID,DDGLDEL)_"^"_$P(DDGLVID,DDGLDEL,10)_" to exit: "
 D GETCH(DTIME,.DDGLX)
 S DY=DDGLPLN,DX=0 X IOXY W $P(DDGLCLR,DDGLDEL)
 Q DDGLX
 ;
GETCH(DTIME,Y) ;Out: Y = Mnemonic
 F  D  Q:Y'=-1
 . R *Y:DTIME
 . I Y<0 S Y="TO" Q
 . D MNE(.Y)
 Q
 ;
MNE(Y) ;Out: Y = Mnemonic, or -1 if invalid
 N S,F
 S S="",F=0
 F  D MNELOOP Q:F
 Q
 ;
MNELOOP ;Read more
 S S=S_$C(Y)
 I DDGLH("IN")'[(DDGL0_S) D  I Y=-1 D FLUSH Q
 . I $C(Y)'?1L S Y=-1 Q
 . S S=$E(S,1,$L(S)-1)_$C(Y-32)
 . S:DDGLH("IN")'[(DDGL0_S_DDGL0) Y=-1
 ;
 I DDGLH("IN")[(DDGL0_S_DDGL0),S'=$C(27) D  Q
 . S Y=$P(DDGLH("OUT"),DDGL0,$L($P(DDGLH("IN"),DDGL0_S_DDGL0),DDGL0)),F=1
 ;
 R *Y:5 D:Y=-1 FLUSH
 Q
 ;
FLUSH ;
 N DDGLZ
 S F=1 W $C(7) F  R *DDGLZ:0 E  Q
 Q
 ;
GETKEY ;Get key sequences and defaults
 N AU,AD,F1,PREVSC,NEXTSC
 N I,K,N,T
 S AU=$P(DDGLKEY,U,2)
 S AD=$P(DDGLKEY,U,3)
 S F1=$P(DDGLKEY,U,6)
 S PREVSC=$P(DDGLKEY,U,14)
 S NEXTSC=$P(DDGLKEY,U,15)
 ;
 K DDGLH
 S DDGLH("IN")="",DDGLH("OUT")=""
 F I=1:1 S T=$P($T(MAP+I),";;",2,999) Q:T=""  D
 . S @("K="_$P(T,";",2))
 . I DDGLH("IN")'[(DDGL0_K),K]"" D
 .. S DDGLH("IN")=DDGLH("IN")_DDGL0_K
 .. S DDGLH("OUT")=DDGLH("OUT")_$P(T,";")_DDGL0
 S DDGLH("IN")=DDGLH("IN")_DDGL0
 S DDGLH("OUT")=$E(DDGLH("OUT"),1,$L(DDGLH("OUT"))-1)
 Q
 ;
MAP ;Keys
 ;;DN;$C(13)
 ;;DN;AD
 ;;DN;F1_AD
 ;;DN;NEXTSC
 ;;UP;AU
 ;;UP;F1_AU
 ;;UP;PREVSC
 ;;QT;F1_"E"
 ;;QT;F1_"Q"
 ;;QT;"^"
 ;;PT;"P"
