QAMAHO5 ;HISC/GJC-CHECKS SORT DATA FOR FALLOUT FILE ^QA(743.1 ;7/2/92  09:02
 ;;1.0;Clinical Monitoring System;;09/13/1993
 ;
SET ;BEGINNING/ENDING SORT VALUES FOR SET OF CODES DATA ELEMENTS
 S QAMELEM=QAMDIEN D EN1^QAMUTL2 W !!,"Enter the beginning and ending values for ",DIR("A"),".",!
 K DIR("A"),DIR("B") S DIR("A")="Start with: First// ",DIR(0)=$P(DIR(0),U)_"A^"_$P(DIR(0),U,2)
 D ^DIR I $D(DTOUT)!($D(DUOUT)) S QAMOUT=1 Q
 I X="" S DATA1=" ",DATA2="~" G SET1
 E  S DATA1=Y(0)
 S DIR("A")="End with: Last// "
 S DATA1=Y D ^DIR I $D(DTOUT)!($D(DUOUT)) S QAMOUT=1 Q
 I X="" S DATA2="~"
 E  S DATA2=Y(0)
 I (DATA2']DATA1),(DATA1'=DATA2) W !!,*7,"The 'Start with' value must fall before the 'End with' value in the alphabet." G SET
SET1 D LOOP
 Q
FREE ;BEGINNING/ENDING SORT VALUES FOR FREE TEXT DATA ELEMENTS
 S QAMELEM=QAMDIEN D EN1^QAMUTL2 W !!,"Enter the beginning and ending values for ",DIR("A"),".",!
 K DIR("A"),DIR("B") S DIR("A")="Start with: First// ",DIR(0)=$P(DIR(0),U)_"A^"_$P(DIR(0),U,2)
 D ^DIR I $D(DTOUT)!($D(DUOUT)) S QAMOUT=1 Q
 I X="" S DATA1=" ",DATA2="~" G FREE1
 E  S DATA1=Y
 S DIR("A")="End with: Last// "
 S DATA1=Y D ^DIR I $D(DTOUT)!($D(DUOUT)) S QAMOUT=1 Q
 I X="" S DATA2="~"
 E  S DATA2=Y
 I (DATA2']DATA1),(DATA1'=DATA2) W !!,*7,"The 'Start with' value must fall before the 'End with' value in the alphabet." G FREE
FREE1 D LOOP
 Q
EVENT ;BEGINNING/ENDING SORT VALUES FOR EVENT DATE
 W !!,"Enter the beginning and ending values for EVENT DATE."
 D ^QAQDATE I QAQQUIT S (QAMQUIT,QAMOUT)=1 Q
 F YZ=0:0 S YZ=$O(^QA(743.1,"AA",YZ)) Q:YZ'>0  F LP=(QAQNBEG-.0000001):0 S LP=$O(^QA(743.1,"AA",YZ,LP)) Q:(LP'>0)!(LP>QAQNEND)  D EVENT1
 Q
EVENT1 ;
 S Y=LP X ^DD("DD")
 F QAMPT=0:0 S QAMPT=$O(^QA(743.1,"AA",YZ,LP,QAMPT)) Q:QAMPT'>0  F QAMD0=0:0 S QAMD0=$O(^QA(743.1,"AA",YZ,LP,QAMPT,QAMD0)) Q:QAMD0'>0  S ^UTILITY($J,"QAM DATE",LP,QAMD0)=Y
 Q
LOOP ;
 S LP0="" F LP=0:0 S LP0=$O(^QA(743.1,"AD",QAMDIEN,LP0)) Q:LP0=""  I (LP0]DATA1)!(LP0=DATA1),((DATA2]LP0)!(DATA2=LP0)) D LOOP1
 Q
LOOP1 F QAMD0=0:0 S QAMD0=$O(^QA(743.1,"AD",QAMDIEN,LP0,QAMD0)) Q:QAMD0'>0  S ^UTILITY($J,"QAM DLMNT",LP0,QAMD0)=LP0
 Q
