FHWOR72 ; HISC/CAH - Diet Profile for CPRS (cont) ;3/13/01  15:15
 ;;5.5;DIETETICS;;Jan 28, 2005
 S X1=NOW,X2=-1 D C^%DTC S LST=X,CT=0
 F K=0:0 S K=$O(^FHPT(FHDFN,"A",ADM,"OO",K)) Q:K<1  S X=^(K,0) I $P(X,"^",2)'<LST!($P(X,"^",5)="S"),$P(X,"^",5)'="X" D L1
 S FHX=$$SPACNG^FHWOR71(0,FHX) S CT=0 F KK=NOW:0 S KK=$O(^FHPT(FHDFN,"A",ADM,"AC",KK)) Q:KK<1  S FHORD=$P(^(KK,0),"^",2) D T1
 I 'CT S FHX=$$SPACNG^FHWOR71(0,FHX) S ^TMP($J,"FHPROF",DFN,FHX)="No future Diet Orders exist"
F4 S FHX=$$SPACNG^FHWOR71(1,FHX) S CT=0 F K=NOW:0 S K=$O(^FHPT(FHDFN,"A",ADM,"EL",K)) Q:K<1  S CT=CT+1,Y=^(K,0) D EL
 I 'CT S FHX=$$SPACNG^FHWOR71(0,FHX) S ^TMP($J,"FHPROF",DFN,FHX)="No future Early or Late Trays ordered"
 K N F K=0:0 S K=$O(^FHPT("ASP",FHDFN,ADM,K)) Q:K<1  S X=^FHPT(FHDFN,"A",ADM,"SP",K,0),M=$P(X,"^",3),M=$S(M="BNE":"A",1:$E(M,1)),N(M,K)=$P(X,"^",2,3),$P(N(M,K),"^",3)=$P(X,"^",8)
 I $O(N(""))="" S FHX=$$SPACNG^FHWOR71(1,FHX) S ^TMP($J,"FHPROF",DFN,FHX)="No Active Standing Orders" G F5
 S FHX=$$SPACNG^FHWOR71(1,FHX) S ^TMP($J,"FHPROF",DFN,FHX)="Active Standing Orders:" S FHX=$$SPACNG^FHWOR71(0,FHX)
 F M="A","B","N","E" F K=0:0 S K=$O(N(M,K)) Q:K<1  S Z=+N(M,K) I Z D
 . D SP S QTY=$P(N(M,K),"^",3)
 . S FHX=$$SPACNG^FHWOR71(0,FHX)
 . K ST1 S ST1="     "_M2,$E(ST1,20,80)=$S(QTY:QTY,1:1)_" "_$P(^FH(118.3,Z,0),"^",1)
 . S ^TMP($J,"FHPROF",DFN,FHX)=ST1
 K L,N,M,M1,M2
F5 S CT=0 F K=0:0 S K=$O(^FHPT(FHDFN,"A",ADM,"DR",K)) Q:K<1  D CD
 I 'CT S FHX=$$SPACNG^FHWOR71(1,FHX) S ^TMP($J,"FHPROF",DFN,FHX)="No Active Consultations for this Admission"
F6 S CT=0 F KK=0:0 S KK=$O(^FHPT(FHDFN,"A",ADM,"MO","AC",KK)) Q:KK<1  F K=0:0 S K=$O(^FHPT(FHDFN,"A",ADM,"MO","AC",KK,K)) Q:K<1  D MO
 I 'CT S FHX=$$SPACNG^FHWOR71(1,FHX) S ^TMP($J,"FHPROF",DFN,FHX)="No Monitors for this Admission"
 S FHX=$$SPACNG^FHWOR71(0,FHX) Q
SP S M1=$P(N(M,K),"^",2) I M1="BNE" S M2="All Meals" Q
 S L=$E(M1,1),M2=$S(L="B":"Break",L="N":"Noon",1:"Even")
 S L=$E(M1,2) Q:L=""  S M2=M2_","_$S(L="B":"Break",L="N":"Noon",1:"Even") Q
EL S MEAL=$P(Y,"^",2),TIM=$P(Y,"^",3),BAG=$P(Y,"^",4),DTP=K\1 D DTP^FH
 S FHX=$$SPACNG^FHWOR71(0,FHX) K ST1 S ST1="Early/Late Meal:  "_DTP,$E(ST1,30,45)=$J(TIM,10),ST1=ST1_"   "_$S(MEAL="B":"Breakfast",MEAL="N":"  Noon ",1:" Evening") S:BAG="Y" ST1=ST1_"       Bagged Meal"
 S ^TMP($J,"FHPROF",DFN,FHX)=ST1 Q
CD S Y=^FHPT(FHDFN,"A",ADM,"DR",K,0) Q:$P(Y,"^",8)'="A"  S CT=CT+1
 S CON=$P(Y,"^",2),DTP=$P(Y,"^",1),COM=$P(Y,"^",3)
 S FHX=$$SPACNG^FHWOR71(1,FHX) S ^TMP($J,"FHPROF",DFN,FHX)="Consult: "_$P($G(^FH(119.5,CON,0)),"^",1)
 I COM'="" S FHX=$$SPACNG^FHWOR71(0,FHX) S ^TMP($J,"FHPROF",DFN,FHX)="Comment: "_COM
 D DTP^FH S FHX=$$SPACNG^FHWOR71(0,FHX) S ^TMP($J,"FHPROF",DFN,FHX)="Ordered: "_DTP Q
L1 I 'CT S FHX=$$SPACNG^FHWOR71(1,FHX) S ^TMP($J,"FHPROF",DFN,FHX)="Additional Orders Saved or Last 24 Hours:" S FHX=$$SPACNG^FHWOR71(0,FHX) S CT=1
 S DTP=$P(X,"^",2) D DTP^FH S FHX=$$SPACNG^FHWOR71(0,FHX) K ST1 S $P(ST1," ",21)="",ST1=ST1_DTP S $E(ST1,21,(21+$L($P(X,"^",3))))=$P(X,"^",3)
 S ^TMP($J,"FHPROF",DFN,FHX)=ST1 Q
T1 Q:'$D(^FHPT(FHDFN,"A",ADM,"DI",FHORD,0))  S DTP=KK D DTP^FH,C2^FHORD7
 I 'CT S FHX=$$SPACNG^FHWOR71(0,FHX) S ^TMP($J,"FHPROF",DFN,FHX)="Future Diet Orders:" S FHX=$$SPACNG^FHWOR71(0,FHX)
 S CT=CT+1 S FHX=$$SPACNG^FHWOR71(0,FHX) S ^TMP($J,"FHPROF",DFN,FHX)="     "_DTP_"  "_Y Q
MO ; Monitors
 S Y=$G(^FHPT(FHDFN,"A",ADM,"MO",K,0)) Q:Y=""  S CT=CT+1
 S FHX=$$SPACNG^FHWOR71(1,FHX) S DTP=$P(Y,"^",2) D DTP^FH S ^TMP($J,"FHPROF",DFN,FHX)=$P(Y,"^",1)_", "_DTP
 S COM=$P(Y,"^",3) I COM'="" S FHX=$$SPACNG^FHWOR71(0,FHX) S ^TMP($J,"FHPROF",DFN,FHX)="     Action: "_COM
 Q
