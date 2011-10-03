PSOBKDE1 ;BIR/MR-Sub-routines for Backdoor Rx Order Edit ;11/25/02
 ;;7.0;OUTPATIENT PHARMACY;**117,133**;DEC 1997
 ;External reference to PSDRUG( supported by DBIA 221
 ;
LST1 ;
 W !,"This is the amount of medication the patient is to receive as one dose"
 W !,"for this order.  This can be a numeric value, such as 325 or 650 or an"
 W !,"amount with a unit of measure such as 325MG or 650MG.  You may also enter"
 W !,"a free text dosage, such as 1 Tablet or 2 Tablets",!
 ;
LST I '$D(DOSE("DD")) D  Q
 . W !,"     No dosages are available"
 . N X S X=$$GET1^DIQ(50,PSODRUG("IEN"),100,"I")
 . W $S(X'=""&(DT>X):" because the Drug is now Inactive.",1:"!")
 . W !,"     Please, enter a free text dosage, or You may select a New"
 . W !,"     Orderable Item and Dispense Drug for this order, or you can"
 . W !,"     enter a New Order with an Active Drug."
 ;
 W:$P(DOSE("DD",PSODRUG("IEN")),"^",5)]"" !,"VERB: "_$P(DOSE("DD",PSODRUG("IEN")),"^",10)
LST2 W !,"Available Dosage(s)"
 K LSTCNT F I=0:0 S I=$O(DOSE(I)) Q:'I!('$D(DOSE(I)))  D
 .W !?5,$J(I,3)_". "_$S($P(DOSE(I),"^"):$P(DOSE(I),"^")_$S($P(DOSE("DD",PSODRUG("IEN")),"^",6)]"":$P(DOSE("DD",PSODRUG("IEN")),"^",6),1:""),$P(DOSE(I),"^",3)'="":$P(DOSE(I),"^",3),1:"Please Enter a Free Text Dosage.")
 .S LSTCNT=$G(LSTCNT)+1 I LSTCNT=15 K DIR S DIR("A")="Enter RETURN to continue or '^' to STOP",DIR(0)="E" W ! D ^DIR K LSTCNT I 'Y S I=9999 Q
 K LSTCNT,DIRUT
 Q
