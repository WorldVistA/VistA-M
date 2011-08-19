PRCGU ;WIRMFO@ALTOONA/CTB  PURGEMASTER UTILITY PROGRAM ;12/10/97  10:55 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
UPDATE ;
 W IORC D POS(XPOS+(PERCENT\2),YPOS) W CURSOR
 QUIT
POS(DX,DY) I $E(IOST)'="C" W ! QUIT
 I DX=""!(DY="") QUIT
 X IOXY
 QUIT
PERCENT ;
 Q:XCOUNT'>0
 Q:TREC'>0
 S:'$D(ITEMS) ITEMS="items"
 S PERCENT=XCOUNT/TREC*100\1 I PERCENT>99.99999 S PERCENT=100
 I $E(IOST)="C" D UPDATE
 D
 . W !!!,$FN($S(PERCENT=100:TREC,XCOUNT<0:0,1:XCOUNT),",")," of ",$FN(TREC,",")," ",ITEMS," processed.  ",PERCENT,"% complete "
 . S TIME=$P($H,",",2)
 . S:BTIME>TIME TIME=TIME+86400
 . S TIME=TIME-BTIME
 . S TTIME=TIME/$S((PERCENT>0):(PERCENT*.01),1:.01),RTIME=TTIME-TIME
 . D TIME(TTIME,"required")
 . D TIME(TIME,"elapsed")
 . D TIME($P(RTIME,"."),"remaining")
 . I $E(IOST)'="C" QUIT
 . QUIT
 QUIT
S(X) Q $S(X'=1:"s",1:"")
TIME(X,Y) ;
 NEW HOURS,MIN,SEC
 S HOURS=0,MIN=0,SEC=0
 I X>3600 S HOURS=X\3600,X=X#3600
 S MIN=X\60,SEC=$P(X#60,".")
 I $E(IOST,1,2)="C-" W !
 W:HOURS HOURS," Hour"_$$S(HOURS)_", "
 W:MIN MIN_" Minute"_$$S(MIN)_", "
 W SEC_" Second"_$$S(SEC)_" "_Y_".                "
 Q
BEGIN ;
 W:$G(IOF)'="" @IOF
 I $E(IOST)="C",'$D(ZTQUEUED) S X="IORVON;IORVOFF;IORC;IOSC" D ENDR^%ZISS
 I $D(IORVON),$D(IORVOFF) S CURSOR=IORVON_" "_IORVOFF
 S LREC=$S($E(IOST)="C":TREC\200+1,1:TREC\20+1)
 W !! S X=MESSAGE D MSG
 S LINE="              |-------------------------+-------------------------|"
 I $E(IOST)="C" W !,?25,"P E R C E N T   C O M P L E T E",!!?18,"                     50                        100",!,LINE,!?14,"|",?66,"|",!,LINE,!
 S DA=0,LASTENT=0,XPOS=15,YPOS=$Y-2,BTIME=$P($H,",",2),XCOUNT=-1
 D POS(XPOS,YPOS) W:$E(IOST)="C" IOSC
 QUIT
END ;
 K X S $P(X," ",40)=""
 W !,"100% complete."_X,!
 D:$G(XPDNM)="" KILL^%ZISS
CLOSE ;CLOSE ALL OPEN DEVICES OTHER THAN THE HOME DEVICE
 N N
 S N=0 F  S N=$O(IO(1,N)) Q:'N  I N'=IO(0) S IO=N D ^%ZISC
 QUIT
MSG ;;PRINTS MESSAGE CONTAINED IN X.  IF IT DOESNT FIT ON ONE LINE, X IS PRINTED ON THE NEXT LINE.
 N X1,X2,ZX Q:'$D(X)  I $S('$D(IOM):1,IOM="":1,1:0) W $P(X,"*") R X:2 K X Q
 I ($L($P(X,"*"))+4+$X)>IOM W !,?(IOM-($L($P(X,"*"))+4))
 F ZX=1:1 D BRK:($L(X)+6)>IOM W "  ",$P(X,"*"),! Q:'$D(X1)  S X=X1 K X1
 W:X["*" *7
 QUIT
BRK N I
 S X1=X F I=1:1 Q:$L($P(X," ",1,I))>(IOM-6)!($L(X)<(IOM-6))  S X1=$P(X," ",1,I)
 S X2=$P(X," ",I,999),X=X1,X1=X2 K X2
 QUIT
DIR() ;SET VARIABLE STRING RETURNING FROM DIR
 NEW X
 S X=$D(DTOUT)_$D(DUOUT)_$D(DIRUT)_$D(DIROUT)
 K DTOUT,DUOUT,DIRUT,DIROUT
 Q X
