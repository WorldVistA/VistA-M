SROAMAN ;BIR/ADM-Managerial Site ID and Assessment Data Input; [ 04/26/97   2:55 PM ]
 ;;3.0; Surgery ;**38,39,55,61,67**;24 Jun 93
MAN() ; determine if site is a risk assessment managerial site
 N MAN,SITE,Y S MAN=0,SITE=+$P($$SITE^SROVAR,"^",3)
 S Y="436,442,503,505,517,519,556,557,564,568,569,574,579,585,591,595,609,612,613,617,619,622,623,647,655,659,668,677,680,686,687"
 S:Y[SITE MAN=1 K SITE,Y
 Q MAN
PRE S (SRFLG,SRCC)=1,SRR=0,SRPROMPT="Preoperative Information" D HDR^SROAUTL,OUT1^SROAUTL0,SEL Q:SRSOUT  G:SRR PRE
 I $D(SRCC) D CONCC
 Q
LAB S SRCC=1,SRR=0,SRPROMPT="Preoperative Laboratory Information" D HDR^SROAUTL,LAB^SROAUTL0,SEL Q:SRSOUT  G:SRR LAB
 I $D(SRCC) D CONCC
 Q
SEL W !!,"Select "_SRPROMPT_" to edit: " R X:DTIME I '$T!(X["^") D:$D(SRCC) CONCC S SRSOUT=1 Q
 Q:X=""  S:X="a" X="A" I '$D(SRFLG),'$D(SRX(X)),(X'?1.2N1":"1.2N),X'="A" D HELP S SRR=1 Q
 I $D(SRFLG),'$D(SRX(X)),(X'?1.2N1":"1.2N),X'="A",X'="N",X'="NO",X'="@" D HELP S SRR=1 Q
 I X?1.2N1":"1.2N S Y=$P(X,":"),Z=$P(X,":",2) I Y<1!(Z>SRX)!(Y>Z) D HELP S SRR=1 Q
 I $D(SRFLG),(X="N"!(X="NO")) D NO S SRR=1 Q
 I $D(SRFLG),X="@" D DEL S SRR=1 Q
 S MM=$E(X) I $D(SRCC)!('$D(SRCC)&((MM'=4)!(MM'=5))) D HDR^SROAUTL
 I X="A" S X="1:"_SRX
 I X?1.2N1":"1.2N D RANGE S SRR=1 Q
 I $D(SRX(X)),+X=X S EMILY=X D ONE S SRR=1
 Q
OERR S SROERR=SRTN D ^SROERR0
 Q
HELP W @IOF,!!!!,"Enter the number, number/letter combination, or range of numbers you",!,"want to edit.  Examples of proper responses are listed below."
 W !!,"1. Enter 'A' to update all items.",!!,"2. Enter a number (1-"_SRX_") to update an individual item.  (For example,",!,"   enter '1' to update "_$P(SRX(1),"^")_")"
 W !!,"3. Enter a range of numbers (1-"_SRX_") separated by a ':' to enter a range",!,"   of items.  (For example, enter '1:4' to update items 1, 2, 3 and 4.)",!
 I $D(SRFLG) W !,"4. Enter 'N' or 'NO' to enter negative response for all items.",!!,"5. Enter '@' to delete information from all items.",!
 D PRESS
 Q
RANGE ; range of numbers
 S SHEMP=$P(X,":"),CURLEY=$P(X,":",2) F EMILY=SHEMP:1:CURLEY Q:SRSOUT  D ONE
 Q
ONE ; edit one item
 K DR,DA,DIE S DR=$P(SRX(EMILY),"^",2)_"T",DA=SRTN,DIE=130,SRDT=$P(SRX(EMILY),"^",3) S:SRDT DR=DR_";"_SRDT_"T" D ^DIE K DR,DA I $D(Y) S SRSOUT=1
 Q
PRESS W ! K DIR S DIR("A")="Press the return key to continue or '^' to exit: ",DIR(0)="FOA" D ^DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
CONCC ; check for concurrent case and update if one exists
 S SRCON=$P($G(^SRF(SRTN,"CON")),"^") Q:'SRCON
 Q:$P($G(^SRF(SRCON,"RA")),"^",2)="C"
 K DA,DIC,DIQ,DR,SRY S DA=SRTN,DR=SRDR,DIC="^SRF(",DIQ="SRY",DIQ(0)="I" D EN^DIQ1
 S SRI="" F  S SRI=$O(SRY(130,SRTN,SRI)) Q:'SRI  S SRW=SRY(130,SRTN,SRI,"I") S:SRW="" SRW="@" K DA,DIE,DR S DA=SRCON,DIE=130,DR=SRI_"////"_SRW D ^DIE
 Q
NO ; stuff negative responses for all items
 K DA,DIE,DR S DR="" F SRI=1:1 S SRFLD=$P(SRDR,";",SRI) Q:'SRFLD  S DR=DR_SRFLD_"////"_$S(SRFLD=240:1,SRFLD=325:1,SRFLD=413:1,1:"N")_";"
 S DA=SRTN,DIE=130 D ^DIE K DA,DIE,DR
 Q
DEL ; delete information for all items
 W !,*7 K DIR S DIR("A")="   Are you sure you want to delete all information ",DIR(0)="Y" D ^DIR K DIR I 'Y!$D(DTOUT)!$D(DUOUT) Q
 K DA,DIE,DR S DR="" F SRI=1:1 S SRFLD=$P(SRDR,";",SRI) Q:'SRFLD  S DR=DR_SRFLD_"////@;"
 S DA=SRTN,DIE=130 D ^DIE K DA,DIE,DR
 Q
