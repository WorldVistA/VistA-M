LRBLPX ;AVAMC/REG/CYM - XMATCH RESULTS ;08/20/2001 3:45 PM
 ;;5.2;LAB SERVICE;**72,77,247,275,408**;Sep 27, 1994;Build 8
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 Q  D V^LRU,CK^LRBLPUS G:Y=-1 END
 S LRB=$O(^LAB(61.3,"C",50710,0)) I 'LRB D EN1^LRBLU
 W !!?28,"Enter crossmatch results",!!?28,LRAA(4) K LRDPAF S LRW=$P(^VA(200,DUZ,0),"^",2)
 I LRCAPA D CK^LRBLPX1 I '$D(LRT) D END Q
ASK W ! K ^TMP($J),LRZ,LRV,DIC D ^LRDPA K DIC,DIE,DR G:LRDFN=-1 END D R G ASK
 ;
R S X=^LR(LRDFN,0),LRDPF=$P(X,U,2),LRPABO=$P(X,"^",5),LRPRH=$P(X,"^",6),LRP=PNM W !,LRP," ",SSN(1),?37,$J(LRPABO,2),?40,LRPRH D AB
 S LRV=0 F E=0:0 S E=$O(^LR(LRDFN,1.8,E)) Q:'E  F B=0:0 S B=$O(^LR(LRDFN,1.8,E,1,B)) Q:'B  S X=^(B,0) D S
 I 'LRV W $C(7),!,"No units currently selected for XMATCH",! Q
 I LRV=1 G E
SEL W !!,"Select units (1-",LRV,") to enter XMATCH results: " R X:DTIME Q:X=""!(X[U)  I X["?" W !,"Enter numbers from 1-",LRV,!,"For 2 or more selections separate each with a ',' (ex. 1,3,4 )",!,"Enter 'ALL' for all units." G SEL
 G:X="ALL" ALL
 I X?.E1CA.E!($L(X)>200) W $C(7),!,"No CONTROL CHARACTERS, LETTERS or more than 200 characters allowed." G SEL
 I '+X W $C(7),!,"START with a NUMBER !!",! G SEL
 S LRQ=X F LRA=0:0 S LRV=+LRQ,LRQ=$E(LRQ,$L(LRV)+2,$L(LRQ)) D:$D(^TMP($J,LRV)) E Q:'$L(LRQ)
 Q
S S X(1)=+$P(X,"^",2) I '$D(^LR(LRDFN,LRSS,X(1),0)) K ^LR(LRDFN,1.8,E,1,B) S X=^LR(LRDFN,1.8,E,1,0),X(1)=$O(^(0)),^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_($P(X,"^",4)-1) Q
 S LRV=LRV+1,(LRJ,^TMP($J,LRV))=^LR(LRDFN,1.8,E,1,B,0)_"^"_E D:LRV#20=0 M D ^LRBLPX1
 Q
E W !! S LRJ=^TMP($J,LRV),LRR="",(LRI,DA(2))=+LRJ,DA=$P(LRJ,"^",2),LRC=$P(LRJ,"^",3),DIE="^LRD(65,LRI,2,LRDFN,1,",DA(1)=LRDFN
 ;
 ; LR*5.2*275 - Specific Requirement 6 from SRS
 ; BNT - Modified DR string below to only set the .05, .09, and 3 fields
 ;       if data is entered in the .04 field.
 ;       Also moved it down two lines just prior to the DIE call.
 K F D EN^LRBLPX1 Q:$D(F(2))  I $D(F(1)) W !!?4,"Sorry, must have ABO/Rh results to enter XMATCH results" Q
 I $D(F(6)) W !!?4,"Antibody screen results not entered.  OK to continue " S %=2 D YN^LRU Q:%'=1
 S DR=".04;S LRR=X;S:LRR="""" Y=0;.05////^S X=DUZ;.09///NOW;D:LRR=""IG"" IG^LRBLPX;3"
 D ^DIE I $D(^LRD(65,LRI,2,LRDFN,1,+DA,0))#2 S LRAD=^(0) S:$P(LRAD,"^",10)]"" $P(^(0),"^",10)=""
 K DIE,DR,DA I $G(Y)>0!(LRR="") S DIE="^LRD(65,LRI,2,",DA=LRDFN,DA(1)=LRI,DR=".02///@" D ^DIE K DIE Q
 I LRR'="C",LRR'="IG",'$P(^LRD(65,LRI,2,LRDFN,0),"^",2) G K
 S DIE="^LRD(65,LRI,2,",DA=LRDFN,DA(1)=LRI,DR=$S(LRR="C"!(LRR="IG"):".02//^S X=""NOW""",1:".02///@") D ^DIE Q:$D(Y)  S LRK=$P(^LRD(65,LRI,2,LRDFN,0),"^",2) I 'LRK S X="N",%DT="T" D ^%DT S LRK=Y
 S LRAN=$P($P(LRAD,"^",6)," ",3),LRAD=$P($P(LRAD,"^"),".") I LRCAPA,LRAN,LRAD S X=$P(^LRO(68,LRAA,0),"^",3),LRAD=$S(X="D":LRAD,X="Y":$E(LRAD,1,3)_"0000",X="M":$E(LRAD,1,5)_"00",1:LRAD) D STF^LRBLPX1
K L +^LR(LRDFN,1.8):5 I '$T W $C(7),!!,"I can't finish this. Someone else is editing this record" Q
 K ^LR(LRDFN,1.8,LRC,1,LRI) S X=^LR(LRDFN,1.8,LRC,1,0),X(1)=$O(^(0)),^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_$S(X(1)="":"",1:($P(X,"^",4)-1)) L -^LR(LRDFN,1.8)
 I $D(^LRD(65,"AP",LRDFN,LRI)) D LBL
 Q
 ;
LBL S X=^LRD(65,LRI,0),Y(7)=$P(X,"^",7),Y(8)=$P(X,"^",8),Y=$P(^(2,LRDFN,0),"^",2) D DT^LRU
 S Y(1)=$P(X,"^")_"^"_LRP_" "_SSN_"^"_"Patient "_LRPABO_" "_LRPRH_" "_Y_"^"_"Unit    "_Y(7)_" "_Y(8)_" # "_$P(X,"^")
 S X=^LRD(65,LRI,2,LRDFN,1,$P(LRJ,"^",2),0),Y(5)=$P(X,"^",5),Y(5)=$S(Y(5)="":"",$D(^VA(200,Y(5),0)):$P(^(0),"^",2),1:Y(5)),X=$P(X,"^",4),X=$$EXTERNAL^DILFD(65.02,.04,"",X),Y(1)=Y(1)_"   "_Y(5)_"^"_X
EN ;from LRBLPUS2
 S:'$D(^LRO(69.2,LRAA,9,0)) ^(0)="^69.25A^^" L +^LRO(69.2,LRAA,9):5 I '$T W $C(7),!!,"I won't be able to make this CAUTION TAG now.  Someone else is using that function",! Q
 S K=^LRO(69.2,LRAA,9,0),K(3)=$P(K,"^",3) F X=0:0 S K(3)=K(3)+1 Q:'$D(^LRO(69.2,LRAA,9,K(3)))
 S ^LRO(69.2,LRAA,9,0)=$P(K,"^",1,2)_"^"_K(3)_"^"_($P(K,"^",4)+1)
 S ^LRO(69.2,LRAA,9,K(3),0)=Y(1) L -^LRO(69.2,LRAA,9) Q
 ;
IG I '$D(^XUSEC("LRBLSUPER",DUZ)) W $C(7),!,"SORRY YOU DO NOT HAVE THE APPROPRIATE SECURITY",!,"TO ALLOW THIS UNIT TO BE ASSIGNED",! S LRR="" Q
 R !!,"ENTER YOUR INITIALS TO ALLOW ASSIGNING UNIT: ",X(1):DTIME I X(1)'=LRW W $C(7),!,"NOT YOUR INITIALS !",! S LRR="" Q
 Q
ALL F LRV=0:0 S LRV=$O(^TMP($J,LRV)) Q:'LRV  D E
 Q
M R !,"Press RETURN",X:DTIME W $C(13),$J("",15),$C(13) Q
AB K R S A=0 F B=0:1 S A=$O(^LR(LRDFN,1.7,A)) Q:'A  S X=^LAB(61.3,A,0) S:$P(X,"^",4) R($P(X,"^",4))=$P(X,"^")
 Q
END D V^LRU W !!,"Do you want to print caution tag labels " S %=1 D YN^LRU Q:%'=1  G ^LRBLJLA
