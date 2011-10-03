PSOATRP ;BIR/SJA - INTERNET REFILL REPORT ;05/29/07 12:36pm
 ;;7.0;OUTPATIENT PHARMACY;**264**;DEC 1997;Build 19
 ;
 N PSODS,PSOED,PSOEDX,PSODIV,PSOREP,PSORST,PSORMZ,PSOSD,PSOSDX,PSOSITE,RDATE,X,Y
 S PSORMZ=0 D NOW^%DTC S Y=% X ^DD("DD") S RDATE=Y
 ;
 D SEL^PSOREJU1("DIVISION","^PS(59,",.PSODIV) I $G(PSODIV)="^" D MESS Q
 I $G(PSODIV)="ALL" S PSOSITE=0 F  S PSOSITE=$O(^PS(59,PSOSITE)) Q:'PSOSITE  D
 .I '$P($G(^PS(59,PSOSITE,"I")),"^")!(DT<$P($G(^("I")),"^")) S PSODIV(PSOSITE)=""
 ;
 K DIR W ! S DIR(0)="DAO^:DT:APEX",DIR("A")="Beginning Date: ",DIR("?")=" ",DIR("?",1)="Enter the date to begin searching.",DIR("?",2)="A future date cannot be entered." D ^DIR K DIR
 I 'Y!($D(DTOUT))!($D(DUOUT)) D MESS Q
 S PSOSD=Y D DD^%DT S PSOSDX=Y
 ;
 W ! K DIR S DIR(0)="DAO^:DT:APEX",DIR("A")="Ending Date: ",DIR("?")=" ",DIR("?",1)="Enter the ending date of the search.",DIR("?",2)="This date cannot be a future date." D ^DIR K DIR
 I 'Y!($D(DTOUT))!($D(DUOUT)) D MESS Q
 S PSOED=Y D DD^%DT S PSOEDX=Y
 ;
 W ! K DIR S DIR(0)="S^P:Patient;D:Date;R:Result;",DIR("B")="R"
 S DIR("A")="Sort by Patient/Date/Result (P/D/R)",DIR("?")="Enter 'P' to sort by Patient, 'D' to sort by date, or 'R' to sort by result." D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) D MESS Q
 S PSOREP=Y
 ;
 W ! K DIR S DIR(0)="S^D:Detail;S:Summary;",DIR("B")="S"
 S DIR("A")="Print Detail/Summary report (D/S)",DIR("?")="Enter 'D' to print detail report or 'S' for summary report" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) D MESS Q
 S PSODS=Y
 ;
SKIPC ;
 I PSODS="S" G SEL
 W ! K DIR S DIR("A")="Do you want this report to print in 80 or 132 column format: "
 S DIR("B")="80",DIR(0)="SAM^1:132;8:80" D ^DIR K DIR I Y["^"!($D(DIRUT)) D MESS Q
 W ! S PSORMZ=$S(Y=1:1,1:0)
 ;
SEL D @$S(PSOREP="D":"^PSOATRD",PSOREP="R":"^PSOATRR",1:"^PSOATRPP")
 ;
END K X,Y,PSOSDX,PSOSD,PSOSITE,PSORST,PSOREP,PSODIV,PSOEDX,PSOED,PSODS,DIRUT,DTOUT,DUOUT
 Q
MESS W !!,"Nothing queued to print.",!
 Q
DIV(RX,DV) ; Check if the Division for the Prescription/Fill was selected by the user
 I $G(PSODIV)="ALL" Q 1
 I $D(PSODIV(DV)) Q 1
 Q 0
