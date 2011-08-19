FHDMP5 ; HISC/REL/NCA - Patient Data Log (cont) ;2/17/93  16:23 
 ;;5.5;DIETETICS;;Jan 28, 2005
 D:$Y>(S1-4) HDR^FHDMP G:QT="^" KIL^FHDMP W !,LN,!?25,"S T A N D I N G   O R D E R S"
 S CT=0 F K=0:0 S K=$O(^FHPT(FHDFN,"A",ADM,"SP",K)) Q:K<1  I $D(^(K,0)) S X=^(0) I $P(X,"^",4)'<SDT D:$Y>(S1-6) HDR^FHDMP G:QT="^" KIL^FHDMP D SP
 I 'CT W !!,"No Standing Orders for this Admission"
 W !
 D:$Y>(S1-4) HDR^FHDMP G:QT="^" KIL^FHDMP W !,LN,!?23,"A D D I T I O N A L   O R D E R S"
 S CT=0 F K=0:0 S K=$O(^FHPT(FHDFN,"A",ADM,"OO",K)) Q:K<1  I $D(^(K,0)) S X=^(0) I $P(X,"^",2)'<SDT D:$Y>(S1-6) HDR^FHDMP G:QT="^" KIL^FHDMP D L1
 I 'CT W !!,"No Additional Orders for this Admission"
 W ! Q
SP S CT=CT+1 W !!,"Order #:   ",K
 S M1=$P(X,"^",3) I M1="BNE" S M2="All Meals" G S1
 S L=$E(M1,1),M2=$S(L="B":"Break",L="N":"Noon",1:"Even")
 S L=$E(M1,2) I L'="" S M2=M2_","_$S(L="B":"Break",L="N":"Noon",1:"Even")
S1 W ?40,"Meals: ",M2
 S Y=$P(X,"^",2),Q=$P(X,"^",8) W !,"Order:     ",$S(Q:Q,1:1)," ",$P($G(^FH(118.3,+Y,0)),"^",1)
 S Y=$P(X,"^",4) W !,"Ordered:   " D DTP S Y=$P(X,"^",5) W ?40,"By:    ",$P($G(^VA(200,+Y,0)),"^",1)
 S Y=$P(X,"^",6) W !,"Cancelled: " D DTP S Y=$P(X,"^",7) W ?40,"By:    ",$P($G(^VA(200,+Y,0)),"^",1)
 S Y=$P(X,"^",9) W !,"Diet Associated: ",$S(Y="Y":"Yes",1:"No") Q
L1 S CT=CT+1 W !!,"Order #:   ",K S Y=$P(X,"^",5) W ?40,"Status: ",$S(Y="C":"Complete",Y="A":"Active",Y="S":"Saved",Y="X":"Cancelled",1:"")
 W !,"Order:     ",$P(X,"^",3)
 S Y=$P(X,"^",2) W !,"Ordered:   " D DTP S Y=$P(X,"^",4) W ?40,"By:     ",$P($G(^VA(200,+Y,0)),"^",1)
 S Y=$P(X,"^",6) W !,"Cleared:   " D DTP S Y=$P(X,"^",7) W ?40,"By:     ",$P($G(^VA(200,+Y,0)),"^",1) Q
DTP ; Printable Date/Time
 Q:Y<1  W $J(+$E(Y,6,7),2)_"-"_$P("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"," ",+$E(Y,4,5))_"-"_$E(Y,2,3)
 I Y["." S %=+$E(Y_"0",9,10) W $J($S(%>12:%-12,1:%),3)_":"_$E(Y_"000",11,12)_$S(%<12:"am",%<24:"pm",1:"m")
 K % Q
