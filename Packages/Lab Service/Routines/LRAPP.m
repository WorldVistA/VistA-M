LRAPP ;AVAMC/REG/KLL - AP PRINT ;10/18/01
 ;;5.2;LAB SERVICE;**72,259**;Sep 27, 1994
 N LRSF515
 S LRSF515=1
 D @LRAPX(0),END
 Q
 ;
P ;Print All On Queue
 N LRFOC S LRFOC=0
 D A G:'$D(Y) END
 S LRAPX=4
 I LRSS'="AU",X=2 D FOC
 I LRSS="AU",X=1 D FOC
 G LRAPP
D ;Delete Print Queue
 D A G:'$D(Y) END
 S LRAPX=2
 G LRAPP
S ;Print Single Report
 N LRFOC S LRFOC=0
 D A G:'$D(Y) END
 S LRAPX=3
 I LRSS'="AU",X=2 D FOC
 I LRSS="AU",X=1 D FOC
 G LRAPP
N ;Add Pt To Print Queue
 D A G:'$D(Y) END
 S LRAPX=1
 G LRAPP
T ;AP Accessions By Date
 D ^LRAP G:'$D(Y) END
 D ^LRUPAD,END
 Q
B ;AP Accessions By Number
 D ^LRAP G:'$D(Y) END
 D ^LRUPA,END
 Q
A ;
 W ! D ^LRAP
 G:'$D(Y) END
 I LRSS="AU" D PS Q
C ;Path Reports (SP,CY,EM)
 W !!?16,"1. Preliminary reports",!?16,"2. Final",?31,"reports"
 R !,"Select 1 or 2 : ",X:DTIME
 G:X=""!(X[U) END
 I X<1!(X>2) D  G C
 .W $C(7),!!,"Enter '1' for preliminary reports or '2' for final "
 .W "reports"
 S LRAPX(0)=$S(X=1:"^LRSPT",1:"^LRSPRPT")
 Q
PS ;Autopsy Reports
 W !!?15,"1. Autopsy protocols"
 W !?15,"2. Autopsy supplementary reports",!,"Select 1 or 2: "
 R X:DTIME G:X=""!(X[U) END
 I X<1!(X>2) D  G PS
 .W $C(7),!!,"Enter '1' for autopsy protocols or '2' for autopsy "
 .W "supplementary reports"
 S LRAPX(0)=$S(X=1:"^LRAURPT",1:"^LRAPAUSR")
 Q
FOC ;Final Office Copy
 W !
 K DIR
 S DIR(0)="Y",DIR("A")="Is this a final office copy"
 S DIR("B")="YES"
 S DIR("?",1)="SNOMED codes no longer appear on the report.  The final"
 S DIR("?",1)=DIR("?",1)_" office copy prints"
 S DIR("?")="these codes on a separate page.  Enter 'Yes' to include "
 S DIR("?")=DIR("?")_"this page."
 D ^DIR
 I Y S LRFOC=1
 Q
END D V^LRU
 Q
