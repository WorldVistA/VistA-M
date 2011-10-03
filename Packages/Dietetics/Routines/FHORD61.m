FHORD61 ; HISC/REL/NCA - Diet Inquiry (cont) ;3/13/01  15:08
 ;;5.5;DIETETICS;**5**;Jan 28, 2005;Build 53
 S X1=NOW,X2=-1 D C^%DTC S LST=X,CT=0
 F K=0:0 S K=$O(^FHPT(FHDFN,"A",ADM,"OO",K)) Q:K<1  S X=^(K,0) I $P(X,"^",2)'<LST!($P(X,"^",5)="S"),$P(X,"^",5)'="X" D L1 Q:QT="^"
 G:QT="^" KIL^FHORD6
 W ! S CT=0 F KK=NOW:0 S KK=$O(^FHPT(FHDFN,"A",ADM,"AC",KK)) Q:KK<1  S FHORD=$P(^(KK,0),"^",2) D T1 Q:QT="^"
 G:QT="^" KIL^FHORD6
 D:$Y>(IOSL-2) HDR^FHORD6 G:QT="^" KIL^FHORD6 I 'CT W !,"No future Diet Orders exist"
F4 W ! S CT=0 F K=NOW:0 S K=$O(^FHPT(FHDFN,"A",ADM,"EL",K)) Q:K<1  S CT=CT+1,Y=^(K,0) D EL Q:QT="^"
 G:QT="^" KIL^FHORD6
 D:$Y>(IOSL-2) HDR^FHORD6 G:QT="^" KIL^FHORD6 I 'CT W !,"No future Early or Late Trays ordered"
 K N F K=0:0 S K=$O(^FHPT("ASP",FHDFN,ADM,K)) Q:K<1  S X=^FHPT(FHDFN,"A",ADM,"SP",K,0),M=$P(X,"^",3),M=$S(M="BNE":"A",1:$E(M,1)),N(M,K)=$P(X,"^",2,3),$P(N(M,K),"^",3)=$P(X,"^",8)
 D:$Y>(IOSL-4) HDR^FHORD6 G:QT="^" KIL^FHORD6 I $O(N(""))="" W !!,"No Active Standing Orders" G F5
 W !!,"Active Standing Orders:",!
 F M="A","B","N","E" F K=0:0 S K=$O(N(M,K)) Q:K<1  S Z=+N(M,K) I Z D:$Y>(IOSL-2) HDR^FHORD6 Q:QT="^"  D SP S QTY=$P(N(M,K),"^",3) W !?5,M2,?18,$S(QTY:QTY,1:1)," ",$P(^FH(118.3,Z,0),"^",1)
 G:QT="^" KIL^FHORD6
 K L,N,M,M1,M2
F5 S CT=0 F K=0:0 S K=$O(^FHPT(FHDFN,"A",ADM,"DR",K)) Q:K<1  D:$Y>(IOSL-5) HDR^FHORD6 Q:QT="^"  D CD
 G:QT="^" KIL^FHORD6
 I 'CT D:$Y>(IOSL-4) HDR^FHORD6 G:QT="^" KIL^FHORD6 W !!,"No Active Consultations for this Admission"
F6 ;S CT=0 F KK=0:0 S KK=$O(^FHPT(FHDFN,"A",ADM,"MO","AC",KK)) Q:KK<1!(QT="^")  F K=0:0 S K=$O(^FHPT(FHDFN,"A",ADM,"MO","AC",KK,K)) Q:K<1  D:$Y>(IOSL-5) HDR^FHORD6 Q:QT="^"  D MO
 S FHTTLM="",FHTTLM=$P($G(^FHPT(FHDFN,"A",ADM,"MO",0)),U,3)
 I FHTTLM="" W !!,"No Monitors on file" G KIL^FHORD6
 S FHMONS=$S(FHTTLM-FHNUM<0:0,1:FHTTLM-FHNUM)
 F NDT=FHMONS:0 S NDT=$O(^FHPT(FHDFN,"A",ADM,"MO",NDT)) Q:NDT<1!(QT="^")  S K=NDT D MO
 Q:QT="^"  I 'CT W !,"No Monitors on file."
 I 'CT D:$Y>(IOSL-4) HDR^FHORD6 G:QT="^" KIL^FHORD6 W !!,"No Monitors for this Admission"
 I $E(IOST,1,2)="C-" R !!,"Press return to continue  ",YN:DTIME
 W ! G KIL^FHORD6
SP S M1=$P(N(M,K),"^",2) I M1="BNE" S M2="All Meals" Q
 S L=$E(M1,1),M2=$S(L="B":"Break",L="N":"Noon",1:"Even")
 S L=$E(M1,2) Q:L=""  S M2=M2_","_$S(L="B":"Break",L="N":"Noon",1:"Even") Q
EL S MEAL=$P(Y,"^",2),TIM=$P(Y,"^",3),BAG=$P(Y,"^",4),DTP=K\1 D DTP^FH
 D:$Y>(IOSL-2) HDR^FHORD6 Q:QT="^"  W !,"Early/Late Meal: ",DTP,?29,$J(TIM,10),"   ",$S(MEAL="B":"Breakfast",MEAL="N":"  Noon ",1:" Evening") W:BAG="Y" ?62,"Bagged Meal" Q
CD S Y=^FHPT(FHDFN,"A",ADM,"DR",K,0) Q:$P(Y,"^",8)'="A"  S CT=CT+1
 S CON=$P(Y,"^",2),DTP=$P(Y,"^",1),COM=$P(Y,"^",3)
 W !!,"Consult: ",$P($G(^FH(119.5,CON,0)),"^",1)
 W:COM'="" !,"Comment: ",COM
 D DTP^FH W !,"Ordered: ",DTP Q
L1 D:$Y>(IOSL-4) HDR^FHORD6 Q:QT="^"  I 'CT W !!,"Additional Orders Saved or Last 24 Hours:",! S CT=1
 S DTP=$P(X,"^",2) D DTP^FH W !,DTP,?20,$P(X,"^",3) Q
T1 Q:'$D(^FHPT(FHDFN,"A",ADM,"DI",FHORD,0))  S DTP=KK D DTP^FH,C2^FHORD7
 D:$Y>(IOSL-3) HDR^FHORD6 Q:QT="^"  I 'CT W !,"Future Diet Orders:",!
 S CT=CT+1 W !?5,DTP,?25,Y Q
MO ; Display Monitors
 S Y=$G(^FHPT(FHDFN,"A",ADM,"MO",K,0)) Q:Y=""  S CT=CT+1
 D:$Y'<(IOSL-4) HDR^FHORD6 Q:QT="^"
 W !!,$P(Y,"^",1) S DTP=$P(Y,"^",2) D DTP^FH W ", ",DTP
 S COM=$P(Y,"^",3) W:COM'="" !?5,"Action: ",COM Q
