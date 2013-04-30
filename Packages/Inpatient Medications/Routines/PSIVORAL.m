PSIVORAL ;BIR/MLM-ACTIVITY LOGGER FOR PHARMACY EDITS ;16 DEC 97 / 1:40 PM 
 ;;5.0;INPATIENT MEDICATIONS;**58,135,267**;16 DEC 97;Build 158
 ;
 ; Reference to ^PS(52.7 is supported by DBIA 2173.
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ;
EN ; Entry point for updating activity log from Pharmacy.
 ;
 D OPI
 ;
REMARKS ; Record changes to remarks.
 I $G(^PS(55,DFN,"IV",+ON55,1))'=P("REM") S P("FC")="REMARKS^"_$G(^(1))_U_P("REM") D GTFC
 ;
ADMIN ; Record changes to admin. times.
 I $P($G(^PS(55,DFN,"IV",+ON55,0)),U,11)'=P(11) S P("FC")="ADMINISTRATION TIMES^"_$P($G(^(0)),U,11)_U_P(11) D GTFC
 ;
INFUS ; Record changes to infusion rate.
 I $P($G(^PS(55,DFN,"IV",+ON55,0)),U,8)'=P(8) S P("FC")="INFUSION RATE^"_$P($G(^(0)),U,8)_U_P(8) D GTFC
 D:P("DTYP")=1 SOL
 ;
STOP ; Record changes to stop date.
 I $P(^PS(55,DFN,"IV",+ON55,0),U,3)'=P(3) S P("FC")="STOP DATE/TIME^",Y=$P(^(0),U,3) X ^DD("DD") S $P(P("FC"),U,3)=$P(Y,"@")_" "_$P(Y,"@",2),Y=P(3) X ^DD("DD") S $P(P("FC"),U,2)=$P(Y,"@")_" "_$P(Y,"@",2) D GTFC
 K DRGI,DRGN,TDRG,P("AGE"),P("FC")
 Q
 ;
SOL ; Record changes to Solutions.
 K TDRG F DRGI=0:0 S DRGI=$O(DRG("SOL",DRGI)) Q:'DRGI  S TDRG("NEW",$P(DRG("SOL",DRGI),U))=$P(DRG("SOL",DRGI),U,2,3)
 S P("AGE")="NEW"
 F DRGI=0:0 S DRGI=$O(^PS(55,DFN,"IV",+ON55,"SOL",DRGI)) Q:'DRGI  S X=$G(^PS(55,DFN,"IV",+ON55,"SOL",DRGI,0)),DRG=+$P(X,U),TDRG("OLD",+DRG)=$P($G(^PS(52.7,DRG,0)),U)_U_$P(X,U,2) D:$G(TDRG("NEW",DRG))'=$G(TDRG("OLD",DRG)) SOL1
 S P("AGE")="OLD" F DRGI=0:0 S DRG=$O(TDRG("NEW",DRG)) Q:'DRG  D:$G(TDRG("NEW",DRG))'=$G(TDRG("OLD",DRG)) SOL1
 Q
 ;
SOL1 ;
 I '$D(TDRG(P("AGE"),DRG)) S P("FC")="SOLUTION^"_$P($G(TDRG("OLD",DRG)),U)_U_$P($G(TDRG("NEW",DRG)),U) D GTFC
 Q:$G(TDRG("NEW",DRG))=$G(TDRG("OLD",DRG))
 S P("FC")="VOLUME^"_$P($G(TDRG("OLD",DRG)),U,2)_$S($G(TDRG("OLD",DRG))]"":" ("_$P($G(^PS(52.7,DRG,0)),U)_")",1:"")_U_$P($G(TDRG("NEW",DRG)),U,2)_$S($G(TDRG("NEW",DRG))]"":" ("_$P($G(^PS(52.7,DRG,0)),U)_")",1:"") D GTFC
 Q
 ;
GTFC ; Create field change entry in activity log.
 N TXTCNT,TXTLN
 S ND=$G(^PS(55,DFN,"IV",+ON55,"A",PSIVLN,1,0)) S:ND="" ND="^55.151^^" S $P(ND,U,3)=$P(ND,U,3)+1,$P(ND,U,4)=$P(ND,U,4)+1,^PS(55,DFN,"IV",+ON55,"A",PSIVLN,1,0)=ND,^PS(55,DFN,"IV",+ON55,"A",PSIVLN,1,$P(ND,U,3),0)=P("FC") K ND
 I $P(P("FC"),U)="OTHER PRINT INFO" D
 .S TXTLN=0 F TXTCNT=0:1 S TXTLN=$O(^PS(55,DFN,"IV",+ON55,10,TXTLN)) Q:'TXTLN  S ^PS(55,DFN,"IV",+ON55,"A",PSIVLN,2,TXTLN,0)=$G(^PS(55,DFN,"IV",+ON55,10,TXTLN,0))
 .I TXTCNT S ^PS(55,DFN,"IV",+ON55,"A",PSIVLN,2,0)="^"_+TXTCNT_"^"_+TXTCNT
 .S TXTLN=0 F TXTCNT=0:1 S TXTLN=$O(^PS(53.45,+$G(PSJSYSP),6,TXTLN)) Q:'TXTLN  S ^PS(55,DFN,"IV",+ON55,"A",PSIVLN,3,TXTLN,0)=$G(^PS(53.45,+$G(PSJSYSP),6,TXTLN,0))
 .I TXTCNT S ^PS(55,DFN,"IV",+ON55,"A",PSIVLN,3,0)="^"_+TXTCNT_"^"_+TXTCNT S ^PS(53.45,+$G(PSJSYSP),6)=PSIVLN
 .N ACNT,AND S ACNT=+$O(^PS(55,DFN,"IV",+ON55,"A",""),-1) I ACNT S AND="^55.04^"_+ACNT_"^"_+ACNT,^PS(55,DFN,"IV",+ON55,"A",0)=AND
 K ND
 Q
LOG ; Update activity log (ask for comment.)
 I $G(P("FC"))["OTHER PRINT INFO" Q:$G(^PS(53.45,+$G(PSJSYSP),6))
 N ON S ON=ON55
 ;PSJPINIT is defined in PSJUTL3.
 S:+$G(PSJPINIT)'>0 PSJPINIT=DUZ
 I $G(PSIVALT)=1,'$G(PSJUNDC) K DA,DIR S DIR(0)="55.04,.04" D ^DIR K DA,DIR S PSIVAL=$S($D(DIRUT):"",1:Y)
 S:$G(PSIVALT)=2 PSIVAL="Action taken using OE/RR options." D ENTACT^PSIVAL
 K TMP
 S TMP(55.04,""_PSIVLN_","_+ON55_","_DFN_","_"",.02)=PSIVREA
 S TMP(55.04,""_PSIVLN_","_+ON55_","_DFN_","_"",.03)=$P(^VA(200,PSJPINIT,0),U)
 S TMP(55.04,""_PSIVLN_","_+ON55_","_DFN_","_"",.04)=$G(PSIVAL)
 S TMP(55.04,""_PSIVLN_","_+ON55_","_DFN_","_"",.06)=PSJPINIT
 D FILE^DIE("","TMP")
 K TMP
 D:$D(PSIVALCK) @PSIVALCK K PSIVALT,PSIVALCK,PSIVAL
 Q
 ;
OPI ; Record changes to Other print info.
 I $$DIFFOPI^PSJBCMA5(DFN,ON55) S P("FC")="OTHER PRINT INFO^^" D GTFC
 Q
