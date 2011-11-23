DVBAPND1 ;ALB ISC/GTS-AMIE PENDING RPT UT ;13 JAN 93@08:10 ; 7/2/90  2:48 PM
 ;;2.7;AMIE;**14,17**;Apr 10, 1995
 ;
 ;  ** The following routines are called from DVBAPEND **
SORTDIV W !!,"Sort by Division" S %=1 D YN^DICN
 I $D(DTOUT)!(%<0) K DTOUT S Y=-1 Q
 I $D(%Y),(%Y["?") W !!,*7,"Enter Y to sort by the Division you"
 I $D(%Y),(%Y["?") W !,"select or enter N to report ALL Divisions."
 I $D(%Y),(%Y["?") G SORTDIV
 I %'=1 S SELDIV="N",DIVNUM=0 Q
 I %=1 S SELDIV="Y" G ENTDIV
 W !,*7,"Invalid response.",!! G SORTDIV
 ;  ** Allow user to enter a selected Division to report **
ENTDIV S DIC="^DG(40.8,",DIC(0)="AEMQ",DIC("A")="Division number: "
 D ^DIC K DIC S DIVNUM=+Y
 S DIVNAM=$S($D(^DG(40.8,+Y,0)):$P(^(0),"^",1),1:"Unknown Division")
 Q
 ;
DCHGDT S DCHGDT="",DCHPTR=$P(^DGPM(XJ,0),U,17),XADMDT=$P(^(0),U,1) I DCHPTR]"",$D(^DGPM(+DCHPTR,0)) S DCHGDT=$P(^DGPM(+DCHPTR,0),U,1)
 K DCHPTR
 Q
 ;
PRINT S DOCTYPE=$S($D(^DVB(396,DA,2)):$P(^(2),U,10),1:""),DFN=$P(^DVB(396,DA,0),U,1),ADMDT=$P(^(0),U,4),RDATE=$P(^(1),U,1),PNAM=$P(^DPT(DFN,0),U,1),SSN=$P(^(0),U,9),CNUM=$S($D(^(.31)):$P(^(.31),U,3),1:"UNKNOWN")
 I RO="Y" S CFLOC=$$STATION^DVBAUTL1(DFN),CFLOC=$S(CFLOC>0:CFLOC,1:9999) Q:CFLOC'=RONUM&(CFLOC'=0)&(CFLOC'=376)
 K ^TMP("DVBA","ADMIT",$J)
 F XI=0:0 S XI=$O(^DGPM("APTT1",DFN,XI)) Q:XI=""  F XJ=0:0 S XJ=$O(^DGPM("APTT1",DFN,XI,XJ)) Q:XJ=""  D DCHGDT S ^TMP("DVBA","ADMIT",$J,XADMDT,DFN)=XI_U_DCHGDT
 W:SELDIV="Y" !,?10,"Division: "_ADIV,!
 W:SELDIV="N" !,?10,"Original Division: "_ADIV,!
 W !,PNAM,?49,"SSN: ",SSN,!,?44,"Claim no: ",CNUM,!,?38,$S(DOCTYPE="L":" Activity date: ",1:"Admission date: "),$$FMTE^XLFDT(ADMDT,"5DZ"),!,?40,"Request date: ",$$FMTE^XLFDT(RDATE,"5DZ")
 S DCHGDT=""
 I $D(^TMP("DVBA","ADMIT",$J,+ADMDT,DFN)) S:DOCTYPE="A" DCHGDT=$P(^TMP("DVBA","ADMIT",$J,+ADMDT,DFN),U,2)
 D ELAPSED
 W ! I DCHGDT]"" S Y=DCHGDT X DVBADD W "** Discharged: ",Y
 W ?40,"Elapsed days: ",EDAYS,!!,?3,"Items Pending:"
ITEMS F Q=9,11,13,15,17,19,21,23,26,28 I $P(^DVB(396,DA,0),U,Q)="P" D PRINT1 Q:DVBAQUIT=1
 S Q=7 I $P(^DVB(396,DA,1),U,Q)="P" D PRINT1 Q:DVBAQUIT=1
 W !! W:$D(^DVB(396,DA,2)) "Requested by: ",$S($P(^DVB(396,DA,2),U,8)]"":$P(^(2),U,8),1:" (Not specified) ")," AT ",$S($P(^(2),U,7)]"":$P(^(2),U,7),1:" (Not specified) "),! F L=1:1:79 W "-"
 W !
 D TOP Q:DVBAQUIT=1
 Q
 ;
PRINT1 S:$D(^DVB(396,DA,6)) GDIVPTR=$P(^DVB(396,DA,6),"^",Q)
 S:'$D(^DVB(396,DA,6)) GDIVPTR=$P(^DVB(396,DA,2),"^",9)
 S:+GDIVPTR>0 GDIVNAM=$P(^DG(40.8,GDIVPTR,0),"^",1)
 S:+GDIVPTR'>0 GDIVNAM=""
 S NODTA=1 I QQ S MC=$T(@Q),MD=$P(MC,";;",2) S GDIV=" ("_$E(GDIVNAM,1,(9+(23-$L(MC))))_")" W !,?8,MD,GDIV S QQ='QQ Q
 I 'QQ S MC=$T(@Q),MD=$P(MC,";;",2) S GDIV=" ("_$E(GDIVNAM,1,(9+(23-$L(MC))))_")" W ?46,MD,GDIV S QQ='QQ I $Y>22 D TOP Q:DVBAQUIT=1
 Q
 ;
TOP I IOST?1"C-".E,'$D(NOASK) W !!,*7,"Press RETURN to continue or ""^"" to exit   " R ANS:DTIME W @IOF I ANS=U!('$T) S DVBAQUIT=1 Q
 I $Y'<53 D HEADER
 Q
 ;
ELAPSED K EDAYS,X1,X S X1=DT,X=RDATE D ^XUWORKDY
 S EDAYS=X
 Q
 ;
HEADER S PG=PG+1 W:(IOST?1"C-".E)!(PG>1) @IOF,!
 W ?(80-$L(HEAD)\2),HEAD,?71,"Page: ",PG,! I HEAD2]"" W ?(80-$L(HEAD2)\2),HEAD2,!
 W ?(80-$L(PROCDT)\2),PROCDT,!!
 Q
FIELDS ;
7 ;;ADMISSION RPT
9 ;;NOTICE OF DISCHARGE
11 ;;HOSPITAL SUMMARY
13 ;;21-DAY CERTIFICATE
15 ;;OTHER/EXAM REVIEW RMKS
17 ;;SPECIAL REPORT
19 ;;COMPETENCY REPORT
21 ;;VA FORM 21-2680
23 ;;ASSET INFORMATION
26 ;;OPT TREATMENT REPORT
28 ;;BEGINNING DATE/CARE
 Q
