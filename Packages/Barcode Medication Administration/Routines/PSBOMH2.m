PSBOMH2 ;BIRMINGHAM/EFC-MAH ;9/13/12 5:15pm
 ;;3.0;BAR CODE MED ADMIN;**6,20,27,26,67,68,70**;Mar 2004;Build 101
 ;
 ; Reference/IA
 ; EN^PSJBCMA/2828
 ; GETSIOPI^PSJBCMA5/5763
 ;
 ;*68 - Add ability to get special instructions at end of each orders
 ;      grid and print in free space before next orders grid, check
 ;      for page overflow each line of word processing text.
 ;*70 - Print Clinic from ^TMP(""PSB",$J,"ORDERS",PSBORD,"INST") on
 ;      the intruction/med cell of grid.  Add psbclinord=2 mode for 
 ;      dual heading text.
 ;
EN ;     Add dual sections for MAH report - IM and then CO           *70
 ;     only one Legend section after CO section
 ;           sort 1 = IM   sort 2 = CO
 ;
 ;*70 MAH was missing report Title
 S Y=$S($P(PSBRPT(.1),U,8)]"":$P(PSBRPT(.1),U,8),1:$P(PSBRPT(.1),U,6))
 S PSBHDR(0)="MEDICATION ADMINISTRATION HISTORY for "_$$FMTE^XLFDT($P(PSBRPT(.1),U,6)+$P(PSBRPT(.1),U,7))_" to "_$$FMTE^XLFDT(Y+$P(PSBRPT(.1),U,9))
 ;
 ;**** INPATIENT ORDERS 1st ****                                   *70
 N PSBSUBHD
 S PSBSUBHD="** INPATIENT ORDERS **"
 S PSBWEEK=0
 F  S PSBWEEK=$O(^TMP("PSB",$J,PSBWEEK)) Q:'PSBWEEK  D
 .D:$D(^TMP("PSB",$J,PSBWEEK,"SORT",1,"C"))
 ..D CONT(1)
 ;
 ; Now the PRN/One Time/On-Call Sheets
 S PSBWEEK=0
 F  S PSBWEEK=$O(^TMP("PSB",$J,PSBWEEK)) Q:'PSBWEEK  D
 .D:$D(^TMP("PSB",$J,PSBWEEK,"SORT",1,"P"))
 ..D PRN(1)
 ;
 ;**** CLINIC ORDERS 2nd ****                                      *70
 S PSBSUBHD="** CLINIC ORDERS **"
 S PSBWEEK=0
 F  S PSBWEEK=$O(^TMP("PSB",$J,PSBWEEK)) Q:'PSBWEEK  D
 .D:$D(^TMP("PSB",$J,PSBWEEK,"SORT",2,"C"))
 ..D CONT(2)
 ;
 ; Now the PRN/One Time/On-Call Sheets
 S PSBWEEK=0
 F  S PSBWEEK=$O(^TMP("PSB",$J,PSBWEEK)) Q:'PSBWEEK  D
 .D:$D(^TMP("PSB",$J,PSBWEEK,"SORT",2,"P"))
 ..D PRN(2)
 ;
 S PSBSUBHD="** LEGEND **"
 D LEGEND
 K ^TMP("PSB",$J)
 Q
 ;
CONT(XO) ;
 N SILN,SITXT
 S PSBHDR(1)="Continuing/PRN/Stat/One Time Medication/Treatment Record (VAF 10-2970 B, C, D)"
 W $$HDR()
 S PSBDRUG=""
 F  S PSBDRUG=$O(^TMP("PSB",$J,PSBWEEK,"SORT",XO,"C",PSBDRUG)) Q:PSBDRUG=""  D
 .S PSBORD=""
 .F  S PSBORD=$O(^TMP("PSB",$J,PSBWEEK,"SORT",XO,"C",PSBDRUG,PSBORD)) Q:'PSBORD  D
 ..S PSBCNT=8
 ..S:$O(^TMP("PSB",$J,"ORDERS",PSBORD,"INST",""),-1)>PSBCNT PSBCNT=$O(^(""),-1)
 ..S:$O(^TMP("PSB",$J,"ORDERS",PSBORD,"AT",""),-1)>PSBCNT PSBCNT=$O(^(""),-1)
 ..W:$Y>(IOSL-PSBCNT-4) $$HDR()
 ..F PSBLINE=0:1:PSBCNT D    ;*70 start at 0 for inserted Clinic name
 ...D CHKPAGE                ;*68 convert overflow logic to a tag call
 ...W !,$G(^TMP("PSB",$J,"ORDERS",PSBORD,"INST",PSBLINE))
 ...W ?32,"| " W:PSBLINE>0 $G(^TMP("PSB",$J,"ORDERS",PSBORD,"AT",PSBLINE))
 ...S PSBDAY=0,PSBCOL=0
 ...F  S PSBDAY=$O(^TMP("PSB",$J,PSBWEEK,"HDR",PSBDAY)) Q:'PSBDAY  D
 ....W ?(40+(PSBCOL*13)),"|" ;Remove space, PSB*3*67
 ....S Y=$G(^TMP("PSB",$J,PSBWEEK,PSBORD,PSBDAY,PSBLINE))
 ....;Write space when status does not contain >, PSB*3*67
 ....I ($L($P(Y,U,2))'=5)!($P(Y,U,3)'="RM"),($P(Y,U,3)'[">") W " "
 ....W $P(Y,U,3)
 ....W $E($P($P(Y,U,1)_"0000",".",2),1,4)," "
 ....W $P(Y,U,2)
 ....I $D(^TMP("PSB",$J,"ORDERS",PSBORD,"HOLD",PSBDAY)),(PSBLINE=PSBCNT) W "HOLD"  ;output hold status
 ....I '$D(^TMP("PSB",$J,"ORDERS",PSBORD,"DISC",PSBDAY))&'$D(^TMP("PSB",$J,"ORDERS",PSBORD,"HOLD",PSBDAY)) D
 .....I $D(^TMP("PSB",$J,"ORDERS",PSBORD,"NTDUE",PSBDAY)),(PSBLINE=PSBCNT) W "***"  ;write *** when day no due
 ....I $D(^TMP("PSB",$J,"ORDERS",PSBORD,"DISC",PSBDAY)),(PSBLINE=PSBCNT) W "***"   ;output discontinued status
 ....S PSBCOL=PSBCOL+1
 ..D SIOPI                     ;*68 get and print SI lines, if exist
 ..W !,$TR($J("",IOM)," ","-")
 Q
 ;
PRN(XO) ;
 S PSBHDR(1)="Continuing/PRN/Stat/One Time Medication/Treatment Record (VAF 10-2970 B, C, D)"
 W $$HDR(1)
 S PSBDRUG=""
 F  S PSBDRUG=$O(^TMP("PSB",$J,PSBWEEK,"SORT",XO,"P",PSBDRUG)) Q:PSBDRUG=""  D
 .S PSBORD=""
 .F  S PSBORD=$O(^TMP("PSB",$J,PSBWEEK,"SORT",XO,"P",PSBDRUG,PSBORD)) Q:'PSBORD  D
 ..S PSBCNT=$O(^TMP("PSB",$J,PSBWEEK,PSBORD,"AT",""),-1)
 ..D:PSBCNT<$O(^TMP("PSB",$J,"ORDERS",PSBORD,"INST",""),-1)
 ...S PSBCNT=$O(^TMP("PSB",$J,"ORDERS",PSBORD,"INST",""),-1)
 ..S:PSBCNT<8 PSBCNT=8  ; Minimum space for order
 ..W:$Y>(IOSL-PSBCNT-4) $$HDR(1)
 ..F PSBLINE=0:1:PSBCNT D
 ...D CHKPAGE                  ;*68 move overflow page logic to a tag
 ...W !,$G(^TMP("PSB",$J,"ORDERS",PSBORD,"INST",PSBLINE))
 ...W ?32,"| ",$G(^TMP("PSB",$J,PSBWEEK,PSBORD,"AT",PSBLINE))
 ..D SIOPI                     ;*68 get and print SI lines, if exist
 ..W !,$TR($J("",IOM)," ","-")
 Q
 ;
LEGEND ;
 ;print the initials - name legend as an extra page  ;
 N PSBCLINORD S PSBCLINORD=2                                    ;*70
 D PT^PSBOHDR(DFN,.PSBHDR,,,,$G(PSBSUBHD))             ;*70
 W !!,"Initial - Name Legend",!  ;
 I $D(^TMP("PSB",$J,"LEGEND"))  D
 .S X=$Q(^TMP("PSB",$J,"LEGEND",""))
 .F  W $S($QS(X,4)[99:"",1:$QS(X,4)),?10,$QS(X,5),! S X=$Q(@X) Q:$QS(X,3)'="LEGEND"  ;
 W !!,"Status Codes",!,"C - Completed",!,"G - Given",!,"H - Held",!,"I - Infusing",!,"M - Missing Dose Requested",!,"R - Refused",!,"RM - Removed",!,"S - Stopped",!  ;
 W "> - Scheduled administration times for the order have been changed",!,"*** - Medication Not Due",! ;add changed Admin time message, PSB*3*67
 K ^TMP("PSJ",$J)
 Q
 ;
HDR(PRN) ;
 ; PRN = TRUE IF DISPLAYING PRN MED (OPTIONAL)
 N PSBCLINORD S PSBCLINORD=2                                      ;*70
 D PT^PSBOHDR(DFN,.PSBHDR,,,,$G(PSBSUBHD))           ;*70
 W !,"Location",?32,"| "                             ;*70
 I '$G(PRN) F X=0:1:6 W ?(40+(X*13)),"|"             ;*70
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
PSBCTAR ;
 S YC="" F  S YC=$O(PSBTAR(YC)) Q:YC=""  D
 .S Z="" F  S Z=$O(^PSB(53.79,PSBIEN,.9,Z)) Q:Z=""  I Z'=0  D
 ..I $P(PSBTAR(YC),U,1)=$P(^PSB(53.79,PSBIEN,.9,Z,0),"^",1)  D
 ...I $P(^PSB(53.79,PSBIEN,.9,Z,0),"^",3)["Instruct"  D
 ....S $P(PSBTAR(YC),U,2)=$P(PSBTAR(YC),U,2)_"*"
 ....D PSBOUT^PSBOMH1($P(^PSB(53.79,PSBIEN,.9,Z,0),"^",1),$P(PSBTAR(YC),U,2))
 Q
 ;
SIOPI ;Get and print SI/OPI Wp text *68
 K ^TMP("PSJBCMA5",$J,DFN)
 S SILN=$$GETSIOPI^PSJBCMA5(DFN,PSBORD,1)
 I SILN F QQ=0:0 S QQ=$O(^TMP("PSJBCMA5",$J,DFN,PSBORD,QQ)) Q:'QQ  D
 .S SITXT=^TMP("PSJBCMA5",$J,DFN,PSBORD,QQ)
 .I SILN=1,SITXT="" Q
 .D CHKPAGE I QQ=1 W !," Special Instructions:"
 .D CHKPAGE W !," ",SITXT
 K ^TMP("PSJBCMA5",$J,DFN)
 Q
 ;
CHKPAGE ;check for page full and print overflow msgs and new page headers *68
 I IOSL>24,$Y>$S(PSBCNT<13:(IOSL-PSBCNT-4),(PSBCNT-PSBLINE=12):(IOSL-12),1:(IOSL-12)) D
 .W !!?(IOM-35\2),"*** CONTINUED ON NEXT PAGE ***"
 .W $$HDR()
 .W !?(IOM-35\2),"*** CONTINUED FROM PREVIOUS PAGE ***",!
 Q
