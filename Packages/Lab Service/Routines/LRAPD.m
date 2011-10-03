LRAPD ;AVAMC/REG/WTY - AP DATA ENTRY ;11/27/01
 ;;5.2;LAB SERVICE;**72,91,259**;Sep 27, 1994
MAIN ;
 S:'$D(LRSOP) LRSOP=""
 I LRCAPA D  G:'$D(X) END
 .D @(LRSS_"^LRAPSWK")
 S LRD(1)=LRD,LRD=LRD_LRSS_"^LRAPD1",LR("TR")=""
 D @LRD
 I LRD(1)="P" D  Q
 .D AK^LRAPDA,END
 D ^LRAPDA
 D END
 Q
A ;also from LRAPOLD,LRAPM,LRAPQAMR,LRAPQAT
 S LRDICS="SPCYEM" D ^LRAP Q:'$D(Y)
 S LRV=$P($G(^LRO(69.2,LRAA,0)),U,10)
 S X=$G(^LAB(69.9,1,11))
 S LR("FS")=+X
 S LR("DX")=$S(LRSS="SP":$P(X,U,2),LRSS="CY":$P(X,U,3),1:"")
 S:LR("DX")="" LR("DX")=$S(LRSS="EM":$P(X,U,4),1:0)
 Q
R ;
 S Y=$S('X:0,'$D(^LAB(61.5,X,0)):0,'$P(^LAB(61.5,X,0),U,3):0,1:.02)
 Q
T ;
 S LR(8)=$S('X:0,'$D(^LAB(61,X,0)):0,1:$P(^LAB(61,X,0),U,4))
 Q
EN ;Gross Description/Clinical HX
 D A
 I '$D(Y) D END Q
 S LRD=""
 D MAIN
 Q
EN1 ;Gross Review/Micro Description
 D A
 I '$D(Y) D END Q
 S LRD="M"
 D MAIN
 Q
EN2 ;Micro Description/SNOMED Coding
 D A
 I '$D(Y) D END Q
 S LRD="B"
 D MAIN
 Q
EN3 ;Micro Description/ICD9CM Coding
 D A
 I '$D(Y) D END Q
 I '$O(^ICD0(0)) D  Q
 .W $C(7),!!,"No entries in the ICD DIAGNOSIS File (#80)."
 S LRD="A"
 D MAIN
 Q
EN4 ;Supplementary Report
 D A
 I '$D(Y) D END Q
 S LRD="S"
 D MAIN
 Q
EN5 ;Special Studies
 D A
 I '$D(Y) D END Q
 S LRD="P"
 D MAIN
 Q
END ;Clean-up
 K DR,LRSFLG,LRREL
 D V^LRU
 Q
