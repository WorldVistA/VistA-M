LRAPQAT1 ;AVAMC/REG/CYM- QA CODE SEARCH ;2/12/98  14:31
 ;;5.2;LAB SERVICE;**201,315**;Sep 27, 1994;Build 25
 D EN^LRUA S (LR("W"),LRS(5),LRQ(9),LRQ(3))=1,LRSDT=9999999-LRSDT,LRP=0
 F LRB=0:0 S LRP=$O(^TMP("LRAP",$J,LRP)) Q:LRP=""!(LR("Q"))  F LRDFN=0:0 S LRDFN=$O(^TMP("LRAP",$J,LRP,LRDFN)) Q:'LRDFN!(LR("Q"))  S X=^(LRDFN) D L
 Q
L S DFN=$P(X,"^",2),LRQ=0,SEX=$P(X,"^",4),SSN=$P(X,"^"),Y=$P(X,"^",3) S DOB=$$FMTE^XLFDT(Y)
 G:'$D(^LR(LRDFN,"SP"))&('$D(^LR(LRDFN,"CY")))&('$D(^LR(LRDFN,"EM"))) AU
 D ^LRAPT1 Q:LR("Q")
AU I $D(^LR(LRDFN,"AU")),+^("AU") D ^LRAPT2
 Q:'DFN!(LR("Q"))  D INP^VADPT Q:VAIN(1)']""  D A
 Q
A S LRPTF=VAIN(10)
 S LRADM=$P(VAIN(7),U,2)
 S LRWARD=$P(VAIN(4),U,2)
 S LRTS=$P(VAIN(3),U,2)
 K VAIN
 W !,"Adm: ",$P(LRADM,"@"),?35,LRWARD
 W !,?12,"Specialty: ",$P(LRADM,"@"),?35,LRTS
 Q:'LRPTF
 I $D(^DGPT(LRPTF,70)),$P(^(70),"^",10) S W=^(70) F X=10,11,16:1:24 I $P(W,"^",X) S LRF($P(W,"^",X))=""
 F Y=0:0 S Y=$O(^DGPT(LRPTF,"M",Y)) Q:'Y  S W=^(Y,0) F X=5:1:9,11:1:15 I $P(W,"^",X) S LRF($P(W,"^",X))=""
 I $D(^DGPT(LRPTF,"401P")) S W=^("401P") F X=1:1:5 I $P(W,"^",X) S LRC($P(W,"^",X))=""
 F Y=0:0 S Y=$O(^DGPT(LRPTF,"P",Y)) Q:'Y  S W=^(Y,0) F X=5:1:9 I $P(W,"^",X) S LRC($P(W,"^",X))=""
 F Y=0:0 S Y=$O(^DGPT(LRPTF,"S",Y)) Q:'Y  S W=^(Y,0) F X=8:1:12 I $P(W,"^",X) S LRC($P(W,"^",X))=""
 N LRTMP,LRX
 F LRTMP=0:0 S LRTMP=$O(LRF(LRTMP)) Q:'LRTMP  D
 . S LRX=$$ICDDX^ICDCODE(LRTMP,,,1)
 . I +LRX=-1 Q
 . W !,$P(LRX,"^",2),?10,$P(LRX,"^",4)
 . Q
 F LRTMP=0:0 S LRTMP=$O(LRC(LRTMP)) Q:'LRTMP  D
 . S LRX=$$ICDOP^ICDCODE(LRTMP,,,1)
 . I +LRX=-1 Q
 . W !,$P(LRX,"^",2),?10,$P(LRX,"^",5)
 . Q
 Q
