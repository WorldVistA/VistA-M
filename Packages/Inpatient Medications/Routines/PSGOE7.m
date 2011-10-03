PSGOE7 ;BIR/CML3-SELECT DRUG ;15 MAY 00 / 1:43 PM
 ;;5.0; INPATIENT MEDICATIONS ;**9,26,34,52,55,50,87,111,181**;16 DEC 97;Build 190
 ;
 ; Reference to ^PS(50.7 is supported by DBIA 2180
 ; Reference to ^PS(59.7 is supported by DBIA 2181
 ; Reference to ^PSDRUG( is supported by DBIA 2192
 ; NFI-UD chgs for FR#: 1
 ; 
 ;S PSGDICS="U"_$S($D(PSJOERR):",I",1:"")
 S PSGDICS="U"
 ;
AD ; Ask Drug
 K PSJDOSE,PSJDOX ;var array use in ^PSJDOSE
 K PSGODO
 K DIC S DIC="^PS(50.7,",DIC(0)="EMQZVT",D="B^C" I '$P(PSJSYSU,";",4) S DIC("S")="I $$ENOISC^PSJUTL(Y,""U"")"
 E  S DIC("T")="",DIC="^PSDRUG(",DIC("S")="I +$G(^PSDRUG(+Y,2)),$P($G(^PSDRUG(+Y,2)),""^"",3)[""U"" S X(1)=+$G(^(""I"")) I $S('X(1):1,1:X(1)'<DT)",D="B^C^VAPN^VAC^NDC^XATC"
 ;
AD1 ;
 K PSGORD,PSJORD,PSJALLGY
 S PSGORQF=0 R !!,"Select DRUG: ",X:DTIME I '$T W $C(7) S X="^"
 I ("^"[X)!(X="") S PSGORQF=1 G DONE
 G:X?1"S."1.E DONE
 I X?1."?" W !!?2,"Select the medication you wish the patient to receive." W:PSJSYSU<3 "  You should consult",!,"with your pharmacy before ordering any non-formulary medication." W !
 D MIX^DIC1 G:X?1."?" AD1 G:"^"[X!(Y'>0) AD1 S (PSGDO,PSGDRG,PSGDRGN,PSGNEDFD,PSGPDRG,PSGPDRGN)=""
 I $P(PSJSYSU,";",4) D  G DO
 .S PSGDRG=+Y,PSGDRGN=Y(0,0)
 .D DIN^PSJDIN(+$G(^PSDRUG(PSGDRG,2)),PSGDRG)
 .I $P(Y(0),"^",9) D NF S:Y>0 PSGDRG=+Y(0),PSGDRGN=Y(0,0) D SNFM
 .S PSGPDRG=+$G(^PSDRUG(PSGDRG,2)),PSGPDRGN=$$OINAME^PSJLMUTL(PSGPDRG)
 S PSGPDRG=+Y,PSGPDRGN=$$OINAME^PSJLMUTL(PSGPDRG)
 ;F Q=1:1:$L(PSGDICS) S X=$P(PSGDICS,",",Q) Q:X=""  S PSJLUAPP=$O(^PS(50.3,PSGPDRG,1,"B",X,0)) I PSJLUAPP S X=$G(^PS(50.3,PSGPDRG,1,PSJLUAPP,0)) Q
 S X=$O(^PSDRUG("ASP",PSGPDRG,0)) I X,'$O(^(X)) S PSGDRG=X,PSGDRGN=$$ENDDN^PSGMI(X)
 ;
DO ; dosage ordered
 NEW PSJALLGY
 S PSGNEDFD=$$GTNEDFD("U",PSGPDRG)
 I $G(PSGDRG),$P(PSJSYSU,";",4) S PSJALLGY(PSGDRG)="" D ENDDC^PSGSICHK(PSGP,PSGDRG) G:$G(PSGORQF) AD
 I '$P(PSJSYSU,";",4) S PSGX=PSGPDRG D END^PSGSICHK G:Y<0 AD
 ;S PSGNEDFD="" I PSGPDRG S PSGX=PSGPDRG D END^PSGSICHK
 S PSGDO=""
 ;I PSGDO]"",'PSGDO,PSGDO?.E1N.E F  S PSGDO=$E(PSGDO,2,999) Q:PSGDO  Q:PSGDO=""
 ;G:Y<0 AD
 ;
DONE ;
 K DIC,%,%Y,PSGDICS,PSJLUAPP,Q1,Q2,Q3,Z,PSJALLGY Q
 ;
 ;
NF ;
 S Y=0 W $C(7),!!,"PLEASE NOTE: The selected item is not currently on your medical center's",!?13,"formulary." Q:'$P(PSJSYSU,";",2)
 N CNT S CNT=0 F Q1=0:0 S Q1=$O(^PSDRUG(PSGDRG,65,Q1)) Q:'Q1  I $$CHKDRG(+$G(^(Q1,0))) S CNT=CNT+1
 I CNT=0 W !!,"There are no formulary alternatives entered for this item." W:PSJSYSU>2 "  You should consult",!,"with your pharmacy before ordering this item." S Y=0 Q
 I CNT=1 S Q1=$O(^PSDRUG(PSGDRG,65,0)),Q1=+$G(^(Q1,0)),Q3=$P(^PSDRUG(Q1,0),"^") W !!,Q3," has been entered as a formulary " W:$X>67 ! W "alternative."
 I  F Q=1:1 S %=2 W !!,"Is ",$S(Q=1:"this",1:Q3)," acceptable" D YN^DICN Q:%  D NFOH
 I CNT=1 S:%=1 (Y(0),Y)=Q1,Y(0,0)=Q3 S:%<0 Y=-1 Q
 K DA,DIC S DA(1)=PSGDRG,DIC="^PSDRUG("_PSGDRG_",65,",DIC(0)="AEMQZ",DIC("A")="Select FORMULARY ALTERNATIVE: " W ! D ^DIC K DIC Q
 ;
NFOH ;
 S X="Answer 'YES' to order this formulary alternative ("_Q3_") for the patient instead of the non-formulary item originally selected.  Answer 'NO' to use the drug originally selected."
 W !!?2 F Y=1:1:$L(X," ") S Z=$P(X," ",Y) W:$L(Z)+$X+2>IOM ! W Z," "
 Q
CHKDRG(DRG) ; Determine if dispense drug is valid for Unit Dose.
 I $D(^PSDRUG(DRG,0)),$P($G(^(2)),U,3)["U" S X=+$G(^("I")) I 'X!(X>DT) Q DRG
 Q 0
 ;
SNFM ; show non-formulary message
 S Y=1 Q:PSJSYSU=3!'$O(^PS(59.7,1,21,0))  W $C(7),! S Q=0 F  S Q=$O(^PS(59.7,1,21,Q)) Q:'Q  W !,$G(^(Q,0))
 W ! D READ^PSJUTL S Y=1 Q
 ;
GTNEDFD(APP,PDRG) ; Find defaults from Orderable Item.
 Q $P($G(^PS(50.7,+PDRG,0)),"^",5,8)
 N Q,X S X=""
 F Q=1:1:$L(APP) S X=$E(APP,Q) Q:X=""  S X=$O(^PS(50.3,+PDRG,1,"B",X,0)) I X S X=$P($G(^PS(50.3,+PDRG,1,X,0)),"^",5,8) Q
 Q X
