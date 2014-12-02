ECPROV3 ;BIR/MAM,JPW - Event Capture Provider Summary (cont'd) ;11/20/12  13:49
 ;;2.0;EVENT CAPTURE;**5,8,18,29,47,56,63,72,95,112,119**;8 May 96;Build 12
 ; This routine is used when printing the report for
 ; all ACCESSIBLE DSS Units
 ;JAM/3/7/03, This routine now combines ECPROV3, ECPROV4 and ECPROV5
 ;
 ;119 Changed all ^TMP($J references to ^TMP("ECTMP",$J so that temporary storage doesn't conflict with exporting data in ^TMP($J
 N %H ;112
 S %H=$H D YX^%DTC S ECRDT=Y
 I ECL D  D LOC D:$G(ECPTYP)="E" EXPORT D:$G(ECPTYP)'="E" PRINT Q  ;119 Q
 .I ECPRV=1 D UNIT Q
 .I 'ECPRV S ECC=+$P(^ECD(ECD,0),U,11) Q
 S ECL=0 D
 .F I=0:0 S ECL=$O(^ECH("ADT",ECL)) Q:'ECL  D
 ..S ECLN=$P(^DIC(4,ECL,0),"^") I ECPRV D UNIT
 ..I 'ECPRV S ECC=+$P(^ECD(ECD,0),U,11)
 ..D LOC
 I $G(ECPTYP)="E" D EXPORT Q  ;119
PRINT ;Changes below were made by VMP to correct NOIS ATG-1003-32545
 S (ECLN,ECPN)=0,ECCN=""
 F I=0:0 S ECLN=$O(^TMP("ECTMP",$J,ECLN)) Q:ECLN=""!(ECOUT)!(ECLN["^")  D
 .I 'ECPRV D CATS Q
 . S ECDN="" D NOUNIT F I=0:0 S ECDN=$O(^TMP("ECTMP",$J,ECLN,ECDN)) Q:ECDN=""!(ECOUT)  D CATS
 K ECPNAM
 D FOOTER  ;print footer on last page
 Q
CATS ; continue looping
 I $O(^TMP("ECTMP",$J,ECLN,ECDN,""))']"" D PAGE W !!!,?12,"NO PROCEDURES" S ECPG=1 Q
 D PAGE Q:ECOUT  S ECPG=1,ECUN=0 F I=0:0 S ECUN=$O(^TMP("ECTMP",$J,ECLN,ECDN,ECUN)) Q:ECUN=""!(ECOUT)  S ECINZ="^"_$O(^(ECUN,0)) D:$Y+10>IOSL PAGE Q:ECOUT  D PRO
 Q
PRO I $Y+13>IOSL D PAGE I ECOUT Q
 W !!,ECUN S ECCN=0 F I=0:0 S ECCN=$O(^TMP("ECTMP",$J,ECINZ,ECCN)) D:ECCN="" TOTP Q:ECCN=""!(ECOUT)  D MORE
 Q
MORE ;
 ;ALB/ESD - Loop through to get procedure reason and print
 W !,?3,ECCN S ECPN=0,(ECPRSN,ECPI)=""
 F  S ECPN=$O(^TMP("ECTMP",$J,ECINZ,ECCN,ECPN)) Q:ECPN=""!(ECOUT)  S ECUSER=1 D:$Y+10>IOSL PAGE Q:ECOUT  K ECUSER F  S ECPRSN=$O(^TMP("ECTMP",$J,ECINZ,ECCN,ECPN,ECPRSN)) Q:ECPRSN=""!(ECOUT)  DO
 .S ECCPT=$S($P(ECPN,"~",3)="I":$P(ECPN,"~",2),1:$P($G(^EC(725,$P(ECPN,"~",2),0)),"^",5))
 .I ECCPT'="" D
 ..;Changes made by VMP to correct NOIS ATG-1003-32545
 ..;use end date/date range to get CPT description; CTD project.
 ..S ECPI=$$CPT^ICPTCOD(ECCPT,$P(ECED,".")),ECCPT=$P(ECPI,"^",2)
 .S EC725="" I $P(ECPN,"~",3)="E" S EC725=$G(^EC(725,+$P(ECPN,"~",2),0))
 .S ECPNAM=$S($P(ECPN,"~",3)="E":$P(EC725,"^"),$P(ECPN,"~",3)="I":$P(ECPI,"^",3),1:"UNKNOWN") ;112
 .S ECPSY=$P(ECPN,"~",4),ECPSYN=""
 .I ECPSY'="" S ECPSYN=$P($G(^ECJ(ECPSY,"PRO")),"^",2)
 .W !,?6,$J(ECCPT_" ",6),$J($S($P($G(EC725),"^",2)="":ECCPT_" ",1:$P($G(EC725),"^",2)_" "),6),?18,$E(ECPNAM,1,40) ;112
 .W:ECPSYN'="" " [",$E(ECPSYN,1,25),"]"
 .W:$D(ECRY) ?70,ECPRSN
 .W ?105,$J(^TMP("ECTMP",$J,ECINZ,ECCN,ECPN,ECPRSN),6)
 .;print CPT procedure modifiers
 .S IEN=""
 .F  S IEN=$O(^TMP("ECTMP",$J,ECINZ,ECCN,ECPN,ECPRSN,"MOD",IEN)) Q:IEN=""  D  I ECOUT Q
 ..;used end date to get description,CTD project
 ..S MODI=$$MOD^ICPTMOD(IEN,"I",$P(ECED,"."))
 ..S MOD=$P(MODI,"^",2) I MOD="" K MODI Q
 ..S MODESC=$P(MODI,"^",3) I MODESC="" S MODESC="UNKNOWN"
 ..S MODAMT=^TMP("ECTMP",$J,ECINZ,ECCN,ECPN,ECPRSN,"MOD",IEN)
 ..W !?10,"- ",MOD," ",MODESC," (",MODAMT,")"
 ..I ($Y+6)>IOSL D PAGE
 .K MODESC,MOD,IEN,MODAMT,MODI,EC725
 Q
LOC S (ECDFN,ECOUT,^TMP("ECTMP",$J,ECLN))=0
 F I=0:0 S ECDFN=$O(^ECH("ADT",ECL,ECDFN)) Q:'ECDFN  D
 .I ECPRV D GECD Q
 .D GMM
 Q
GECD S ECD=0 F I=0:0 S ECD=$O(^ECH("ADT",ECL,ECDFN,ECD)) Q:'ECD  D GMM
 Q
GMM S MM=ECSD F I=0:0 S MM=$O(^ECH("ADT",ECL,ECDFN,ECD,MM)) Q:'MM!(MM>ECED)  D LOC1
 Q
LOC1 S ECFN=0 F I=0:0 S ECFN=$O(^ECH("ADT",ECL,ECDFN,ECD,MM,ECFN)) Q:'ECFN  D UTL
 Q
UTL ; set ^TMP("ECTMP",$J
 Q:'$D(^ECH(+ECFN,0))!(+$G(ECD)'=$P($G(^ECH(+ECFN,0)),"^",7))
 S ECEC=^ECH(+ECFN,0),ECV=+$P(ECEC,"^",10),ECC=+$P(ECEC,"^",8)
 ;S ECP=$P(ECEC,"^",9),ECU=+$P(ECEC,"^",11)
 S ECP=$P(ECEC,"^",9),ECU=$$GETPPRV^ECPRVMUT(ECFN,.ECUN),ECUN=$S(ECU:"UNKNOWN",1:$P(ECUN,"^",2))
 S ECCN=$S($P($G(^EC(726,ECC,0)),"^")]"":$P(^(0),"^"),1:"None")
 Q:ECP']""
 S ECD=+$P(ECEC,"^",7)
 I ECPRV=1 Q:'$D(ECDU(ECD))  S ECDN=ECDU(ECD)
 I ECPRV=2 S ECDN=$S($P($G(^ECD(ECD,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
 ;S ECUN=$S($P($G(^VA(200,ECU,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
 S ECPSY=+$O(^ECJ("AP",ECL,ECD,ECC,ECP,"")),ECPN=""
 S ECFILE=$P(ECP,";",2),ECFILE=$S($E(ECFILE)="I":81,$E(ECFILE)="E":725,1:"UNKNOWN")
 I ECFILE=81 S ECPN=$P($$CPT^ICPTCOD(+ECP,$P(ECED,".")),"^",3)
 I ECFILE=725 S ECPN=$P($G(^EC(725,+ECP,0)),"^")
 I ECFILE="UNKNOWN"!(ECPN="") S ECPN="UNKNOWN"
 ;Changes made by VMP to correct NOIS SDC-1003-60397
 S ECPN=$E(ECPN,1,5)_"~"_$P(ECP,";")_"~"_$E($P(ECP,";",2))_"~"_ECPSY
 ;Get Procedure CPT modifiers
 S ECMODF=0 K ECMOD
 I $O(^ECH(+ECFN,"MOD",0))'="" S ECMODF=$$MOD^ECUTL(+ECFN,"I",.ECMOD)
 ;
 ;ALB/ESD - Get procedure reason from EC Patient file (#721) record
 N ECLNK
 S ECPRSN=""
 S ECLNK=+$P(ECEC,"^",23)
 I +ECLNK>0 DO
 .S ECPRSN=$P($G(^ECL(ECLNK,0)),"^",1)
 .S:+ECPRSN'>0 ECPRSN="REASON NOT DEFINED"
 .S:+ECPRSN>0 ECPRSN=$P(^ECR(ECPRSN,0),"^",1)
 S:+ECLNK'>0 ECPRSN="REASON NOT DEFINED"
 I '$D(ECRY) S ECPRSN="REASON NOT DEFINED" ;group proc reason-not print
 I '$D(^TMP("ECTMP",$J,ECLN,ECDN,ECUN)) S ECINC=ECINC+1,ECINZ="^"_ECINC,^(ECUN)=0,^(ECUN,ECINC)=0
 S ECINZ="^"_$O(^TMP("ECTMP",$J,ECLN,ECDN,ECUN,0))
 I '$D(^TMP("ECTMP",$J,ECINZ,ECCN)) S ^TMP("ECTMP",$J,ECINZ,ECCN)=0
 ;
 ;ALB/ESD - Add procedure reason to ^TMP array
 I '$D(^TMP("ECTMP",$J,ECINZ,ECCN,ECPN,ECPRSN)) S ^TMP("ECTMP",$J,ECINZ,ECCN,ECPN,ECPRSN)=0
 S ^TMP("ECTMP",$J,ECLN)=^TMP("ECTMP",$J,ECLN)+ECV
 S ^TMP("ECTMP",$J,ECLN,ECDN,ECUN)=^TMP("ECTMP",$J,ECLN,ECDN,ECUN)+ECV
 S ^TMP("ECTMP",$J,ECINZ,ECCN)=^TMP("ECTMP",$J,ECINZ,ECCN)+ECV
 ;
 ;ALB/ESD - Add procedure reason to ^TMP array
 S ^TMP("ECTMP",$J,ECINZ,ECCN,ECPN,ECPRSN)=^TMP("ECTMP",$J,ECINZ,ECCN,ECPN,ECPRSN)+ECV
 ;ALB/JAM - Add Procedure CPT modifier to ^TMP array
 S MOD="" F  S MOD=$O(ECMOD(MOD)) Q:MOD=""  D
 . S ^TMP("ECTMP",$J,ECINZ,ECCN,ECPN,ECPRSN,"MOD",MOD)=$G(^TMP("ECTMP",$J,ECINZ,ECCN,ECPN,ECPRSN,"MOD",MOD))+ECV
 Q
PAGE ; end of page
 D:$D(ECPG) FOOTER
 I $D(ECPG),$E(IOST,1,2)="C-" W !!,"Press <RET> to continue, or ^ to quit  " R X:DTIME I '$T!(X="^") S ECOUT=1 Q
HDR ; print heading
 W:$Y @IOF W !!,?49,"EVENT CAPTURE PROVIDER SUMMARY",!,?49,"FROM "_$P(ECDATE,"^")_"  TO "_$P(ECDATE,"^",2),!,?49,"Run Date : ",ECRDT
 W !!?3,"Category",?105,"Procedure/Reason",!,?6,"CPT",?12,"Proc",?18,"Procedure Name" ;112
 W:$D(ECRY) ?70,"Procedure Reason #1" ;112
 W ?105,"Volume*",!,?6,"Code",?12,"Code",!,?10,"CPT Modifier (volume)",! ;112
 F LINE=1:1:132 W "-"
 W !!,"Location: "_ECLN,! W:ECDN]"" "DSS Unit: "_ECDN
 I ECPRV,$D(ECUSER) W !!,ECUN,!,ECCN
 Q
FOOTER ;print page footer
 W !!?4,"*Volume totals may represent days, minutes, numbers of procedures and/or a combination of these."
 I $G(ECRY)'="" W !?4,"Procedure/Reason Volume = count of unique combinations of procedure code and procedure reason" ;112
 Q
 ;
TOTP Q:ECOUT  W !,?105,"------",!,"Total Procedures for "_ECUN,?105,$J(^TMP("ECTMP",$J,ECLN,ECDN,ECUN),6)
 Q
UNIT ; set units
 S CNT=0 F I=0:0 S CNT=$O(UNIT(CNT)) Q:'CNT  S ECDU(+UNIT(CNT))=$P(UNIT(CNT),"^",2)
 Q
 ;
NOUNIT ;Nothing there
 I $O(^TMP("ECTMP",$J,ECLN,ECDN))']"" D PAGE W !!!,?12,"NO PROCEDURES",! S ECPG=1
 Q
 ;
EXPORT ;119 Entire section added in patch 119 for exporting data to excel
 N CNT,ECLN,ECPN,ECCN,I,ECDN,ECINZ,ECUN,ECPRSN,ECPI,ECCPT,EC725,ECPNAM,ECPSY,ECPSYN,MOD1,VOL1,MOD2,VOL2,MOD3,VOL3
 S CNT=1,^TMP($J,"ECRPT",CNT)="LOCATION^DSS UNIT^CATEGORY^PROVIDER^CPT CODE^PROCEDURE CODE^PROCEDURE NAME^PROCEDURE REASON#1^PROCEDURE/REASON VOLUME^CPT MOD 1^CPT MOD 1 VOL^CPT MOD 2^CPT MOD 2 VOL^CPT MOD 3^CPT MOD 3 VOL"
 S ECLN=0 F  S ECLN=$O(^TMP("ECTMP",$J,ECLN)) Q:ECLN=""!(ECLN["^")  D
 .S ECDN="" F  S ECDN=$O(^TMP("ECTMP",$J,ECLN,ECDN)) Q:ECDN=""  D
 ..S ECUN=0 F  S ECUN=$O(^TMP("ECTMP",$J,ECLN,ECDN,ECUN)) Q:ECUN=""  D
 ...S ECINZ="^"_$O(^TMP("ECTMP",$J,ECLN,ECDN,ECUN,0))
 ...S ECCN=0 F  S ECCN=$O(^TMP("ECTMP",$J,ECINZ,ECCN)) Q:ECCN=""  D
 ....S ECPN=0 F  S ECPN=$O(^TMP("ECTMP",$J,ECINZ,ECCN,ECPN)) Q:ECPN=""  D
 .....S ECPRSN="" F  S ECPRSN=$O(^TMP("ECTMP",$J,ECINZ,ECCN,ECPN,ECPRSN)) Q:ECPRSN=""  D
 ......S ECPI="",ECCPT=$S($P(ECPN,"~",3)="I":$P(ECPN,"~",2),1:$P($G(^EC(725,$P(ECPN,"~",2),0)),U,5)) I ECCPT'="" S ECPI=$$CPT^ICPTCOD(ECCPT,$P(ECED,".")),ECCPT=$P(ECPI,U,2)
 ......S EC725="" I $P(ECPN,"~",3)="E" S EC725=$G(^EC(725,+$P(ECPN,"~",2),0))
 ......S ECPNAM=$S($P(ECPN,"~",3)="E":$P(EC725,U),$P(ECPN,"~",3)="I":$P(ECPI,U,3),1:"UNKNOWN")
 ......S ECPSY=$P(ECPN,"~",4),ECPSYN="" I ECPSY'="" S ECPSYN=$P($G(^ECJ(ECPSY,"PRO")),U,2)
 ......S CNT=CNT+1,^TMP($J,"ECRPT",CNT)=ECLN_U_ECDN_U_ECCN_U_ECUN_U_ECCPT_U_$S($P($G(EC725),U,2)="":ECCPT,1:$P($G(EC725),U,2))_U_ECPNAM_$S(ECPSYN'="":" ["_ECPSYN_"]",1:"")_U_ECPRSN_U_^TMP("ECTMP",$J,ECINZ,ECCN,ECPN,ECPRSN)
 ......D ORDMODS S ^TMP($J,"ECRPT",CNT)=^TMP($J,"ECRPT",CNT)_U_MOD1_U_VOL1_U_MOD2_U_VOL2_U_MOD3_U_VOL3
 Q
 ;119, sections added to order CPT modifiers
ORDMODS ;Find first three mods by volume
 N MOD,ORD,VOL,NUM
 S (MOD1,VOL1,MOD2,VOL2,MOD3,VOL3)="",NUM=0
 S MOD="" F  S MOD=$O(^TMP("ECTMP",$J,ECINZ,ECCN,ECPN,ECPRSN,"MOD",MOD)) Q:'+MOD  S ORD(-^TMP("ECTMP",$J,ECINZ,ECCN,ECPN,ECPRSN,"MOD",MOD),MOD)=""
 I $D(ORD) S VOL="" F  S VOL=$O(ORD(VOL)) Q:VOL=""!(NUM=3)  S MOD="" F  S MOD=$O(ORD(VOL,MOD)) Q:MOD=""!(NUM=3)   S NUM=NUM+1 S @("MOD"_NUM)=$$MODNM(MOD),@("VOL"_NUM)=-VOL
 Q
 ;
MODNM(IEN) ;Get modifier name
 N MOD,MODI,MODESC
 S MODI=$$MOD^ICPTMOD(IEN,"I",$P(ECED,"."))
 S MOD=$P(MODI,U,2) I MOD="" Q MOD
 S MODESC=$S($P(MODI,U,3)'="":$P(MODI,U,3),1:"Unknown")
 Q MOD_" "_MODESC
