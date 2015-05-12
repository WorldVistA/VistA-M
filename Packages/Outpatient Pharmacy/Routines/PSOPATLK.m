PSOPATLK ;BIR/JAM - Patient Lookup utility ;7/21/08
 ;;7.0;OUTPATIENT PHARMACY;**326,348,438**;DEC 1997;Build 4
 ;
 ; This API looks for a patient using a prescription number, barcode,
 ; universal Member ID number from the patient's VHIC Card
 ; or the registration standard patient lookup.
 ;
EN ;Entry point - Prompts for Patient, Prescription Number or Barcode
 ; 
 ; Input  - DIC(0) & DIC("A") [Optional] 
 ;          Used by DIR if defined by the calling routine.
 ;
 ; Output - PSOPTLK [Processed user response]
 ;
 N DIR
 K PSOPTLK
 S DIR(0)="FOU"_$S($D(DIC("A")):"A",1:"")_"^^K:$$PATVAL^PSOPATLK() X"
 S DIR("A")=$S($D(DIC("A")):DIC("A"),1:"Select PATIENT NAME")
 S (DIR("?"),DIR("??"))="^D PATHLP^PSOPATLK"
 D ^DIR
 M PSOPTLK=Y
 K DIROUT,DIRUT,DTOUT,DUOUT
 Q
PATHLP ;Help text for patient prompt
 N DIC
 I $E(X)'="?" Q
 I X="?" D
 .W !?1,"Enter the prescription number prefixed by a # (ex. #XXXXXXX) or"
 .W !?1,"Wand the barcode of the prescription. The format of the barcode is"
 .W !?1,"NNN-NNNNNNN where the first 3 digits are your station number."
 .W !?1,"         - OR -           "
 .W !?1,"Enter the universal Member ID number from the patient's VHIC Card"
 .W !?1,"or wand the barcode of the VHIC card"
 .W !?1,"         - OR -           "
 S DIC="^DPT(",DIC(0)="QZEXN" D ^DIC
 Q
 ;
PATVAL() ;Validate user input
 N OUT
 S OUT=0
 ;Prescription lookup
 I X?1"#".E D RXLK Q OUT
 ;Barcode lookup
 I X?3N1"-".N D RXLK Q OUT
 ;Standard patient lookup
 S DIC="^DPT(" S:'$D(DIC(0)) DIC(0)="QEMZ" D ^DIC
 S OUT=$S(+Y>0:0,1:1)
 Q OUT
 ;
RXLK ;Prescription Lookup
 N DFN,DIC,RXNUM,RX,Z
 S RXNUM=X,RX=$S($E(RXNUM)="#":$E(RXNUM,2,999999999),1:$P(RXNUM,"-",2))
 I RX="" W !,$C(7),"No prescription number entered." S OUT=1 Q
 I $E(RXNUM)'="#",$P(RXNUM,"-")'=$$INST() D  S OUT=1 Q
 .W !!,$C(7),"This prescription is not from this institution."
 S Z=$S($E(RXNUM)="#":$O(^PSRX("B",RX,0)),1:RX),Y=$G(^PSRX(+Z,0))
 I (Y="")!(Z="") D  S OUT=1 Q
 .W !,$C(7),"No Prescription Record found"_$S($E(RXNUM)="#":".",1:" for this barcode.")
 S DFN=$P(Y,"^",2) K Y
 N DIC,X S DIC="^DPT(",DIC(0)="QZEXN" S X=DFN D ^DIC
 Q 
INST() ;get institution number
 N PSOINST,DA,DIQ
 S DA=$P($$SITE^VASITE(),"^")
 S PSOINST=$$GET1^DIQ(4,DA,99,"I")
 Q PSOINST
 ;
