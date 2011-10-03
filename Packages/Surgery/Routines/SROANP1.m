SROANP1 ;B'HAM ISC/MAM - LIST OF ANESTHETIC PROCEDURES ; [ 09/22/98  11:28 AM ]
 ;;3.0; Surgery ;**77,50**;24 Jun 93
EN ;
 S (SRF,SRFLG,SRSOUT)=0 W @IOF,!,"List of Anesthetic Procedures"
 D DATE^SROUTL(.SRSD,.SRED,.SRSOUT) G:SRSOUT END
ASK W @IOF,!,"Print List of Anesthetic Procedures for",!!,"1. O.R. Surgical Procedures.",!,"2. Non-O.R. Procedures.",!,"3. Both O.R. Surgical Procedures and Non-O.R. Procedures."
 W !!,"Select Number:  1// " R X:DTIME I '$T!(X["^") G END
 S:X="" X=1 I X>3!(X<1)!(X'?.N) D HELP G:SRSOUT END G ASK
 S SRFLG=X
 K IOP,%ZIS,POP,IO("Q") S %ZIS("A")="Print the Report on which Device: ",%ZIS="QM" W !!,"This report is designed to use a 132 column format.",! D ^%ZIS G:POP END
 I $D(IO("Q")) K IO("Q") S ZTDESC="LIST OF ANESTHETIC PROCEDURES",ZTRTN="EN1^SROANP1",(ZTSAVE("SRED"),ZTSAVE("SRSD"),ZTSAVE("SRFLG"),ZTSAVE("SRSITE*"))="" D ^%ZTLOAD G END
EN1 D BEG^SROANP
END W:$E(IOST)="P" @IOF I $D(ZTQUEUED) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 I 'SRF,$E(IOST)'="P" W !!,"Press RETURN to continue " R X:DTIME
 D ^SRSKILL K SRTN D ^%ZISC W @IOF
 Q
HELP W !!,"Enter '1' or press <RET> to print the List of Anesthetic Procedures",!,"performed in the OR with a surgical procedure.  Enter '2' to print the"
 W !,"List of Anesthetic Procedures performed as or with a Non-OR Procedure.",!,"Enter '3' to print the List of Anesthetic Procedures including both of",!,"the above categories of procedures."
 W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1
 Q
HDR I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRF=1 Q
 W:$Y @IOF W !,?(132-$L(SRINST)\2),SRINST,?120,"PAGE: "_PAGE,!,?58,"SURGICAL SERVICE",?100,"REVIEWED BY:",!,?51,"LIST OF ANESTHETIC PROCEDURES",?100,"DATE REVIEWED:"
 W !,$S(SRFLG=1:"O.R. SURGICAL PROCEDURES",SRFLG=2:"NON-O.R. PROCEDURES",1:"O.R. SURGICAL AND NON-O.R. PROCEDURES"),?(132-$L(SRFRTO)\2),SRFRTO,?100,SRPRINT
 W !!,?2,"DATE",?18,"PATIENT",?45,"PRINCIPAL DIAGNOSIS",?97,"PRIN ANESTHETIST",?117,"START TIME",!,?2,"CASE #",?20,"ID#",?45,"PROCEDURE(S)",?97,"ANESTH TECHNIQUE",?118,"END TIME"
 W !,?17,"ASA CLASS",?97,"ANESTH AGENT",?118,"ELAPSED",! F LINE=1:1:IOM W "="
 S PAGE=PAGE+1
 Q
