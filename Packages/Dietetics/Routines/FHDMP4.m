FHDMP4 ; HISC/REL/NCA - Patient Data Log (cont) ;5/7/92  15:36 
 ;;5.5;DIETETICS;**1**;Jan 28, 2005
 S LST=1 D:$Y>(S1-4) HDR^FHDMP G:QT="^" KIL^FHDMP W !,LN,!?28,"T U B E F E E D I N G S"
 I SDT F K=0:0 S K=$O(^FHPT(FHDFN,"A",ADM,"TF",K)) Q:K<1  S D1=$P(^(K,0),"^",1) Q:D1=""!(D1'<SDT)  S LST=K
 S CT=0 F TF=LST-1:0 S TF=$O(^FHPT(FHDFN,"A",ADM,"TF",TF)) Q:TF<1  I $D(^(TF,0)) S X=^(0) D TF G:QT="^" KIL^FHDMP
 I 'CT W !!,"No Tubefeedings ordered for this Admission"
 W !
 D:$Y>(S1-4) HDR^FHDMP G:QT="^" KIL^FHDMP W !,LN,!?23,"D I E T E T I C   C O N S U L T S"
 S CT=0 F K=0:0 S K=$O(^FHPT(FHDFN,"A",ADM,"DR",K)) Q:K<1  I $D(^(K,0)) S X=^(0) I $P(X,"^",1)'<SDT S CT=CT+1 D:$Y>(S1-6) HDR^FHDMP G:QT="^" KIL^FHDMP D CD
 I 'CT W !!,"No Consultations ordered for this Admission"
 W !
 D:$Y>(S1-4) HDR^FHDMP G:QT="^" KIL^FHDMP W !,LN,!?24,"E A R L Y / L A T E   T R A Y S"
 S CT=0 F K=SDT:0 S K=$O(^FHPT(FHDFN,"A",ADM,"EL",K)) Q:K<1  S X=^(K,0),CT=CT+1 D:$Y>(S1-4) HDR^FHDMP G:QT="^" KIL^FHDMP D EL
 I 'CT W !!,"No Early or Late Trays ordered for this Admission"
 W ! G ^FHDMP5
TF W !!,"Order # ",TF S CT=CT+1
 F TF2=0:0 S TF2=$O(^FHPT(FHDFN,"A",ADM,"TF",TF,"P",TF2)) Q:TF2<1  S X1=^(TF2,0) D:$Y>(S1-8) HDR^FHDMP Q:QT="^"  D TF1
 Q:QT="^"  W !,"Daily ML's:   ",$P(X,"^",3),?42,"Daily KCals: ",$P(X,"^",7)
 S Y=$P(X,"^",5) W:Y'="" !,"Comment:      ",Y
 S Y=$P(X,"^",1) W !,"Ordered:      " D DTP S Y=$P(X,"^",10) W ?42,"By: ",$P($G(^VA(200,+Y,0)),"^",1)
 S Y=$P(X,"^",11) W !,"Cancelled:    " D DTP S Y=$P(X,"^",12) W ?42,"By: ",$P($G(^VA(200,+Y,0)),"^",1) Q
TF1 S Y=$P(X1,"^",1) W !,"Product: ",$P($G(^FH(118.2,+Y,0)),"^",1),", "
 S Y=$P(X1,"^",2) W $S(Y=4:"Full",Y=1:"1/4",Y=2:"1/2",1:"3/4")," Str., "
 S FHTUBML=$P(X1,"^",3)
 I FHTUBML["CC" S QUAFI=$P(FHTUBML,"CC",1),QUASE=$P(FHTUBML,"CC",2),FHTUBML=QUAFI_"ML"_QUASE
 W FHTUBML
 W !,"Product ML's: ",$P(X1,"^",4),?42,"Water ML's:  ",$P(X1,"^",5) Q
CD S Y=$P(X,"^",2) W !!,"Request:   ",$P($G(^FH(119.5,+Y,0)),"^",1)
 S Y=$P(X,"^",8) W ?62,"Status: ",$S(Y="A":"Active",Y="C":"Complete",Y="X":"Cancelled",1:"")
 S Y=$P(X,"^",3) I Y'="" W !,"Comment:   ",Y
 S Y=$P(X,"^",5) W !,"Clinician: ",$P($G(^VA(200,+Y,0)),"^",1)
 S Y=$P(X,"^",11) W ?62,"Type:   ",$S(Y="I":"Initial",Y="F":"Follow-up",1:"")
 S Y=$P(X,"^",1) W !,"Ordered:   " D DTP S Y=$P(X,"^",7) W ?45,"By: ",$P($G(^VA(200,+Y,0)),"^",1)
 S Y=$P(X,"^",9) W !,"Cleared:   " D DTP S Y=$P(X,"^",10) W ?45,"By: ",$P($G(^VA(200,+Y,0)),"^",1) Q
EL S Y=$P(X,"^",1) W !!,"Order:   " D DTP S Y=$P(X,"^",2) W ?28,"Meal: ",$S(Y="B":"Breakfast",Y="N":"Noon",Y="E":"Evening",1:"")
 S Y=$P(X,"^",4) W ?47,"Bagged: ",$S(Y="Y":"Yes",Y="N":"No",1:"") W ?62,"Time: ",$P(X,"^",3)
 S Y=$P(X,"^",6) W !,"Ordered: " D DTP S Y=$P(X,"^",5) W ?28,"By:   ",$P($G(^VA(200,+Y,0)),"^",1) Q
DTP ; Printable Date/Time
 Q:Y<1  W $J(+$E(Y,6,7),2)_"-"_$P("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"," ",+$E(Y,4,5))_"-"_$E(Y,2,3)
 I Y["." S %=+$E(Y_"0",9,10) W $J($S(%>12:%-12,1:%),3)_":"_$E(Y_"000",11,12)_$S(%<12:"am",%<24:"pm",1:"m")
 K % Q
