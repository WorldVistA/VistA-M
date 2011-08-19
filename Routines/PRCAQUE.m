PRCAQUE ;SF-ISC/YJK-AR LIST,REPORT SUBROUTINE -ASK QUEUEING ;4/24/92  8:53 AM
V ;;4.5;Accounts Receivable;;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
QUE K PRCAQUE S %=2 W !,PRCA("MESS") D YN^DICN Q:%<0  W " "
 I %=0 W !,"Answer <YES> or <NO>" G QUE
QUE1 K IO("Q") S %ZIS("B")="",%ZIS="M",PRCA("DEV")="" S:%=1 %ZIS="MQ",PRCA("DEV")="Q;",IOP="Q"
 D ^%ZIS Q:POP  S PRCA("DEV")=PRCA("DEV")_ION_";"_IOST_";"_IOM_";"_IOSL,PRCA("IOSAVE")=IO(0)
 ;
CKQUE I $D(PRCA("DEV")) S IOP=PRCA("DEV"),%ZIS="M",%ZIS("B")="" S:PRCA("DEV")["Q;" %ZIS="MQ"
 S PRCAQUE="" Q
ASKDT ;to set the 'sort by date' for the report. called by EN8^PRCAQUE
 S:'$D(PRCA("DATE")) PRCA("DATE")="DATE" S (PRCADT1,PRCADT2,PRCAKDT1,PRCAKDT2)="",%DT="AEP",%DT("A")="START WITH "_PRCA("DATE")_": " D ^%DT I Y<0 Q
 S PRCADT1=+Y S:PRCADT1'>0 PRCADT1=2700101
 S %DT="AEP",%DT("A")="GO TO "_PRCA("DATE")_": " D ^%DT Q:Y<0  S PRCADT2=+Y I PRCADT1>PRCADT2 W *7,"  Dates are not appropriate." G ASKDT
 K %DT S PRCAKDT1=$E(PRCADT1,4,5)_"/"_$E(PRCADT1,6,7)_"/"_$E(PRCADT1,2,3),PRCAKDT2=$E(PRCADT2,4,5)_"/"_$E(PRCADT2,6,7)_"/"_$E(PRCADT2,2,3) Q
D ;CONVERTS FILEMAN INTERNAL DATE TO EXTERNAL FORMAT
 S:Y Y=$S($E(Y,4,5):$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",+$E(Y,4,5))_" ",1:"")_$S($E(Y,6,7):+$E(Y,6,7)_",",1:"")_($E(Y,1,3)+1700)_$P("@"_$E(Y_0,9,10)_":"_$E(Y_"000",11,12),"^",Y[".")
 Q
