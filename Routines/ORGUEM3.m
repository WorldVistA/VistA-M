ORGUEM3 ; slc/KCM - Setup Formatted Protocol Menus (cont) ;7/13/92  15:40
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
 ;;
HLP ;Provide help for ORCL PROTOCOL MENU SETUP menu
 N ORGPOP
 I X="?" D  G HLPX
 . D DISP^XQORM1
 . W !!
 I X["??" D  G HLPX
 . N Y D SEQ(+XQORNOD,.Y)
 . S (DX,DY)=0 X ^%ZOSF("XY")
 . F I=1:1:Y I ^ORD(101,$P(Y(I),"^",2),0)'?1"ORB".E D  Q:$D(ORGPOP)
 . . W !,$P(^ORD(101,+XQORNOD,10,+Y(I),0),"^",2)
 . . S J=0 F  S J=$O(^ORD(101,$P(Y(I),"^",2),1,J)) Q:J'>0  D  Q:$D(ORGPOP)
 . . . W ?5,^ORD(101,$P(Y(I),"^",2),1,J,0),!
 . . . I $Y>22 D
 . . . . W "Press RETURN to continue or '^' to exit: "
 . . . . R X:DTIME S:'$T!(X["^") ORGPOP=1 W $C(13)
 . . . . S (DX,DY)=0 X ^%ZOSF("XY")
 . W !
HLPX Q
SEQ(PCL,Y) ; For the named protocol (PCL) return array of items in sequence
 ; Y must be call by reference, returned is Y(n)=item ien^protocol
 N X,SEQ,ITM K Y ;(make sure Y is empty)
 S Y=0 ; Y is returned 0 if no items found
 S ITM=0 F  S ITM=$O(^ORD(101,PCL,10,ITM)) Q:ITM'>0  D
 . S X=^ORD(101,PCL,10,ITM,0)
 . ;precedence for sequence is SEQUENCE, numeric MNEMONIC, alpha MNEMONIC, alpha ITEM TEXT
 . S SEQ=$S(+$P(X,"^",3):+$P(X,"^",3),+$P(X,"^",2):+$P(X,"^",2),$L($P(X,"^",2)):"M"_$P(X,"^",2),1:"Z"_$P(^ORD(101,+X,0),"^",2))
 . S X(SEQ,ITM)=+X
 S SEQ="" F  S SEQ=$O(X(SEQ)) Q:SEQ=""  D
 . S ITM="" F  S ITM=$O(X(SEQ,ITM)) Q:ITM=""  D
 . . S Y=Y+1,Y(Y)=ITM_"^"_X(SEQ,ITM)
 Q
LIST ; List protocols on menu
 S %ZIS="Q" D ^%ZIS I POP D HOME^%ZIS Q
 I $D(IO("Q")) D  Q
 . K IO("Q")
 . S ZTRTN="DQ^ORGUEM3",ZTDESC="List Menu Items",ZTSAVE("ORGMENU")=""
 . D ^%ZTLOAD W:$D(ZTSK) !,"List queued." K ZTSK
 . D HOME^%ZIS
DQ U IO N CTM,EOP,ITM,LIST
 D SEQ(+ORGMENU,.LIST)
 S %DT="T",X="NOW" D ^%DT,DD^%DT S CTM=Y
 I $E(IOST)="C" W @IOF,$C(13)
 D HDR1
 F ITM=1:1:LIST S EOP=$$EOP(2) Q:EOP=-1  D:EOP=1 HDR D PITM(LIST(ITM))
 I $E(IOST)'="C" W @IOF
 I $D(ZTQUEUED) S ZTREQ="@"
 I '$D(ZTQUEUED) D ^%ZISC
 Q
HDR ; Print header
 W @IOF,$C(13)
HDR1 W "Menu: ",$P(ORGMENU,"^",2),?61,CTM,!!
 Q
PITM(X) ; Print item fields
 ; ITEM: 123 Displayed Text                          ?64 SEQUENCE: 99.00
 ; NAME: NAME OF PROTOCOL (ITEM TEXT)
 W "ITEM: "
 I $P(^ORD(101,$P(X,"^",2),0),"^",2)?." " W "<blank line>"
 E  D
 . W $P(^ORD(101,+ORGMENU,10,+X,0),"^",2)
 . W ?(6+$S($P($G(^ORD(101,+ORGMENU,4)),"^",2):$P(^(4),"^",2),1:5))
 . W $S($L($P(^ORD(101,+ORGMENU,10,+X,0),"^",6)):$P(^(0),"^",6),1:$P(^ORD(101,$P(X,"^",2),0),"^",2))
 W ?64,"SEQUENCE: ",$S($L($P(^ORD(101,+ORGMENU,10,+X,0),"^",3)):$J($P(^(0),"^",3),5,2),1:""),!
 W "PROTOCOL: ",$P(^ORD(101,$P(X,"^",2),0),"^"),"  "
 I $P(^ORD(101,$P(X,"^",2),0),"^",2)'?1." ",$L($P(^(0),"^",2)) W "(",$P(^(0),"^",2),")"
 W !!
 Q
EOP(LINES) ; Check if end of page, handle CRT & printer advance
 I $Y<(IOSL-LINES) Q 0
 I $E(IOST)="C" D  Q:X["^" -1
 . W "Press RETURN to continue or '^' to exit: "
 . R X:DTIME
 Q 1
