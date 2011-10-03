ECPAT ;BIR/MAM,JPW - Event Capture Patient Summary ;1 Jul 2008
 ;;2.0; EVENT CAPTURE ;**5,18,47,72,95**;8 May 96;Build 26
SET ; set ^TMP($J,"ECPAT")
 N ECPXD,EC725
 I $Y+11>IOSL D PAGE I ECOUT Q
 S ECEC=$G(^ECH(ECFN,0))
 S ECL=+$P(ECEC,"^",4),ECC=+$P(ECEC,"^",8),ECP=$P(ECEC,"^",9),ECD=+$P(ECEC,"^",7),ECV=+$P(ECEC,"^",10)
 S ECU=$$GETPPRV^ECPRVMUT(ECFN,.ECUN),ECUN=$S(ECU:"UNKNOWN",1:$P(ECUN,"^",2))
 Q:ECP']""
 ;set default med spec and ord sect to administrative if blank
 S ECM=$S($P(ECEC,"^",6)]"":+$P(ECEC,"^",6),1:108),ECO=$S($P(ECEC,"^",12)]"":+$P(ECEC,"^",12),1:108)
 S ECMN=$S($P($G(^ECC(723,ECM,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
 S ECON=$S($P($G(^ECC(723,ECO,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
 S ECS=+$P(ECEC,"^",5),ECSN=$S($P($G(^DIC(49,ECS,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
 S ECCN=$S($P($G(^EC(726,ECC,0)),"^")]"":$P(^(0),"^"),1:"None")
 S ECPSY=+$O(^ECJ("AP",ECL,ECD,ECC,ECP,""))
 S ECPSYN=$P($G(^ECJ(ECPSY,"PRO")),"^",2)
 S ECFILE=$P(ECP,";",2),ECFILE=$S($E(ECFILE)="I":81,1:725)
 S ECCPT=$S(ECFILE=81:+ECP,1:$P($G(^EC(725,+ECP,0)),"^",5)),ECPXD=""
 I ECCPT'="" D
 . S ECPXD=$$CPT^ICPTCOD(ECCPT,$P(ECEC,"^",3)),ECCPT=$P(ECPXD,"^",2)
 . I ECCPT'="" S ECCPT=ECCPT_" "
 I ECFILE=81 S ECPN=$S($P(ECPXD,"^",3)]"":$P(ECPXD,"^",3),1:"UNKNOWN")
 I ECFILE=725 D
 .S EC725=$G(^EC(725,+ECP,0)),ECPN=$P(EC725,"^",2)_" "_$P(EC725,"^")
 S ECPN=$J(ECCPT,6)_$E(ECPN,1,38)_$S(ECPSYN]"":" ["_ECPSYN_"] ",1:"")
 S ECDN=$S($P($G(^ECD(ECD,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
 S ECLN=$S($P($G(^DIC(4,ECL,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
 S ECUN=$S(ECUN'="UNKNOWN":$P(ECUN,",",2)_" "_$P(ECUN,","),1:"UNKNOWN")
 S ECDT=$$FMTE^XLFDT(DATE)
 ;
 ;ALB/ESD - Add Procedure Reason to report
 N ECLNK
 S ECPRSN=""
 S ECLNK=+$P(ECEC,"^",23)
 I +ECLNK>0 DO
 .S ECPRSN=$P($G(^ECL(ECLNK,0)),"^",1)
 .S:+ECPRSN'>0 ECPRSN="REASON NOT DEFINED"
 .S:+ECPRSN>0 ECPRSN=$P(^ECR(ECPRSN,0),"^",1)
 S:+ECLNK'>0 ECPRSN="REASON NOT DEFINED"
 ;
 ;Get Procedure CPT modifiers
 S ECMODF=0 K ECMOD
 I $O(^ECH(ECFN,"MOD",0))'="" S ECMODF=$$MOD^ECUTL(ECFN,"E",.ECMOD)
 I $D(ECY) DO
 .W !!,ECDT,?25,ECCN,?80,ECPN_" ("_ECV_")",!
 .I ECMODF S MD="" D  K MD I ECOUT Q
 ..F  S MD=$O(ECMOD(MD)) Q:MD=""  D  I ECOUT Q
 ...D:$Y+5>IOSL PAGE Q:ECOUT  W ?84,"- ",MD," ",$P(ECMOD(MD),U,3),!
 .W $E(ECLN,1,22),?25,ECSN,?80,ECMN,!
 .W:$D(ECRY) ECPRSN
 .W ?25,ECON,?80,ECUN
 I $D(ECN) DO
 .W !!,ECDT,?25,ECPN_" ("_ECV_")",!
 .I ECMODF S MD="" D  K MD I ECOUT Q
 ..F  S MD=$O(ECMOD(MD)) Q:MD=""  D  I ECOUT Q
 ...D:$Y+5>IOSL PAGE Q:ECOUT  W ?29,"- ",MD," ",$P(ECMOD(MD),U,3),!
 .W $E(ECLN,1,22),?25,ECSN,?80,ECMN,!
 .W:$D(ECRY) ECPRSN
 .W ?25,ECON,?80,ECUN
 Q
PAT ; entry point
 K DIC S DIC=2,DIC(0)="QEAMZ",DIC("A")="Select Patient: " D ^DIC K DIC G:Y<0 END S ECDFN=+Y,ECPAT=$P(Y,"^",2)
DATE K %DT S %DT="AEX",%DT("A")="Start with Date:  " D ^%DT G:Y<0 END S ECSD=Y,%DT("A")="End with Date:  " D ^%DT G:Y<0 END S ECED=Y I ECED<ECSD W !,"End date must be after start date",! G DATE
 S ECDATE=$$FMTE^XLFDT(ECSD)_"^"_$$FMTE^XLFDT(ECED),ECSD=ECSD-.0001,ECED=ECED+.9999
 D REASON^ECRUTL ;* Prompt to report Procedure Reasons
 K IOP,%ZIS,POP,IO("Q") S %ZIS("A")="Select Device: ",%ZIS="QM" W !!,"This report is designed to use a 132 column format.",! D ^%ZIS G:POP END
 I $D(IO("Q")) S:$D(ECRY) ZTSAVE("ECRY")=""
 I $D(IO("Q")) K IO("Q") S (ZTSAVE("ECDFN"),ZTSAVE("ECPAT"),ZTSAVE("ECDATE"),ZTSAVE("ECED"),ZTSAVE("ECSD"))="",ZTDESC="EVENT CAPTURE PATIENT SUMMARY",ZTRTN="SUM^ECPAT",ZTIO=ION D ^%ZTLOAD,HOME^%ZIS G END
SUM ; entry when queued
 S %H=$H D YX^%DTC S ECRDT=Y
 U IO S DATE=$O(^ECH("APAT",ECDFN,ECSD)) I 'DATE W:$Y @IOF W !!,"No Data for "_ECPAT_" during the time selected." G END
 S ECFN=+$O(^ECH("APAT",ECDFN,DATE,0)),ECL=+$P(^ECH(ECFN,0),"^",4) D BRO D:$D(ECY) HDR D:$D(ECN) HDR1
 S DATE=ECSD,(ECFN,ECOUT)=0 F I=0:0 S DATE=$O(^ECH("APAT",ECDFN,DATE)) Q:'DATE!(DATE>ECED)!(ECOUT)  F I=0:0 S ECFN=$O(^ECH("APAT",ECDFN,DATE,ECFN)) Q:'ECFN!(ECOUT)  D SET
 D FOOTER  ;for last page
END I $D(ECGUI) D ^ECKILL Q
 W ! I $D(ECOUT),'ECOUT D
 . I $E(IOST,1,2)="C-" W !!,"Press <RET> to continue  " R X:DTIME
 W @IOF D ^%ZISC D ^ECKILL S:$D(ZTQUEUED) ZTREQ="@"
 Q
HDR ; print heading
 ;
 ;ALB/ESD - Add Procedure Reason to column headings
 W:$Y @IOF
 W !,?32,"EVENT CAPTURE PATIENT SUMMARY FOR "_ECPAT,!,?32,"FROM "_$P(ECDATE,"^")_"   TO "_$P(ECDATE,"^",2),!,?32,"Run Date : ",ECRDT
 W !,"PROCEDURE DATE/TIME",?25,"CATEGORY",?80,"PROCEDURE",!,?80,"PROCEDURE (CPT) MODIFIER",!,"LOCATION",?25,"SERVICE",?80,"SECTION"
 W !
 W:$D(ECRY) "PROCEDURE REASON"
 W ?25,"ORDERING SECTION",?80,"PROVIDER",! F LINE=1:1:132 W "-"
 W !
 Q
PAGE ; end of page
 I $G(X)'["?" D FOOTER
 S X="" I $E(IOST,1,2)="C-" W !!,"Press <RET> to continue, or ^ to quit   " R X:DTIME I '$T!(X="^") S ECOUT=1 Q
 I X["?" W !!,"If you want to continue with this report, press <RET>.  Entering an ^ will",!,"exit you from this option." G PAGE
 D:$D(ECY) HDR D:$D(ECN) HDR1
 Q
HDR1 ; print heading without categories
 ;
 ;ALB/ESD - Add Run Date to header
 W @IOF,!!,?32,"EVENT CAPTURE PATIENT SUMMARY FOR "_ECPAT,!,?36,"FROM "_$P(ECDATE,"^")_"   TO "_$P(ECDATE,"^",2),!,?36,"Run Date : ",ECRDT
 ;
 ;ALB/ESD - Add Procedure Reason to column headings
 W !!,"PROCEDURE DATE/TIME",?25,"PROCEDURE(VOLUME)",!,?25,"PROCEDURE (CPT) MODIFIER",!,"LOCATION",?25,"SERVICE",?80,"SECTION"
 W !
 W:$D(ECRY) "PROCEDURE REASON"
 W ?25,"ORDERING SECTION",?80,"PROVIDER",! F LINE=1:1:132 W "-"
 W !
 Q
 ;
FOOTER ;print page footer
 W !!?4,"Volume totals may represent days, minutes, numbers of procedures"
 W !?4,"and/or a combination of these."
 Q
 ;
BRO ;ask prt with category or without
 S ECN=1
 Q
