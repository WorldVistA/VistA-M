LRBLDPA2 ;AVAMC/REG/CYM - BLOOD DONOR PRINT  6/26/96  20:57 ;
 ;;5.2;LAB SERVICE;**72,247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 S Y=$P(LRZ,U,2) D D^LRU W !,"COLLECTION STARTED: ",Y S Y=$P(LRZ,U,3) D D^LRU W ?40,"COMPLETED: ",Y
 S Y=$P(LRZ,U,4) D D^LRU W !?9,"PROCESSED: ",Y,?40,"COLLECTION WT(gm): ",$P(LRZ,U,5)
 W !,"EMPTY PRIMARY UNIT(gm): ",$P(LRZ,U,6),?40,"COLLECTION VOL(ml): ",$P(LRZ,U,7)
 S X=+$P(LRZ,U,8) D V^LRBLDPA1 W !,"PROCESSING TECH: ",X
 W:$P(LRX,U,5)]"" !,"PATIENT CREDIT: ",$P(LRX,U,5) W:$P(LRX,U,9)]"" !,"PHLEBOTOMIST: ",$P(LRX,U,9)
 S X=$P(LRX,U,10),Z=6.1 D S^LRBLDPA1 W !,"COLLECTION DISPOSITION: ",Y
 S C=0 F E=1:1 S C=$O(^LRE(LR,5,A,3,C)) Q:'C!(LR("Q"))  S LRA=^(C,0) D M^LRBLDPA1 Q:LR("Q")  W:E=1 !,"COLLECTION DISPOSITION COMMENT:" W !?3,LRA
 D M^LRBLDPA1 Q:LR("Q")  S I=$S($D(^LRE(LR,5,A,10)):^(10),1:"") S X=$P(I,U),Z=10 D S^LRBLDPA1 W !,"ABO INTERPRETATION: ",Y S X=+$P(I,U,2) D V^LRBLDPA1 W ?40,"TECH: ",X I $P(I,U,3)]"" W !,$P(I,U,3)
 I $P(I,U,4)]"" S X=$P(I,U,4),Z=10.4 D S^LRBLDPA1 W !,"ABO RECHECK: ",Y S X=+$P(I,U,5) D V^LRBLDPA1 W ?40,"RECHECH TECH: ",X I $P(I,U,6)]"" W !,$P(I,U,6)
 D M^LRBLDPA1 Q:LR("Q")  S I=$S($D(^LRE(LR,5,A,11)):^(11),1:"") S X=$P(I,U),Z=11 D S^LRBLDPA1 W !,"RH  INTERPRETATION: ",Y S X=+$P(I,U,2) D V^LRBLDPA1 W ?40,"TECH: ",X I $P(I,U,3)]"" W !,$P(I,U,3)
 I $P(I,U,4)]"" S X=$P(I,U,4),Z=11.4 D S^LRBLDPA1 W !,"RH RECHECK: ",Y S X=+$P(I,U,5) D V^LRBLDPA1 W ?40,"RECHECH TECH: ",X I $P(I,U,6)]"" W !,$P(I,U,6)
 F LRZ=12:1:20 D T Q:LR("Q")
 Q:LR("Q")  S LRF=65.66,C=0 F E=1:1 S C=$O(^LRE(LR,5,A,66,C)) Q:'C!(LR("Q"))  S LRA=^(C,0) D M^LRBLDPA1 Q:LR("Q")  W:E=1 !!,"COMPONENT PREPARED:" S X=+LRA W !?3,$S($D(^LAB(66,X,0)):$P(^(0),U),1:X) D R
 Q
T D M^LRBLDPA1 Q:LR("Q")
 S I=$S($D(^LRE(LR,5,A,LRZ)):^(LRZ),1:"") S X=$P(I,U),Z=LRZ D S^LRBLDPA1 D FIELD^DID(65.54,LRZ,"","LABEL","NAME") S NAME=NAME("LABEL") W !,NAME,": ",Y
 S X=+$P(I,U,2) D V^LRBLDPA1 W ?40,"TECH: ",X
 I $P(I,U,3)]"" D FIELD^DID(65.54,LRZ_.3,"","LABEL","NAME") S NAME=NAME("LABEL") W !,NAME,": ",$P(I,U,3)
 Q
R S Y=$P(LRA,U,2) D D^LRU W ?40,"DISPOSITION DATE: ",Y S Y=$P(LRA,U,3) D D^LRU W !,"DATE STORED: ",Y S Y=$P(LRA,U,4) D D^LRU W ?40,"EXPIRATION  DATE: ",Y
 W !,"COMPONENT VOL(ml): ",$P(LRA,U,5) S X=+$P(LRA,U,6) D V^LRBLDPA1 W ?40,"LABELING TECH:",X
 S X=+$P(LRA,U,7) D V^LRBLDPA1 W !,"DISPOSITION TECH:",X S X=$P(LRA,U,8),Z=.08 D S^LRBLDPA1 W ?40,"DISPOSITION: ",Y
 S F=0 F G=1:1 S F=$O(^LRE(LR,5,A,66,C,1,F)) Q:'F!(LR("Q"))  S LRB=^(F,0) D M^LRBLDPA1 Q:LR("Q")  W:G=1 !,"COMPONENT DISPOSITION COMMENT:" W !,LRB
 Q
A ;donor antigen list from LRBLDPA1
 S E=1,(F(1),G)="" F V=1.1,1.3 F B=0:0 S B=$O(^LRE(LR,V,B)) Q:'B  S I=$P(^LAB(61.3,B,0),"^"),F(E)=F(E)_I_", ",G=G+1 I $L(F(E))>39 S F(E)=$P(F(E),", ",1,G-1),E=E+1,F(E)=I_", ",G=""
 S K=E,E=1,(J(1),G)="" F V=1.2,1.4 F B=0:0 S B=$O(^LRE(LR,V,B)) Q:'B  S I=$P(^LAB(61.3,B,0),"^"),J(E)=J(E)_I_", ",G=G+1 I $L(J(E))>39 S J(E)=$P(J(E),", ",1,G-1),E=E+1,J(E)=I_", ",G=""
 I $L(F(1))!($L(J(1))) W !,"Antigen(s)  present",?40,"| Antigen(s) absent",! S:E>K K=E F E=1:1:K W:E>1 ! S X=$S($D(F(E)):F(E),1:"") D:X]"" C W ?40,"|" S X=$S($D(J(E)):J(E),1:"") D:X]"" C
 Q:LR("Q")  W ! F A=1.1,1.2,1.3,1.4 D L Q:LR("Q")
 Q:LR("Q")  S X=$P(LRX,U,15) I X]"" S Z=6.5,LRF=65.5 D S^LRBLDPA1 W !,"CMV ANTIBODY: ",Y
 Q
C S Y=$L(X) I $E(X,Y-1,Y)=", " S X=$E(X,1,Y-2)
 W X Q
L S B=0 F C=1:1 S B=$O(^LRE(LR,A,B)) Q:'B!(LR("Q"))  S LRB=^(B,0) I $P(LRB,U,2)]"" D:$Y>(IOSL-6) H^LRBLDPA1 Q:LR("Q")  W !?3,$P(^LAB(61.3,B,0),U) W:$P(LRB,U,2)]"" !?5,$P(LRB,U,2)
 Q
P S X=^LR(X,0),Y=$P(X,U,3),X=^DIC($P(X,"^",2),0,"GL"),X=@(X_Y_",0)") Q
