LRAPQOR ;AVAMC/REG/CYM - QA CODE REPORT ;2/12/98  09:21
 ;;5.2;LAB SERVICE;**72,201**;Sep 27, 1994
 D ^LRAP G:'$D(Y) END D B^LRU G:Y<0 END
 S (LRSDT(1),LRSDT)=LRSDT-.01,LRLDT=LRLDT+.99 W !!,"Sort by QA CODE / PATHOLOGIST " S %=2 D YN^LRU G:%<1 END I %=1 G ^LRAPQOR1
 W !!,"Print all QA codes " S %=1 D YN^LRU G:%<1 END I %=2 D T G:'$D(LRB) END
 S ZTRTN="QUE^LRAPQOR" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) D XR^LRU,L^LRU,S^LRU,H S LR("F")=1
 F X=0:0 S LRSDT=$O(^LR(LRXR,LRSDT)) Q:'LRSDT!(LRSDT>LRLDT)  D I
 K ^TMP($J) W:IOST'?1"C".E @IOF D END^LRUTL,V^LRU Q
I F LRDFN=0:0 S LRDFN=$O(^LR(LRXR,LRSDT,LRDFN)) Q:'LRDFN!(LR("Q"))  D @($S("CYEMSP"[LRSS:"L",1:"A"))
 Q
L Q:'$D(^LR(LRDFN,0))  F LRI=0:0 S LRI=$O(^LR(LRXR,LRSDT,LRDFN,LRI)) Q:'LRI  I $P($P($G(^LR(LRDFN,LRSS,LRI,0)),U,6)," ")=LRABV,$O(^LR(LRDFN,LRSS,LRI,9,0)) D B
 Q
B I $D(LRB) K LRF F X=0:0 S X=$O(LRB(X)) Q:'X  I $D(^LR(LRDFN,LRSS,LRI,9,X)) S LRF=1 Q
 I $D(LRB),'$D(LRF) Q
 S X=^LR(LRDFN,LRSS,LRI,0),Z=$P(X,"^",2),Y=$P($P(X,"^",10),"."),LRZ=$P(X,"^",6) D S Q
W S LRY=$$FMTE^XLFDT(Y),LRC=$S('Z:"",'$D(^VA(200,Z,0)):"",1:$P(^(0),"^")) D:$Y>(IOSL-6) H Q:LR("Q")  W !!,LRZ,?10,LRY,?24,LRC Q
W1 D:$Y>(IOSL-6) H1 Q:LR("Q")  S X=$S($D(^LAB(62.5,LRA,0)):^(0),1:"") W !,$P(X,"^"),?4,$P(X,"^",2) Q
S D W Q:LR("Q")  F LRA=0:0 S LRA=$O(^LR(LRDFN,LRSS,LRI,9,LRA)) Q:'LRA  D W1 Q:LR("Q")
 Q
A Q:$P($P($G(^LR(LRDFN,"AU")),U,6)," ")'=LRABV  Q:'$O(^LR(LRDFN,99,0))  I $D(LRB) K LRF F X=0:0 S X=$O(LRB(X)) Q:'X  I $D(^LR(LRDFN,99,X)) S LRF=1 Q
 I $D(LRB),'$D(LRF) Q
 Q:'$D(^LR(LRDFN,"AU"))  S X=^("AU"),Y=$P($P(X,"^"),"."),LRZ=$P(X,"^",6),Z=$P(X,"^",10) D W Q:LR("Q")  F LRA=0:0 S LRA=$O(^LR(LRDFN,99,LRA)) Q:'LRA  D W1 Q:LR("Q")
 Q
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"QA CODES for ",LRO(68)," From: ",LRSTR,"  To: ",LRLST
 W !,"Acc #",?10,$S(LRSS'="AU":"Rec'd",1:"Date"),?24,"Pathologist",!,LR("%") Q
H1 D H Q:LR("Q")  W !,LRZ,?10,LRY,?20,LRC Q
T S DIC="^LAB(62.5,",DIC(0)="AEQ",D="AI",DIC("A")="Select QA CODE: ",DIC("S")="I $L($P(^(0),U))<3" D IX^DIC K DIC I Y>0 S LRB(+Y)="" G T
 Q
 ;
END D V^LRU Q
