ABSVU3 ;ALTOONA/CTB  SCREEN UPDATE UTILITY PROGRAM ;8/31/95  4:29 PM
V ;;4.0;VOLUNTARY TIMEKEEPING;**6**;JULY 6, 1994
PERCENT ;
 N TIME,RTIME,TTIME,DX,DY,LINE
 S $P(LINE," ",40)=""
 S PERCENT=XCOUNT/TREC*100\1
 I $E(IOST)="C" W CURSOR S XPOS=XPOS+1
 D
 . W !
 . I 'NOCOUNT W XCOUNT," of ",TREC," items processed.  "
 . W $J((PERCENT/1),0,0),"% complete "_$E(LINE,1,15)
 . S TIME=$P($H,",",2)
 . S:BTIME>TIME TIME=TIME+86400
 . S TIME=TIME-BTIME
 . S TTIME=TIME/(PERCENT*.01),RTIME=TTIME-TIME
 . D TIME(TTIME,"required")
 . D TIME(TIME,"elapsed")
 . D TIME($P(RTIME,"."),"remaining")
 . I $E(IOST)'="C" QUIT
 . S DX=XPOS,DY=A
 . X IOXY
 . QUIT
 QUIT
TIME(X,Y) ;
 NEW HOURS,MIN,SEC
 S $P(LINE," ",IOM)=""
 S HOURS=0,MIN=0,SEC=0
 I X>3600 S HOURS=X\3600,X=X#3600
 S MIN=X\60,SEC=$P(X#60,".")
 W:$E(IOST,1,2)="C-" !
 W:HOURS HOURS," Hours, "
 W MIN_" Minutes, "_SEC_" Seconds "_Y_"."_$E(LINE,1,15)
 Q
BEGIN ;
 U IO W @IOF
 I '$D(NOCOUNT) S NOCOUNT=0
 S CURSOR="*"
 I $E(IOST)="C",'$D(ZTQUEUED) S X="IORVON;IORVOFF" D ENDR^%ZISS
 I $D(IORVON),$D(IORVOFF) S CURSOR=IORVON_" "_IORVOFF
 S LREC=$S($E(IOST)="C":TREC\80+1,1:TREC\20+1)
 W !! S X=MESSAGE D MSG^ABSVQ
 S LINE="---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+"
 I TREC>79,$E(IOST)="C" W !,?25,"P E R C E N T   C O M P L E T E",!!,"      10      20      30      40      50      60      70      80      90     100",!,LINE,!
 I TREC<80,$E(IOST)="C" W !?(TREC-2),"100%",!?TREC,"|"
 S DA=0,LASTENT=0,XPOS=0,A=$Y,BTIME=$P($H,",",2),XCOUNT=0
 QUIT
END ;
 K X S $P(X," ",40)=""
 W !!!!,"100% complete."_X,!
 D KILL^%ZISS
 K CURSOR,LREC,MESSAGE,TREC,LINE,XPOS,A,BTIME,XCOUNT
 QUIT
