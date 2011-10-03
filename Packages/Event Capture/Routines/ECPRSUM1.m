ECPRSUM1 ;BIR/DMA,RHK,JPW - Provider Summary (1 to 7) ;22 Jul 2008
 ;;2.0; EVENT CAPTURE ;**5,18,33,47,62,63,61,72,88,95**;8 May 96;Build 26
 S DIC=200,DIC(0)="AQEMZ",DIC("A")="Select Provider: "
 D ^DIC K DIC G END:Y<0 S ECU=+Y,ECUN=$P(Y,"^",2)
 D REASON^ECRUTL ;* Prompt to include Procedure Reasons
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
 N ECPG,ECGT,EC,ECCAT,ECPXD,MODI,ECI,ECPRV,RK,A,ECX,EC725
 U IO
 S (ECOUT,ECPG)=0 F ECI=1:1:7 S ECGT(ECI)=0,A(ECI)=0
 K ^TMP($J) S ECOUT=0,ECSD=ECSD-.1,ECED=ECED+.3
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
 .S ECPSY=+$O(^ECJ("AP",ECLOC,ECUNIT,ECCAT,ECP,""))
 .S ECPSYN=$P($G(^ECJ(ECPSY,"PRO")),"^",2)
 .S ECFILE=$P(ECP,";",2),ECFILE=$S($E(ECFILE)="I":81,$E(ECFILE)="E":725,1:"UNKNOWN")
 .I ECFILE="UNKNOWN" S ECPN="UNKNOWN"
 .S ECCPT=$S(ECFILE=81:+ECP,1:$P($G(^EC(725,+ECP,0)),"^",5)),ECPXD=""
 .I ECCPT'="" D
 ..S ECPXD=$$CPT^ICPTCOD(ECCPT,$P(ECED,".")),ECCPT=$P(ECPXD,"^",2)_" "
 .I ECFILE=81 S ECPN=$S($P(ECPXD,"^",3)]"":$P(ECPXD,"^",3),1:"UNKNOWN")
 .I ECFILE=725 S EC725=$G(^EC(725,+ECP,0)),ECPN=$P(EC725,"^",2)_" "_$P(EC725,"^")
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
 ..F J=1:1:7 I A(J) S ^(J)=$G(^TMP($J,PRO,ECPRSN,PA_"^"_SS,J))+V D
 ...I $G(^TMP($J,PRO))="" S ^TMP($J,PRO)=ECPTDS
 ..;ALB/JAM - Add Procedure CPT modifier to ^TMP array
 ..S MOD="" F  S MOD=$O(ECMOD(MOD)) Q:MOD=""  D
 ...S ^TMP($J,PRO,ECPRSN,PA_"^"_SS,"MOD",MOD)=$G(^TMP($J,PRO,ECPRSN,PA_"^"_SS,"MOD",MOD))+V
 K ECLNK,MOD,ECPTDS
 ;
PRINT ;print report
 S ECSD=$P(ECDATE,"^"),ECED=$P(ECDATE,"^",2)
 D HDR I '$D(^TMP($J)) W !!,?12,"No Event Capture Provider Summary for "_ECUN_" to report for the date range selected.",!! D PAGE G END
 F ECI=1:1:7 S A(ECI)=0
 S (ECREAS,PA,PR)=""
 F  S PR=$O(^TMP($J,PR)),PA="" Q:PR=""  D  Q:ECOUT
 .W !,^TMP($J,PR)
 .F  S ECREAS=$O(^TMP($J,PR,ECREAS)) Q:ECREAS=""  D  Q:ECOUT
 ..F  S PA=$O(^TMP($J,PR,ECREAS,PA)) D:PA="" TOT Q:PA=""  D  Q:ECOUT
 ...S A=$G(^TMP($J,PR,ECREAS,PA,0))
 ...W ! W:$D(ECRY) $E(ECREAS,1,23)
 ...W ?25,$E($P(PA,"^"),1,24),?50,$P(PA,"^",2)
 ...F J=1:1:7 S A=$G(^TMP($J,PR,ECREAS,PA,J)),A(J)=A(J)+A W ?10*J+50,$J(A,5,0) I J=7 I $Y+8>IOSL D PAGE Q:ECOUT  D HDR
 ...;print CPT procedure modifiers
 ...Q:ECOUT  S IEN=""
 ...F  S IEN=$O(^TMP($J,PR,ECREAS,PA,"MOD",IEN)) Q:IEN=""  D  I ECOUT Q
 ....S MODI=$$MOD^ICPTMOD(IEN,"I",$P(ECED,"."))
 ....S MOD=$P(MODI,U,2) I MOD="" Q
 ....S MODESC=$P(MODI,U,3)  I MODESC="" S MODESC="UNKNOWN"
 ....S MODAMT=^TMP($J,PR,ECREAS,PA,"MOD",IEN)
 ....W !?5,"- ",MOD," ",MODESC," (",MODAMT,")"
 ....I ($Y+7)>IOSL D PAGE Q:ECOUT  D HDR
 ...K MODESC,MOD,MODAMT
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
 W !!?33,"EVENT CAPTURE PROVIDER SUMMARY FOR ",ECUN,?118,"Page: ",ECPG,!,?33,"FOR THE DATE RANGE ",$$FMTE^XLFDT(ECSD)," TO ",$$FMTE^XLFDT(ECED),!!,"PROCEDURE",?85,"TOTALS AS PROVIDER #",!
 W:$D(ECRY) "PROCEDURE REASON" W ?25,"PATIENT",?52,"SSN",?64,1,?74,2,?84,3,?94,4,?104,5,?114,6,?124,7
 W !,?5,"CPT MODIFIER (Volume of modifiers use)",!
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
 W !?4,"and/or a combination of these."
 Q
 ;
END D ^ECKILL K ^TMP($J),ZTSK W @IOF
 K ^TMP($J) Q:$D(ECGUI)
 I $D(ZTQUEUED) S ZTREQ="@"
 D ^%ZISC
 Q
