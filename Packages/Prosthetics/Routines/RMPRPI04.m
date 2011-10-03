RMPRPI04 ;HIN/RVD-PROS STOCK ITEM RECORDS ;3/8/05  11:24
 ;;3.0;PROSTHETICS;**61**;Feb 09, 1996
 ; DBIA #10090 - Read Access to entire file #4.
 ;
 D DIV4^RMPRSIT I $D(Y),(Y<0) Q
 S RS=RMPR("STA")
 ;
EN K ^TMP($J),RMPRI,RMPRFLG S RMPREND=0 D HOME^%ZIS
 S DIC="^RMPR(661.1,",DIC(0)="AEQM"
 F HCPCS=1:1 S DIC("A")="Select HCPCS "_HCPCS_": " D ^DIC G:$D(DTOUT)!(X["^")!(X=""&(HCPCS=1)) EXIT1 Q:X=""  D
 .Q:'$D(^RMPR(661.1,+Y,0))  S RMHCPC=$P(^RMPR(661.1,+Y,0),U,1)
 .I $D(RMPRI(RMHCPC)) W $C(7)," ??",?40,"..Duplicate HCPCS" S HCPCS=HCPCS-1 Q
 .S:RMHCPC'="" RMPRI(RMHCPC)=+Y
 S RMPRCOUN=0 W !! S %DT("A")="Beginning Date: ",%DT="AEPX"
 S %DT("B")="T-30" D ^%DT S RMPRBDT=Y G:Y<0 EXIT1
 ;
ENDATE S %DT("A")="Ending Date: ",%DT="AEX",%DT("B")="TODAY" D ^%DT
 G:Y<0 EXIT1
 I RMPRBDT>Y W !,$C(7),"Invalid Date Range Selection!!" G ENDATE
 G:Y<0 EXIT S RMPREDT=Y,Y=RMPRBDT D DD^%DT S RMPRX=Y,Y=RMPREDT
 D DD^%DT S RMPRY=Y
 S %ZIS="MQ" K IOP D ^%ZIS G:POP EXIT
 I '$D(IO("Q")) U IO G PRINT
 K IO("Q") S ZTDESC="STOCK ITEM REPORT",ZTRTN="PRINT^RMPRPI04",ZTIO=ION
 S ZTSAVE("RMPRBDT")="",ZTSAVE("RMPREDT")="",ZTSAVE("RMPRI(")=""
 S ZTSAVE("RMPRX")="",ZTSAVE("RMPRY")="",ZTSAVE("RMPR(""STA"")")=""
 S ZTSAVE("RMPR(")=""
 D ^%ZTLOAD W:$D(ZTSK) !,"REQUEST QUEUED!" H 1 G EXIT1
 ;
 ;Entry point for printing report.
PRINT I $E(IOST)["C" W @IOF,!!,"Processing report......"
 I '$D(RMPRI) D NONEALL G EXIT
 ;call API
 ;input variables:
 ;      RM = 'RM' subscript
 ;      RS = station
 ;      RMPRI = array of HCPCS
 ;      RMPRBDT = beginning date
 ;      RMPREDT = ending date
 ;
 S RS=RMPR("STA"),RM="RM"
 S RMCHK=$$THIS^RMPRPI03(RM,RS,RMPRBDT,RMPREDT,.RMPRI)
 I RMCHK W !!,"ERROR NUMBER = ",RMCHK,!,"*** Error in API RMPRPI03 !!!" G EXIT
 ;
 S RMBDATE=$E(RMPRBDT,4,5)_"/"_$E(RMPRBDT,6,7)_"/"_$E(RMPRBDT,2,3)
 S RMPAGE=1
 S (RMPREND,RP,QTYT,RMIFL,RMCO,RMTOCO,RMTOCOH,RMSTAFL,RMSUF,RMQTYT)=0
 D HEAD
 S RQ="" F  S RQ=$O(RMPRI(RQ)) Q:RQ=""  I '$D(^TMP($J,"RM",RQ)) D NONE
 D WRI
 W !,"<End of Report>"
 ;
EXIT ;exit here if report prints in home device.
 I $E(IOST)["C",'$D(DUOUT),'$G(RMPREND) K DIR S DIR(0)="E" D ^DIR
 ;
EXIT1 ;close device and clean-up variables.
 D ^%ZISC
 N RMPR,RMPRSITE D KILL^XUSCLEAN
 K ^TMP($J)
 Q
 ;end of processing (exit program)
 ;
 ;   RH = HCPCS
 ;   RI = HCPCS ITEM NAME
 ;   R2 = ITEM NUMBER
 ;   R3 =SEQUENCE
 ;
WRI S (RMFH,RMFI,RMPRFLG,RMTOCO,RMTOCOH,RMTOCOI)=0
 S (RMITEM,RH)=""
 F  S RH=$O(^TMP($J,"RM",RH)) D:RMFH HTOTAL D:RH'="" HEAD1 Q:RH=""  S (RIT2,RI)="" F  S RI=$O(^TMP($J,"RM",RH,RI)) Q:RI=""  D
 .F R2=0:0 S R2=$O(^TMP($J,"RM",RH,RI,R2)) D:RMFI ITOTAL Q:(R2'>0)!(RMPREND)  D:RIT2'=R2 IHEAD F R3=0:0 S R3=$O(^TMP($J,"RM",RH,RI,R2,R3)) Q:(R3'>0)!(RMPREND)  D
 ..S RDATA=^TMP($J,"RM",RH,RI,R2,R3)
 ..S RMDAT=$P(RDATA,U,1),RMTIM=$P(RDATA,U,2),RMOPE=$P(RDATA,U,3)
 ..S RMCLO=$P(RDATA,U,4),RMQTY=$P(RDATA,U,5)
 ..S RMVAL=$P(RDATA,U,6),RMTRA=$P(RDATA,U,7),RMPAT=$P(RDATA,U,8)
 ..S RMSSN=$P(RDATA,U,9),RMUSE=$E($P(RDATA,U,10),1,10)
 ..S RMITE=$P(RDATA,U,11)
 ..S RMAVCO=$P(RDATA,U,11) S:RMAVCO'="" RMCO=RMAVCO*RMQTY
 ..S RIT2=R2
 ..I 'RMPRFLG D HEAD1
 ..S (RMFH,RMFI)=1
 ..W !,RMDAT
 ..I RMPAT'="" D
 ...W ?9,$E(RMPAT,1,14),?26,$P(RMSSN,"-",3),?31,RMUSE,?45,$J(RMQTY,4)
 ...W ?69,$J(RMVAL,9,2)
 ..I RMTRA="PATIENT ISSUE" S RMTOCO=RMTOCO+RMVAL
 ..I RMTRA="RETURN IN" S RMTOCO=RMTOCO-RMVAL
 ..I RMPAT="" D
 ...W:RMTRA="RECEIPT" ?9,"**Note: ",RMTRA,?31,RMUSE,?60,$J(RMQTY,4),?69,$J(RMVAL,9,2)
 ...W:RMTRA="ORDER" ?9,"**Note: ",RMTRA,?31,RMUSE,?54,$J(RMQTY,4),?69,$J(RMVAL,9,2)
 ...I (RMTRA'="RECEIPT"),(RMTRA'="ORDER") W ?9,"**Note: ",RMTRA,?31,RMUSE,?45,$J(RMQTY,4),?69,$J(RMVAL,9,2)
 ..S RMPRFLG=1
 ..I $E(IOST)["C"&($Y>(IOSL-7)) S DIR(0)="E" D ^DIR S:$D(DTOUT)!(Y=0) RMPREND=1 Q:RMPREND  W @IOF D HEAD,HEAD1 Q
 ..I $Y>(IOSL-6) W @IOF D HEAD,HEAD1 S RMPRFLG=1
 Q
 ;
HEAD ;print headers
 W !,"*** ISSUE and STOCK CONTROL RECORD - PROSTHETICS STOCK ITEMS ***"
 W ?65,"Page: ",RMPAGE,!,?30,"station: "
 W $E($P($G(^DIC(4,RMPR("STA"),0)),U,1),1,20)
 N X,% S Y=RMPRBDT D DD^%DT W !,Y," to " S Y=RMPREDT D DD^%DT W Y
 S RMPAGE=RMPAGE+1
 Q
 ;
IHEAD S RMDAHC=$O(^RMPR(661.1,"B",RH,0))
 S RMITEM=$E(RMITEM,1,26)
 W !,"HCPCS: ",RH,"-",R2,?16,"Item: ",RI
 S RMI=1
 Q
 ;
HEAD1 ;write column headers
 I $E(IOST)["C"&($Y>(IOSL-7)) S DIR(0)="E" D ^DIR S:$D(DTOUT)!(Y=0) RMPREND=1 Q:RMPREND  W @IOF D HEAD
 W !,RMPR("L")
 W !,?45,"QTY",?54,"QTY",?61,"QTY",?72,"DOLLAR"
 W !," DATE",?9,"PATIENT",?26,"SSN",?31,"USER",?44,"ISSUE"
 W ?53,"ORDER",?61,"REC",?72,"VALUE"
 W !," ----",?9,"-------",?26,"---",?31,"----",?44,"-----"
 W ?53,"-----",?61,"---",?72,"------"
 S RMPRFLG=1
 Q
 ;
HTOTAL ;
 I RMFH,'RMPREND D
 .W !!,?23,"*** Dollar Value of HCPCS Issued",?60,"="
 .W ?60,$J(RMTOCOH,10,2)
 S (RMTOCOH,RMFH)=0
 Q
 ;
ITOTAL ;prints totals.
 I RMFI,'RMPREND D
 .W !,?42,"--------------------------------------",!
 .W ?23,"*** Dollar Value of Item Issued",?60,"=",?60,$J(RMTOCO,10,2)
 S RMTOCOH=RMTOCOH+RMTOCO,(RMTOCO,RMCO,RMFI)=0
 Q
 ;
NONE ;nothing to report.
 W !,RMPR("L"),!,"No Item Statistics for HCPCS: "
 W RQ,"...for this date range !!!"
 Q
 ;
NONEALL W !!,"NO DATA AT THIS DATE RANGE!!!!"
 Q
