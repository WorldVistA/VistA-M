LRBLDPA1 ;AVAMC/REG/CYM - BLOOD DONOR PRINT  ;7/5/96  20:57 ;
 ;;5.2;LAB SERVICE;**72,247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 N LRDOB,NAME S (X,LRX)=^LRE(LR,0),PNM=$P(X,U),SEX=$P(X,U,2),LRABO=$P(X,U,5),LRRH=$P(X,U,6),SSN=$P(X,U,13),Y=$P(X,U,3) D D^LRU S LRDOB=Y,LRF=65.5,Z=.02,X=SEX D S S SEX=Y
 D H S LR("F")=1 S X=$P(LRX,U,13) W:X]"" !,"SSN: ",X S X=$P(X,U,14) W:X]"" !,"MILITARY RANK: ",X
 K ^TMP($J) S LRE=0 F LRJ=0:1 S LRE=$O(^LRE(LR,9,LRE)) Q:'LRE!(LR("Q"))  S LRA=^(LRE,0) D:$Y>(IOSL-6) H Q:LR("Q")  S X=LRA D ^DIWP
 Q:LR("Q")  D:LRJ ^DIWW Q:LR("Q")  D:$Y>(IOSL-6) H Q:LR("Q")
 S X=$P(LRX,U,10),Z=.1 D S W ! W:X]"" "PERMANENT DEFERRAL: ",Y S X=+$P(LRX,U,12) D V W:X]"" ?29,"DEFERRAL ENTER/EDIT: ",X
 S Y=$P(LRX,U,16) I Y D D^LRU W !,"PERMANENT DEFERRAL DATE CHANGE: ",Y
 K ^TMP($J) S LRE=0 F LRJ=0:1 S LRE=$O(^LRE(LR,99,LRE)) Q:'LRE!(LR("Q"))  S LRA=^(LRE,0) D:$Y>(IOSL-6) H Q:LR("Q")  W:LRJ=0 !,"PERMANENT DEFERRAL REASON:" S X=LRA D ^DIWP
 Q:LR("Q")  D:LRJ ^DIWW Q:LR("Q")  D:$Y>(IOSL-6) H Q:LR("Q")  D A^LRBLDPA2 Q:LR("Q")  D:$Y>(IOSL-6) H Q:LR("Q")
 Q:LR("Q")  K F S LRF=65.53,E=1,(F(1),G)="" F A=0:0 S A=$O(^LRE(LR,4,A)),Z=.01 Q:'A  S X=$P(^LRE(LR,4,A,0),U) D S S F(E)=F(E)_Y_", ",G=G+1 I $L(F(E))>60 S F(E)=$P(F(E),", ",1,G-1),E=E+1,F(E)=Y_", ",G=""
 I F(1)]"" W !!,"SCHEDULING/RECALL: " S X=F(1) D C^LRBLDPA2 I $D(F(2)) W !?19 S X=F(2) D C^LRBLDPA2
 D:$Y>(IOSL-6) H Q:LR("Q")  K F S E=1,(F(1))="" F A=0:0 S A=$O(^LRE(LR,2,A)) Q:'A  S X=A D G S F(E)=X(3),E=E+1
 I F(1)]"" W !,"GROUP AFFILIATION: " F E=0:0 S E=$O(F(E)) Q:'E!(LR("Q"))  D:$Y>(IOSL-6) H1 Q:LR("Q")  W:E>1 ! W ?19,F(E)
 Q:LR("Q")  D:$Y>(IOSL-6) H Q:LR("Q")  S LRF=65.5,X=$P(LRX,U,4),Z=.04 D S W !!?3,"APHERESIS: ",Y,?28,"CUMULATIVE DONATIONS: ",$P(LRX,U,7)
 W !,"TOTAL AWARDS: ",$P(LRX,U,8),?34,"GIVE NEW AWARD: " S X=$S($D(^LRE(LR,3)):$P(^(3),U),1:"") I X]"" S Z=.085 D S W Y
 S X=+$P(LRX,U,9) D V W !?2,"DEMOG EDIT: ",X S Y=$P(LRX,U,11) D D^LRU W ?45,"DATE REG/EDITED: ",Y
 S X=$S($D(^LRE(LR,1)):^(1),1:"") W !!?3,"ADDRESS: ",$P(X,U)," ",$P(X,U,2) S Y=$P(X,U,3) W:Y]"" !?12,Y W !?12,$P(X,U,4),", " S Y=+$P(X,U,5) W $S($D(^DIC(5,Y,0)):$P(^(0),U),1:"")," ",$P(X,U,6)
 D:$Y>(IOSL-6) H Q:LR("Q")  W !,"HOME PHONE: ",$P(X,U,7),?38,"WORK PHONE: ",$P(X,U,8)
 I $D(LRI) S A=LRI,LRF=65.54,LRX=^LRE(LR,5,LRI,0) D W D:LRN=1 ^LRBLDPAW Q
 S A=0 F B=1:1 S A=$O(^LRE(LR,5,A)) Q:'A!(LR("Q"))  S LRF=65.54,LRX=^(A,0) D:$Y>(IOSL-6) H Q:LR("Q")  D W Q:LR("Q")
 Q
W S Y=+LRX D D^LRU S LRY=Y D FIELD^DID(65.54,.01,"","LABEL","NAME") S NAME=NAME("LABEL") W !!,NAME,": ",Y
 S Z=1,X=$P(LRX,U,2) D S W ?40,"DONATION CODE: ",Y S X=+$P(LRX,U,6) D G W !,"COLLECTION SITE: ",X S X=+$P(LRX,U,7) D G W ?40,"DONATION GROUP: ",$E(X,1,24)
 S Y=$P(LRX,U,13) D D^LRU W !,"ARRIVAL/APPT TIME: ",Y,?40,"ENTER/EDIT: " S X=+$P(LRX,U,8) D V W X D M Q:LR("Q")
 I $P(LRX,U,14) S X=$P(LRX,U,14),Z=.14 D S D FIELD^DID(65.54,.14,"","LABEL","NAME") S NAME=NAME("LABEL") W !,NAME,": ",Y
 D M Q:LR("Q")  S X=$P(LRX,U,11),Z=1.1 D S,FIELD^DID(65.54,1.1,"","LABEL","NAME") S NAME=NAME("LABEL") W !,NAME,": ",Y
 S X=$P(LRX,U,12) I X D P^LRBLDPA2 D FIELD^DID(65.54,1.2,"","LABEL","NAME") S NAME=NAME("LABEL") W !,NAME,": ",$P(X,U)," ",$P(X,U,9)
 S X=+$P(LRX,U,3) D G W ?40,"DONOR REACTION: ",X
 S C=0 F E=1:1 S C=$O(^LRE(LR,5,A,1,C)) Q:'C!(LR("Q"))  S LRA=^(C,0) D M Q:LR("Q")  W:E=1 !,"DEFERRAL REASON:" S X=+LRA D G W:X]"" !?3,X(3)
 D M Q:LR("Q")  W:$P(LRX,U,4)]"" !,"UNIT ID: ",$P(LRX,U,4) S LRZ=$S($D(^LRE(LR,5,A,2)):^(2),1:"") Q:LRZ=""  W ?40,"PRIMARY BAG: " S X=$P(LRZ,U,1),Z=4.1 D S W Y
 S X=$P(LRZ,U,9),Z=4.11 D S W !,"ANTICOAGULANT: ",Y,?40,"BAG LOT #: ",$P(LRZ,U,10)
 D ^LRBLDPA2 Q
G S X=$S($D(^LAB(65.4,X,0)):^(0),1:""),X(3)=$P(X,U,3),X=$P(X,U) Q
V S X=$S($D(^VA(200,X,0)):$P(^(0),U),1:"") Q
M S LRM=0 I $Y>(IOSL-6) D H S LRM=1
 Q:LR("Q")  W:LRM !,"DONATION OR DEFERRAL DATE: ",LRY Q
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !," BLOOD DONOR: ",PNM,?45,"DOB: ",LRDOB,!?9,"SEX: ",SEX,?42,"ABO/RH: ",LRABO," ",LRRH,!
 Q
H1 D H Q:LR("Q")  W !!,"GROUP AFFILIATION:" Q
 ;
S I X=":" S (X,Y)="" Q
 S Y=$$EXTERNAL^DILFD(LRF,Z,"",X) Q
