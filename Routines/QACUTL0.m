QACUTL0 ;WCIOFO/ERC/VAD - Utility for Patient Rep reports ;29 Dec 98
 ;;2.0;Patient Representative;**10,9,17**;07/25/1995
 ;
DATDIV ;
 D DATE Q:QAQPOP
 D DIV Q:QAQPOP
 Q
 ;
DATE ;select date range for Patient Rep
 S QAQPOP=0
 W !!,"Select the date range you want to print."
 D ^QAQDATE I QAQQUIT S QAQPOP=1 Q
 I QAQNBEG>DT W !,"*** Beginning date must be today or earlier! ***",$C(7) G DATE
 Q
 ;
DIV ;select Patient Rep division
 K QAC1DIV,QACDV,QACDVSN
 S QAQPOP=0
 S QACDV=1 ;with patch 17 division always enabled
 ;
 N DIR,DIRUT,DTOUT,DUOUT
 S DIR(0)="YA"
 S DIR("A")="Select ALL Divisions? "
 S DIR("B")="YES"
 D ^DIR K DIR I $D(DIRUT) S QAQPOP=1 Q
 I Y S QAC1DIV="" Q
 N DIC,QACX
 S DIC="^DIC(4,"
 S DIC(0)="AEMZQ"
 S DIC("A")="Enter Division: "
 S DIC("S")="I $D(^DG(40.8,""AD"",+Y))"
 S QACX=$$SITE^VASITE
 S QACDVSN=$P(QACX,U,2)
 S DIC("B")=$G(QACDVSN)
 D ^DIC K DIC
 I +Y>0 S QAC1DIV=+Y Q
 Q
 ;
TASK ;set variables for call to ^%ZTLOAD
 S (ZTSAVE("QAQNBEG"),ZTSAVE("QAQNEND"))=""
 S ZTSAVE("QAQ2HED")=""
 S (ZTSAVE("QACDIV"),ZTSAVE("QAC1DIV"))=""
 S (ZTSAVE("QACTEXT"),ZTSAVE("QACDESC"))=""
 D ^%ZTLOAD
 I $G(ZTSK) W !,"Task Number: ",ZTSK
 Q
INST(QACIEN,QACDV) ;uses FileMan for name of a division from the Institution file (#4)
 N DIC,X,Y
 K QACDV
 S DIC="^DIC(4,"
 S DIC(0)="NZX"
 S X=QACIEN
 D ^DIC K DIC
 I Y<0 S QACDV="Unknown" Q
 S QACDV=Y(0,0)
 Q
SITE(QACIEN,QACSIT) ;uses FM for node 99 of Inst file (#4)
 N DA,DIC,DIQ,DR
 K QACSIT,QACSITE
 S DIC="^DIC(4,"
 S DA=QACIEN
 S DR=99
 S DIQ="QACSITE"
 D EN^DIQ1
 S QACSIT=QACSITE(4,QACIEN,99)
 Q
