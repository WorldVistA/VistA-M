LRBLJED ;AVAMC/REG/CYM - BB INVENTORY EDIT 3/3/97  13:20 ;
 ;;5.2;LAB SERVICE;**72,90,247,408**;Sep 27, 1994;Build 8
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 ;
D Q  D G G:Y<1 END D CK^LRU G:$D(LR("CK")) D S DR="[LRBLIDTM]" D ^DIE D FRE^LRU D:$D(LRT) FX G D
E Q  D G G:Y<1 END D CK^LRU G:$D(LR("CK")) E S DR="[LRBLIXR]" D ^DIE D FRE^LRU G E
L Q  D G G:Y<1 END D CK^LRU G:$D(LR("CK")) L S LR(0)=$P(Y,U,2),LR(4)=$P(Y(0),U,4) W !!,LR(0),"// " R X:DTIME G L:X[U!('$T),DIE:X="" I X'="@" X $P(^DD(65,.01,0),U,5,99) I '$D(X) W !,$C(7),$G(^DD(65,.01,3)) X:$D(^(4)) ^(4) G L
 S LR(1)=DA I X="@" W $C(7),!?3,"SURE YOU WANT TO DELETE THE ENTIRE '",LR(0),"' BLOOD INVENTORY" S %=2 D YN^LRU G:%'=1 L I %=1 S O=LR(0),X="Deleted",Z="65,.01" D EN^LRUD S LR="@",DR=".01///^S X=LR" D ^DIE G L
 D W G:'$D(X) L S LR=X,DR=".01///^S X=LR" D ^DIE S O=LR(0),Z="65,.01" D EN^LRUD
DIE S DR="[LRBLILG]" D ^DIE I $D(DA),$P(^LRD(65,DA,0),U)'=LR(65,.01) D KK^LRBLU
 D FRE^LRU G L
 ;
G D END S X="BLOOD BANK",LRAA(2)="BB" D BB^LRUTL
 S DIC=68,DIC(0)="MOXZ" I X="" S DIC(0)="AEMQZ"
 D ^DIC K DIC S LRAA=+Y
 W ! S (DIC,DIE)="^LRD(65,",DIC(0)="AEFQMZ",DIC("S")="I $P(^(0),U,16)=DUZ(2)" D ^DIC K DIC Q:Y<1
 S (DA,LR("UNIT"))=+Y,LR(65,.01)=$P(Y,U,2),X=$P(^VA(200,DUZ,0),"^",2) D C^LRUA S LRWHO=X Q
 ;
FX Q:'$D(^LRD(65,DA,6))  S T(9)="",T=LRT,T(1)=LRT(1),W=^(0),X=^(6),T(3)="",T(4)=$P(X,"^",4),T(5)=$P(X,"^",5),T(11)=$P(X,"^",8) I T,T(4),$D(^LR(T,1.6,T(4),0)) S T(0)=^(0),T(9)=$P(T(0),U,9) D KL
 Q:'T(1)  S:'$D(^LR(T(1),1.6,0)) ^(0)="^63.017DAI^^" S:$D(^LRD(65,DA,9,0)) T(3)=$P(^(0),"^",4) L +^LR(T(1),1.6):5 I '$T W !,"I can't do this right now.  Someone else is editing this record.  " Q
FC I $D(^LR(T(1),1.6,LRI)) S LRI=LRI-.00001 G FC
 S T(10)=$P(^LRD(65,DA,0),"^",11)
 S ^LR(T(1),1.6,LRI,0)=LRQ_"^"_$P(W,"^",4)_"^"_$P(W,"^")_"^"_DUZ_"^"_$P(W,"^",7)_"^"_$P(W,"^",8)_"^"_T(3)_"^"_T(5)_"^"_T(9)_"^"_T(10)_"^"_T(11),X=^LR(T(1),1.6,0),^(0)=$P(X,"^",1,2)_"^"_LRI_"^"_($P(X,"^",4)+1) L -^LR(T(1),1.6)
 I T(11) S ^LR("AB",T(1),T(11),LRI)=""
 S $P(^LRD(65,DA,6),"^",4)=LRI S E=0 F A=1:1 S E=$O(^LRD(65,DA,7,E)) Q:'E  S E(2)=^(E,0),^LR(T(1),1.6,LRI,1,A,0)=E(2)
 S:A>1 ^LR(T(1),1.6,LRI,1,0)="^63.186A^"_(A-1)_"^"_(A-1)
 I LRO(1)'=LRW(9) S LRREC=LRI,LRPTR=T(1) D DISP5^LRBLAUD1 ; Adds patient transfusion record data to the audit trail
 Q
KL L +^LR(T,1.6):5 I '$T W !,"Someone else is editing this entry.  Try again later " Q
 K ^LR(T,1.6,T(4)),^LR("AB",T,+$P(T(0),U,11),T(4)) S X(1)=$O(^LR(T,1.6,0)) S:'X(1) X(1)=0 S X=^LR(T,1.6,0),^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_$S(X(1)=0:X(1),1:($P(X,"^",4)-1)) L -^LR(T,1.6)
 Q
 ;
A Q  D G G:Y<1 END I '$D(^LRD(65,DA,8)) W !?7,"No autologous/directed donor entry for this unit." G A
 S W=^LRD(65,DA,8),(X,LRX)=+(W),W=$P(W,"^",2),W(3)=$S($P(W,"^",3)="A":"Autologous ","D":"Directed ",1:"")_"donation" I 'X W !?7,"Donor unit has been released to stock.",! G A
 I W!(W="") W:W !?7,"One or more screening tests from ",W(3)," are positive." W:W="" !?7,"Not all screening tests completed." W !?7,$C(7),"DELETION NOT ALLOWED !",! G A
 W !,$P(W(3)," ")," donor: " S X=^LR(X,0),(LRDPF,Y)=$P(X,"^",2),X=$P(X,"^",3),Y=^DIC(Y,0,"GL"),X=@(Y_X_",0)"),LRP=$P(X,"^"),SSN=$P(X,"^",9) D SSN^LRU W LRP," ",SSN," OK TO DELETE " S %=1 D YN^LRU Q:%'=1
 S ^LRD(65,DA,8)="^"_W K ^LRD(65,"AU",LRX,DA) Q
 ;
W S X(1)=+$P($G(^LRD(65,DA,0)),"^",4),X(2)=0 F  S X(2)=$O(^LRD(65,"B",X,X(2))) Q:'X(2)  I $P(^LRD(65,X(2),0),"^",4)=X(1) D W1 Q
 Q
W1 W $C(7),!,$P(^LAB(66,$P(^LRD(65,X(2),0),U,4),0),U)," unit already exists in inventory" K X Q
 ;
END D V^LRU Q
