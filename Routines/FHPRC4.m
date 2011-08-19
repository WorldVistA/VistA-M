FHPRC4 ; HISC/REL - Menu Cycle Query ;4/27/93  13:44 
 ;;5.5;DIETETICS;;Jan 28, 2005
EN1 ; Menu Cycle Query
 S %DT("A")="Select Date: ",%DT="AEX" W ! D ^%DT G KIL:"^"[X!$D(DTOUT),EN1:Y<1 S (X1,D1)=+Y
 D E1^FHPRC1 I FHCY<1 W *7,!!,"No MENU CYCLE Defined for that Date!" G EN1
 W !!?5,"Menu Cycle: ",$P(^FH(116,FHCY,0),"^",1),!?5,"Cycle Day:  ",FHDA
 I '$D(^FH(116,FHCY,"DA",FHDA,0)) W *7,!!,"MENU CYCLE DAY Not Defined!" G EN1
 S FHX1=^FH(116,FHCY,"DA",FHDA,0) G:'$D(^FH(116.3,D1,0)) N1
 S X=^FH(116.3,D1,0) W !!,"Normal Cycle Suspended for Holiday: ",$P(X,"^",5)
 F LL=2:1:4 I $P(X,"^",LL) S $P(FHX1,"^",LL)=$P(X,"^",LL)
N1 W ! F K=1:1:3 S X=$P(FHX1,"^",K+1) W !?5,$P("Breakfast Noon Evening"," ",K)," Menu:" I X W ?23,$P($G(^FH(116.1,X,0)),"^",1)
 G EN1
EN2 ; Menu Cycle Time Line
 W !!,"Effective Date",?25,"Menu Cycle",!
 F K=0:0 S K=$O(^FH(116,"AB",K)) Q:K<1  S FHCY=$O(^(K,0)),DTP=K D DTP^FH W !?2,DTP,?25,$P($G(^FH(116,+FHCY,0)),"^",1)
 G KIL
KIL G KILL^XUSCLEAN
