LRAPWR1 ;AVAMC/REG - STUFF CYTOPATH SCREENED SLIDES ;5/5/93  10:39
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 F LR=0:0 S LR=$O(LR(LR)) Q:'LR  S X=LR(LR),A=$P(X,"^"),E=$P(X,"^",2),B=$P(X,"^",3),LRT=$P(X,"^",4),LRK=$P(X,"^",5),LRX(6)=$P(X,"^",6) D A
 Q
A I LRX(6),LRK D B Q
 I LRT=LRG,'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,LRR)) S LRC=LRR,LRA(1)=$S($D(^LAB(60,LRT,9,LRC,0)):$P(^(0),"^",3),1:1) W !!,"Is this a rescreen of a negative Gyn Pap Smear " S %=2 D YN^LRU Q:%<1  D:%=1 CAP,SET
 Q
B S:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,0)) ^(0)="^68.04PA^^"
 I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,0)) S ^(0)=LRT_"^50^^"_DUZ_"^"_LRK,X=^LRO(68,LRAA,1,LRAD,1,LRAN,4,0),^(0)=$P(X,"^",1,2)_"^"_LRT_"^"_($P(X,"^",4)+1)
 S:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,0)) ^(0)="^68.14P^^"
 S LRF=$S($D(^LAB(60,LRT,0)):$P(^(0),"^",19),1:"") I LRF D CAP1 D:$O(^TMP($J,0)) SET Q
 F LRC=0:0 S LRC=$O(^LAB(60,LRT,9.1,LRC)) Q:'LRC  S LRC(3)=$P(^(LRC,0),"^",3) S:'LRC(3) LRC(3)=1 S LRA(1)=LRC(3)*LRX(6) D CAP
SET S ^LRO(68,"AA",LRAA_"|"_LRAD_"|"_LRAN_"|"_LRT)="" Q
 ;
CAP I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,LRC,0)) S ^(0)=LRC_"^"_LRA(1)_"^0^0^^"_LRK_"^"_DUZ_"^"_DUZ(2)_"^"_LRAA_"^"_LRAA_"^"_LRAA,X=^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,0),^(0)=$P(X,"^",1,2)_"^"_LRC_"^"_($P(X,"^",4)+1) Q
 S X=^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,LRC,0),$P(X,"^",2)=$S($P(X,"^",3):LRA(1),1:$P(X,"^",2)+LRA(1)),$P(X,"^",3)=0,^(0)=X Q
 ;
CAP1 K ^TMP($J) I '$O(^LAB(62.07,LRF,9,0)) W $C(7),!!,"No WKLD CODES to select for ",$P(^LAB(62.07,LRF,0),U)," in EXECUTE CODE file." Q
 I $P(^LAB(62.07,LRF,0),"^")="PAP STAIN" D CK Q:'$D(Y)
 F LRA=0:0 S DIC="^LAB(62.07,LRF,9,",DIC(0)="AEQM",DIC("A")="Select "_$P(^LAB(62.07,LRF,0),U)_" WKLD CODES: " D ^DIC K DIC Q:Y<1  S ^TMP($J,+Y)=LRX(6)
 I '$D(^TMP($J)) W $C(7),!,"No WKLD CODES selected." Q
 W !!,"Count  WKLD CODES Selected: " F A=0:0 S A=$O(^TMP($J,A)) Q:'A  S B=^(A),X=^LAM(A,0) W !,$J(B,2),?6,$P(X,U,2),?16,$P(X,U)
 W !,"WKLD CODES selected OK " S %=1 D YN^LRU Q:%<1  I %'=1 W !!,$C(7),"No WKLD codes selected.  Try again." G CAP1
 F LRC=0:0 S LRC=$O(^TMP($J,LRC)) Q:'LRC  S LRA(1)=^(LRC) D CAP
 Q
CK S X=$S($D(^LR(LRDFN,LRSS,LRI,2,0)):$P(^(0),"^",4),1:0) I X'=1 S Y=1 Q
 S X=$O(^LR(LRDFN,LRSS,LRI,2,0)) I 'X S Y=1 Q
 S LRC="" F A=0:0 S A=$O(^LR(LRDFN,LRSS,LRI,2,X,2,A)) Q:'A  S Y=+^(A,0),LRC=$S($D(LRF(Y)):LRF(Y),1:"") Q:LRC
 I 'LRC S Y=1 Q
 S LRA(1)=LRX(6) D CAP,SET K Y Q
 ;
CY S X="PAP STAIN, GYN" D X^LRUWK S LRG=LRT K LRT I '$D(X) S Y=-1 Q
 S Y=1,LRA=$O(^LAM("E","88580.0000",0)),LRN=$O(^LAM("E","88578.0000",0)),LRR=$O(^LAM("E","88596.0000",0))
 I 'LRA!('LRN)!('LRR) W $C(7),!,"WKLD Codes 88580.000, 88578.000 and 88596.000 must be entered in WKLD CODE File (#64)." S Y=-1 Q
 F X=80013,69760,"09460","09010" S Z=$O(^LAB(61.1,"C",X,0)) S:Z LRF(Z)=$S("8001369760"[X:LRA,1:LRN) I 'Z W $C(7),!,"No entry in MORPHOLOGY File (#61.1) for SNOMED code: ",X S Y=-1
 Q
