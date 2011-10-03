LRBLDRR ;AVAMC/REG/CYM - REVIEW/RELEASE COMPONENTS ;1/24/97  11:04 ;
 ;;5.2;LAB SERVICE;**72,90,97,247,408**;Sep 27, 1994;Build 8
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 Q  D E S LR("M")=1,X="BLOOD BANK" D ^LRUTL G:Y=-1 E D D^LRBLU G:'$D(X) E
 I LRCAPA S X="DONOR UNIT LABELING" D X^LRUWK G:'$D(X) E S Y="RR" D S^LRBLWD K LRT S X="UNIT LOG-IN/SEND-OUT" D X^LRUWK G:'$D(X) E
 S LRA=$S($D(^LAB(69.9,1,8,1,0)):$P(^(0),"^",2),1:0),Y="LG" D:LRCAPA S^LRBLWD
 W !!?20,"Review-label-release components",!!?20,LRAA(4),! D BAR^LRBLB I LR W !!?15,"STANDARD UNIT ID LABELING " S %=1 D YN^LRU G:%<1 E S LR(3)=$S(%=1:"",1:1)
 F A=1,6.1,10:1:16,18,19 D
 . D FIELD^DID(65.54,A,"","POINTER","LRB") S LRB(A)=LRB("POINTER")
 . D FIELD^DID(65.54,A,"","LABEL","LRN") S LRN(A)=LRN("LABEL")
 F A=17,20 I $G(LRH(A)) D
 . D FIELD^DID(65.54,A,"","POINTER","LRB") S LRB(A)=LRB("POINTER")
 . D FIELD^DID(65.54,A,"","LABEL","LRN") S LRN(A)=LRN("LABEL")
P R !!,"Select UNIT FOR LABEL/RELEASE: ",X:DTIME I LR D U^LRBLB
 W ! S DIC="^LRE(",DIC(0)="FQMZ",D="C^B" D MIX^DIC1 K DIC G E:X[U!(X=""),P:Y<1 S LRQ(5)=$P(Y(0),"^",5),LRQ(6)=$P(Y(0),"^",6),LRQ("X")=0
 I X["," D ASK G:Y<1 P D REST G P
 S LRQ=+Y,LRI=$O(^LRE("C",X,LRQ,0)) G:'LRI P L +^LRE(LRQ,5,LRI):5 I '$T W !,$C(7),"Someone else is editing this entry! " G P
 S LRG=$P(^LRE(LRQ,5,LRI,0),"^",4) D REST G P
 ;
S S F=^LAB(66,A,0),Y=$P(X,"^",3) D D^LRU S S=Y,Y=$P(X,"^",4) D D^LRU
 S F(B)=$P(X,"^",2)_"^"_$P(X,"^",6)_"^"_$P(X,"^",7)_"^"_$E($P(F,"^"),1,21)_"^"_S_"^"_Y_"^"_A_"^"_$P(F,"^",9)_"^"_$P(X,"^",8)_"^"_$P(F,"^",19) Q
 ;
REST S LRV=$P(^LRE(LRQ,0),"^",15),X=^(5,LRI,0),LRQ("S")=$P(X,"^",11),LRQ("D")=$P(X,"^",12),T=$S($D(^(2)):$P(^(2),"^",3),1:"") F A=10,11 S LRJ(A+.4)=$S($D(^(A)):$P(^(A),"^",4),1:"")
 F A=10:1:20 S (LRJ(A),LRE(A),LRW(A))=""
 F A=10:1:16,18,19 I $D(^LRE(LRQ,5,LRI,A)) S B=^(A),LRJ(A)=$P(B,"^"),LRW(A)=$P(B,"^",3),LRE(A)=$P(B,"^",2)
 F A=17,20 I $G(LRH(A)),$D(^LRE(LRQ,5,LRI,A)) S B=^(A),LRJ(A)=$P(B,U),LRW(A)=$P(B,U,3),LRE(A)=$P(B,U,2)
 S V=$P(X,"^",10),V(10)=LRJ(10),V(11)=LRJ(11),V(12)=V(10)_" "_V(11),LRJ(1)=$P(X,"^",2),(W,LRJ(6.1))=$P(X,"^",10)
 F A=1,6.1,10:1:16,18,19 S X=LRJ(A),B=LRB(A),X=$S(X]"":$P($P(B,X_":",2),";"),1:"") S LRJ(A)=X
 F A=17,20 I $G(LRH(A)) S X=LRJ(A),B=LRB(A),X=$S(X]"":$P($P(B,X_":",2),";"),1:"") S LRJ(A)=X
 W @IOF I LRQ("S")]"","AD"[LRQ("S") W $C(7)
 W $S(LRQ("S")="A":"AUTOLOGOUS ",LRQ("S")="D":"DIRECTED ",1:" ") I LRQ("D") W "For: " S X=^LR(LRQ("D"),0),Y=$P(X,"^",3),(LRDPF,X)=$P(X,"^",2),X=^DIC(X,0,"GL"),X=@(X_Y_",0)"),SSN=$P(X,"^",9) D SSN^LRU W $P(X,"^")," ",SSN
 W ?53,"Unit: ",LRG
 W !,"Unit testing:",?70,"Tech" F A=10:1:16,18,19 D W
 F A=17,20 I $G(LRH(A)) D W
 I LRJ(10)=""!(LRJ(11)="") W $C(7),!,"Must perform ABO/Rh testing !!",! D FRE^LRBLDRR1 Q
 I LRA S A=0 D EN1^LRBLDRR2 Q:A
 I LRJ(10)'=LRQ(5) W $C(7),!,"Donor ABO (",LRQ(5),") is different from unit ABO (",LRJ(10),"). Resolve discrepancy." S LRD=1
 I $E(LRJ(11),1,3)'=LRQ(6) W $C(7),!,"Donor Rh (",LRQ(6),") is different from unit Rh (",$E(LRJ(11),1,3),").  Resolve discrepancy." S LRD=1
 I $D(LRD),'$D(^XUSEC("LRBLSUPER",DUZ)) D FRE^LRBLDRR1 Q
 I $D(LRD) K LRD D SUPER I $D(LRY) K LRY Q
 K F S A=0 F B=1:1 S A=$O(^LRE(LRQ,5,LRI,66,A)) Q:'A  S X=^(A,0) D S
 I B<2 W $C(7),!!,"No components prepared !",! D FRE^LRBLDRR1 Q
 S Y=T D D^LRU W !!,"Donation: ",LRJ(1),?36,"Collection completed: ",Y,!?5,"Component",?36,"Date/time stored",?58,"Expiration date" S A=0
 F B=0:1 S A=$O(F(A)) Q:'A  S L=$P(F(A),U,9) W !,$J(A,2),".",?5,$P(F(A),U,4),?27,$S(L=2:"Discard",L=1:"Quarant",$P(F(A),U,3)]"":"released",$P(F(A),U,2)]"":"labeled",1:""),?36,$P(F(A),U,5),?58,$P(F(A),U,6)
 I V W $C(7),!!,LRN(6.1),": ",LRJ(6.1) Q
 D ^LRBLDRR1 Q
SUPER W !!,"If you continue with label/release of ",LRG," a message will be",!,"sent to all users holding the blood bank supervisor's key.",!,"Do you want to continue with label/release of ",LRG S %=2 D YN^LRU I %=2 D FRE^LRBLDRR1 S LRY=1 Q
 S LR("TXT",1,0)="Blood donor unit ID: "_LRG,LR("KEY")="LRBLSUPER",LR("SUB")="Donor unit label/release with ABO/Rh discrepancy",LR("TXT",2,0)=" Component(s) have been labeled/released with ABO/Rh donor/unit ID discrepancy"
 D ^LRUMSG Q
ASK S LRQ=+Y,DIC="^LRE(LRQ,5,",DIC(0)="FAEQM",DIC("A")="Select DONATION DATE: " D ^DIC K DIC I X["^"!(X="") S Y=-1 Q
 S LRI=+Y,LRG=$P(^LRE(LRQ,5,LRI,0),U,4) Q
E D V^LRU Q
W W !?5,LRN(A),?36,": ",LRJ(A),?70,$S(LRE(A)="":"",$D(^VA(200,LRE(A),0)):$P(^(0),"^",2),1:LRE(A)) I LRW(A)]"" W !,LRW(A)
 Q
