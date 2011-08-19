DGSCHAD3 ;ALB/MTC - OUTPUT FUTURE SCHEDULED ADMISSION DATA ; 11 MAY 87
 ;;5.3;Registration;**60,71**;Aug 13, 1993
 ;
 D OLD^DGSCHAD2 G Q:DGERR!(DGOLD=0) S Y=$S(DT<DGOLD1:DGOLD1,1:DT) X ^DD("DD") S DGTD=Y
F W ! S %DT("A")="Start with DATE OF RESERVATION: ",%DT("B")=DGTD,%DT="EAX",%DT(0)=DGOLD1 D ^%DT K %DT G Q:Y'>0 S (DGFR,DGHFR)=Y,X1=DGFR,X2=-1 D C^%DTC S DGFR1=X_".9999"
 W ! S Y=DGFR X ^DD("DD") S DGFR=Y,%DT("A")="     Go to DATE OF RESERVATION: ",%DT("B")=Y,%DT="EAX",%DT(0)=DGHFR K DGHFR D ^%DT K %DT G Q:Y'>0 S DGTO1=Y X ^DD("DD") S DGTO=Y,DGTO1=DGTO1_".9999"
 S DHD="Scheduled Admission List for "_$S(DGTO'=DGFR:"period covering ",1:"")_DGFR_$S(DGTO'=DGFR:" through "_DGTO,1:"")_"."
1 D H^DGUTL S Z="^SCHEDULED^CANCELLED^BOTH^" R !!,"List (S)cheduled, (C)ancelled or (B)oth scheduled admissions: BOTH// ",X:DTIME S:'$T X="^" W:X="" "B" S:X="" X="B" D IN^DGHELP I X["^" G Q
 I %=-1 W !!?4,"C - To list only future scheduled admissions which have been cancelled.",!?4,"S - To list only active future scheduled admissions.",!?4,"B - To list all future scheduled admissions regardless of status." G 1
 S DGSCH=X,(BY,FR,TO)="" D DIV^DGUTL I DGDIV G 2
 D DIVISION^VAUTOMA G:VAUTD']""&('$O(VAUTD(0)))!(Y=-1) Q
 I VAUTD=1 S BY="12,",FR=FR_"@,",TO=TO_"," G 2
 S DGDIV=0,BY="12," K TO,FR S TO(1)="",FR(1)=""
 N DIS S DIS(0)="I VAUTD!$D(VAUTD(+$P(^DGS(41.1,D0,0),""^"",12)))"
 D H^DGUTL S BY=BY_"@2,.01,",FR(2)=DGFR1,FR(3)="",TO(2)=DGTO1,TO(3)="" I "SC"[DGSCH S BY=BY_"'13" S:DGSCH="S" TO(4)="@",FR(4)="@" I DGSCH="C" S TO(4)="",FR(4)=""
 G 3
2 D H^DGUTL S BY=BY_"@2,.01,",FR=FR_DGFR1_",,",TO=TO_DGTO1_",," I "SC"[DGSCH S BY=BY_"'13" S:DGSCH="S" TO=TO_"@,",FR=FR_"@," I DGSCH="C" S TO=TO_",",FR=FR_","
3 S DGNO=0 S X=1 D ^DGTEMP G Q:DGNO S FLDS=X,L=0,DIC="^DGS(41.1," W !!?15,*7,"This output requires 132 columns",!! D EN1^DIP
Q K X,DGERR,DGOLD,DGOLD1,DGNO,DGTEMP,DGDIV,DGSCH,DGDATE,DGTIME Q
TEMP S DGSA=^DGS(41.1,D0,0),DFN=+DGSA,DGPT=$S($D(^DPT(DFN,0)):^(0),1:""),Y=$P(DGSA,U,2) X ^DD("DD") W ?28,$E($P(DGPT,U,9),6,9),?35,"Phone: ",$S($D(^DPT(DFN,.13)):$P(^(.13),U),1:"UNKNOWN"),?60,"Reservation: ",Y
 W ?95,$S($P(DGSA,U,10)="W":"Ward Loc: "_$S($D(^DIC(42,+$P(DGSA,U,8),0)):$P(^(0),U),1:"UNKNOWN"),$P(DGSA,U,10)="T":"Treat Sp: "_$S($D(^DIC(45.7,+$P(DGSA,U,9),0)):$P(^(0),U),1:"UNKNOWN"),1:"")
 W !?32,"Provider: "_$S($P(DGSA,U,5)]""&($D(^VA(200,+$P(DGSA,U,5),0))):$P(^(0),U),1:"UNKNOWN"),?96,"Surgery: "_$S($P(DGSA,U,6)="Y":"YES",$P(DGSA,U,6)="N":"NO",1:"UNKNOWN")
 W !?34,"Status: " I $P(DGSA,U,13)']""&($P(DGSA,U,17)']"") W "SCHEDULED - Admitting Diagnosis '"_$S($P(DGSA,U,4)]"":$P(DGSA,U,4),1:"UNKNOWN")_"',"
 I ($P(DGSA,U,13)']"")&($P(DGSA,U,17)]"") W "ADMITTED - " I $D(^DGPM($P(DGSA,U,17),0)) S Y=$P(^DGPM($P(DGSA,U,17),0),U) D DD^%DT W Y
 I $P(DGSA,U,13)]"" W "CANCELLED by: "_$S($P(DGSA,U,14)]"":$P(^VA(200,$P(DGSA,U,14),0),U),1:"UNKNOWN")
 I DGPT']"" W !,"**PATIENT DELETED FROM PATIENT FILE - CONTACT IRM SERVICE",!!
 K DGSA,DFN,DGPT,Y
