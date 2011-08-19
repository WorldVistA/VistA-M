LRMIBUG ;AVAMC/REG,SLC/CJS,BA- DISPLAY ORGANISMS ;6/5/89  09:21 ;
 ;;5.2;LAB SERVICE;**318,321,339**;Sep 27, 1994
BUGS Q:$G(LREND)  D KVAR^VADPT S LR1PASS=1 F I=0:0 D BUGIN Q:Y<1  S LRBG1=Y(0) D:$P(Y,U,3)&($P(LRPARAM,U,14))&($P($G(^LRO(68,LRAA,0)),U,16)) ETIO^LRCAPV1 D BUGGER,BUGOUT
 D BUGOUT K LR1PASS,LRBG,LRBI,LRBG1
 Q
BUGIN S DIC=DIC_DA_",3,",LRODA=DA,LRODIE=DIE,DA(1)=DA,DA(2)=LRDFN,DIC(0)="AEFLMOQZ",DIC("S")="I 1 Q:$D(^LR(DA(2),""MI"",DA(1),3,+X))  Q:'$D(^LAB(61.2,+X,0))  I $L($P(^(0),U,5)),""PVRBFM""[$P(^(0),U,5)"
 S:'$D(@(DIC_"0)")) ^(0)="^63.3PA" S LRSPEC=$P(^LR(LRDFN,"MI",LRIDT,0),U,5)
 W ! S LRBG=0 F I=0:0 S LRBG=$O(^LR(LRDFN,"MI",DA,3,LRBG)) Q:LRBG<1  S LRBUG=+^(LRBG,0) K DIC("B") S:LRBG=1&LR1PASS DIC("B")=$P(^LAB(61.2,+^LR(LRDFN,"MI",DA,3,1,0),0),U) W !?2,LRBG,?5,$P(^LAB(61.2,LRBUG,0),U)
 S DLAYGO=63 D ^DIC K DIC("B"),DIC("S"),DLAYGO S LR1PASS=0
 Q
BUGGER S LRNB=$S($L($P(^LAB(61.2,+LRBG1,0),U,4)):$P(^(0),U,4),1:LRMIDEF),LRBI=$P(^(0),U,5)
 N LRTHISDA
 S DIE=DIC,DA=+Y,LRTHISDA=DA D TEMP,^DIE,DELINT I '$D(Y) Q
 W !,"Any other antibiotics" S %=2 D YN^DICN I %'=1 Q
 I '$L(LRMIOTH) S DR="S Y=200;2.0000001:200",DR(2,63.32)=.01 D ^DIE Q
 K DR S LRNB=LRMIOTH D TEMP F J=1:1 S K=$P(DR,";",J) Q:+K'=K!(K>2)!'$L(K)
 S (DR,DR(1,63.3))=$P(DR,";",J,245) D ^DIE
 Q
TEMP S LRNB=+$O(^DIE("B",$S($L(LRNB):LRNB,1:0),0))
 I LRNB,$D(^DIE(LRNB,"DR",3,63.3)) S (DR,DR(1,63.3))=^(63.3),J=0 F I=0:0 S J=$O(^DIE(LRNB,"DR",3,63.3,J)) Q:J<1  S DR(1,63.3,J)=^(J)
 I 'LRNB!('$D(^DIE(LRNB,"DR",3,63.3))) S DR=$S(($L(LRBI)&("MFBVRP"[LRBI)):".01;1;2",1:".01;1;2:195")
 Q
BUGOUT S (DIE,DIC)=LRODIE,DA=LRODA,DA(1)=LRDFN K DR(1,63.3)
 Q
DELINT ; If a Result is (1st piece) deleted in ^LR(LRDFN,"MI",LRIDT,3
 ; the associated Interpretation (2nd piece) should be deleted
 ; as well. If S^S^ exists, and the Result is deleted, ^S^ Interpretation remains.
 ; This process will clean up the remaining Interpretation 
 Q:'LRDFN!('LRIDT)!('LRTHISDA)
 N LRXX,I
 S LRXX=2 ;This node bumps in fractions exp. 2.001 2.00234
 F I=1:1 S LRXX=$O(^LR(LRDFN,"MI",LRIDT,3,LRTHISDA,LRXX)) Q:'LRXX!(LRXX'<3)  D
 .I $P(^LR(LRDFN,"MI",LRIDT,3,LRTHISDA,LRXX),U)="" S $P(^LR(LRDFN,"MI",LRIDT,3,LRTHISDA,LRXX),U,2)=""
 Q
