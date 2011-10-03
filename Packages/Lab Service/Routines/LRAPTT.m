LRAPTT ;AVAMC/REG/CYM - TURNAROUND TIME PATH 2/13/98  09:36 ;
 ;;5.2;LAB SERVICE;**1,72,201,397**;Sep 27, 1994;Build 1
 D ^LRAP Q:'$D(Y)
J I LRSS="AU" W !?15,"1. Turnaround time for PAD",!?15,"2. Turnaround time for FAD",!,"Select 1 or 2: " R X:DTIME G:X=""!(X[U) END S LR("AU")=X I X'=1&(X'=2) D H G J
 D B^LRU G:Y<0 END S LRSDT=LRSDT-.01,LRLDT=LRLDT+.99,LRL=0
 W !,"Identify cases exceeding turnaround time limit " S %=2 D YN^LRU I %=1 D T^LRAPTT1 G:X[U END
 S ZTRTN="QUE^LRAPTT" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) S LRD="",(LRE,LRF,LRA,LRM)=0 D XR^LRU,L^LRU,S^LRU,^LRAPTT1 S LR("F")=1 F A=0:0 S A=$O(^DIC("AC","LR",A)) Q:'A  S (LRE(A),LRF(A),LRM(A),LRA(A))=0
 F X=0:0 S LRSDT=$O(^LR(LRXR,LRSDT)) Q:'LRSDT!(LRSDT>LRLDT)  D I
 F LRH=0:0 S LRH=$O(^TMP($J,LRH)) Q:'LRH!(LR("Q"))  D N
 G:LR("Q") OUT S B=0 F A=0:0 S A=$O(LRM(A)) Q:'A  I A'=2,LRM(A) S B=1 Q
 I B D:$Y>(IOSL-8) ^LRAPTT1 Q:LR("Q")  W !!,"If '#', '*' or '?' is after Acc # then demographic data is in file indicated:",!?7,"# = Referral file  * = Research file  ? = Other file listed below"
 I LRSS="AU" W !?6,"F= FULL AUTOPSY  H= HEAD ONLY T= TRUNK ONLY  O=OTHER LIMITATION"
 D:$Y>(IOSL-8) ^LRAPTT1 Q:LR("Q")  S X=LRM-LRF W !!,"Total cases:",$J(LRM,4) W:X !?3,"Incomplete cases:",$J(X,4) W !?3,"Complete   cases:",$J(LRF,4)
 W:LRF !?5,"Average turnaround time (days): ",$J(LRE/LRF,2,2) W:LRL&(LRF) ?44,"Cases exceeding limit: ",LRA," (",$J(LRA/LRF*100,2,2),"%)" D F^LRAPTT1
OUT K ^TMP($J) W:IOST'?1"C".E @IOF D END^LRUTL,V^LRU Q
N S LRZ=0 F  S LRZ=$O(^TMP($J,LRH,LRZ)) Q:LRZ=""!(LR("Q"))  D:$Y>(IOSL-6) ^LRAPTT1 Q:LR("Q")  S Y=^TMP($J,LRH,LRZ) D B
 Q
B W !,$J(LRZ,5),?5,$P(Y,U,8),?6,$P(Y,U,9),?8,$P(Y,U),?19,$E($P(Y,U,2),1,20),?40,$P(Y,U,3),?46,$P(Y,U,5),?51,$P(Y,U,4),?62,$J($P(Y,U,6),3),?66,$E($P(Y,U,7),1,13) Q
I F LRDFN=0:0 S LRDFN=$O(^LR(LRXR,LRSDT,LRDFN)) Q:'LRDFN  S M(2)="" D @($S("CYEMSP"[LRSS:"L",1:"A"))
 Q
L Q:'$D(^LR(LRDFN,0))
 F LRI=0:0 S LRI=$O(^LR(LRXR,LRSDT,LRDFN,LRI)) Q:'LRI  I $D(^LR(LRDFN,LRSS,LRI,0)) S X=^(0) D G:$P($P(X,"^",6)," ")=LRABV
 S LREND=0 Q
G S Y=$P(X,U,11),Z=+$P($P(X,U,6)," ",3),W=$P(X,U,15),LRC=$S(W>1:W,Y>1:Y,Y=1:$P(X,U,3),1:""),H(4)=$P(X,U,2),LRR=$P(X,U,10),H(9)=$P(X,U,9),X=^LR(LRDFN,0) S:Z="" Z="??" D S Q
S D ^LRUP Q:$G(LREND)  S LRX=P("F") S:'$D(LRF(LRX))#2 LRF(LRX)=0
 S:LRC LRF=LRF+1,LRF(LRX)=LRF(LRX)+1 S LRM=LRM+1,LRM(LRX)=LRM(LRX)+1,X1=LRC,X2=LRR D ^%DTC S:X=0 X="<1" S LRT=X I X>1 S LRY=X-1,Y=0,X=$P(LRR,".") D D
 S LRE=LRE+LRT,LRE(LRX)=LRE(LRX)+LRT I LRC,LRL,LRT<LRL Q
 I H(4),$D(^VA(200,H(4),0)) S X=$P(^(0),U),H(4)=$S(X[",":$E($P(X,","),1,16),1:$E(X,1,16))
 S H(5)=$$Y2K^LRX(LRR,"5D"),H("F")=$S(+LRC:$$Y2K^LRX(LRC,"5D"),1:""),X=$S(LRX=2:"",LRX=67:"#",LRX=67.1:"*",1:"?")
 S:'LRR LRR="?" S ^TMP($J,$E(LRR,1,3),Z)=H(5)_U_LRP_U_SSN(1)_U_H("F")_U_H(9)_U_LRT_U_H(4)_U_X_U_LRD S:LRC LRA=LRA+1,LRA(LRX)=LRA(LRX)+1 Q
A S X=$G(^LR(LRDFN,"AU")) Q:$P($P(X,U,6)," ")'=LRABV  S LRR=$P(X,U),Z=$P($P(X,U,6)," ",3),LRC=$S(LR("AU")=1:$P(X,U,17),1:$P(X,U,3)),LRD=$P(X,U,11),H(4)=$P(X,U,10),H(9)=$P(X,U,13),X=^LR(LRDFN,0)
 D S Q
 ;
D F K=1:1:LRY S X1=X,X2=1 D C^%DTC,H^%DTC S K(X)=%Y
 F K=0:0 S K=$O(K(K)) Q:'K  D C
 S LRT=LRT-Y K K Q
C I "06"[K(K) S Y=Y+1 Q
 S:$D(^HOLIDAY(K)) Y=Y+1 Q
 ;
H W !!,"Enter 1 for Provisional Anatomic Diagnoses (PAD)",!,"Enter 2 for Final       Anatomic Diagnoses (FAD)" Q
END D V^LRU Q
