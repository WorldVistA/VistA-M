PSOBKDE1 ;BIR/MR-Sub-routines for Backdoor Rx Order Edit ;11/25/02
 ;;7.0;OUTPATIENT PHARMACY;**117,133,372,402,500**;DEC 1997;Build 9
 ;
LST1 ;
 W @IOF
 N PSOLCNT,DIRUT,DTOUT,DUOUT,I,PSODOSCT,PSODOSFL,PSOBKDF1
 W !,"This is the amount of medication the patient is to receive as one dose"
 W !,"for this order. This can be a numeric value, such as 325 or 650 or an"
 W !,"amount with a unit of measure such as 325MG or 650MG. You may also enter"
 W !,"a free text dosage, such as 1 Tablet or 2 Tablets",!
 S PSOLCNT=5,PSOBKDF1=1
 ;
LST ;
 I '$G(PSOBKDF1) W @IOF S PSOBKDF1=1
 N DIR I '$D(DOSE("DD")) D  Q
 . W !," No dosages are available"
 . N X S X=$$GET1^DIQ(50,PSODRUG("IEN"),100,"I")
 . W $S(X'=""&(DT>X):" because the Drug is now Inactive.",1:"!")
 . W !," Please, enter a free text dosage, or You may select a New"
 . W !," Orderable Item and Dispense Drug for this order, or you can"
 . W !," enter a New Order with an Active Drug."
 . S PSOLCNT=$G(PSOLCNT)+4
 ;
 I $P(DOSE("DD",PSODRUG("IEN")),"^",5)]"" D
 .W !,"VERB: "_$P(DOSE("DD",PSODRUG("IEN")),"^",10)
 .S PSOLCNT=$G(PSOLCNT)+1
 ;
LST2 ;
 I '$G(PSOBKDF1) W @IOF S PSOBKDF1=1
 N PSOEND
 S (PSODOSFL,PSODOSCT)=0
 F I=0:0 S I=$O(DOSE(I)) Q:'I!('$D(DOSE(I)))  S PSODOSCT=I
 I PSODOSCT=1,$P(DOSE(1),"^")=""&($P(DOSE(1),"^",3)="") S PSODOSFL=1
 W !!,"There "_$S(PSODOSFL:"are NO",PSODOSCT=1&('PSODOSFL):"is ",1:"are ")_$S(PSODOSFL:"",1:PSODOSCT)_" Available Dosage(s)."
 F I=0:0 S I=$O(DOSE(I)) Q:'I!('$D(DOSE(I)))  D
 .S PSOLCNT=$G(PSOLCNT)+1
 .W:'$G(PSODOSFL) !?5,$J(I,3)_". "_$S($P(DOSE(I),"^"):$P(DOSE(I),"^")_$S($P(DOSE("DD",PSODRUG("IEN")),"^",6)]"":$P(DOSE("DD",PSODRUG("IEN")),"^",6),1:""),$P(DOSE(I),"^",3)'="":$P(DOSE(I),"^",3),1:"Please Enter a Free Text Dosage.")
 .;Q:(PSOLCNT+2)>PSODOSFL
 .I (($Y+5)>IOSL) D PAUSE S PSOLCNT=0 W !
 .;I PSOLCNT>16&(I>2) D PAUSE S PSOLCNT=0 W !
 K DIRUT,DIR
 Q
 ;
PAUSE ;
 Q:PSODOSCT=I
 N DIR
 S DIR("A")="Enter RETURN to view additional dosages or '^' to exit the list of dosages"
 S DIR(0)="E" W !
 D ^DIR
 I $D(DTOUT)!($D(DUOUT)) S I=9999 Q
 W @IOF
 Q
