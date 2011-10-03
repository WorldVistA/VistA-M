FHADR2 ; HISC/NCA/JH - Type of Service ;2/15/95  16:02 
 ;;5.5;DIETETICS;;Jan 28, 2005
Q1 ; Bedside Tray, Cafeteria, and Dining Room Tray
 ; Enter/Edit the Type of Service
 S DP=0 D NOW^%DTC S NOW=%\1 K %
 D YR^FHADR1 G:'PRE KIL
 S X=$P($G(^XMB(1,1,"XUS")),"^",17) G:X="" MSG S FHX1=X
 S ST=$G(^DIC(4,FHX1,0)) Q:ST=""
 S X1=PRE,X2=-356 D C^%DTC S OLD=$E(X,1,4)_"400"
 I '$D(^FH(117.3,PRE,0)) D S1^FHADR1 S OLD=PRE D SET^FHADR1 S PRE=OLD G F1
 S OLD=PRE
F1 W ! K DIC,DIE S DIE="^FH(117.3,",DA=PRE
 L +^FH(117.3,PRE,0):0 I '$T W !?5,"Another user is editing this entry." G KIL
 I '$D(^FH(117.3,PRE,0)) D
 .S $P(^FH(117.3,PRE,0),"^",1)=PRE,^FH(117.3,"B",PRE,PRE)=""
 .S Z=$G(^FH(117.3,0)),$P(^FH(117.3,0),"^",3,4)=PRE_"^"_($P(Z,"^",4)+1)
 .S $P(ZZ,"^",2,12)=$P(ST,"^",7)_"^"_$P($G(^DIC(4,FHX1,"DIV")),"^",1)_"^^^^^^^^^"
 .S $P(^FH(117.3,PRE,0),"^",2,13)=ZZ
 .Q
 S DR="15:17" D ^DIE L -^FH(117.3,PRE,0) K DA,DIC,DIE,DR
SET ; Set all three quarters with the Type of Service
 F QTR=2:1:4 S PRE=$E(OLD,1,4)_QTR_"00" D S1
KIL G KILL^XUSCLEAN
S1 Q:'$D(^FH(117.3,OLD,0))
 I '$D(^FH(117.3,PRE,0)) S $P(^FH(117.3,PRE,0),"^",1)=PRE,^FH(117.3,"B",PRE,PRE)="",Z=^FH(117.3,0),$P(^FH(117.3,0),"^",3,4)=PRE_"^"_($P(Z,"^",4)+1)
 S $P(^FH(117.3,PRE,0),"^",2,16)=$P($G(^FH(117.3,OLD,0)),"^",2,16)
 Q
MSG W !!,$C(7)," *** SITE NOT FOUND IN ^XMB GLOBAL ***" G KIL
EN2 ; Print out the Type of Service
 D:$Y'<(LIN-10) HDR^FHADRPT,HDR2^FHADR3A
 W !!!!!,?13,"TYPE OF SERVICE SUMMARY"
 S (N1,N2,N3,X2,X3)=""
 W !?65,"Average Daily Meals Served",!?68,"By Type of Service",?93,"% of Workload"
 S X="" F QR=1:1:4 S QTR=QR,PRE=FHYR_"0"_QTR_"00" S X3=$P($G(^FH(117.3,PRE,0)),"^",14,16) S:"^^"'[X3 X=X3
 S N1=$P(X,"^",1),N2=$P(X,"^",2),N3=$P(X,"^",3),X2=$P(X,"^",1)+$P(X,"^",2)+$P(X,"^",3)
 W !,?15,"Bedside Tray",?80 W $J($S(N1:N1,1:""),6),?100,$S(X2:$J(N1/X2*100,6,0),1:$J("",6))
 W !?15,"Cafeteria",?80 W $J($S(N2:N2,1:""),6),?100,$S(X2:$J(N2/X2*100,6,0),1:$J("",6))
 W !?15,"Dining Room Tray",?80 W $J($S(N3:N3,1:""),6),?100,$S(X2:$J(N3/X2*100,6,0),1:$J("",6))
 W !,?15,"Total",?80 W $J($S(X2:X2,1:""),6)
 K N1,N2,N3,X2,X3 Q
