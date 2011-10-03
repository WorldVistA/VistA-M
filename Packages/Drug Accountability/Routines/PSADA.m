PSADA ;BIR/LTL-Pharmacy Location Lookup Utility ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;; 10/24/97
 ;This routine is called by many routines. It is used to allow the user
 ;to select a pharmacy location.
 ;
START D DT^DICRW N D,DIC,DIR,DIRUT,DTOUT,DUOUT,PSA,PSAB,PSAC,PSADRUG,PSAII,PSAIT,PSAIPS,PSAINV,PSAISIT,PSAOC,PSAOSIT,PSASTO,PSAITY,PSAOP,PSAO,PSAI,PSAOU,X,Y
 S PSALOC(1)=$O(^PSD(58.8,"ADISP","P",0))
 I 'PSALOC(1) W !,"No Drug Accountability location has been created yet.",! G QUIT
 ;only one
 I '$O(^PSD(58.8,"ADISP","P",+PSALOC(1))) S PSALOC=PSALOC(1),PSALOC(1)=0
 I $G(PSALOC) S PSALOCN=$P($G(^PSD(58.8,+PSALOC,0)),U),PSAISIT=$P($G(^(0)),U,3),PSAOSIT=$P($G(^(0)),U,10) G QUIT
 ;pick type
PIC S DIR(0)="S^1:INPATIENT;2:OUTPATIENT;3:COMBINED (IP/OP)",DIR("A")="Select Pharmacy type",PSALOC(1)=0 D ^DIR K DIR S:'Y PSAOUT=1,PSALOC=0 G:'Y QUIT
 S PSAITY=+Y,PSALOCN=Y(0)
SKIP I PSAITY'=2  D
 .;check for more than one IP site
 .S (PSA(1),PSA(2))=0 F  S PSA(1)=$O(^PS(59.4,PSA(1))) Q:'PSA(1)  S:$P($G(^(PSA(1),0)),U,26)=1 PSA(2)=PSA(2)+1,PSAB=PSA(1)
 .I PSA(2)<1 W !!,"An Inpatient Site has not been identified for AR/WS.",!,"AR/WS dispensing data may not be gathered.",! S:PSAITY=3 PSAO=1 Q
 .S:PSA(2)=1 PSAISIT=PSAB
 .D:PSA(2)>1  I Y<1 S PSAOU=1 K PSALOC Q
 ..W !!,"Because there is more than one Inpatient Site at this facility, I need you to"
 ..S DIC="^PS(59.4,",DIC(0)="AEMQZ",DIC("A")="select an AR/WS Inpatient Site Name: ",DIC("S")="I $P($G(^(0)),U,26)=1" D ^DIC K DIC S:$D(DUOUT)!($D(DTOUT)) PSAOU=1 S:PSAITY=3&(Y<1) PSAO=1 Q:Y<1  S PSAISIT=+Y
 .S PSALOC=$O(^PSD(58.8,"ASITE",PSAISIT,"P",""))
 .I 'PSALOC S:PSAITY=3 PSAO=1 Q
 .I PSALOC S PSALOCN=$P($G(^PSD(58.8,+PSALOC,0)),U) D:$O(^PSD(58.8,+PSALOC,3,0))
 ..W !!,"Checking wards for accurate collection of UD/IV dispensing.",!
 ..N PSAWARD S PSAWARD=0 F  S PSAWARD=$O(^DIC(42,PSAWARD)) Q:'PSAWARD  W "*" D:'$O(^PSD(58.8,"AB",+PSAWARD,0))&('$D(^DIC(42,+PSAWARD,"I")))
 ...W !!,$P($G(^DIC(42,+PSAWARD,0)),U)," is an active ward and NOT linked to any location."
 S:PSAITY>1 PSAO=1 G @$S($D(PSAOU):"QUIT",$D(PSAO):"OP",1:"QUIT")
OP S Y=1,PSA=$O(^PS(59,0)) D:$O(^PS(59,PSA))  G:Y<0 QUIT
 .;more than one OP site
 .W !!,"Because there is more than one Outpatient Site at this facility, I need you to "
 .S DIC="^PS(59,",DIC(0)="AEMQ",DIC("A")="select an Outpatient Site: " D ^DIC K DIC S PSAOSIT=+Y
 S:'$D(PSAOSIT) PSAOSIT=PSA
 S PSALOC=$O(^PSD(58.8,"AOP",+PSAOSIT,"")),PSALOCN=$P($G(^PSD(58.8,+PSALOC,0)),U)
 I $G(PSAOSIT),'$G(PSALOC) W !!,"No Drug Accountability location has been created for ",$P($G(^PS(59,+PSAOSIT,0)),U),".",!
QUIT I '$G(PSALOC) W !,"No site was selected.",! Q
 I $G(PSALOC) S PSACNT=0 W !!,PSALOCN," for " D
 .I $P($G(^PS(59.4,+$G(PSAISIT),0)),U)'="" W $P(^(0),U)_" (IP) " S PSACNT=PSACNT+1
 .I $P($G(^PS(59,+$G(PSAOSIT),0)),U)'="" W $P(^(0),U)_" (OP)" S PSACNT=PSACNT+1
 .I 'PSACNT W "...I'm not sure"
 I $G(PSALOC(1)) S DIR(0)="Y",DIR("A")="OK",DIR("B")="Yes",DIR("?")="Answering no will allow you to change Location." D ^DIR K DIR K:Y=0 PSAOSIT,PSAISIT,PSALOC G:Y=0 PIC K:$D(DIRUT) PSALOC
 Q
COP I '$O(^PSD(58.8,"AOP",0)) W !,"No outpatient sites have been set up.",! Q
 S PSALOC=$O(^PSD(58.8,"AOP",0)),PSALOCN=$P($G(^PSD(58.8,+PSALOC,0)),U)
 Q:'$O(^PSD(58.8,"AOP",+PSALOC))
 W !!,"Because there is more than one Outpatient Site at this facility, I need you to "
 S DIC="^PSD(58.8,",DIC(0)="AEMQ",DIC("A")="select an Outpatient Site: ",D="AOP" D MIX^DIC1 S PSALOC=+Y,PSALOCN=$P($G(^PSD(58.8,+Y,0)),U)
 Q
