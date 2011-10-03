LRCKF60 ;SLC/RWF - CHECK FILE 60 ;4/4/89  20:36 ;
 ;;5.2;LAB SERVICE;**272,293**;Sep 27, 1994
 S ZTRTN="ENT^LRCKF60" D LOG^LRCKF Q:LREND  D ENT W !! W:$E(IOST,1,2)="P-" @IOF D ^%ZISC Q
ENT ;from LRCKF
 U IO S U="^" W !,"  CHECKING LAB TEST FILE  ^LAB(60 ",!," DD VERSION is  ",$S($D(^DD(60,0,"VR"))#2:^("VR"),1:"Missing"),! S LRDA=0
 F DA=0:0 S DA=$O(^LAB(60,DA)) Q:DA'>0  D CHK
END K LRLCS,LROKCS,LRDA,LA0,LRATOMIC,LRYES  W !! W:$E(IOST,1,2)="P-" @IOF Q
 Q
NAME I LRDA'=DA W !!,$P(^LAB(60,DA,0),U) S LRDA=DA
 W !,?5 Q
CHK I '$D(^LAB(60,DA,0))#2 W !!,"ENTRY ",DA," HAS NO ZERO NODE.. REMOVED" K ^LAB(60,DA) Q
 I $D(LRYES) Q:'$L($P(^LAB(60,DA,0),U,3))  Q:$P(^LAB(60,DA,0),U,3)="N"
 S LA0=^LAB(60,DA,0),LRATOMIC=$L($P(LA0,U,5))
 I LRATOMIC&($O(^LAB(60,DA,2,0))>0) D NAME W "F- A test can NOT be Atomic and Cosmic at the same time."
 I LRCKW,LRATOMIC&($O(^LAB(60,DA,1,0))<1) D NAME W "W- Atomic test has no site/specimen, therefore no units or range."
 I $P(LA0,U,16)<1 D NAME W "F- Test MUST have a HIGHEST URGENCY ALLOWED value."
 I $P(LA0,U,5)?1"CH;".NP,$S($D(^LAB(60,DA,.2)):'+^(.2),1:1) D NAME W "F- Atomic test has a location but not a DATA NAME."
 I $D(^LAB(60,DA,.2)),^(.2) S X=^(.2) I $P(LA0,U,5)'[X!($P(LA0,U,12)'[X) D NAME W "F- The data name field must be re-entered to set up location & field."
 I $D(^LAB(60,DA,.2)),^(.2),$D(^DD(63.04,+^LAB(60,DA,.2),0))[0 D NAME W "F- BAD Data name."
 S P1=$S($D(^LAB(60,DA,.1)):^(.1),1:"")
 I '$L($P(P1,U)) D NAME W "F- Needs a print name entered."
 I $L($P(P1,U,3)) S X="W "_$P(P1,U,3) D ^DIM I '$D(X) D NAME W "F- BAD print code."
 I LRCKW,LRATOMIC,$S($D(^LAB(60,DA,.1)):'$P(^(.1),U,6),1:1) D NAME W "W- Does not have a print order."
 I $D(^LAB(60,DA,9,0)) D CAP
 F LRIX=0:0 S LRIX=$O(^LAB(60,DA,2,LRIX)) Q:LRIX<.01  I $D(^(LRIX,0))#2 S X=+^(0) D PANEL
C2 ;I $P(LA0,U,6),$D(^LRO(68,+$P(LA0,U,6),0))[0 D NAME W "F- BAD pointer to the Accession file."
 I $P(LA0,U,9),$D(^LAB(62,+$P(LA0,U,9),0))[0 D NAME W "F- BAD Lab collection sample pointer to the Collection sample file."
 I $P(LA0,U,10),$D(^LAB(61.5,+$P(LA0,U,10),0))[0 D NAME W "F- BAD pointer to the Procedure file."
 I $P(LA0,U,14),$D(^LAB(62.07,+$P(LA0,U,14),0))[0 D NAME W "F- BAD Edit code pointer to the Execute code file."
 I $D(^LAB(60,DA,4)),+^(4),$D(^LAB(62.07,+^LAB(60,DA,4),0))[0 D NAME W "F- BAD 'Batch data code' pointer to the execute code file."
 F LRSSP=0:0 S LRSSP=$O(^LAB(60,DA,1,LRSSP)) Q:LRSSP<1  I $D(^(LRSSP,0))#2 S X=^(0) D SPEC
 S X=$P(^LAB(60,DA,0),U,9),LRLCS=X D LROKCS:X S LRLCS=0
 F LRCS=0:0 S LRCS=$O(^LAB(60,DA,3,LRCS)) Q:LRCS<1  I $D(^(LRCS,0))#2 S X=^(0) D COLSAMP
 Q
PANEL I $D(^LAB(60,X,0))[0 D NAME W "F- BAD pointer in panel.. "
 I X=DA D NAME W "F- Test is on it's own panel. (infinite loop)"
 Q
SPEC I LRSSP='+X D NAME W "F- BAD entry in specimen/site subfile. ",LRSSP
 I $D(^LAB(61,+X,0))[0 D NAME W "F- BAD specimen/site subfile pointer to file #61."
 I $P(X,U,8),$D(^LAB(62.1,+$P(X,U,8),0))[0 D NAME W "F- BAD type of delta check pointer."
 Q
COLSAMP I $D(^LAB(62,+X,0))[0 D NAME W "F- BAD collection sample pointer to file #62."
 I $P(X,U,6),$D(^LAB(62.07,+$P(X,U,6),0))[0 D NAME W "F- BAD required comment pointer to execute code file."
 D LROKCS Q
LROKCS Q:$D(^LAB(62,+X,0))[0  S Y=$P(^(0),U,2) Q:Y<1
 S LROKCS=1 I $D(^LAB(60,DA,1,+Y,0))#2 S LROKCS=0
 I LRCKW,LRATOMIC,LROKCS D NAME W "W- ",$S(LRLCS:"LAB ",1:""),"Collection sample ",$P(^LAB(62,+X,0),U)," does not have a matching Site/Specimen entry."
 Q
CAP Q  ;S (CAP,LRCAP)=0 F A=1:1 S LRCAP=$O(^LAB(60,DA,9,LRCAP)) Q:+LRCAP<1  I $D(^(LRCAP,0)),$P(^(0),U,2) S CAP=LRCAP
 I A>1,'+CAP D NAME W:'+CAP "W -  No WKLD code for this test"
 K LRCAP,A,CAP Q
