RMPFQS ;DDC/KAW-PURGE ORDERS; [ 06/16/95   3:06 PM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;;JUN 16, 1995
RMPFSET I '$D(RMPFMENU) D MENU^RMPFUTL I '$D(RMPFMENU) W !!,$C(7),"*** A MENU SELECTION MUST BE MADE ***" Q  ;;RMPFMENU must be defined
 I '$D(RMPFSTAN)!'$D(RMPFDAT)!'$D(RMPFSYS) D ^RMPFUTL Q:'$D(RMPFSTAN)!'$D(RMPFDAT)!'$D(RMPFSYS)
 W @IOF,!,"PURGE ORDERS",!!?23,"*** WARNING ***"
 W !!,"This routine will permanently purge orders from the disk."
 W !,"The number of days to retain orders with a status that can be purged"
 W !,"is controlled by the parameter file.  If a status has no entry in the"
 W !,"parameter file, it will be purged 30 days after the last action on the order."
 W !!,"Only orders with one of the following statuses will be purged: ",! K RM
 F IX=1:1 S X=$T(STATUS+IX) Q:X=""  D
 .S A=$P(X,";",3),B=$P(X,";",4),C=$P(X,";",5),D=$P(X,";",6)
 .I RMPFMENU=10 Q:A="R"
 .S E=$P(RMPFSYS(1),U,D) S:E="" E=30
 .W !?3,"<",A,"> ",B,?35,"More than ",E," days since last action."
 .S RMPF(A)=C_U_E
STATS W !!,"Enter an <*> to purge all statuses or status(es) selected by letter(s): " D READ G END:$D(RMPFOUT)
STATS1 I $D(RMPFQUT) W !!,"Enter an <*> to purge all orders with a status listed above or",!?6,"the letter or letters to the left of each status separated by commas",!?6,"to select specific statuses." G STATS
 G END:Y="" K RMPFP
 I Y="*" S X=0 F  S X=$O(RMPF(X)) Q:X=""  S Y1=$P(RMPF(X),U,1),RMPFP(Y1)=$P(RMPF(X),U,2)
 G VIEW:Y="*"
 F I=1:1 S X=$P(Y,",",I) Q:X=""  D  I $D(RMPFOUT) S RMPFQUT="" G STATS1
 .I '$D(RMPF(X)) S RMPFOUT="" Q
 .S W=$P(RMPF(X),U,1),RMPFP(W)=$P(RMPF(X),U,2) K W
VIEW W !!,"<P>rint orders to be purged or <RETURN> to continue: " K RMPFL
 D READ G END:$D(RMPFOUT)
VIEW1 I $D(RMPFQUT) W !!,"Enter a <P> to print a list of the orders to be purged or",!?8,"<RETURN> to continue with the process." G VIEW
 G ASK:Y="" S Y=$E(Y,1) I "Pp"'[Y S RMPFQUT="" G VIEW1
 S RMPFL="" D QUE K RMPFL G ASK:'$D(RMPFCX)
ASK I $D(RMPFCX) G END:'RMPFCX
 W !!!!,"Do you wish to purge these orders now?  NO// " D READ
 G END:$D(RMPFOUT)
ASK1 I $D(RMPFQUT) D  G ASK
 .W !!,"Enter <Y> to permanently purge old orders with one of the following",!,"statues:",!
 .S X=0 F  S X=$O(RMPFP(X)) Q:'X  I $D(^RMPF(791810.2,X,0)) W !,$P(^(0),U,1)
 S:Y="" Y="N" S Y=$E(Y,1) I "YyNn"'[Y S RMPFQUT="" G ASK1
 G END:"nN"[Y
SURE W !!,"Are you sure? NO// " D READ
 G END:$D(RMPFOUT)
SURE1 I $D(RMPFQUT) W !!,"Enter <Y> to begin the purge, <N> or <RETURN> to exit." G SURE
 K RMPFL S:Y="" Y="N" S Y=$E(Y,1) I "YyNn"'[Y S RMPFQUT="" G SURE1
 G END:"nN"[Y S RMPFCX=0,ZTIO="",ZTRTN="RUN^RMPFQS",ZTSAVE("RM*")=""
 S ZTDESC="PURGE ROES FILES" D ^%ZTLOAD W !!,"*** Request Queued ***"
END K %XX,%YY,A,B,C,D,E,IX,POP,RMPF,RMPFP,Y,ZTSK,RMPFCX,I,%X,%Y Q
RUN ;; input: RMPFP
 ;;output:  None
 S X="NOW",%DT="T" D ^%DT S TD=Y
 S DIE="^RMPF(791813,",DA=RMPFSTAN,DR="2.03////"_DUZ_";2.04////"_TD
 D ^DIE,PURGE^RMPFQS1,BATCH^RMPFQS1
 K RMPFP,RMPFS,ZTSK,%H,%T,Y,TD,%DT,DIE,DR,DA,D,D0,DI,DQ Q
READ K RMPFOUT,RMPFQUT
 R Y:DTIME I '$T W $C(7) R Y:5 G READ:Y="." S:'$T Y=U
 I Y?1"^".E S (RMPFOUT,Y)="" Q
 S:Y?1"?".E (RMPFQUT,Y)=""
 Q
QUE W ! S %ZIS="NPQ" D ^%ZIS G END:POP
 I IO=IO(0),'$D(IO("S")) D PURGE^RMPFQS1 Q
 I $D(IO("S")) S %ZIS="",IOP=ION D ^%ZIS D PURGE^RMPFQS1 Q
 S ZTRTN="PURGE^RMPFQS1",ZTDESC="ROES FILE PURGE",ZTIO=ION,ZTSAVE("RM*")=""
 D ^%ZTLOAD,HOME^%ZIS
 W:$D(ZTSK) !!,"*** Request Queued ***" H 2
 Q
STATUS ;;Statuses to purge
 ;;C;COMPLETE;8;4
 ;;D;DISAPPROVED;7;2
 ;;E;ERROR;6;3
 ;;I;INCOMPLETE;1;1
 ;;N;CANCELED;11;6
 ;;R;ADJUSTMENT REJECTED;10;5
