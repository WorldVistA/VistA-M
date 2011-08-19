QAMAHO4 ;HISC/GJC-CHECKS SORT DATA FOR FALLOUT FILE ^QA(743.1 ;7/2/92  09:03
 ;;1.0;Clinical Monitoring System;;09/13/1993
 ;
DATE ;BEGINNING/ENDING SORT VALUES FOR DATE DATA ELEMENTS
 S QAMELEM=QAMDIEN D EN1^QAMUTL2 W !!,"Enter the beginning and ending values for ",DIR("A"),".",!
 K DIR("A"),DIR("B") S DIR("A")="Start with: First// ",DIR(0)=$P(DIR(0),U)_"A^"_$P(DIR(0),U,2)
 D ^DIR I $D(DTOUT)!($D(DUOUT))!(+Y=-1) S QAMOUT=1 Q
 I X="" S DATA1=0,DATA2=9999999 G DATE1
 E  S DATA1=Y
 S DIR("A")="End with: Last// ",DATA1=Y,DIR(0)=$P(DIR(0),U)_"^"_DATA1_"::"_$P(DIR(0),":",3)
 D ^DIR I $D(DTOUT)!($D(DUOUT))!(+Y=-1) S QAMOUT=1 Q
 I X="" S DATA2=9999999
 E  S DATA2=Y
 I (DATA2<DATA1),(DATA1'=DATA2) W !!,*7,"The 'Start with' date must fall before the 'End with' date." G DATE
DATE1 S LP0="" F LP=0:0 S LP0=$O(^QA(743.1,"AD",QAMDIEN,LP0)) Q:LP0=""  S X=LP0 D ^%DT I (Y>DATA1)!(Y=DATA1),((DATA2>Y)!(DATA2=Y)) D DATE2
 Q
DATE2 F QAMD0=0:0 S QAMD0=$O(^QA(743.1,"AD",QAMDIEN,LP0,QAMD0)) Q:QAMD0'>0  S ^UTILITY($J,"QAM DLMNT",Y,QAMD0)=LP0
 Q
NUM ;BEGINNING/ENDING SORT VALUES FOR NUMERIC DATA ELEMENTS
 S QAMELEM=QAMDIEN D EN1^QAMUTL2 W !!,"Enter the beginning and ending values for ",DIR("A"),".",!
 K DIR("A"),DIR("B") S DIR("A")="Start with: First// ",DIR(0)=$P(DIR(0),U)_"A^"_$P(DIR(0),U,2)
 D ^DIR I $D(DTOUT)!($D(DUOUT))!(+Y=-1) S QAMOUT=1 Q
 I X="" S DATA1=0,DATA2=9999999 G NUM1
 E  S DATA1=Y
 S DIR("A")="End with: Last// ",DATA1=Y,DIR(0)=$P(DIR(0),U)_"^"_DATA1_"::"_$P(DIR(0),":",3)
 D ^DIR I $D(DTOUT)!($D(DUOUT))!(+Y=-1) S QAMOUT=1 Q
 I X="" S DATA2=9999999
 E  S DATA2=Y
 I (DATA2<DATA1),(DATA1'=DATA2) W !!,*7,"The 'Start with' number must fall before the 'End with' number." G DATE
NUM1 S LP0="" F LP=0:0 S LP0=$O(^QA(743.1,"AD",QAMDIEN,LP0)) Q:LP0=""  I (LP0>DATA1)!(LP0=DATA1),((DATA2>LP0)!(DATA2=LP0)) D NUM2
 Q
NUM2 F QAMD0=0:0 S QAMD0=$O(^QA(743.1,"AD",QAMDIEN,LP0,QAMD0)) Q:QAMD0'>0  S ^UTILITY($J,"QAM DLMNT",LP0,QAMD0)=LP0
 Q
POINT ;BEGINNING/ENDING SORT VALUES FOR POINTER DATA ELEMENTS
 S QAMELEM=QAMDIEN D EN1^QAMUTL2 W !!,"Enter the beginning and ending values for ",DIR("A"),".",!
 K DIR("A"),DIR("B") S DIR("A")="Start with: First// ",DIR(0)=$P(DIR(0),U)_"A^"_$P(DIR(0),U,2)
 D ^DIR I $D(DTOUT)!($D(DUOUT))!(($E(X)="^")&(+Y=-1)) S QAMOUT=1 Q
 I X="" S DATA1=" ",DATA2="~" G POINT1
 I X]"" S DATA1=Y(0,0)
 S DIR("A")="End with: Last// "
 D ^DIR I $D(DTOUT)!($D(DUOUT))!(($E(X)="^")&(+Y=-1)) S QAMOUT=1 Q
 I X="" S DATA2="~"
 E  S DATA2=Y(0,0)
 I (DATA2']DATA1),(DATA1'=DATA2) W !!,*7,"The 'Start with' value must fall before the 'End with' value in the alphabet." G POINT
POINT1 S LP0="" F LP=0:0 S LP0=$O(^QA(743.1,"AD",QAMDIEN,LP0)) Q:LP0=""  I (LP0]DATA1)!(LP0=DATA1),((DATA2]LP0)!(DATA2=LP0)) D PNT
 Q
PNT F QAMD0=0:0 S QAMD0=$O(^QA(743.1,"AD",QAMDIEN,LP0,QAMD0)) Q:QAMD0'>0  S ^UTILITY($J,"QAM DLMNT",LP0,QAMD0)=LP0
 Q
