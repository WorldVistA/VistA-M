PSBOMH2 ;BIRMINGHAM/EFC-MAH ;Mar 2004
 ;;3.0;BAR CODE MED ADMIN;**6,20,27,26**;Mar 2004
 ;
 ; Reference/IA
 ; EN^PSJBCMA/2828
 ;
EN ;
 ; Okay, let's print this puppy
 S PSBWEEK=0
 F  S PSBWEEK=$O(^TMP("PSB",$J,PSBWEEK)) Q:'PSBWEEK  D
 .D:$D(^TMP("PSB",$J,PSBWEEK,"SORT","C"))
 ..D CONT
 ;
 ; Now the PRN/One Time/On-Call Sheets
 S PSBWEEK=0
 F  S PSBWEEK=$O(^TMP("PSB",$J,PSBWEEK)) Q:'PSBWEEK  D
 .D:$D(^TMP("PSB",$J,PSBWEEK,"SORT","P"))
 ..D PRN
 ;
 D LEGEND
 Q
CONT ;
 S PSBHDR(1)="Continuing/PRN/Stat/One Time Medication/Treatment Record (VAF 10-2970 B, C, D)"
 W $$HDR()
 S PSBDRUG=""
 F  S PSBDRUG=$O(^TMP("PSB",$J,PSBWEEK,"SORT","C",PSBDRUG)) Q:PSBDRUG=""  D
 .S PSBORD=""
 .F  S PSBORD=$O(^TMP("PSB",$J,PSBWEEK,"SORT","C",PSBDRUG,PSBORD)) Q:'PSBORD  D
 ..;S X="",PSBNAF=0 F  S X=$O(^TMP("PSB",$J,PSBWEEK,PSBORD,X)) Q:X=""  I ^TMP("PSB",$J,PSBWEEK,PSBORD,X,0)'=0 S PSBNAF=1  ; check for data
 ..;D CLEAN^PSBVT,PSJ1^PSBVT(DFN,PSBORD)
 ..;S X=PSBOST D H^%DTC S PSBOSTH=%H
 ..;S X=PSBOSP D H^%DTC S PSBOSPH=%H
 ..;I PSBNAF=0 Q
 ..;I PSBNAF=0,$G(PSBAR(PSBOSTH))'=PSBWEEK,$G(PSBAR(PSBOSPH))'=PSBWEEK Q  ; no data for this week and neither start or stop date is this week
 ..S PSBCNT=8
 ..S:$O(^TMP("PSB",$J,"ORDERS",PSBORD,"INST",""),-1)>PSBCNT PSBCNT=$O(^(""),-1)
 ..S:$O(^TMP("PSB",$J,"ORDERS",PSBORD,"AT",""),-1)>PSBCNT PSBCNT=$O(^(""),-1)
 ..W:$Y>(IOSL-PSBCNT-4) $$HDR()
 ..F PSBLINE=1:1:PSBCNT D
 ...I IOSL>24,$Y>$S(PSBCNT<13:(IOSL-PSBCNT-4),(PSBCNT-PSBLINE=12):(IOSL-12),1:(IOSL-12)) D
 ....W !?(IOM-35\2),"*** CONTINUED ON NEXT PAGE ***"
 ....W $$HDR()
 ....W !?(IOM-35\2),"*** CONTINUED FROM PREVIOUS PAGE ***"
 ...W !,$G(^TMP("PSB",$J,"ORDERS",PSBORD,"INST",PSBLINE))
 ...W ?32,"| ",$G(^TMP("PSB",$J,"ORDERS",PSBORD,"AT",PSBLINE))
 ...S PSBDAY=0,PSBCOL=0
 ...F  S PSBDAY=$O(^TMP("PSB",$J,PSBWEEK,"HDR",PSBDAY)) Q:'PSBDAY  D
 ....W ?(40+(PSBCOL*13)),"| "
 ....S Y=$G(^TMP("PSB",$J,PSBWEEK,PSBORD,PSBDAY,PSBLINE))
 ....W $P(Y,U,3)
 ....W $E($P($P(Y,U,1)_"0000",".",2),1,4)," "
 ....W $P(Y,U,2)
 ....I $D(^TMP("PSB",$J,"ORDERS",PSBORD,"HOLD",PSBDAY)),(PSBLINE=PSBCNT) W "HOLD"  ;output hold status
 ....I '$D(^TMP("PSB",$J,"ORDERS",PSBORD,"DISC",PSBDAY))&'$D(^TMP("PSB",$J,"ORDERS",PSBORD,"HOLD",PSBDAY)) D
 .....I $D(^TMP("PSB",$J,"ORDERS",PSBORD,"NTDUE",PSBDAY)),(PSBLINE=PSBCNT) W "***"  ;write *** when day no due
 ....I $D(^TMP("PSB",$J,"ORDERS",PSBORD,"DISC",PSBDAY)),(PSBLINE=PSBCNT) W "***"   ;output discontinued status
 ....S PSBCOL=PSBCOL+1
 ..W !,$TR($J("",IOM)," ","-")
 Q
 ;
PRN ;
 S PSBHDR(1)="Continuing/PRN/Stat/One Time Medication/Treatment Record (VAF 10-2970 B, C, D)"
 W $$HDR(1)
 S PSBDRUG=""
 F  S PSBDRUG=$O(^TMP("PSB",$J,PSBWEEK,"SORT","P",PSBDRUG)) Q:PSBDRUG=""  D
 .S PSBORD=""
 .F  S PSBORD=$O(^TMP("PSB",$J,PSBWEEK,"SORT","P",PSBDRUG,PSBORD)) Q:'PSBORD  D
 ..S PSBCNT=$O(^TMP("PSB",$J,PSBWEEK,PSBORD,"AT",""),-1)
 ..D:PSBCNT<$O(^TMP("PSB",$J,"ORDERS",PSBORD,"INST",""),-1)
 ...S PSBCNT=$O(^TMP("PSB",$J,"ORDERS",PSBORD,"INST",""),-1)
 ..S:PSBCNT<8 PSBCNT=8  ; Minimum space for order
 ..W:$Y>(IOSL-PSBCNT-4) $$HDR(1)
 ..F PSBLINE=1:1:PSBCNT D
 ...I IOSL>24,$Y>$S(PSBCNT<13:(IOSL-PSBCNT-4),(PSBCNT-PSBLINE=12):(IOSL-12),1:(IOSL-12)) D
 ....W !?(IOM-35\2),"*** CONTINUED ON NEXT PAGE ***"
 ....W $$HDR(1)
 ....W !?(IOM-35\2),"*** CONTINUED FROM PREVIOUS PAGE ***"
 ...W !,$G(^TMP("PSB",$J,"ORDERS",PSBORD,"INST",PSBLINE))
 ...W ?32,"| ",$G(^TMP("PSB",$J,PSBWEEK,PSBORD,"AT",PSBLINE))
 ..W !,$TR($J("",IOM)," ","-")
 Q
 ;
LEGEND  ;
 ;print the initials - name legend as an extra page  ;
 ;I '$D(^TMP("PSB",$J,"LEGEND")) K ^TMP("PSJ",$J),^TMP("PSB",$J) Q  ;
 D PT^PSBOHDR(DFN,.PSBHDR)  ;
 W !!,"Initial - Name Legend",!  ;
 I $D(^TMP("PSB",$J,"LEGEND"))  D
 .S X=$Q(^TMP("PSB",$J,"LEGEND",""))
 .F  W $S($QS(X,4)[99:"",1:$QS(X,4)),?10,$QS(X,5),! S X=$Q(@X) Q:$QS(X,3)'="LEGEND"  ;
 W !!,"Status Codes",!,"C - Completed",!,"G - Given",!,"H - Held",!,"I - Infusing",!,"M - Missing Dose Requested",!,"R - Refused",!,"RM - Removed",!,"S - Stopped",!,"*** - Medication Not Due",!  ;
 K ^TMP("PSJ",$J),^TMP("PSB",$J)
 Q
 ;
HDR(PRN)   ;
 ; PRN = TRUE IF DISPLAYING PRN MED (OPTIONAL)
 D PT^PSBOHDR(DFN,.PSBHDR)
 W !,"Start Date",?20,"Stop Date",?32,"| ",$S('$G(PRN):"Admin",1:"Action Status")
 I '$G(PRN) F X=0:1:6 W ?(40+(X*13)),"|"
 W !,"and Time",?20,"and Time",?32,"| ",$S('$G(PRN):"Times",1:"Action Date/Times")
 D:'$G(PRN)
 .S PSBCOL=0,X=0 F  S X=$O(^TMP("PSB",$J,PSBWEEK,"HDR",X)) Q:'X  D
 ..W ?(40+(PSBCOL*13)),"| ",$E(X,4,5),"/",$E(X,6,7),"/",(1700+$E(X,1,3))
 ..S PSBCOL=PSBCOL+1
 D:$G(PRN)
 .W ?76,"PRN Reason"
 W !,$TR($J("",IOM)," ","-")
 Q ""
 ;
PSBCK1(PSBCHK) ;                   
 I PSBCHK="A" D
 .S TEST=$P(^PSB(53.79,PSBIEN,0),U,6)
 .D PSBOUT^PSBOMH1(TEST,PSBINIT)
 .S X=$P(^PSB(53.79,PSBIEN,0),U,6)_U_PSBINIT_U_"G"_U_PSBIEN
 I PSBCHK="B" D
 .S TESTB=$P(^PSB(53.79,PSBIEN,0),U,6)
 .D PSBOUT^PSBOMH1(TESTB,PSBINIT)
 .S X=$P(^PSB(53.79,PSBIEN,0),U,6)_U_PSBINIT_U_$P(^(0),U,9)_U_PSBIEN
 S PSBCHK=""
 Q
 ;
PSBENT(PSBTIS) ;
 S PSBNAME="",PSBNAME=$$GET1^DIQ(53.79,PSBIEN_",","ACTION BY:NAME")
 S ^TMP("PSB",$J,"LEGEND",$S($G(PSBTIS)="":99,1:PSBTIS),PSBNAME)=""
 Q
 ;
PSBSTIV ;
 S YB="" F  S YB=$O(PSBAUD(YB)) Q:YB=""  D
 .S Z="" F  S Z=$O(^PSB(53.79,PSBIEN,.9,Z)) Q:Z=""  I Z'=0  D
 ..I $P(PSBAUD(YB),U,1)=$P(^PSB(53.79,PSBIEN,.9,Z,0),"^",1)  D
 ...I $P(^PSB(53.79,PSBIEN,.9,Z,0),"^",3)["Instruct"  D
 ....I $P(PSBAUD(YB),U,2)'["*"  S $P(PSBAUD(YB),U,2)=$P(PSBAUD(YB),U,2)_"*"
 ....D PSBOUT^PSBOMH1($P(PSBAUD(YB),U,1),$P(PSBAUD(YB),U,2))
 Q
 ;
PSBCTAR   ;
 S YC="" F  S YC=$O(PSBTAR(YC)) Q:YC=""  D
 .S Z="" F  S Z=$O(^PSB(53.79,PSBIEN,.9,Z)) Q:Z=""  I Z'=0  D
 ..I $P(PSBTAR(YC),U,1)=$P(^PSB(53.79,PSBIEN,.9,Z,0),"^",1)  D
 ...I $P(^PSB(53.79,PSBIEN,.9,Z,0),"^",3)["Instruct"  D
 ....S $P(PSBTAR(YC),U,2)=$P(PSBTAR(YC),U,2)_"*"
 ....D PSBOUT^PSBOMH1($P(^PSB(53.79,PSBIEN,.9,Z,0),"^",1),$P(PSBTAR(YC),U,2))
 Q
 ;
