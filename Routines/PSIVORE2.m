PSIVORE2 ;BIR/RGY,PR,MLM-ACT, NEW ORDER (CONT. OF PSIVORE1) ;16 Mar 99 / 2:16 PM
 ;;5.0; INPATIENT MEDICATIONS ;**21,58,101**;16 DEC 97
 ;
 ; References to ^PS(55 supported by DBIA #2191.
 ;
DEQ ;
 S P(4)=$P(^PS(55,DFN,"IV",+ON,0),U,4),ACTION=1,TRACK=4 D ^PSIVLTR D ^PSIVHYPL:P(4)="H",^PSIVLABL:P(4)'="H"
K ;
 S:$D(ZTQUEUED) ZTREQ="@" K PSIVMI,PSI,OD,PSIVEC,PSIVSC,I,PSIVNOL,PSIV1,PSIVA,PSIVDOSE,PSGCNT,PSGSA,PSCT,PDOSE,PDATE,PSIVLABN,UP1,PLAST Q
TL ;
 W ! F X=3:3:24 W "       ",$S($L(X)=1:" ",1:""),X
 W ! F X=1:1:24 W "..:"
 K PSI F X=0:0 S X=$O(^PS(59.5,PSIVSN,2,"AC",P(4),X)) Q:'X  S PSI(+("."_$P(^PS(59.5,PSIVSN,2,X,0),U)))=$S($P($P(^(0),U,6),".")=DT:"*",1:"")
 S PSI=P(4) D TL1
 K PSI S:'$D(PSGSA) PSGSA="" F PSI=1:1 S X=$P(PSGSA," ",PSI) Q:X=""  I X S PSI(X#1)=""
 S PSI="^" D TL1
 D NOW^%DTC S Y=% S PSI(Y#1)="",PSI="N" D TL1 Q
TL1 ;
 W ! S Y="" F X=0:0 S Y=$O(PSI(Y)) Q:'Y  W ?3*$E(Y_"000",2,3)-1+$S($E(Y_"000",4,5)>40:2,$E(Y_"000",4,5)>20:1,1:0),PSI,PSI(Y)
 K PSI Q
C ;
 S SNM=0 F DAT=0:0 S DAT=$O(^PS(55,"PSIVSUS",PSIVSN,DFN,+ON,DAT)) Q:'DAT  S SNM=SNM+$P(^(DAT),U)
 Q
 ;
CONVER(X,Y) ;
 ;***$$FMADD^XLFDT(DT.HH,D,H,M,S) returns the DT.HH+(D,H,M,S)
 ;*I +P(15)>1440 S X=$$FMADD^XLFDT($P(PSGSA," "),"","",(P(15)*(Y-1))) Q X
 I +P(15)>1440 S X=$$CONVER1($P(PSGSA," "),P(15),(Y-1)) Q X
 S PDOSE=X S:Y=2 PDATE=$E($P(PSGSA," "),1,7)
 I $P(PSGSA," ",Y-1)#1'<PDOSE!(P(15)>1440) S X1=PDATE,X2=1 D C^%DTC S PDATE=X,X=X_PDOSE Q X
 S X=PDATE_PDOSE
 Q X
 ;
CONVER1(ORDDT,X,Y)       ;
 ;* This sub-routine is necessary when a schedule such as q36h was
 ;* entered and the Start date is such as T-3@1200.  Without these codes
 ;* instead of schedule due for T@2400 it will display as T+1@0000.
 NEW DAYS,MINS S (DAYS,MINS)=0
 S DAYS=(X*Y)\1440,MINS=(X*Y)#1440
 S X=$$FMADD^XLFDT(ORDDT,DAYS,"",MINS)
 Q X
 ;
INCOMP ; Delete order missing critical information.
 N DIR,PSIVAC W !!,$C(7),"THIS ORDER IS NOT USABLE!",!,"Enter ""D"" to Delete, or ""B"" to Bypass",!
 S DIR(0)="SOA^D:DELETE;B:BYPASS",DIR("A")="ACTION (B/D): ",DIR("??")="^S HELP=""INCOMP"" D ^PSIVHLP2" D ^DIR K DIR Q:Y="B"!$D(DIRUT)  S PSIVAC="N"
 ;
DEL55 ; Delete order from 55.
 I ON55'["V"!($G(P(21))]"") Q
 S DIK="^PS(55,"_DFN_",""IV"",",DA(1)=DFN,DA=+ON55 D ^DIK W:'$G(PSIVORFA) $C(7),"...Order ",$S($E($G(PSIVAC),2)="N":"deleted.",1:"unchanged.")
 N DA,DIK,ORIFN S ORIFN=$P($G(^PS(55,DFN,"IV",+ON55,0)),U,21) I ORIFN,$E($G(PSIVAC),2)="N" D EN1^PSJHL2(DFN,"OD",+ON55_"V","ORDER DELETED")
 L -^PS(55,DFN,"IV",+ON55)
 Q
 ;
NEW ; New order entry
 D NEWENT^PSIVORFE S DRGN="",P("IVRM")=+PSIVSN_U_$P($G(^PS(59.5,+PSIVSN,0)),U)
 K DRG,PSGFDX F X="AD","DRG","LF","LFA","CUM","MR","SOL","OPI","OT","SYRS","REM","SI",2,3,4,5,7,8,9,11,12,15,17,23 S:'$D(P(X)) P(X)=""
 S P(17)="A",P(4)=$E($G(PSIVTYPE)) S:"CS"[P(4) P(23)=$P($G(PSIVTYPE),U,2)
 D:P(4)="" 53^PSIVORC1 Q:$G(P(4))=""  S Y=$P($G(^PS(55,DFN,5.1)),U,2),P(6)=Y_U_$P($G(^VA(200,+Y,0)),U)
 D OTYP^PSIVORC1 S PSIVOK="",EDIT="57^58^59^3"_$S(P("DTYP")=1:"^26^39",1:"")_"^63^64^10^25^1"
 D EDIT^PSIVEDT Q:'$G(P(2))  D GTOT^PSIVUTL(P(4)) D:$G(P("PD"))="" GTPD
 Q
 ;
GTPD ; Find Orderable Item/dosage ordered for IM.
 S P("PD")="" F DRGT="AD","SOL" Q:P("PD")  F DRGI=0:0 S DRGI=$O(DRG(DRGT,DRGI)) Q:'DRGI!P("PD")  D
 . S X=DRG(DRGT,DRGI) S:$P(X,U,6) P("PD")=$P(X,U,6)_U_$$OIDF^PSJLMUT1(+$P(X,U,6))
 . S P("DO")=$P(X,U,3)
 . ;S:$G(P("DO"))="" P("DO")=$P(X,U,3)
 Q
