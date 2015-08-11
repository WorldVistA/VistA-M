ECPRSUM1 ;BIR/DMA,RHK,JPW - Provider Summary (1 to 7) ;12/2/14  11:09
 ;;2.0;EVENT CAPTURE;**5,18,33,47,62,63,61,72,88,95,112,119,126**;8 May 96;Build 8
 ;In patch 119, temporary data storage for the report was moved from
 ;^TMP($J to ^TMP("ECTMP",$J so that the exportable version of the
 ;report, which is returned in ^TMP($J,"ECRPT", wouldn't be deleted upon
 ;completion. That change occurred in many lines in this routine.
 ;
 S DIC=200,DIC(0)="AQEMZ",DIC("A")="Select Provider: "
 D ^DIC K DIC G END:Y<0 S ECU=+Y,ECUN=$P(Y,"^",2)
 ;D REASON^ECRUTL ;* Prompt to include Procedure Reasons. 112, Remove reasons from report
 I ($D(DIRUT))!($D(DUOUT)) G END
BDATE K %DT S %DT="AEX",%DT("A")="Starting with Date: "
 D ^%DT G:Y<0 END S ECSD=Y
EDATE K %DT S %DT="AEX",%DT("A")="Ending with Date: " D ^%DT G:Y<0 END
 I Y<ECSD D  G EDATE
 .W !!,"The ending date cannot be earlier than the starting date.  "
 .W "Please re-enter",!,"the ending date.",!
 S ECED=Y,ECDATE=ECSD_"^"_ECED
DEV ;dev call
 W !!,"This report is formatted for 132 column output.",!!
 S %ZIS="Q",%ZIS("A")="Select Device: " D ^%ZIS G END:POP
 I $D(IO("Q")) K ZTSAVE S (ZTSAVE("ECRY"),ZTSAVE("ECSD"),ZTSAVE("ECDATE"),ZTSAVE("ECED"),ZTSAVE("ECU"),ZTSAVE("ECUN"))="",ZTDESC="Event Capture Provider Summary",ZTRTN="EN^ECPRSUM1" D ^%ZTLOAD,HOME^%ZIS K ZTSK G END
 ;
EN ;QUEUED ENTRY POINT
 N ECPG,ECGT,EC,ECCAT,ECPXD,MODI,ECI,ECPRV,RK,A,ECX,EC725,ECEPN,ECLOCN,ECUNITN ;119,126
 I $G(ECPTYP)'="E" U IO ;119 Only need IO if not exporting
 S (ECOUT,ECPG)=0 F ECI=1:1:7 S ECGT(ECI)=0,A(ECI)=0
 K ^TMP("ECTMP",$J) S ECOUT=0,ECSD=ECSD-.1,ECED=ECED+.3
 F ECD=ECSD:0 S ECD=$O(^ECH("AC",ECD)) Q:'ECD  Q:ECD>ECED  F DA=0:0 S DA=$O(^ECH("AC",ECD,DA)) Q:'DA  I $D(^ECH("APRV",ECU,DA)) S EC=$G(^ECH(DA,0)) D 
 .K ECPRV S ECPRV=$$GETPRV^ECPRVMUT(DA,.ECPRV),ECX=0 I ECPRV Q
 .F ECI=1:1:7 S A(ECI)=0
 .F ECI=1:1:7 S ECX=$O(ECPRV(ECX)) Q:'ECX  D
 ..S A(ECI)=$P(ECPRV(ECX),U)=ECU
 .S ECX=A(1)=A(2)=A(3)=A(4)=A(5)=A(6)=A(7) I 'ECX Q
 .S ECPAT=+$P(EC,"^",2),PA=$G(^DPT(ECPAT,0)),SS=$P(PA,"^",9)
 .S PA=$S($P(PA,"^")]"":$P(PA,"^"),1:"UNKNOWN"),ECP=$P(EC,"^",9)
 .Q:ECP']""
 .S ECLOC=+$P(EC,U,4),ECUNIT=+$P(EC,U,7),ECCAT=+$P(EC,U,8)
 .I $G(ECSLOC)'="ALL"&('$D(ECSLOC(ECLOC))) Q  ;126 Location check
 .I $G(ECSUNIT)'="ALL"&('$D(ECSUNIT(ECUNIT))) Q  ;126 DSS Unit check
 .S ECLOCN=$$GET1^DIQ(4,ECLOC,.01) ;126 Get location name
 .S ECUNITN=$$GET1^DIQ(724,ECUNIT,.01) ;126 Get DSS Unit name
 .S ECPSY=+$O(^ECJ("AP",ECLOC,ECUNIT,ECCAT,ECP,""))
 .S ECPSYN=$P($G(^ECJ(ECPSY,"PRO")),"^",2)
 .S ECFILE=$P(ECP,";",2),ECFILE=$S($E(ECFILE)="I":81,$E(ECFILE)="E":725,1:"UNKNOWN")
 .I ECFILE="UNKNOWN" S ECPN="UNKNOWN"
 .S ECCPT=$S(ECFILE=81:+ECP,1:$P($G(^EC(725,+ECP,0)),"^",5)),ECPXD=""
 .I ECCPT'="" D
 ..S ECPXD=$$CPT^ICPTCOD(ECCPT,$P(ECED,".")),ECCPT=$P(ECPXD,"^",2)_" "
 .I ECFILE=81 S ECPN=$S($P(ECPXD,"^",3)]"":$P(ECPXD,"^",3),1:"UNKNOWN")
 .I ECFILE=725 S EC725=$G(^EC(725,+ECP,0)),ECPN=$P(EC725,"^",2)_" "_$P(EC725,"^")
 .S ECEPN=$S(ECFILE=81:ECPN,1:$P(EC725,U))_$S(ECPSYN]"":" ["_ECPSYN_"]",1:"") ;119
 .S ECPTDS=ECCPT_ECPN_$S(ECPSYN]"":" ["_ECPSYN_"] ",1:"")
 .;Get Procedure CPT modifiers
 . K ECMOD S ECMODF=0 I $O(^ECH(DA,"MOD",0))'="" D
 ..S ECMODF=$$MOD^ECUTL(DA,"I",.ECMOD)
 ..;K ECMOD S ECMODF=$$MOD^ECUTL(DA,"I",.ECMOD)
 .;
 .;ALB/ESD - Get procedure reason from EC Patient file (#721) record
 .S ECPRSN="",ECLNK=+$P(EC,"^",23)
 .I +ECLNK>0 DO
 ..S ECPRSN=$P($G(^ECL(ECLNK,0)),"^",1)
 ..S:+ECPRSN'>0 ECPRSN="REASON NOT DEFINED"
 ..S:+ECPRSN>0 ECPRSN=$P(^ECR(ECPRSN,0),"^",1)
 .S:+ECLNK'>0 ECPRSN="REASON NOT DEFINED"
 .I '$D(ECRY) S ECPRSN="REASON NOT DEFINED"
 .;
 .;ALB/ESD - Add procedure reason to ^TMP array
 .S PRO=ECCPT_ECPN I PRO]"" S V=+$P(EC,"^",10) D
 ..F J=1:1:7 I A(J) S ^(J)=$G(^TMP("ECTMP",$J,ECLOCN,ECUNITN,PRO,ECPRSN,PA_"^"_SS,J))+V D  ;126
 ...I $G(^TMP("ECTMP",$J,ECLOCN,ECUNITN,PRO))="" S ^TMP("ECTMP",$J,ECLOCN,ECUNITN,PRO)=ECPTDS ;126
 ..;ALB/JAM - Add Procedure CPT modifier to ^TMP array
 ..S MOD="" F  S MOD=$O(ECMOD(MOD)) Q:MOD=""  D
 ...S ^TMP("ECTMP",$J,ECLOCN,ECUNITN,PRO,ECPRSN,PA_"^"_SS,"MOD",MOD)=$G(^TMP("ECTMP",$J,ECLOCN,ECUNITN,PRO,ECPRSN,PA_"^"_SS,"MOD",MOD))+V ;126
 .I $G(ECPTYP)="E" S ^TMP("ECTMP",$J,ECLOCN,ECUNITN,PRO,ECPRSN,PA_U_SS,"EXPORT")=$P($G(ECCPT)," ")_U_$S(ECFILE=725:$P(EC725,U,2),1:"")_U_$G(ECEPN) ;119,126 additional information needed for export
 K ECLNK,MOD,ECPTDS
 I $G(ECPTYP)="E" D EXPORT,^ECKILL K ^TMP("ECTMP",$J) Q  ;119 If exporting, process and then quit
 ;
PRINT ;print report
 S ECSD=$P(ECDATE,"^"),ECED=$P(ECDATE,"^",2)
 I '$D(^TMP("ECTMP",$J)) S (ECLOC,ECUNIT)="" D HDR W !!,?12,"No Event Capture Provider Summary for "_ECUN_" to report for the date range selected.",!! D PAGE G END ;126
 S ECLOC="" F  S ECLOC=$O(^TMP("ECTMP",$J,ECLOC)) Q:ECLOC=""  D  ;126
 .S ECUNIT="" F  S ECUNIT=$O(^TMP("ECTMP",$J,ECLOC,ECUNIT)) Q:ECUNIT=""  D  ;126
 ..;126 Code below modified for dot structure and correct array reference
 ..D HDR ;126 need header for each section
 ..F ECI=1:1:7 S A(ECI)=0
 ..S (ECREAS,PA,PR)=""
 ..F  S PR=$O(^TMP("ECTMP",$J,ECLOC,ECUNIT,PR)),PA="" Q:PR=""  D  Q:ECOUT
 ...W !,^TMP("ECTMP",$J,ECLOC,ECUNIT,PR)
 ...F  S ECREAS=$O(^TMP("ECTMP",$J,ECLOC,ECUNIT,PR,ECREAS)) Q:ECREAS=""  D  Q:ECOUT
 ....F  S PA=$O(^TMP("ECTMP",$J,ECLOC,ECUNIT,PR,ECREAS,PA)) D:PA="" TOT Q:PA=""  D  Q:ECOUT
 .....S A=$G(^TMP("ECTMP",$J,ECLOC,ECUNIT,PR,ECREAS,PA,0))
 .....W ! W:$D(ECRY) $E(ECREAS,1,23)
 .....W ?25,$E($P(PA,"^"),1,24),?52,$E($P(PA,"^",2),6,9) ;112 only print last 4
 .....F J=1:1:7 S A=$G(^TMP("ECTMP",$J,ECLOC,ECUNIT,PR,ECREAS,PA,J)),A(J)=A(J)+A W ?10*J+50,$J(A,5,0) I J=7 I $Y+8>IOSL D PAGE Q:ECOUT  D HDR
 .....;print CPT procedure modifiers
 .....Q:ECOUT  S IEN=""
 .....F  S IEN=$O(^TMP("ECTMP",$J,ECLOC,ECUNIT,PR,ECREAS,PA,"MOD",IEN)) Q:IEN=""  D  I ECOUT Q
 ......S MODI=$$MOD^ICPTMOD(IEN,"I",$P(ECED,"."))
 ......S MOD=$P(MODI,U,2) I MOD="" Q
 ......S MODESC=$P(MODI,U,3)  I MODESC="" S MODESC="UNKNOWN"
 ......S MODAMT=^TMP("ECTMP",$J,ECLOC,ECUNIT,PR,ECREAS,PA,"MOD",IEN)
 ......W !?5,"- ",MOD," ",MODESC," (",MODAMT,")"
 ......I ($Y+7)>IOSL D PAGE Q:ECOUT  D HDR
 .....K MODESC,MOD,MODAMT
 W !!,?60 F RK=61:1:IOM W "*"
 W !,?35,"GRAND TOTAL - PROCEDURES"
 F J=1:1:7 W ?10*J+50,$J(ECGT(J),5,0)
 D:'ECOUT PAGE G END
 ;
PAGE ; end of page
 D FOOTER
 I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR I 'Y S ECOUT=1
 Q
HDR ;
 W:$Y @IOF S ECPG=ECPG+1
 W !!?33,"EVENT CAPTURE PROVIDER (1-7) SUMMARY FOR ",ECUN,?118,"Page: ",ECPG,!,?33,"LOCATION: ",$G(ECLOC),!,?33,"DSS UNIT: ",$G(ECUNIT) ;112,126
 W !,?33,"FOR THE DATE RANGE ",$$FMTE^XLFDT(ECSD)," TO ",$$FMTE^XLFDT(ECED),!!,"PROCEDURE",?85,"TOTALS AS PROVIDER #",! ;112,126
 W:$D(ECRY) "PROCEDURE REASON" W ?25,"PATIENT",?52,"SSN",?64,1,?74,2,?84,3,?94,4,?104,5,?114,6,?124,7
 W !,?5,"CPT MODIFIER (Volume of modifiers used)",! ;126 fixed spelling error
 F RK=1:1:IOM W "-"
 W !
 Q
 ;
TOT W !,?60 F RK=61:1:IOM W "-"
 W !?35,"TOTAL PROCEDURES"
 F J=1:1:7 W ?10*J+50,$J(A(J),5,0) S ECGT(J)=ECGT(J)+A(J)
 W ! F ECI=1:1:7 S A(ECI)=0
 Q
 ;
FOOTER ;print page footer
 W !!?4,"Volume totals may represent days, minutes, numbers of procedures"
 W " and/or a combination of these." ;126 Combined lines for report
 Q
 ;
END D ^ECKILL K ^TMP("ECTMP",$J),ZTSK W @IOF
 K ^TMP("ECTMP",$J) Q:$D(ECGUI)
 I $D(ZTQUEUED) S ZTREQ="@"
 D ^%ZISC
 Q
 ;
EXPORT ;Section added in 119
 N CNT,ECI,A,PA,PR,ECREAS,EXPORT,SUB,MODCNT,MODI,MOD,MODESC,MODAMT,ECLOC,ECUNIT ;126
 S CNT=1
 S ^TMP($J,"ECRPT",CNT)="PROVIDER NAME^LOCATION^DSS UNIT^CPT CODE^CPT MOD #1 (VOL)^CPT MOD #2 (VOL)^CPT MOD #3 (VOL)^PROCEDURE CODE^PROCEDURE NAME^PATIENT^SSN" ;126
 S ^TMP($J,"ECRPT",CNT)=^TMP($J,"ECRPT",CNT)_"^TOTAL AS PROV #1^TOTAL AS PROV #2^TOTAL AS PROV #3^TOTAL AS PROV #4^TOTAL AS PROV #5^TOTAL AS PROV #6^TOTAL AS PROV #7" ;126
 S ECLOC="" F  S ECLOC=$O(^TMP("ECTMP",$J,ECLOC)) Q:ECLOC=""  D  ;126
 .S ECUNIT="" F  S ECUNIT=$O(^TMP("ECTMP",$J,ECLOC,ECUNIT)) Q:ECUNIT=""  D  ;126
 ..;126 Section modified for dot structure and array levels
 ..S (ECREAS,PA,PR)=""
 ..F  S PR=$O(^TMP("ECTMP",$J,ECLOC,ECUNIT,PR)),PA="" Q:PR=""  D
 ...F  S ECREAS=$O(^TMP("ECTMP",$J,ECLOC,ECUNIT,PR,ECREAS)) Q:ECREAS=""  D
 ....F  S PA=$O(^TMP("ECTMP",$J,ECLOC,ECUNIT,PR,ECREAS,PA)) Q:PA=""  D
 .....S EXPORT=^TMP("ECTMP",$J,ECLOC,ECUNIT,PR,ECREAS,PA,"EXPORT")
 .....S CNT=CNT+1
 .....S ^TMP($J,"ECRPT",CNT)=ECUN_U_ECLOC_U_ECUNIT_U_$P(EXPORT,U) ;126
 .....S SUB=0,MODCNT=0 F  S:SUB'="" SUB=$O(^TMP("ECTMP",$J,ECLOC,ECUNIT,PR,ECREAS,PA,"MOD",SUB)) Q:MODCNT=3  D  S ^TMP($J,"ECRPT",CNT)=^TMP($J,"ECRPT",CNT)_U_MOD,MODCNT=MODCNT+1 ;126
 ......S MOD="" I SUB="" Q  ;126
 ......S MODI=$$MOD^ICPTMOD(SUB,"I",$P(ECED,".")) S MOD=$P(MODI,U,2) Q:MOD=""  S MODESC=$S($P(MODI,U,3)="":"UNKNOWN",1:$P(MODI,U,3)),MODAMT=^TMP("ECTMP",$J,ECLOC,ECUNIT,PR,ECREAS,PA,"MOD",SUB) ;126
 ......S MOD=MOD_" "_MODESC_" ("_MODAMT_")" ;126
 .....S ^TMP($J,"ECRPT",CNT)=^TMP($J,"ECRPT",CNT)_U_$P(EXPORT,U,2)_U_$P(EXPORT,U,3)_U_$P(PA,U)_U_$E($P(PA,U,2),6,9) ;126
 .....F J=1:1:7 S $P(^TMP($J,"ECRPT",CNT),U,(J+11))=+$G(^TMP("ECTMP",$J,ECLOC,ECUNIT,PR,ECREAS,PA,J)) ;126
 Q
