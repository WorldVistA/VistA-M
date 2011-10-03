LRAPJNC ;AVAMC/REG - INCOMPLETE PATH RPTS ;2/10/98  20:30 ;
 ;;5.2;LAB SERVICE;**72,201**;Sep 27, 1994
 D ^LRAP G:'$D(Y) END  W !!,LRO(68)," Incomplete Reports" D B^LRU G:Y<0 END
 S LRSDT=LRSDT-.01,LRLDT=LRLDT+.99
 S ZTRTN="QUE^LRAPJNC" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) D XR^LRU,L^LRU,S^LRU
 F X=0:0 S LRSDT=$O(^LR(LRXR,LRSDT)) Q:'LRSDT!(LRSDT>LRLDT)  D I
 D H I '$D(^TMP($J)) W !!,"There are no incomplete reports within specified time." G OUT
 S LR("F")=1,H(2)=0 F A=0:0 S H(2)=$O(^TMP($J,H(2))) Q:H(2)=""!(LR("Q"))  D N
OUT K ^TMP($J) W:IOST'?1"C".E @IOF D END^LRUTL,END Q
N S Z=0 F LRB=0:0 S Z=$O(^TMP($J,H(2),Z)) Q:Z=""!(LR("Q"))  D:$Y>(IOSL-6) H Q:LR("Q")  S Y=^(Z) D W
 Q
W W !,$J(Z,5),?7,$J($P(Y,"^"),8),?18,$E($P(Y,"^",2),1,20),?39,$P(Y,"^",3),?44,$P(Y,"^",4),?62,$E($P(Y,"^",5),1,18) W:$P(Y,"^",6)]"" !?62,$E($P(Y,"^",6),1,18) Q
 ;
I F LRDFN=0:0 S LRDFN=$O(^LR(LRXR,LRSDT,LRDFN)) Q:'LRDFN  S M(2)="" D @($S("CYEMSP"[LRSS:"L",1:"A"))
 Q
L Q:'$D(^LR(LRDFN,0))
 F LRI=0:0 S LRI=$O(^LR(LRXR,LRSDT,LRDFN,LRI)) Q:'LRI  S X=$G(^LR(LRDFN,LRSS,LRI,0)) I $P($P(X,U,6)," ")=LRABV,'$P(X,U,3) S Z=+$P($P(X,U,6)," ",3),LRDTINT=$P(X,U,10),M(1)=$P(X,U,8),M=$P(X,U,2),X=^LR(LRDFN,0) D S
 Q
S D ^LRUP S M=$S('M:"",1:$P($G(^VA(200,+M,0)),U)) I M(2),$D(^VA(200,M(2),0)) S M(2)=$P(^(0),U)
 S LRDTEXT=$$Y2K^LRX(LRDTINT,"5D")
 S:'LRDTINT LRDTINT="?" S:Z="" Z="?" S ^TMP($J,$E(LRDTINT,1,3),Z)=LRDTEXT_"^"_LRP_"^"_SSN(1)_"^"_M(1)_"^"_M_"^"_M(2) Q
A S X=$G(^LR(LRDFN,"AU")) Q:$P($P(X,U,6)," ")'=LRABV  I '$P(X,U,3) S LRDTINT=$P(X,U),M(1)=$P(X,U,5),Z=+$P($P(X,U,6)," ",3),M=$P(X,U,10),M(2)=$P(X,U,7),X=^LR(LRDFN,0) D S
 Q
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"Incomplete ",LRO(68)," (",LRABV,") Reports",!,LRABV,?23,"FROM ",LRSTR," TO ",LRLST,!,"Acc #",?7,"Date",?18,"Patient",?39,"ID",?44,"Location",?62,$S(LRSS="AU":"Pathologist(s)",1:"Pathologist"),!,LR("%") Q
 ;
END K LRDTEXT,LRDTINT D V^LRU Q
