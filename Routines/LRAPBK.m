LRAPBK ;AVAMC/REG/CYM - AP LOG BOOK ;2/9/98  15:36 ;
 ;;5.2;LAB SERVICE;**51,72,201,274**;Sep 27, 1994
 ; The code for functionality of LR*5.2*51 has changed with patch 72.
 ; The functionality that came with LR*5.2*51 remains the same.
 D ^LRAP G:'$D(Y) END D XR^LRU
 W !!?20,LRO(68)," LOG BOOK" S X=$E(DT,2,3),%DT="" D ^%DT S LRH(2)=$E(Y,1,3) D D^LRU S LRH(0)=Y
 W !!,"Print SNOMED codes if entered " S %=2 D YN^LRU G:%<1 END S:%=1 LRB=1
 I $D(LRB) W !,"Print only Topography and Morphology codes " S %=2 D YN^LRU G:%<1 END S:%=2 LRB(1)=1
 W !!,"Log book year: ",LRH(0)," OK " S %=1 D YN^LRU G:%<0 END
ASK I %=2 W ! S %DT("A")="Select YEAR: ",%DT="AQ" D ^%DT K %DT G:Y<1 END S LRH(2)=$E(Y,1,3) D D^LRU S LRH(0)=Y
 I '$D(^LR(LRXREF,LRH(2),LRABV)) W $C(7),!!,"No entries for ",LRH(0) S %=2 G ASK
N1 R !,"Start with Acc #: ",X:DTIME G:X=""!(X[U) END I X'?1N.N W $C(7),!!,"NUMBERS ONLY !!" G N1
 S LRN(1)=X
N2 R !,"Go    to   Acc #: LAST // ",X:DTIME G:X='$T!(X[U) END S:X="" X=999999 I X'?1N.N W $C(7),!!,"NUMBERS ONLY !!",!! G N2
 S LRN(2)=X,ZTRTN="QUE^LRAPBK",ZTDESC="Anatomic Path Log Book",ZTSAVE("LR*")="" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO D L^LRU,S^LRU S P(9)="",LRW=LRH(2)_"0000" D H S LR("F")=1
 S LRAN=LRN(1)-1 F  S LRAN=$O(^LR(LRXREF,LRH(2),LRABV,LRAN)) Q:'LRAN!(LRAN>LRN(2))!(LR("Q"))  D SH
 W:IOST'?1"C".E @IOF D END^LRUTL,END Q
SH S P(13)="",LRDFN=$O(^LR(LRXREF,LRH(2),LRABV,LRAN,0)) Q:'LRDFN!(LR("Q"))  I "SPCYEM"[LRSS S LRI=$O(^(LRDFN,0)) Q:'LRI
 D:$Y>(IOSL-6) H Q:LR("Q")
 K LRDPF,LRLLOC D PT^LRX I $G(LREND) K LREND Q
 S LRP=PNM,P(0)=$S(LRDPF=2:"PATIENT",1:"OTHER")
 I "SPCYEM"[LRSS Q:'$D(^LR(LRDFN,LRSS,LRI,0))  S X=^(0),LRLLOC=$P(X,U,8),Y=$P(X,U,7) D S S P(2)=Y,Y=$P(X,U,2) D S S P(1)=$E(Y,1,12),Y=$P(X,U,13) D S S P(13)=Y,LRSPDT=$$Y2K^LRX(+X),X=$P(X,U,10)
 E  Q:'$D(^LR(LRDFN,"AU"))  S X=^("AU"),LRLLOC=$P(X,U,5),Y=$P(X,U,12) D S S P(2)=Y,Y=$P(X,U,7) D S S P(9)=$E(Y,1,15),Y=$P(X,U,2) D S S LR("ASST")=Y,Y=$P(X,U,10) D S S P(1)=$E(Y,1,12),X=+X
 S T=+$E(X,4,5)_"/"_$E(X,6,7)
 W !,$J(T,5),?7,$J(LRAN,5),?14 W:P(0)'="PATIENT" "#" W $E(LRP,1,18),?34,SSN(1),?40,$E(LRLLOC,1,8),?49,$E(P(2),1,16),?67,P(1),!?10,"SSN: ",SSN
 S LRLLOC("TY")=$P($G(^LRO(68,LRAA,1,LRH(2)_"0000",1,LRAN,0)),U,11)
 S LRLLOC("TY")=$S('$L(LRLLOC("TY")):"InPatient","WI"[LRLLOC("TY"):"InPatient",1:"OutPatient")
 W !?5,LRLLOC("TY")
 I $L($G(^LRO(68,LRAA,1,LRH(2)_"0000",1,LRAN,.3))) W ?29,"UID: ",^(.3)
 D
 . N IEN,LRENC,LRX,LRSTR,X,Y
 . Q:'$G(^LRO(68,LRAA,1,LRH(2)_"0000",1,LRAN,"PCE"))  S LRSTR=^("PCE")
 . F IEN=1:1 S LRX=$P(LRSTR,";",IEN) Q:'LRX  D GETCPT^PXAPIOE(LRX,"LRENC","ERR")
 . Q:'$O(LRENC(0))  W !,"CPT Code: " S IEN=0 F  S IEN=$O(LRENC(IEN)) Q:'IEN  W $P(LRENC(IEN),U)_"X"_$P(LRENC(IEN),U,16)_" " W:$X>70 !
 I "SPCYEM"[LRSS W !,"Date specimen taken:",LRSPDT I $D(^LRO(68,LRAA,1,LRW,1,LRAN,0)) S Y=$P(^(0),"^",10) I Y,$D(^VA(200,Y,0)) W ?37,"Entered  by:",$P(^(0),"^")
 I P(13)]"" W !?37,"Released by:",P(13)
 S Y=+$G(^LRO(68,LRAA,1,LRH(2)_"0000",1,LRAN,.4)) I Y,Y'=DUZ(2) W !,$P($G(^DIC(4,Y,0)),U)
 I LRSS="AU" S DA=LRDFN D D^LRAUAW S Y=LR(63,12) D D^LRU W !?14,"Date died: ",Y,?49,"Path resident:",?64,P(9) D AS
 I "CYEMSP"[LRSS F Z=0:0 S Z=$O(^LR(LRDFN,LRSS,LRI,.1,Z)) Q:'Z  D:$Y>(IOSL-6) H1 Q:LR("Q")  W !?2 S Z(1)=$P(^LR(LRDFN,LRSS,LRI,.1,Z,0),"^") W:$L(Z(1))<61 ?14 W Z(1)
 Q:LR("Q")  I $D(LRB),"CYEMSP"[LRSS,$D(^LR(LRDFN,LRSS,LRI,2,0)) D:$Y>(IOSL-6) H1 Q:LR("Q")  W !?14,"SNOMED codes:" D ^LRAPBK1
 Q:LR("Q")  I $D(LRB),LRSS="AU",$O(^LR(LRDFN,"AY",0)) D:$Y>(IOSL-6) H1 Q:LR("Q")  W !?14,"SNOMED codes:" D AU^LRAPBK1
 I LRSS'="AU" D D Q:LR("Q")
 Q:LR("Q")  W !,LR("%") Q
D F Z(1)=99,97 Q:LR("Q")  S Z=0 F  S Z=$O(^LR(LRDFN,LRSS,LRI,Z(1),Z)) Q:'Z  D:$Y>(IOSL-6) H1 Q:LR("Q")  W !?4,^LR(LRDFN,LRSS,LRI,Z(1),Z,0)
 Q
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,LRO(68)," (",LRABV,") LOG BOOK for ",LRH(0),!
 W "# =Demographic data in file other than PATIENT file"
 W !,"Date",?8,"Num",?14,"Patient",?35,"ID",?40,"LOC",?49,"PHYSICIAN",?67,"PATHOLOGIST",!,LR("%") Q
H1 D H Q:LR("Q")  W !,$J(T,5),?7,$J(LRAN,5),?14 W:P(0)'="PATIENT" "#" W $E(LRP,1,18),?34,SSN(1),?40,$E(LRLLOC,1,8),?49,$E(P(2),1,16),?67,P(1) Q
 ;
S S Y=$P($G(^VA(200,+Y,0)),U) Q
AS I $D(^LRO(68,LRAA,1,LRW,1,LRAN,0)) S Y=$P(^(0),"^",10) D S W ! W:Y]"" ?14,"Entered by: ",Y W:LR("ASST")]"" ?49,"Autopsy Asst: ",LR("ASST")
 Q
END K LRSPDT D V^LRU Q
