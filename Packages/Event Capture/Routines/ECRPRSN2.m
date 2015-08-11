ECRPRSN2 ;ALB/DAN - Updated Procedure Reasons Report;24 JAN 07 ;9/30/14  17:18
 ;;2.0;EVENT CAPTURE;**112,126**;8 May 96;Build 8
STRPT ;queued entry point or continuation
 D PROCESS
 I ECPTYP="E" D EXPORT D EXIT Q
 U IO D PRINT Q:$D(ECGUI)
 I IO'=IO(0) D ^%ZISC
 I $D(ZTQUEUED) S ZTREQ="@"
 D EXIT
 Q
PROCESS ;get data to print
 N EC,ECD,ECDA,ECPA,ECR,ECRL,ECRN,ECPATN,ECSSN,ECP,ECLOCA
 N ECUNIT,ECFILE,ECPRV,ECPRVN,ECDFN,ECCPT
 N NLOC,NUNIT,JJ,REAS,ECRSNUM,ECPI,ECPROCNM ;126
 K ^TMP("ECREAS",$J)
 ;if ecreas array doesn't exist, quit
 I $D(ECLINK)<10 Q
 ;put locations and units into ien subscripted arrays
 S JJ="" F  S JJ=$O(ECLOC(JJ)) Q:JJ=""  D
 .S NLOC($P(ECLOC(JJ),"^",1))=$P(ECLOC(JJ),"^",2)
 S JJ="" F  S JJ=$O(ECDSSU(JJ)) Q:JJ=""  D
 .S NUNIT($P(ECDSSU(JJ),"^",1))=$P(ECDSSU(JJ),"^",2)
 S ECD=ECSD F  S ECD=$O(^ECH("AC",ECD)) Q:'ECD  Q:ECD>ECED  D
 .S ECDA="" F  S ECDA=$O(^ECH("AC",ECD,ECDA)) Q:'ECDA  S EC=$G(^ECH(ECDA,0))  I $P(EC,"^",23)'="" D
 ..S ECDFN=$P(EC,"^")
 ..I $P(EC,"^",3)<ECSD!($P(EC,"^",3)>ECED) Q  ;file or x-ref problem
 ..S ECLOCA=+$P(EC,U,4),ECUNIT=+$P(EC,U,7)
 ..I '$D(NLOC(ECLOCA))!('$D(NUNIT(ECUNIT))) Q
 ..F REAS=34,43,44 S ECRL=$$GET1^DIQ(721,ECDA,REAS,"I") I +ECRL I $D(ECLINK(ECRL))  S ECR=ECLINK(ECRL),ECRN=$P($G(^ECR(ECR,0)),"^") I ECRN'="" S ECRSNUM=$S(REAS=34:1,REAS=43:2,1:3) D
 ...S ECP=$P(EC,U,9) Q:ECP']""
 ...S ECPROCNM=$$GETPRNM^ECRDSSA(ECP,ECD) ;126 Get procedure name from file entry
 ...S ECFILE=$P(ECP,";",2),ECFILE=$S($E(ECFILE)="I":81,$E(ECFILE)="E":725,1:"UNKNOWN")
 ...S ECCPT=$S(ECFILE=81:+ECP,1:$P($G(^EC(725,+ECP,0)),"^",2))
 ...I ECCPT'=""&(ECFILE=81) D
 ....S ECPI=$$CPT^ICPTCOD(ECCPT,$P(ECED,".")) I +ECPI>1 S ECCPT=$P(ECPI,"^",2)
 ...S (ECPA,ECPATN)="",ECPA=$G(^DPT(+$P(EC,"^",2),0)) Q:ECPA=""
 ...S ECPATN=$P(ECPA,"^",1),ECSSN=$E($P(ECPA,"^",9),6,9)
 ...S:ECPATN="" ECPATN="UNKNOWN"
 ...S (ECPRV,ECPRVN)="",ECPRV=$$GETPPRV^ECPRVMUT(ECDA,.ECPRVN),ECPRVN=$S(ECPRV:"UNKNOWN",1:ECPRVN)
 ...S ^TMP("ECREAS",$J,NLOC(ECLOCA),NUNIT(ECUNIT)_"~"_ECUNIT,ECRN,ECPATN,ECD)=ECRSNUM_"^"_$P(ECPRVN,U,2)_"^"_ECSSN_"^"_ECCPT_"^"_ECPROCNM ;126
 Q
PRINT ;output report
 N ECED2,ECSD2,Y,DSSU,REAS,PAT,DATE,DATA,PAGE,QFLAG,DASH,PRNTDT,LOC,%
 S (PAGE,QFLAG)=0 S $P(DASH,"-",132)=""
 S Y=$P(ECSD,".",1)+1 D DD^%DT S ECSD2=Y S Y=$P(ECED,".",1) D DD^%DT S ECED2=Y
 D NOW^%DTC S Y=$E(%,1,12) D DD^%DT S PRNTDT=Y
 ;if no data exists then print the header and quit
 I '$D(^TMP("ECREAS",$J)) D  Q
 .S LOC="" D HEAD
 .W !!,?6,"No data for the date range specified.",!!
 .I $E(IOST)="C"&('QFLAG) S DIR(0)="E" D  D ^DIR K DIR
 ..S SS=22-$Y F JJ=1:1:SS W !
 .W:$E(IOST)'="C" @IOF
 S LOC="" F  S LOC=$O(^TMP("ECREAS",$J,LOC)) Q:LOC=""  D HEAD  S DSSU="" F  S DSSU=$O(^TMP("ECREAS",$J,LOC,DSSU)) Q:DSSU=""  W !,"DSS Unit: ",$P(DSSU,"~",1)_" (IEN "_$P(DSSU,"~",2)_")"  D  W !
 .S REAS="" F  S REAS=$O(^TMP("ECREAS",$J,LOC,DSSU,REAS)) Q:REAS=""  D
 ..S PAT="" F  S PAT=$O(^TMP("ECREAS",$J,LOC,DSSU,REAS,PAT)) Q:PAT=""  S DATE="" F  S DATE=$O(^TMP("ECREAS",$J,LOC,DSSU,REAS,PAT,DATE)) Q:'+DATE  D
 ...S DATA=^TMP("ECREAS",$J,LOC,DSSU,REAS,PAT,DATE)
 ...W !,?3,REAS,?37,$P(DATA,U),?41,$P(DATA,U,4),?52,$P(DATA,U,5),?118,$$FMTE^XLFDT(DATE,2),!,?43,PAT,?75,$P(DATA,U,3),?81,$P(DATA,U,2) ;126
 ...I $Y>(IOSL-4) D HEAD
 Q
HEAD ;header
 I $E(IOST)="C" S SS=22-$Y F JJ=1:1:SS W !
 I $E(IOST)="C",PAGE>0 S DIR(0)="E" W ! D ^DIR K DIR I 'Y S QFLAG=1 Q
 W:$Y!($E(IOST)="C") @IOF
 S PAGE=PAGE+1
 W !,?47,"Event Capture Procedure Reasons Report",?123,"Page: ",PAGE
 W !,?43,"for the Date Range ",$$FMTE^XLFDT(ECSD2)," to ",$$FMTE^XLFDT(ECED2),!,?53,"Printed: "_PRNTDT,!
 W !,"Location: ",LOC,!
 W ?3,"PROCEDURE REASON",?35,"RSN#",?41,"PROC CODE",?52,"PROCEDURE NAME",?118,"DATE/TIME",!,?43,"PATIENT",?75,"SSN",?81,"PROVIDER" ;126
 W !,DASH
 Q
EXIT ;common exit point
 D:'$D(ECGUI) ^%ZISC
 K ^TMP("ECREAS",$J)
 Q
 ;
EXPORT ;Convert data to exportable format
 N LOC,DSSU,REAS,PAT,DATE,CNT,DATA
 K ^TMP($J,"ECRPT") ;make sure there isn't anything here before it's populated
 S CNT=1,^TMP($J,"ECRPT",CNT)="LOCATION^DSS UNIT^DSS UNIT IEN^REASON TEXT^REASON #^PROC CODE^PROCEDURE NAME^SSN^PATIENT^DATE/TIME^PROVIDER" ;126
 S LOC="" F  S LOC=$O(^TMP("ECREAS",$J,LOC)) Q:LOC=""  S DSSU="" F  S DSSU=$O(^TMP("ECREAS",$J,LOC,DSSU)) Q:DSSU=""  S REAS="" F  S REAS=$O(^TMP("ECREAS",$J,LOC,DSSU,REAS)) Q:REAS=""  D
 .S PAT="" F  S PAT=$O(^TMP("ECREAS",$J,LOC,DSSU,REAS,PAT)) Q:PAT=""  S DATE="" F  S DATE=$O(^TMP("ECREAS",$J,LOC,DSSU,REAS,PAT,DATE)) Q:'+DATE  D
 ..S DATA=^TMP("ECREAS",$J,LOC,DSSU,REAS,PAT,DATE)
 ..S CNT=CNT+1,^TMP($J,"ECRPT",CNT)=LOC_U_$P(DSSU,"~",1)_U_$P(DSSU,"~",2)_U_REAS_U_$P(DATA,U,1)_U_$P(DATA,U,4)_U_$P(DATA,U,5)_U_$P(DATA,U,3)_U_PAT_U_$$FMTE^XLFDT(DATE,2)_U_$P(DATA,U,2) ;126
 Q
