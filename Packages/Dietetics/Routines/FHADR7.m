FHADR7 ; HISC/NCA - Staffing Yearly Average ;1/5/94  14:44 
 ;;5.5;DIETETICS;;Jan 28, 2005
EN1 ; Enter/Edit Staffing Data
 D QR^FHADR1 G:'PRE KIL S FHYR=$E(PRE,1,3) D Q2^FHADRPT
 G:'SDT!('EDT) KIL
 F I=1:1:6 S S(I)=0
 S D1=SDT,ND=0 F L1=0:0 D N2 S X1=D1,X2=1 D C^%DTC Q:X>EDT  S D1=X
 F L=1:1:6 S S(L)=$S(ND:S(L)/ND,1:""),S(L)=+$J(S(L),0,1)
 K DIC,DIE S DIE="^FH(117.3,",DA=PRE
 S DR="27//^S X=S(1);28//^S X=S(2);29//^S X=S(3);30//^S X=S(4);31//^S X=S(5);31.6//^S X=S(6)"
 L +^FH(117.3,PRE,1):0 I '$T W !?5,"Another user is editing this entry." G KIL
 D ^DIE L -^FH(117.3,PRE,1) K DA,DIE,DR
 S (P1,X1)=$E(PRE,1,4)_"100",X2=-356 D C^%DTC S OLD=$E(X,1,4)_"400"
 S PRE=P1 I "^^^"[$P($G(^FH(117.3,P1,1)),"^",14,17) D S1 S OLD=PRE D SET S PRE=P1
 W ! K DIR S DIR(0)="YAO",DIR("A")="Change the number of Specialty Staffing? ",DIR("B")="NO" D ^DIR I $D(DIRUT)!($D(DIROUT)) G KIL
 G:'Y KIL
 K DIE S DIE="^FH(117.3,",DA=PRE,DR="47:50" D ^DIE K DA,DIE,DR S OLD=PRE D SET
KIL G KILL^XUSCLEAN
SET ; Set three quarters with the number of Specialty Staffing
 F QTR=2:1:4 S PRE=$E(OLD,1,4)_QTR_"00" D S1
 Q
S1 Q:$G(^FH(117.3,OLD,1))=""
 S $P(^FH(117.3,PRE,1),"^",14,17)=$P($G(^FH(117.3,OLD,1)),"^",14,17) Q
N2 S Y0=$G(^FH(117.1,D1,0)) Q:Y0=""  S ND=ND+1
 F L=2:1:6 S S(L-1)=S(L-1)+$P(Y0,"^",L)
 S S(6)=S(6)+$P(Y0,"^",10)+$P(Y0,"^",11)
 Q
EN2 ; Print the Staffing Data
 D HDR
 K T1 S (TQ,TQ1)=0,Z1="" F I=1:1:8 S T1(I)=""
 F QR=1:1:4 S QTR=QR,PRE=FHYR_"0"_QTR_"00" D Q2^FHADRPT,Q11
 D Q2
 W !!!,"Specialty Staffing",!
 W !,"Staff Certified Diabetes Educators (CDE): ",$J($P(Z1,"^",1),2)
 W !,"Staff Certified in Nutrition Support: ",$J($P(Z1,"^",2),2)
 W !,"Staff Registered Clinical Dietetic Technicians: ",$J($P(Z1,"^",3),2)
 W !,"Staff With Clinical Privileges (Not Scope of Practice): ",$J($P(Z1,"^",4),2)
 K S,T1 Q
Q11 Q:'SDT!('EDT)
 S AV=0 F K=1:1:7 S S(K)=""
 S Y0=$G(^FH(117.3,PRE,1)) Q:Y0=""
 F I=1:1:5 S S(I)=$P(Y0,"^",I+5)
 S S(7)=$P(Y0,"^",13),Z=$P(Y0,"^",14,17) S:"^^^"'[Z Z1=Z
 S:S(1) TQ=TQ+1 S S(7)=S(7)/8,S(1)=S(1)+S(7)
 S S(6)=S(1)-S(2)-S(3)-S(4)-S(5)
 F L=1:1:6 S $P(T1(QTR),"^",L)=$P(T1(QTR),"^",L)+S(L),$P(T1(6),"^",L)=$P(T1(6),"^",L)+S(L)
 ; AMS is the Average meals served for four quarters.
 S:S(6) AV=$P(AMS,"^",QTR)/S(6) S:AV TQ1=TQ1+1 S $P(T1(5),"^",QTR)=$P(T1(5),"^",QTR)+AV
 Q
Q2 S K=0 F TIT="CLINICAL","ADMINISTRATIVE","SUPPORT STAFF","SUPERVISORY","ADJUSTED MEASURED" S K=K+1 D Q3
 W !,"TOTAL",?36 F I=1:1:4 W $S(+$P(T1(I),"^",1)'<1:$J($P(T1(I),"^",1),7,1),1:$J("",7))_$J("",13)
 W $S(TQ:$J($P(T1(6),"^",1)/TQ,7,1),1:$J("",7))
 W !!,"Average Daily",!,"Meals/Adj Measured FTEE"
 W ?36 F I=1:1:4 W $S($P(T1(5),"^",I):$J($P(T1(5),"^",I),7,2),1:$J("",7))_$J("",13) S $P(T1(5),"^",5)=$P(T1(5),"^",5)+$P(T1(5),"^",I)
 S $P(T1(5),"^",5)=$S(TQ1:$P(T1(5),"^",5)/TQ1,1:"") W $S($P(T1(5),"^",5)'="":$J($P(T1(5),"^",5),7,2),1:$J("",7))
 Q
Q3 W !,TIT,?36 F I=1:1:4 W $S(+$P(T1(I),"^",K+1)'<1:$J($P(T1(I),"^",K+1),7,1),1:$J("",7))_$J("",13)
 W $S(TQ:$J($P(T1(6),"^",K+1)/TQ,7,1),1:$J("",7))
 Q
HDR ; Print Heading for Staffing
 D:$Y'<(LIN-25) HDR^FHADRPT
 W !!!,"S E C T I O N  IV   S T A F F I N G"
 W !!!,"FTEE Summary",!?37,"1st Qtr",?57,"2nd Qtr",?77,"3rd Qtr",?97,"4th Qtr",?120,"YTD"
 W !,?38,"Total",?58,"Total",?78,"Total",?98,"Total",?116,"Average",! Q
