SROACCT ;B'HAM ISC/MAM - TOTAL CPT CODES ; [ 09/22/98  11:20 AM ]
 ;;3.0; Surgery ;**77,50,124**;24 Jun 93
BEG S (SRFLG,SRSOUT)=0
 W @IOF,!,"Cumulative Report of CPT Codes"
START D DATE^SROUTL(.SDATE,.EDATE,.SRSOUT) G:SRSOUT END
 S SDATE1=SDATE-.0001,EDATE1=EDATE+.9999
ASK W @IOF,!,"Include which cases on the Cumulative Report of CPT Codes ?",!!,"1. O.R. Surgical Procedures",!,"2. Non-O.R. Procedures",!,"3. Both O.R. Surgical Procedures and Non-O.R. Procedures."
 W !!,"Select Number:  1// " R X:DTIME I '$T!(X["^") G END
 S:X="" X=1 I X>3!(X<1)!(X'?.N) D HELP G:SRSOUT END G ASK
 S SRFLG=X
 W !!,"This report is designed to use a 132 column format.",!!
 K IOP,%ZIS,POP,IO("Q") S %ZIS("A")="Select Device: ",%ZIS="QM" D ^%ZIS I POP S SRSOUT=1 G END
 I $D(IO("Q")) K IO("Q") S ZTRTN="EN^SROACCT",(ZTSAVE("SDATE*"),ZTSAVE("EDATE*"),ZTSAVE("SRSITE*"))="",ZTSAVE("SRFLG")=SRFLG,ZTDESC="CUMULATIVE REPORT OF CPT CODES" D ^%ZTLOAD G END
EN D EN^SROACCM
END W:$E(IOST)="P" @IOF I $D(ZTQUEUED) K ^TMP("SR",$J) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 I 'SRSOUT,$E(IOST)'="P" W !!,"Press RETURN to continue  " R X:DTIME
 D ^%ZISC K SRTN D ^SRSKILL W @IOF
 Q
HELP W !!,"Enter '1' or press <RET> to include only cases for O.R. surgical procedures,",!,"enter '2' to include only cases for non-O.R. procedures, or enter '3' to include"
 W !,"cases for both O.R. surgical procedures and non-O.R. procedures on the report."
 W !!,"Press <RET> to continue, or '^' to quit.  " R X:DTIME I '$T!(X["^") S SRSOUT=1
 Q
