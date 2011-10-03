FHORE3 ; HISC/REL - Cancel Early/Late Trays ;6/21/96  10:30 ;
 ;;5.5;DIETETICS;;Jan 28, 2005;
 S ALL=0 D ^FHDPA G:'DFN KIL G:'FHDFN KIL D NOW^%DTC S NOW=%
S0 S CT=0 K N,NN W !!,"Order     Date        Time       Meal",!
 F K=NOW:0 S K=$O(^FHPT(FHDFN,"A",ADM,"EL",K)) Q:K<1  S CT=CT+1,N(CT)=K,Y=^(K,0) D D3
 I 'CT W !,"No future early or late trays to cancel" G KIL
D0 R !!,"Cancel Which Early/Late Orders (or ALL)? ",MEAL:DTIME G:'$T!("^"[MEAL) AB S:$P("all",MEAL,1)="" MEAL="A" S:$P("ALL",MEAL,1)="" MEAL="1-"_CT
 F K=1:1 S K1=$P(MEAL,",",K) Q:K1=""  S K2=$S(K1["-":$P(K1,"-",2),1:+K1),K1=+K1 D CK G:'K1 S0 F K3=K1:1:K2 D D2
 W "  ... done" G KIL
CK I K1<1!(K1>CT)!(K1'?1N.N) G C1
 I K2<1!(K2>CT)!(K2'?1N.N) G C1
 Q:K2'<K1
C1 W *7,!,"  Enter numbers, or range, of desired orders or ALL (E.G.,  1,3,4 or 3-5 or 1,3-5 etc.)" S K1=0 Q
D2 S DTE=N(K3) S FHORN=$P($G(^FHPT(FHDFN,"A",ADM,"EL",DTE,0)),"^",7) I FHORN S:'$D(NN(FHORN,DTE)) NN(FHORN,DTE)=""
 K ^FHPT(FHDFN,"A",ADM,"EL",DTE),^FHPT("ADLT",DTE,FHDFN)
 S %=$S($D(^FHPT(FHDFN,"A",ADM,"EL",0)):$P(^(0),"^",4),1:0)-1 S:%'<0 $P(^(0),"^",4)=%
 Q:'FHORN  F I9=NOW:0 S I9=$O(^FHPT(FHDFN,"A",ADM,"EL",I9)) Q:I9<1  I $P(^(I9,0),"^",7)=FHORN G D21
 D CODE^FHWOR3 D:$D(MSG) MSG^XQOR("FH EVSEND OR",.MSG) K MSG
D21 Q
D3 S MEAL=$P(Y,"^",2),TIM=$P(Y,"^",3),BAG=$P(Y,"^",4),DTP=K\1 D DTP^FH
 W !,$J(CT,4),"   ",DTP
 W $J(TIM,10),"   ",$S(MEAL="B":"Breakfast",MEAL="N":"  Noon ",1:" Evening") W:BAG="Y" ?45,"Bagged Meal" Q
AB W *7,!!,"Early/Late Tray operation TERMINATED - No change!"
KIL K %,%H,%I,ADM,ALL,BAG,CT,DA,WARD,FHDFN,DFN,DTE,DTP,FHORN,FHWF,FHPV,I9,K,K1,K2,K3,MEAL,N,NN,NOW,TIM,X,Y Q
