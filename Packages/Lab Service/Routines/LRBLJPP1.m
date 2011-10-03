LRBLJPP1 ;AVAMC/REG - PT ADM,RX SPECIALTY,ICD9CM CODES ;4/17/91  14:31 ;
 ;;5.2;LAB SERVICE;**247,315**;Sep 27, 1994;Build 25
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 ;Reference to ^DGPT is supported by ICR# 418
 ;Reference to ^DGPT is supported by ICR# 2360
 ;Reference to $$ICDDX^ICDCODE Supported by ICR# 3990
 ;Reference to $$ICDOP^ICDCODE Supported by ICR# 3990
 K LRF,LRC S LRA=$O(^DGPM("APID",DFN,0)) Q:'LRA  S LRX=$O(^(LRA,0)) D:$Y>(IOSL-9) H Q:LR("Q")  I LRX,$D(^DGPM(LRX,0)) S X=^(0) I $P(X,"^",14),$D(^DGPM($P(X,"^",14),0)) S LRX=$P(X,"^",14) D A ;MAS
 F LRA=LRA:0 S LRA=$O(^DGPM("APID",DFN,LRA)) Q:'LRA!(LRA>LRSDT)!(LR("Q"))  S LRX=$O(^(LRA,0)) D:$Y>(IOSL-9) H Q:LR("Q")  D:LRX A ;MAS
 Q
A S Y=$S($D(^DGPM(LRX,0)):^(0),1:""),LR=$P(Y,"^",16) W !,"Adm:",+$E(Y,4,5)_"/"_+$E(Y,6,7)_"/"_$E(Y,2,3) S Z=$P(Y,"^",17) I Z S Z=$S($D(^DGPM(Z,0)):+^(0),1:"") W ?13,"Discharge:",+$E(Z,4,5)_"/"_+$E(X,6,7)_"/"_$E(Z,2,3) ;MAS
 S Z=$P(Y,"^",6) I Z,$D(^DIC(42,Z,0)) W ?35,$P(^(0),"^") ;MAS
 S A=0 F B=0:0 S A=$O(^DGPM("ATS",LRX,A)) Q:'A!(LR("Q"))  S C=$O(^(A,0)) D B Q:LR("Q")  ;MAS
 Q:'LR
 I $D(^DGPT(LR,70)),$P(^(70),"^",10) S W=^(70) F X=10,11,16:1:24 I $P(W,"^",X) S LRF($P(W,"^",X))=""
 F Y=0:0 S Y=$O(^DGPT(LR,"M",Y)) Q:'Y  S W=^(Y,0) F X=5:1:9,11:1:15 I $P(W,"^",X) S LRF($P(W,"^",X))=""
 I $D(^DGPT(LR,"401P")) S W=^("401P") F X=1:1:5 I $P(W,"^",X) S LRC($P(W,"^",X))=""
 F Y=0:0 S Y=$O(^DGPT(LR,"P",Y)) Q:'Y  S W=^(Y,0) F X=5:1:9 I $P(W,"^",X) S LRC($P(W,"^",X))=""
 F Y=0:0 S Y=$O(^DGPT(LR,"S",Y)) Q:'Y  S W=^(Y,0) F X=8:1:12 I $P(W,"^",X) S LRC($P(W,"^",X))=""
 N LRTMP,LRX
 F LRTMP=0:0 S LRTMP=$O(LRF(LRTMP)) Q:'LRTMP!(LR("Q"))  D
 . S LRX=$$ICDDX^ICDCODE(LRTMP,,,1)
 . I +LRX=-1 Q
 . D:$Y>(IOSL-9) H Q:LR("Q")
 . W !,$P(LRX,"^",2),?10,$P(LRX,"^",4)
 . Q
 F LRTMP=0:0 S LRTMP=$O(LRC(LRTMP)) Q:'LRTMP!(LR("Q"))  D
 . S LRX=$$ICDOP^ICDCODE(LRTMP,,,1)
 . I +LRX=-1 Q
 . D:$Y>(IOSL-9) H Q:LR("Q")
 . W !,$P(LRX,"^",2),?10,$P(LRX,"^",5)
 . Q
 Q
B I C,$D(^DGPM(C,0)) S LRY=^(0) D:$Y>(IOSL-9) H Q:LR("Q")  S Z=$P(LRY,"^",9) W !?12,"Specialty:",+$E(LRY,4,5)_"/"_+$E(LRY,6,7)_"/"_$E(LRY,2,3) I Z,$D(^DIC(45.7,Z,0)) W ?35,$P(^(0),"^") ;MAS
 Q
H D H1^LRBLJPP Q
