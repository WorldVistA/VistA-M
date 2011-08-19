ECPCER ;BIR/JPW - Event Capture PCE Data Summary ;1 Jul 2008
 ;;2.0; EVENT CAPTURE ;**4,18,23,47,72,95**;8 May 96;Build 26
EN ; entry point
 K DIC S DIC=2,DIC(0)="QEAMZ",DIC("A")="Select Patient: " D ^DIC K DIC G:Y<0 END S ECDFN=+Y,ECPAT=$P(Y,"^",2)
DATE K %DT S %DT="AEX",%DT("A")="Start with Date:  " D ^%DT G:Y<0 END S ECSD=Y,%DT("A")="End with Date:  " D ^%DT G:Y<0 END S ECED=Y I ECED<ECSD W !,"End date must be after start date",! G DATE
 S ECDATE=$$FMTE^XLFDT(ECSD)_"^"_$$FMTE^XLFDT(ECED),ECSD=ECSD-.0001,ECED=ECED+.9999
 K IOP,%ZIS,POP,IO("Q") S %ZIS("A")="Select Device: ",%ZIS="QM" W !!,"This report is designed to use a 132 column format.",! D ^%ZIS G:POP END
 I $D(IO("Q")) K IO("Q") S (ZTSAVE("ECDFN"),ZTSAVE("ECPAT"),ZTSAVE("ECDATE"),ZTSAVE("ECED"),ZTSAVE("ECSD"))="",ZTDESC="ECS/PCE PATIENT SUMMARY",ZTRTN="SUM^ECPCER",ZTIO=ION D ^%ZTLOAD,HOME^%ZIS G END
SUM ; entry when queued
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
 ;W !,"LOCATION",?25,"CLINIC (DSS ID)",?78,"PROVIDER",!
 W !,"LOCATION",?25,"CLINIC (DSS ID)",?78,"CPT CODE"
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
 I $Y+10>IOSL D PAGE I ECOUT Q
 Q:'$D(^ECH(ECFN,"PCE"))  S ECEC=$G(^ECH(ECFN,"PCE"))
 I '$P($G(^ECH(ECFN,"P")),"^",7) Q
 S ECL=+$P(ECEC,"~",4),ECCPT=+$P(ECEC,"~",10),ECD=+$P(ECEC,"~",3),ECV=+$P(ECEC,"~",9),ECDX=+$P(ECEC,"~",11),ECID=$P(ECEC,"~",5),ECDT=+$P(ECEC,"~")
 S ECDN=$S($P($G(^SC(ECD,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
 S ECPS=$$CPT^ICPTCOD(ECCPT,$P(ECEC,"~")),ECCPT=$S(+ECPS>0:$P(ECPS,"^",2),1:""),ECPS=$S(+ECPS>0:$P(ECPS,"^",2)_" "_$P(ECPS,"^",3),1:"CPT NAME UNKNOWN")
 S ECLN=$S($P($G(^DIC(4,ECL,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
 S ECID=$S($P($G(^DIC(40.7,ECID,0)),"^",2)]"":$P(^(0),"^",2),1:"DSS ID UNKNOWN")
 S ECDXN=$P($$ICDDX^ICDCODE(ECDX,$P(ECEC,"~")),U,2) S:ECDXN="" ECDXN="UNKNOWN"
 S ECPN=$S($P(ECEC,"~",16)]"":$P(ECEC,"~",16),1:ECPS)
 S ECU=$$GETPPRV^ECPRVMUT(ECFN,.ECUN),ECUN=$S(ECU:"UNKNOWN",1:$P(ECUN,"^",2))
 S ECUN=$S(ECUN'="UNKNOWN":$P(ECUN,",",2)_" "_$P(ECUN,","),1:"UNKNOWN")
 S ECDT=$$FMTE^XLFDT(ECDT)
 ;get secondary diagnosis codes, ALB/JAM
 S DXS=0,ECI=2 F  S DXS=$O(^ECH(ECFN,"DX",DXS)) Q:'DXS  D
 . S DXSIEN=+$G(^ECH(ECFN,"DX",DXS,0)) I DXSIEN="" Q
 . S ECDXSN=$P($$ICDDX^ICDCODE(DXSIEN,$P(ECEC,"~")),"^",2) I ECDXSN="" Q
 . I $L($G(ECDXS(ECI)))+$L(ECDXSN)>52 S ECI=ECI+1
 . I $G(ECDXS(ECI))="" S ECDXS(ECI)="Secondary Dx: "
 . S ECDXS(ECI)=ECDXS(ECI)_$S($L(ECDXS(ECI))=14:"",1:", ")_ECDXSN
 S ECMOD="" I $D(^ECH(ECFN,"PCE1")) S ECMOD=^("PCE1")
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
