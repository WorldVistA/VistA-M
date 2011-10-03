ONCOSSA3 ;WASH ISC/SRR-Print life tables ;11/1/93  12:34
 ;;2.11;ONCOLOGY;**13**;Mar 07, 1995
 ;
PRINT ;print actuarial life tables
 ;in:  CASES,LEN,GRP,HEADER,INTS,NGRPS,NPG,XCRT,^TMP($J
 ;out: NPG
 N INT,LEFT,LOSSES,MORTS,PSURV
 S ONCOEX=0 F GRP=1:1:NGRPS Q:ONCOEX  D:CASES(GRP) PRLT
 Q
 ;
PRLT ;print life table
 S (MORTS,LOSSES)=0,LEFT=CASES(GRP),PSURV=100,INTS=INTS(GRP)
 I ($Y+INTS+2<IOSL)&(NPG>0) D WGRP
 E  D WHEAD Q:ONCOEX
 F INT=0:1:INTS Q:ONCOEX  D WINT,WHEAD:INT<INTS&($Y=IOSL)
 Q
 ;
WHEAD ;write header
 D TOF Q:ONCOEX  W $P(HEADER,U,1),"Life Table",?IOM-30,$P(HEADER,U,2),NPG,!
 W "  ",$P(LEN,U,3),?11,"% Alive",?21,"# Left",?31,"Deaths",?41,"Losses",!
 F X=1:1:IOM W "-"
WGRP W ! W:NGRPS>1 "Group ",$C(GRP+64),":  ",^TMP($J,"GRP",GRP),!
 Q
 ;
TOF ;write top of form & bump page
 I XCRT,NPG,'$G(ONCOEX) W *7 R !,"Enter RETURN to continue or '^' to exit: ",X:DTIME S ONCOEX=$S('$T:1,X="^":1,1:0)
 I '$G(ONCOEX) W:$Y @IOF S NPG=NPG+1
 Q
 ;
WINT ;write (& compute) an interval
 S LOSSES=+$G(^TMP($J,"LT",GRP,INT,0)),MORTS=+$G(^(1))
 W $J(INT,5),?12,$J(PSURV,5,1),?22,$J(LEFT,5),?32,$J(MORTS,5)
 W ?42,$J(LOSSES,5),!
 S PSURV=$S(MORTS=0:PSURV,LEFT=0:0,1:PSURV*(1-(MORTS/(LEFT-(LOSSES/2)))))
 S LEFT=LEFT-MORTS-LOSSES
 Q
