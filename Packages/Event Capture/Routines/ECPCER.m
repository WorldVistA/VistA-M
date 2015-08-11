ECPCER ;BIR/JPW - Event Capture PCE Data Summary ;10/9/14  16:43
 ;;2.0;EVENT CAPTURE;**4,18,23,47,72,95,119,114,126**;8 May 96;Build 8
 ;
 ; Reference to $$SINFO^ICDEX supported by ICR #5747
 ; Reference to $$ICDDX^ICDEX supported by ICR #5747
 ;
EN ; entry point
 K DIC S DIC=2,DIC(0)="QEAMZ",DIC("A")="Select Patient: " D ^DIC K DIC G:Y<0 END S ECDFN=+Y,ECPAT=$P(Y,"^",2)
DATE K %DT S %DT="AEX",%DT("A")="Start with Date:  " D ^%DT G:Y<0 END S ECSD=Y,%DT("A")="End with Date:  " D ^%DT G:Y<0 END S ECED=Y I ECED<ECSD W !,"End date must be after start date",! G DATE
 S ECDATE=$$FMTE^XLFDT(ECSD)_"^"_$$FMTE^XLFDT(ECED),ECSD=ECSD-.0001,ECED=ECED+.9999
 K IOP,%ZIS,POP,IO("Q") S %ZIS("A")="Select Device: ",%ZIS="QM" W !!,"This report is designed to use a 132 column format.",! D ^%ZIS G:POP END
 I $D(IO("Q")) K IO("Q") S (ZTSAVE("ECDFN"),ZTSAVE("ECPAT"),ZTSAVE("ECDATE"),ZTSAVE("ECED"),ZTSAVE("ECSD"))="",ZTDESC="ECS/PCE PATIENT SUMMARY",ZTRTN="SUM^ECPCER",ZTIO=ION D ^%ZTLOAD,HOME^%ZIS G END
SUM ; entry when queued
 N ECEPN,ECPCODE,ECEXDS,ECEI ;119
 I $G(ECPTYP)="E" D EXPORT,^ECKILL Q  ;119
 S %H=$H D YX^%DTC S ECRDT=Y
 U IO S DATE=$O(^ECH("APAT",ECDFN,ECSD)) I 'DATE W:$Y @IOF W !!,"No Data for "_ECPAT_" during the time selected." G END
 S ECFN=+$O(^ECH("APAT",ECDFN,DATE,0)),ECL=+$P(^ECH(ECFN,0),"^",4) D HDR1
 S DATE=ECSD,(ECFN,ECOUT)=0 F  S DATE=$O(^ECH("APAT",ECDFN,DATE)) Q:'DATE!(DATE>ECED)!(ECOUT)  F  S ECFN=$O(^ECH("APAT",ECDFN,DATE,ECFN)) Q:'ECFN!(ECOUT)  D SET
 D FOOTER  ;print footer on last page
END I $D(ECGUI) D ^ECKILL Q
 W ! I $E(IOST,1,2)="C-" W !!,"Press <RET> to continue  " R X:DTIME
 W @IOF D ^%ZISC D ^ECKILL S:$D(ZTQUEUED) ZTREQ="@"
 Q
PAGE ; end of page
 I $G(X)'["?" D FOOTER
 S X="" I $E(IOST,1,2)="C-" W !!,"Press <RET> to continue, or ^ to quit   " R X:DTIME I '$T!(X="^") S ECOUT=1 Q
 I X["?" W !!,"If you want to continue with this report, press <RET>.  Entering an ^ will",!,"exit you from this option." G PAGE
 D HDR1
 Q
HDR1 ; print heading without categories
 W:$Y @IOF
 ;W !,?31,"ECS/PCE PATIENT SUMMARY FOR "_ECPAT,!,?36,"FROM "_$P(ECDATE,"^")_"   TO "_$P(ECDATE,"^",2),!!,"PROCEDURE DATE/TIME",?25,"PROCEDURE NAME SENT (VOLUME)",?78,"CPT CODE (DIAGNOSIS)",!?78,"PROCEDURE (CPT) MODIFIER"
 W !,?31,"ECS/PCE PATIENT SUMMARY FOR "_ECPAT,!,?36,"FROM "_$P(ECDATE,"^")_"   TO "_$P(ECDATE,"^",2),!!,"PROCEDURE DATE/TIME",?25,"PROCEDURE NAME SENT (VOLUME)",?78,"PROVIDER"
 W !,"LOCATION",?25,"CLINIC (STOP CODE)",?78,"CPT CODE" ;126
 W !,?25,"DIAGNOSIS",?78,"PROCEDURE (CPT) MODIFIER",!
 F LINE=1:1:132 W "-"
 W !
 Q
FOOTER ;print page footer
 W !!?4,"Volume totals may represent days, minutes, numbers of procedures"
 W !?4,"and/or a combination of these."
 Q
 ;
SET ; set data
 I $G(ECPTYP)'="E" I $Y+10>IOSL D PAGE I ECOUT Q  ;119
 Q:'$D(^ECH(ECFN,"PCE"))  S ECEC=$G(^ECH(ECFN,"PCE"))
 I '$P($G(^ECH(ECFN,"P")),"^",7) Q
 S ECL=+$P(ECEC,"~",4),ECCPT=+$P(ECEC,"~",10),ECD=+$P(ECEC,"~",3),ECV=+$P(ECEC,"~",9),ECDX=+$P(ECEC,"~",11),ECID=$P(ECEC,"~",5),ECDT=+$P(ECEC,"~")
 S ECDN=$S($P($G(^SC(ECD,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
 S ECPS=$$CPT^ICPTCOD(ECCPT,$P(ECEC,"~")),ECCPT=$S(+ECPS>0:$P(ECPS,"^",2),1:""),ECEPN=$S(+ECPS>0:$P(ECPS,U,3),1:""),ECPS=$S(+ECPS>0:$P(ECPS,"^",2)_" "_$P(ECPS,"^",3),1:"CPT NAME UNKNOWN") ;119
 S ECLN=$S($P($G(^DIC(4,ECL,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
 S ECID=$S($P($G(^DIC(40.7,ECID,0)),"^",2)]"":$P(^(0),"^",2),1:"DSS ID UNKNOWN")
 ; Changes for ICD10
 N ECCS
 S ECCS=$$SINFO^ICDEX("DIAG",$P(ECEC,"~")) ; Supported by ICR 5747
 S ECDXN=$$ICDDX^ICDEX(ECDX,$P(ECEC,"~"),+ECCS,"I") ; Supported by ICR 5747
 S ECDXN=$S($P(ECDXN,U,1)=-1:"UNKNOWN",1:$P(ECDXN,U,2))
 S ECPN=$S($P(ECEC,"~",16)]"":$P(ECEC,"~",16),1:ECPS)
 S ECPCODE="" ;119
 I $P(^ECH(ECFN,0),U,9)["EC" S:$P(ECEC,"~",16)]"" ECEPN=$$GET1^DIQ(721,ECFN,8) S ECPCODE=$P($P(ECEC,"~",16)," ") ;119
 S ECU=$$GETPPRV^ECPRVMUT(ECFN,.ECUN),ECUN=$S(ECU:"UNKNOWN",1:$P(ECUN,"^",2))
 S ECUN=$S(ECUN'="UNKNOWN":$P(ECUN,",",2)_" "_$P(ECUN,","),1:"UNKNOWN")
 S ECDT=$$FMTE^XLFDT(ECDT)
 ;get secondary diagnosis codes, ALB/JAM
 S DXS=0,ECI=2,ECEI=1 F  S DXS=$O(^ECH(ECFN,"DX",DXS)) Q:'DXS  D  ;119
 . S DXSIEN=+$G(^ECH(ECFN,"DX",DXS,0)) I DXSIEN="" Q
 . S ECDXSN=$$ICDDX^ICDEX(DXSIEN,$P(ECEC,"~"),+ECCS,"I")
 . S ECDXSN=$S($P(ECDXSN,U,1)=-1:"UNKNOWN",1:$P(ECDXSN,U,2))
 . I $L($G(ECDXS(ECI)))+$L(ECDXSN)>52 S ECI=ECI+1
 . I $G(ECDXS(ECI))="" S ECDXS(ECI)="Secondary Dx: "
 . S ECDXS(ECI)=ECDXS(ECI)_$S($L(ECDXS(ECI))=14:"",1:", ")_ECDXSN
 . S ECEXDS(ECEI)=ECDXSN,ECEI=ECEI+1 ;119
 S ECMOD="" I $D(^ECH(ECFN,"PCE1")) S ECMOD=^("PCE1")
 I $G(ECPTYP)="E" Q  ;119
PRT W !,ECDT,?25,ECPN_" ("_ECV_")",?78,ECUN,!
 W $E(ECLN,1,22),?25,ECDN_" ("_ECID_")",?78,ECCPT,!
 W ?25,"Primary DX: ",ECDXN
 ;ALB/JAM print CPT modifiers and secondary diagnosis code
 F I=1:1 S MOD=$P(ECMOD,";",I) Q:MOD=""  D  I ECOUT Q
 . S MODESC=$$MODP^ICPTMOD(ECCPT,MOD,"E",$P(ECEC,"~")) I +MODESC'>0 Q
 . W ?25,$S(I>1:$G(ECDXS(I)),1:""),?79,"- ",MOD," ",$P(MODESC,"^",2),!
 . K ECDXS(I) I ($Y+6)>IOSL D PAGE I ECOUT Q
 W:ECMOD="" ! S DXS=""
 F  S DXS=$O(ECDXS(DXS)) Q:DXS=""  W ?25,ECDXS(DXS),!
 K I,MOD,MODESC,ECI,DXS,DXSIEN,ECDXS,ECDXN,ECDXSN
 Q
EXPORT ;Produce exportable version, added in patch 119
 N CNT,DATE,ECFN,I,MOD,MODESC
 S CNT=1
 S ^TMP($J,"ECRPT",CNT)="PATIENT^PROCEDURE DATE/TIME^LOCATION^CLINIC^STOP CODE^CPT CODE^PROCEDURE CODE^PROCEDURE NAME^PROCEDURE VOLUME^CPT MOD 1^CPT MOD 2^CPT MOD 3^PROVIDER^PRIMARY DIAGNOSIS^2ND DIAG 1^2ND DIAG 2^2ND DIAG 3^2ND DIAG 4" ;126
 S DATE=ECSD F  S DATE=$O(^ECH("APAT",ECDFN,DATE)) Q:'+DATE!(DATE>ECED)  S ECFN=0 F  S ECFN=$O(^ECH("APAT",ECDFN,DATE,ECFN)) Q:'+ECFN  D
 .Q:'$D(^ECH(ECFN,"PCE"))
 .I '$P($G(^ECH(ECFN,"P")),U,7) Q
 .K ECEXDS D SET
 .S CNT=CNT+1
 .S ^TMP($J,"ECRPT",CNT)=ECPAT_U_ECDT_U_ECLN_U_ECDN_U_ECID_U_ECCPT_U_ECPCODE_U_ECEPN_U_ECV
 .F I=1:1:3 D
 ..S MOD=$P(ECMOD,";",I),MODESC="" I MOD'="" S MODESC=$$MODP^ICPTMOD(ECCPT,MOD,"E",$P(ECEC,"~")) S MODESC=$S(+MODESC>0:MOD_" "_$P(MODESC,U,2),1:"")
 ..S ^TMP($J,"ECRPT",CNT)=^TMP($J,"ECRPT",CNT)_U_MODESC
 .S ^TMP($J,"ECRPT",CNT)=^TMP($J,"ECRPT",CNT)_U_ECUN_U_ECDXN
 .F I=1:1:4 S ^TMP($J,"ECRPT",CNT)=^TMP($J,"ECRPT",CNT)_U_$G(ECEXDS(I))
 Q
