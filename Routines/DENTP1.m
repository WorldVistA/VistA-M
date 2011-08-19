DENTP1 ;ISC2/SAW-OTHER DENTAL REPORTS ; 12/5/88  4:35 PM
 ;;1.2;DENTAL;**24**;JAN 26, 1989
 ;SITTING/VISITS REPORT
 S U="^",Z5="",Z1=0 G:'$D(^DENT(225,0)) W F Z3=0:1:2 S Z1=$O(^(Z1)) Q:Z1'>0  S Z2=Z1
 G:Z3=0 W I Z3>1 S DIC="^DENT(225,",DIC(0)="AEMNQ",DIC("A")="Select STATION.DIVISION: " D ^DIC Q:Y<0  K DIC("A")
 S Z1=$S(Z3=1:Z2,1:+Y) G W:'$D(^DENT(225,Z1,0)) S DENTSTA=$P(^(0),U,1) G W:DENTSTA=""
D1 W !,"Enter the starting and ending dates for the Treatment Data entries that",!,"you want to include in this report.",!
 S %DT("A")="STARTING DATE: ",%DT="AEPX" D ^%DT K %DT("A") G EXIT:Y<0 S DENTSD=Y-.0001 X ^DD("DD") S H1=Y
 S %DT("A")="ENDING DATE: ",%DT="AEPX" D ^%DT K %DT("A") G EXIT:Y<0 S DENTED=Y+.24 X ^DD("DD") S H2=Y
 I DENTED<DENTSD W *7,!!,"End Date before Start Date?" G D1
A W !,"Would you like to review released data only" S %=2 D YN^DICN D:%=0 Q1 G A:%=0,EXIT:%<0 S:%=1 D1=1
 S %ZIS="MQ" K IO("Q") D ^%ZIS G EXIT:IO=""
 I $D(IO("Q")) S ZTRTN="QUE^DENTP1",ZTSAVE("DENTSD")="",ZTSAVE("DENTED")="",ZTSAVE("DENTSTA")="",ZTSAVE("D1")="",ZTSAVE("H1")="",ZTSAVE("H2")="" D ^%ZTLOAD K ZTSK,ZTRTN,ZTSAVE G CLOSE
QUE U IO S (E,V(1),V(2),V(3),S(1),S(2),S(3),F)=0
 F I=0:0 S DENTSD=$O(^DENT(221,"A1",DENTSTA,DENTSD)) Q:DENTSD>DENTED!(DENTSD="")  S DENT="" F K=0:0 S DENT=$O(^DENT(221,"A1",DENTSTA,DENTSD,DENT)) Q:DENT=""  D:$D(D1)&($D(^DENT(221,DENT,.1))) R D:'$D(D1)&($D(^DENT(221,DENT,0))) R
 W @IOF,!,?20,"TOTAL SITTINGS/VISITS BY PATIENT CATEGORY" S H3="("_$S(H1=H2:"For "_H1,1:"From "_H1_" to "_H2)_")" W !,?(80-$L(H3)/2),H3
 W !!,?15,"Inpatient",?28,"Outpatient",?42,"Class I-VI",?61,"Total"
 W !!,"Visits",?12,$J(V(1),12),?26,$J(V(2),12),?40,$J(V(3),12),?54,$J((V(1)+V(2)+V(3)),12)
 W !,"Sittings",?12,$J(S(1),12),?26,$J(S(2),12),?40,$J(S(3),12),?54,$J((S(1)+S(2)+S(3)),12)
 W ! I E W !,"NOTE: There ",$S(E=1:"is ",1:"are "),E," treatment data ",$S(E=1:"entry",1:"entries")," in the time frame you specified",!,"for which the Patient Category field was blank.",!
 W:F>0 !,?15,"(Note: Sittings figure includes "_F_" admin procedure"_$S(F>1:"s.)",1:".)")
 G CLOSE
R S Z=^DENT(221,DENT,0),X=$P(Z,"^",19),X1=$P(Z,"^",2) S:$P(Z,"^",8) F=F+1 S X=$S(X>0&(X<9):1,X>17&(X<23):2,X>8&(X<18):3,1:"")
 I X="" S E=E+1 Q
 I X1'="",'$P(Z,"^",8),'$D(^UTILITY($J,"DENT",DENTSD,X1)) S V(X)=V(X)+1,^UTILITY($J,"DENT",DENTSD,X1)=""
 S S(X)=S(X)+1 Q
W W !!,"Stations have not been entered in the Dental Site Parameter file.",!,"You must enter a station before you can use this option" Q
TOS ;TYPE OF SERVICE REPORT
 S DIC="^DIC(220.3,",FLDS=".001,.01,1,2",BY=.001,FR=1,TO=99,DHD="DENTAL TYPE OF SERVICE REPORT" D EN1^DIP
CLOSE X ^%ZIS("C")
EXIT K %DT,%ZIS,BY,DENT,DENTED,DENTSD,DENTSTA,DHD,D1,E,F,FLDS,FR,H1,H2,H3,HD1,I,S,TO,V,X,X1,Y,Z,Z1,Z2,Z5,^UTILITY($J,"DENT") K:$D(ZTSK) ^%ZTSK(ZTSK),ZTSK Q
Q1 W !!!,"Enter 'Y' or 'YES' if you want released data only.  Press RETURN or enter 'N'",!,"or 'NO' if you do not want released data.  Enter an uparrow (^) to EXIT.",! Q
