FBAAPHV ;AISC/DMK-PHARMACY PAYMENT VOID ;12JUL88
 ;;3.5;FEE BASIS;**69**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;Variable 'FBVOID' is set if cancelling a voided payment.
 D DT^DICRW
 N FBFPPSC
 I '$D(^XUSEC("FBAASUPERVISOR",DUZ)) W !!,*7,"You must be a Fee supervisor to use this option.",! Q
RD S DIC="^FBAA(162.1,",DIC(0)="AEQM",DIC("A")="Select Invoice number: ",DIC("S")="I $P(^(0),U,5)=4" D ^DIC G Q:X["^"!(X=""),RD:Y<0 S FBAAIN=+Y K DIC("A"),DIC("S")
 S FBFPPSC=$P($G(^FBAA(162.1,FBAAIN,0)),U,13)
 I FBFPPSC]"" W !,?2,"FPPS Claim ID: ",FBFPPSC
RX W ! S DIC="^FBAA(162.1,FBAAIN,""RX"",",DIC(0)="AEQM",DIC("A")="Select Prescription # : " D ^DIC G Q:X["^"!(X=""),RD:Y<0
 S (DA,RX)=+Y,RXN=$P(Y,"^",2) K DIC
 I $D(FBVOID),'$D(^FBAA(162.1,FBAAIN,"RX",RX,2)) W !,*7,"Payment not voided!",! K DA G RD
 I '$D(FBVOID),$D(^FBAA(162.1,FBAAIN,"RX",RX,2)),$P(^(2),"^",3)="V" W !,*7,"Payment already voided!",! K DA G RD
 W !! S DIC="^FBAA(162.1,FBAAIN,""RX"",",DIC(0)="AEQM",DR="" D EN^DIQ
RD1 S DIR(0)="Y",DIR("A")="Is this the prescription you want to "_$S($D(FBVOID):"Cancel the void on ",1:"Void"),DIR("B")="NO",DIR("?")="Answer 'Yes' if you want to "_$S($D(FBVOID):"Cancel the void on ",1:"Void ")_"this prescription."
 D ^DIR K DIR G RD:$D(DIRUT),RX:'Y
 S V=$S($D(FBVOID):"",1:"VOID"),DR=$S($D(FBVOID):"23///@;23.5///@;24///@",1:"23////^S X=""V"";23.5R;24////^S X=DUZ"),DIE="^FBAA(162.1,FBAAIN,""RX""," D ^DIE
 S FBON=$P(^FBAA(162.1,FBAAIN,"RX",DA,0),"^",18),A2=$P(^(0),"^",16),DFN=$P(^(0),"^",5) D ^FBAAVP0 W !,?5,"...  Done.",!
Q K DA,DIC,DIE,DIRUT,RX,RXN,X,Y,A2,DFN,DR,FBAACB,FBAAIN,FBON,FBVOID,ON,P3,P4,RX,RXN,V,VAL Q
