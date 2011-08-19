DVBCFEE ;ALB/GTS-557/THM-FEE BASIS COVER SHEET ; 7/1/91  7:48 PM
 ;;2.7;AMIE;;Apr 10, 1995
 ;
 D HOME^%ZIS S FF=IOF
 ;
COPY W @IOF,!,"Print Cover Sheet for Fee Exam",!!!,"Number of copies: " R DVBCCOPY:DTIME G:'$T!(DVBCCOPY=U) EXIT
 I +DVBCCOPY<1!(+DVBCCOPY>10) W *7,!!,"You cannot print less than one or more than ten copies per session.",!! H 3 G COPY
 W !!,"Fee exam cover sheets should be sent to a printer." S %ZIS="AEQ",%ZIS("A")="Printing device: " D ^%ZIS K %ZIS G:POP EXIT
 I $D(IO("Q")) S ZTRTN="GO^DVBCFEE",ZTIO=ION,ZTDESC="Print C&P Fee Cover Sheet",ZTSAVE("DVBC*")="" D ^%ZTLOAD W:$D(ZTSK) !!,"Request queued.",!! G EXIT
GO U IO F DVBCX=1:1:DVBCCOPY D GO1
 ;
EXIT D:$D(ZTQUEUED) KILL^%ZTLOAD K DVBCCOPY,DVBCX G KILL^DVBCUTIL
 ;
GO1 W:(IOST?1"C-".E) @IOF K ^UTILITY($J,"W") D ^DVBCLTR
 W !!!,?(IOM-$L($$SITE^DVBCUTL4)\2),$$SITE^DVBCUTL4,!!!!
 F ZZI=0:1 S LY=$T(TXT+ZZI) Q:LY["END"  S X=$P(LY,";;",2),DIWF="R",DIWR=80,DIWL=1 D ^DIWP
 D ^DIWW
 K LY,TXT W @IOF Q
 ;
TXT ;;Notice to the fee basis physician:
 ;;
 ;;
 ;;The nature of a Compensation and Pension examination is different from the
 ;;regular exam that you perform.  Unlike a regular examination where the
 ;;objective is to provide a diagnosis and a course of treatment, the C & P
 ;;examination is used to provide a diagnosis and assess the residual condition.
 ;;The payment of benefits, as determined by the VA Regional Office rating
 ;;board, is determined (in part) by your assessment of the Veteran's degree
 ;;of disability.
 ;;END
