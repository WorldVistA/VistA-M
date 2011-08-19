IBCROR ;ALB/ARH - RATES: REPORTS ; 5/23/96
 ;;2.0;INTEGRATED BILLING;**52,106,287**;21-MAR-94
 ;
 ;
OPTION ;
 W !!!,"Charge Master Reports:",!
 S DIR(0)="SO^R:RATE SCHEDULES;C:CHARGE SETS;I:CHARGE ITEMS;IP:CHARGE ITEMS - PROCEDURES;B:BILLING RATES;T:RATE TYPES;G:BILLING REGIONS;V:REV CD LINKS;D:PROVIDER DISCOUNTS;O:OTHER BILLABLE ITEMS;X:(OLD RATES FILE)"
 S DIR("A")="Select Report" D ^DIR K DIR
 I Y="R" D RS G OPTION
 I Y="C" D CS G OPTION
 I Y="I" D CI G OPTION
 I Y="IP" D CIP G OPTION
 I Y="B" D BR G OPTION
 I Y="T" D RT G OPTION
 I Y="G" D RG G OPTION
 I Y="V" D RL G OPTION
 I Y="D" D PD G OPTION
 I Y="O" D BI G OPTION
 I Y="X" D OLD G OPTION
 K DIR,X,Y,DIRUT
 Q
RS ;
 W !,"Report requires 120 columns."
 S FLDS=".01,.03;L5,.04;L10;""BILL SERVICE"",.05,.06,W:$$RSADJ^IBCROR($G(D0)) ""YES"";""CHARGES ADJUSTED"";L10,11,.01,.02"
 S L=0,DIC="^IBE(363,",BY=".02;S1,.03"
 D EN1^DIP
 K FLDS,BY,FR,TO,L,DIC
 Q
CS ;
 W !,"Report requires 132 columns."
 S L=0,DIC="^IBE(363.1,",FLDS=".01,.03;L26,.04,.05,.06;L15,.07",BY=".02;S1,.03",FR="",TO=""
 D EN1^DIP
 K FLDS,BY,FR,TO,L,DIC
 Q
CI ;
 ;
 W !!,"Caution: This report may be extremely long for some Charge Sets.",!,"Some Charge Sets, such as CMAC or AWP, may have many thousands of Charge Items.",!
 ;
 D ^IBCROI
 Q
CIP ;
 ;
 W !!,"Caution: This report may be extremely long if many procedures are selected.",!
 ;
 D ^IBCROIP
 Q
BR ;
 S L=0,DIC="^IBE(363.3,",FLDS=".01,.02,.03,.04,.05",BY=".03;S1,.01",FR="",TO=""
 D EN1^DIP
 K FLDS,BY,FR,TO,L,DIC
 Q
RT ;
 W !,"Report requires 132 columns."
 S FLDS=".01;L20,.02;L20,.03;L5,.04;L8,.05;L5;""THIRD PARTY BILL?"",.06;L20,.07;L11,.08;L5;""REIMB INS?"",.09;L4"
 S L=0,DIC="^DGCR(399.3,",BY="",FR="",TO=""
 D EN1^DIP
 K FLDS,BY,FR,TO,L,DIC
 Q
RG ;
 S L=0,DIC="^IBE(363.31,",FLDS=".01,11,.01,",BY=".01;S1",(FR,TO)=""
 D EN1^DIP
 K FLDS,BY,FR,TO,L,DIC
 Q
BI ;
 S L=0,DIC="^IBA(363.21,",FLDS=".01,.02,",BY=".02;S1,.01"
 D EN1^DIP
 K FLDS,BY,FR,TO,L,DIC
 Q
RL ;
 N IBX,DIR,X,Y,DTOUT,DUOUT,DIRUT
 S DIR(0)="SO^1:SORT BY REVENUE CODE;2:SORT BY PROCEDURE" D ^DIR Q:Y'>0
 I Y=1 S L=0,DIC="^IBE(363.33,",FLDS=".01,.03,.04,.02",BY=".01,.02"
 I Y=2 S L=0,DIC="^IBE(363.33,",FLDS=".03,.04,.01,.02",BY=".03;TXT,.02",(FR,TO)=",?"
 D EN1^DIP
 K FLDS,BY,FR,TO,L,DIC
 Q
 ;
PD ;
 D ^IBCRON
 Q
 ;
OLD ;  prints old rates in 399.5, provided for reference only
 ; (these rates are no longer used and the orginal report (IBORAT2) was deleted)
 W !!,"This report is for reference only, the rates and charges in this report are no",!,"longer used.  They have been replace by the rates in the Charge Master.",!
 S L=0,DIC="^DGCR(399.5,",FLDS=".01,.04,"" "";"""",.03,.05;L3,.06,.07",BY=".02;S1,.01;S1,.06,.03",FR=",?",TO=",?"
 D EN1^DIP
 K FLDS,BY,FR,TO,L,DIC
 Q
 ;
RSADJ(D0) ; returns true if RS has an Adjustment
 N IBX S IBX=0 I $G(^IBE(363,+$G(D0),10))'="" S IBX=1
 Q IBX
